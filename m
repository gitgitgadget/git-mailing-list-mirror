From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH v2 2/3] remote: repack packed-refs once when deleting multiple
 refs
Date: Fri, 23 May 2014 12:29:45 +0200
Message-ID: <537F2319.7040105@opera.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnmk1-0003rE-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaEWKaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 06:30:13 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:44736 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaEWKaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:30:11 -0400
Received: by mail-la0-f54.google.com with SMTP id pv20so3903147lab.41
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bfQ+bfBk0hiyefFvB0cRJRXwDsEI10ms2XFSMtKcbaQ=;
        b=jRPgz1lvVN0ID4wCkCooyKpYn9t1Q7FRvzXzoHK3LOs7uaYrKMePb6LzUu8kPX6Cs5
         YDvax6J075k2kW33Gb+m51y7LE7AV0x9nCInUe9Ec9mxTR4uvQDMq3tGF8YFv7Dkq3/D
         nsM5rdNBU6pk6OXzIWSSNPwyBaFeQOQ1e++3qwnxR0vuJOBZAZoa8HdWBzgHXUq8Cxai
         cB8ed69HdOACbexulF9iWi+LF+tUqojQvrGijLlb/vo6mwG1ZEMcRMMu8CPDb28Y9bUU
         SbTZP8CC8Q8OclgkERj7MIxYkFqEJzvIz897m7C1hj0cjGB9pwlO+mIdPaDWQhwpB94N
         DjiA==
X-Gm-Message-State: ALoCoQmWN/jC4bBFbo6VNhWi6jocxJig+G055QF36DryD84G+GEQ45cWLCENZSHTzWQC/BSuR6UL
X-Received: by 10.152.242.164 with SMTP id wr4mr2808059lac.38.1400841009700;
        Fri, 23 May 2014 03:30:09 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id q2sm2207002laj.9.2014.05.23.03.30.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 03:30:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537F2252.3010101@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249983>

When 'git remote rm' or 'git remote prune' were used in a repository
with many refs, and needed to delete many remote-tracking refs, a lot
of time was spent deleting those refs since for each deleted ref,
repack_without_refs() was called to rewrite packed-refs without just
that deleted ref.

To avoid this, call repack_without_refs() first to repack without all
the refs that will be deleted, before calling delete_ref() to delete
each one completely.  The call to repack_without_ref() in delete_ref()
then becomes a no-op, since packed-refs already won't contain any of
the deleted refs.

Signed-off-by: Jens Lindstr=F6m <jl@opera.com>
---
Note: remove_branches() no longer checks that the remote-tracking
branches it deletes point at the right object before deleting them
by passing the expected SHA-1 to delete_ref().  This was a required
change since all packed refs have been deleted already by the time
we call delete_ref(), which causes delete_ref() to fail if given an
expected SHA-1 to check.  'remote prune' already behaved this way.

 builtin/remote.c | 20 ++++++++++++++++++--
 refs.c           |  2 +-
 refs.h           |  2 ++
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 84802cd..d33abe6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -749,15 +749,23 @@ static int mv(int argc, const char **argv)
=20
 static int remove_branches(struct string_list *branches)
 {
+	const char **branch_names;
 	int i, result =3D 0;
+
+	branch_names =3D xmalloc(branches->nr * sizeof(*branch_names));
+	for (i =3D 0; i < branches->nr; i++)
+		branch_names[i] =3D branches->items[i].string;
+	result |=3D repack_without_refs(branch_names, branches->nr);
+	free(branch_names);
+
 	for (i =3D 0; i < branches->nr; i++) {
 		struct string_list_item *item =3D branches->items + i;
 		const char *refname =3D item->string;
-		unsigned char *sha1 =3D item->util;
=20
-		if (delete_ref(refname, sha1, 0))
+		if (delete_ref(refname, NULL, 0))
 			result |=3D error(_("Could not remove branch %s"), refname);
 	}
+
 	return result;
 }
=20
@@ -1305,6 +1313,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
 {
 	int result =3D 0, i;
 	struct ref_states states;
+	const char **delete_refs;
 	const char *dangling_msg =3D dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1318,6 +1327,13 @@ static int prune_remote(const char *remote, int =
dry_run)
 		       states.remote->url_nr
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
+
+		delete_refs =3D xmalloc(states.stale.nr * sizeof(*delete_refs));
+		for (i =3D 0; i < states.stale.nr; i++)
+			delete_refs[i] =3D states.stale.items[i].util;
+		if (!dry_run)
+			result |=3D repack_without_refs(delete_refs, states.stale.nr);
+		free(delete_refs);
 	}
=20
 	for (i =3D 0; i < states.stale.nr; i++) {
diff --git a/refs.c b/refs.c
index 28d5eca..262c1c2 100644
--- a/refs.c
+++ b/refs.c
@@ -2431,7 +2431,7 @@ static int curate_packed_ref_fn(struct ref_entry =
*entry, void *cb_data)
 	return 0;
 }
=20
-static int repack_without_refs(const char **refnames, int n)
+int repack_without_refs(const char **refnames, int n)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete =3D STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index 87a1a79..f287c7a 100644
--- a/refs.h
+++ b/refs.h
@@ -132,6 +132,8 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
=20
+extern int repack_without_refs(const char **refnames, int n);
+
 extern int ref_exists(const char *);
=20
 /*
--=20
1.9.1
