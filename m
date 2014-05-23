From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH v2 3/3] remote prune: optimize "dangling symref" check/warning
Date: Fri, 23 May 2014 12:30:25 +0200
Message-ID: <537F2341.4050702@opera.com>
References: <537B2FA4.7020001@opera.com> <537F2252.3010101@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:30:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnmkZ-0004kj-51
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaEWKav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2014 06:30:51 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:42615 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbaEWKav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:30:51 -0400
Received: by mail-la0-f49.google.com with SMTP id pv20so3973088lab.36
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0YcojcAosDYqOXH0u8o+hr/5HljrFNe2s+/ZCoLO4sM=;
        b=X1jUp4fXT4u5B4nE/eViCsO4/CK8q3e/FM/6OTVVXVduBoaeRTjlfiBaZcyJo+qYTd
         zU2uJXMSAPiLM8Ke7BdA3Lsx/HsEZr0f6QNlY7h2M38jP/05BFQLnwbhGtHc3wBCD6fp
         NaV8QofB0C3SXnRIbepVDgqNc8E5Em498cJNG/N9ggUhXllhkICMiyuRwqyDlulocjH+
         1wGtrE5bRzl5Hbkjn+lcw+8xW5yzNwbh/2Lj8zbvvGbVFUJpz0Zd7SpHx6rLYzAJRjSQ
         f51STAKtd8ly6VmWW34NAg103eN4vyLkfkZ6UsoA1SVDKIRVfurNwsu653UVJPTuVwec
         CVDQ==
X-Gm-Message-State: ALoCoQm5giHnsRjKCSiKHtp9ELOPlnX5Q5ahhlnZwLxmIinFSV5dfaQZsIgZVr+9ugABcTd6OHJ/
X-Received: by 10.152.20.99 with SMTP id m3mr520970lae.80.1400841049787;
        Fri, 23 May 2014 03:30:49 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id p5sm2201597laj.17.2014.05.23.03.30.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 May 2014 03:30:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537F2252.3010101@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249984>

When 'git remote prune' was used to delete many refs in a repository
with many refs, a lot of time was spent checking for (now) dangling
symbolic refs pointing to the deleted ref, since warn_dangling_symref()
was once per deleted ref to check all other refs in the repository.

Avoid this using the new warn_dangling_symrefs() function which
makes one pass over all refs and checks for all the deleted refs in
one go, after they have all been deleted.

Signed-off-by: Jens Lindstr=F6m <jl@opera.com>
---
 builtin/remote.c |  7 ++++++-
 refs.c           | 19 ++++++++++++++++++-
 refs.h           |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d33abe6..9b3e368 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1313,6 +1313,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
 {
 	int result =3D 0, i;
 	struct ref_states states;
+	struct string_list delete_refs_list =3D STRING_LIST_INIT_NODUP;
 	const char **delete_refs;
 	const char *dangling_msg =3D dry_run
 		? _(" %s will become dangling!")
@@ -1339,6 +1340,8 @@ static int prune_remote(const char *remote, int d=
ry_run)
 	for (i =3D 0; i < states.stale.nr; i++) {
 		const char *refname =3D states.stale.items[i].util;
=20
+		string_list_insert(&delete_refs_list, refname);
+
 		if (!dry_run)
 			result |=3D delete_ref(refname, NULL, 0);
=20
@@ -1348,9 +1351,11 @@ static int prune_remote(const char *remote, int =
dry_run)
 		else
 			printf_ln(_(" * [pruned] %s"),
 			       abbrev_ref(refname, "refs/remotes/"));
-		warn_dangling_symref(stdout, dangling_msg, refname);
 	}
=20
+	warn_dangling_symrefs(stdout, dangling_msg, &delete_refs_list);
+	string_list_clear(&delete_refs_list, 0);
+
 	free_remote_ref_states(&states);
 	return result;
 }
diff --git a/refs.c b/refs.c
index 262c1c2..59fb700 100644
--- a/refs.c
+++ b/refs.c
@@ -1611,6 +1611,7 @@ int peel_ref(const char *refname, unsigned char *=
sha1)
 struct warn_if_dangling_data {
 	FILE *fp;
 	const char *refname;
+	const struct string_list *refnames;
 	const char *msg_fmt;
 };
=20
@@ -1625,8 +1626,12 @@ static int warn_if_dangling_symref(const char *r=
efname, const unsigned char *sha
 		return 0;
=20
 	resolves_to =3D resolve_ref_unsafe(refname, junk, 0, NULL);
-	if (!resolves_to || strcmp(resolves_to, d->refname))
+	if (!resolves_to
+	    || (d->refname
+		? strcmp(resolves_to, d->refname)
+		: !string_list_has_string(d->refnames, resolves_to))) {
 		return 0;
+	}
=20
 	fprintf(d->fp, d->msg_fmt, refname);
 	fputc('\n', d->fp);
@@ -1639,6 +1644,18 @@ void warn_dangling_symref(FILE *fp, const char *=
msg_fmt, const char *refname)
=20
 	data.fp =3D fp;
 	data.refname =3D refname;
+	data.refnames =3D NULL;
+	data.msg_fmt =3D msg_fmt;
+	for_each_rawref(warn_if_dangling_symref, &data);
+}
+
+void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct=
 string_list *refnames)
+{
+	struct warn_if_dangling_data data;
+
+	data.fp =3D fp;
+	data.refname =3D NULL;
+	data.refnames =3D refnames;
 	data.msg_fmt =3D msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
diff --git a/refs.h b/refs.h
index f287c7a..1440acc 100644
--- a/refs.h
+++ b/refs.h
@@ -89,6 +89,7 @@ static inline const char *has_glob_specials(const cha=
r *pattern)
 extern int for_each_rawref(each_ref_fn, void *);
=20
 extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const =
char *refname);
+extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const=
 struct string_list* refnames);
=20
 /*
  * Lock the packed-refs file for writing.  Flags is passed to
--=20
1.9.1
