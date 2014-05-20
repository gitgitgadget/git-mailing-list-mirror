From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH 1/2] remote: defer repacking packed-refs when deleting refs
Date: Tue, 20 May 2014 12:39:35 +0200
Message-ID: <537B30E7.5020505@opera.com>
References: <537B2FA4.7020001@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 12:40:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmhSo-0002B9-91
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 12:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbaETKkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2014 06:40:00 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61835 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbaETKj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 06:39:59 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so227402lbv.31
        for <git@vger.kernel.org>; Tue, 20 May 2014 03:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4OTweFMhxg8LrEZbOjpiOp9N4z+w6m5dHacCl3xEEQc=;
        b=YlQInaNFBeI7viK5qDEGYCOb0JFeW7Y5r3/agEfa0qRweiV1eTiDulxQUzfOvIDSGc
         Qb0VrPX42flmKsO7zwQRU9Q3auGT0rg9lGDX7omutbMcThuy6g/WicHGZOKsuAcmENZT
         bW1LCAZIQNRfY4LLb+Fbx5i9mo/LFXEpvoX2iMBDah4rS8xC859HuD4pnBiFqCDJb+4y
         F9Am9ed2tgjYa5aEFU1sy7W2kcCm2Fx2Zhoi7f1iiEJpPHzYgiUrPtnr6EyqtZ/4Xb82
         KJIMpyLDmUW4MQ5FI4I4QfMbDz6VcsYFu7Ulcx4Ok55iSDuVoVTZaje3dpVbqqmgygXT
         GQzA==
X-Gm-Message-State: ALoCoQmVVCR58wIQXZnlbreQbvMbhNjnN0PGaZs5wsLkAoZ74EoXzXOvgNZZEGG22I3tJfysHfuL
X-Received: by 10.112.142.35 with SMTP id rt3mr627826lbb.92.1400582397075;
        Tue, 20 May 2014 03:39:57 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id u4sm22498934lal.8.2014.05.20.03.39.56
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 03:39:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537B2FA4.7020001@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249659>

When 'git remote rm' or 'git remote prune' were used in a repository
with many refs, and needed to delete many refs, a lot of time was spent
deleting those refs since for each deleted ref, repack_without_refs()
was called to rewrite packed-refs without just that deleted ref.

To avoid this, defer the repacking until after all refs have been
deleted (by delete_ref()), and then call repack_without_refs() once to
repack without all the deleted refs.

Signed-off-by: Jens Lindstr=F6m <jl@opera.com>
---
This patch changes behavior when the operation is aborted in the
middle, so that loose refs and ref logs might have been deleted, but
not the corresponding entries in packed-refs, since packed-refs is now
only updated at the end.  This is a bit unfortunate, and may
"resurrect" an obsolete packed-refs entry by deleting the loose ref
that had overridden it.

Mitigating factors would be that this only affects remote tracking
branches that we were about to delete anyway, and that in the case of
'git remote prune' were apparently not actually matching a ref in the
remote.

Also, it is a lot harder to interrupt the operation in the middle when
it takes a few seconds compared to when it takes many minutes to
complete.  :-)

 builtin/remote.c | 19 ++++++++++++++++---
 refs.c           | 15 +++++++++------
 refs.h           |  3 +++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b3ab4cf..ce60a30 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -749,15 +749,18 @@ static int mv(int argc, const char **argv)
=20
 static int remove_branches(struct string_list *branches)
 {
+	const char **branch_names =3D xmalloc(branches->nr * sizeof(*branch_n=
ames));
 	int i, result =3D 0;
 	for (i =3D 0; i < branches->nr; i++) {
 		struct string_list_item *item =3D branches->items + i;
-		const char *refname =3D item->string;
+		const char *refname =3D branch_names[i] =3D item->string;
 		unsigned char *sha1 =3D item->util;
=20
-		if (delete_ref(refname, sha1, 0))
+		if (delete_ref(refname, sha1, REF_DEFERREPACK))
 			result |=3D error(_("Could not remove branch %s"), refname);
 	}
+	result |=3D repack_without_refs(branch_names, branches->nr);
+	free(branch_names);
 	return result;
 }
=20
@@ -1303,6 +1306,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
 {
 	int result =3D 0, i;
 	struct ref_states states;
+	const char **delete_refs;
 	const char *dangling_msg =3D dry_run
 		? _(" %s will become dangling!")
 		: _(" %s has become dangling!");
@@ -1316,13 +1320,16 @@ static int prune_remote(const char *remote, int=
 dry_run)
 		       states.remote->url_nr
 		       ? states.remote->url[0]
 		       : _("(no URL)"));
+		delete_refs =3D xmalloc(states.stale.nr * sizeof(*delete_refs));
 	}
=20
 	for (i =3D 0; i < states.stale.nr; i++) {
 		const char *refname =3D states.stale.items[i].util;
=20
+		delete_refs[i] =3D refname;
+
 		if (!dry_run)
-			result |=3D delete_ref(refname, NULL, 0);
+			result |=3D delete_ref(refname, NULL, REF_DEFERREPACK);
=20
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
@@ -1333,6 +1340,12 @@ static int prune_remote(const char *remote, int =
dry_run)
 		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
=20
+	if (states.stale.nr) {
+		if (!dry_run)
+			result |=3D repack_without_refs(delete_refs, states.stale.nr);
+		free(delete_refs);
+	}
+
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/refs.c b/refs.c
index 28d5eca..3b62aca 100644
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
@@ -2507,11 +2507,14 @@ int delete_ref(const char *refname, const unsig=
ned char *sha1, int delopt)
 		return 1;
 	ret |=3D delete_ref_loose(lock, flag);
=20
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |=3D repack_without_ref(lock->ref_name);
+	if (!(delopt & REF_DEFERREPACK))
+	{
+		/* removing the loose one could have resurrected an earlier
+		 * packed one.  Also, if it was not loose we need to repack
+		 * without it.
+		 */
+		ret |=3D repack_without_ref(lock->ref_name);
+	}
=20
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 87a1a79..0db5584 100644
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
@@ -149,6 +151,7 @@ extern struct ref_lock *lock_ref_sha1(const char *r=
efname, const unsigned char *
=20
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+#define REF_DEFERREPACK	0x02
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
--
1.9.1
