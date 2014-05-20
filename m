From: =?ISO-8859-1?Q?Jens_Lindstr=F6m?= <jl@opera.com>
Subject: [PATCH 2/2] remote prune: optimize "dangling symref" check/warning
Date: Tue, 20 May 2014 12:41:25 +0200
Message-ID: <537B3155.1010309@opera.com>
References: <537B2FA4.7020001@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 12:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmhUW-00054c-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 12:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaETKlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2014 06:41:49 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:65166 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbaETKls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 06:41:48 -0400
Received: by mail-la0-f48.google.com with SMTP id mc6so224753lab.7
        for <git@vger.kernel.org>; Tue, 20 May 2014 03:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=wy9LG9wveSEPDs9PXKHx+4EoAocWFYxM7fl/QbA6Ih8=;
        b=b8+9rTioeJrW/avPGpZFux2GkiKLDMTHnWOb5XhL5mcI35MAWQygmp46Z6t1m5b3f/
         cj0ObINgUisgwkxbGGQsCIwR4mquuGXsfoir5NchfLP7hiHZuOhXELDTumqc4hQFV4Ym
         deCdlRJOgxIvLeUsTSvwuZ4lrXrctvY4KyMRXEJtnBMm/qRvNeRJZuZ+d7SHqq+w0bKo
         JsqdOGzxPQveRZJ7qZSghO+8ZMMDQTVCL9fxrUyFoRzjgkBxSjg+5Xs6T4sqnJTttvFw
         bwPeOvZdwF42mts2ooYZbufuQte5BncyiYlOAZNF9QlIWtshebIBMOoGWESUDD5w69nJ
         Xmxw==
X-Gm-Message-State: ALoCoQkZ5jIlQ0ouB1S6Z6o6l0YEfLITuPMlVEBPltnocR85Si31xJHsps69axqb9gt9rcmcExy+
X-Received: by 10.152.87.176 with SMTP id az16mr21504623lab.43.1400582506971;
        Tue, 20 May 2014 03:41:46 -0700 (PDT)
Received: from [10.34.0.102] (77.72.99.119.c.fiberdirekt.net. [77.72.99.119])
        by mx.google.com with ESMTPSA id a2sm20436837lbz.25.2014.05.20.03.41.46
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 03:41:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <537B2FA4.7020001@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249660>

When 'git remote prune' was used to delete many refs in a repository
with many refs, a lot of time was spent checking for (now) dangling
symbolic refs pointing to the deleted ref, since warn_dangling_symref()
was once per deleted ref to check all other refs in the repository.

Avoid this using the new warn_dangling_symrefs() function which
makes one pass over all refs and checks for all the deleted refs in
one go, after they have all been deleted.

Signed-off-by: Jens Lindstr=F6m <jl@opera.com>
---
 builtin/remote.c |  6 +++++-
 refs.c           | 19 ++++++++++++++++++-
 refs.h           |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ce60a30..5e4a8dd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1306,6 +1306,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
 {
 	int result =3D 0, i;
 	struct ref_states states;
+	struct string_list delete_refs_list =3D STRING_LIST_INIT_NODUP;
 	const char **delete_refs;
 	const char *dangling_msg =3D dry_run
 		? _(" %s will become dangling!")
@@ -1327,6 +1328,7 @@ static int prune_remote(const char *remote, int d=
ry_run)
 		const char *refname =3D states.stale.items[i].util;
=20
 		delete_refs[i] =3D refname;
+		string_list_insert(&delete_refs_list, refname);
=20
 		if (!dry_run)
 			result |=3D delete_ref(refname, NULL, REF_DEFERREPACK);
@@ -1337,9 +1339,11 @@ static int prune_remote(const char *remote, int =
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
 	if (states.stale.nr) {
 		if (!dry_run)
 			result |=3D repack_without_refs(delete_refs, states.stale.nr);
diff --git a/refs.c b/refs.c
index 3b62aca..fdd8b74 100644
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
index 0db5584..cd4710d 100644
--- a/refs.h
+++ b/refs.h
@@ -89,7 +89,7 @@ static inline const char *has_glob_specials(const cha=
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
--
1.9.1
