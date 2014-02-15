From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] Use wildmatch() directly without fnmatch() wrapper
Date: Sat, 15 Feb 2014 09:01:46 +0700
Message-ID: <1392429709-9237-2-git-send-email-pclouds@gmail.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:02:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUa3-0004Rw-15
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbaBOCCA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:02:00 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53314 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaBOCBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:01:48 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so13002178pab.32
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5G0wdaNC/XjnQjwdZnqMt97ROz92O1lJkH740xxzuk4=;
        b=c9MYOH/RIML7HRvT8ntw/MEgtobitncYxAL73UcLLc3ntnPrXtR8Th4eKLLBIXesmW
         0SUsUmd+xyNPQBea/8grpVvGkD+6QGyDuHaV2tcTyY5EYamMYPsaiM7bBEiLKpi1Raiu
         VStT0oOBYitWR4FBJLlGFrOysC31KCVbEArw792WoXKiVVToMN1x91oai9gmWottFiXg
         JjLON832SiEaQcVTl1+nF1EvMZR5yit81h9zWf1iJxIoouSFuacylSOhQFirCGOKeJ8K
         /J8FDNRIvC08/L3SXM7JFRwOukt8Ik4jft4KcesMaX1JKfT9D0j7GSSc06ssrv6sJG0P
         Ux9w==
X-Received: by 10.66.26.236 with SMTP id o12mr12930419pag.15.1392429708115;
        Fri, 14 Feb 2014 18:01:48 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id qq5sm21839299pbb.24.2014.02.14.18.01.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:01:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:01:58 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242173>

Make it clear that we don't use fnmatch() anymore.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c        |  2 +-
 builtin/branch.c       |  2 +-
 builtin/describe.c     |  2 +-
 builtin/for-each-ref.c |  2 +-
 builtin/ls-remote.c    |  2 +-
 builtin/name-rev.c     |  2 +-
 builtin/reflog.c       |  2 +-
 builtin/replace.c      |  2 +-
 builtin/show-branch.c  |  2 +-
 builtin/tag.c          |  2 +-
 diffcore-order.c       |  2 +-
 dir.c                  | 11 +++++++----
 refs.c                 |  2 +-
 revision.c             |  2 +-
 14 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..66e2eed 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4152,7 +4152,7 @@ static int use_patch(struct patch *p)
 	/* See if it matches any of exclude/include rule */
 	for (i =3D 0; i < limit_by_name.nr; i++) {
 		struct string_list_item *it =3D &limit_by_name.items[i];
-		if (!fnmatch(it->string, pathname, 0))
+		if (!wildmatch(it->string, pathname, 0, NULL))
 			return (it->util !=3D NULL);
 	}
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index b4d7716..652b1d2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -315,7 +315,7 @@ static int match_patterns(const char **pattern, con=
st char *refname)
 	if (!*pattern)
 		return 1; /* no pattern always matches */
 	while (*pattern) {
-		if (!fnmatch(*pattern, refname, 0))
+		if (!wildmatch(*pattern, refname, 0, NULL))
 			return 1;
 		pattern++;
 	}
diff --git a/builtin/describe.c b/builtin/describe.c
index 7db43da..848acdf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -150,7 +150,7 @@ static int get_name(const char *path, const unsigne=
d char *sha1, int flag, void
 		return 0;
=20
 	/* Accept only tags that match the pattern, if given */
-	if (pattern && (!is_tag || fnmatch(pattern, path + 10, 0)))
+	if (pattern && (!is_tag || wildmatch(pattern, path + 10, 0, NULL)))
 		return 0;
=20
 	/* Is it annotated? */
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 51798b4..3e1d5c3 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -864,7 +864,7 @@ static int grab_single_ref(const char *refname, con=
st unsigned char *sha1, int f
 			     refname[plen] =3D=3D '/' ||
 			     p[plen-1] =3D=3D '/'))
 				break;
-			if (!fnmatch(p, refname, FNM_PATHNAME))
+			if (!wildmatch(p, refname, WM_PATHNAME, NULL))
 				break;
 		}
 		if (!*pattern)
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 39e5144..3e9eefb 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -22,7 +22,7 @@ static int tail_match(const char **pattern, const cha=
r *path)
 	if (snprintf(pathbuf, sizeof(pathbuf), "/%s", path) > sizeof(pathbuf)=
)
 		return error("insanely long ref %.*s...", 20, path);
 	while ((p =3D *(pattern++)) !=3D NULL) {
-		if (!fnmatch(p, pathbuf, 0))
+		if (!wildmatch(p, pathbuf, 0, NULL))
 			return 1;
 	}
 	return 0;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0b21d7e..c824d4e 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -87,7 +87,7 @@ static int subpath_matches(const char *path, const ch=
ar *filter)
 	const char *subpath =3D path;
=20
 	while (subpath) {
-		if (!fnmatch(filter, subpath, 0))
+		if (!wildmatch(filter, subpath, 0, NULL))
 			return subpath - path;
 		subpath =3D strchr(subpath, '/');
 		if (subpath)
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 852cff6..c12a9784 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -561,7 +561,7 @@ static void set_reflog_expiry_param(struct cmd_refl=
og_expire_cb *cb, int slot, c
 		return; /* both given explicitly -- nothing to tweak */
=20
 	for (ent =3D reflog_expire_cfg; ent; ent =3D ent->next) {
-		if (!fnmatch(ent->pattern, ref, 0)) {
+		if (!wildmatch(ent->pattern, ref, 0, NULL)) {
 			if (!(slot & EXPIRE_TOTAL))
 				cb->expire_total =3D ent->expire_total;
 			if (!(slot & EXPIRE_UNREACH))
diff --git a/builtin/replace.c b/builtin/replace.c
index 2336325..80b152a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -36,7 +36,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 {
 	struct show_data *data =3D cb_data;
=20
-	if (!fnmatch(data->pattern, refname, 0)) {
+	if (!wildmatch(data->pattern, refname, 0, NULL)) {
 		if (data->format =3D=3D REPLACE_FORMAT_SHORT)
 			printf("%s\n", refname);
 		else if (data->format =3D=3D REPLACE_FORMAT_MEDIUM)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d9217ce..d873172 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -450,7 +450,7 @@ static int append_matching_ref(const char *refname,=
 const unsigned char *sha1, i
 			slash--;
 	if (!*tail)
 		return 0;
-	if (fnmatch(match_ref_pattern, tail, 0))
+	if (wildmatch(match_ref_pattern, tail, 0, NULL))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
 		return append_head_ref(refname, sha1, flag, cb_data);
diff --git a/builtin/tag.c b/builtin/tag.c
index 74d3780..169c676 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -42,7 +42,7 @@ static int match_pattern(const char **patterns, const=
 char *ref)
 	if (!*patterns)
 		return 1;
 	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
+		if (!wildmatch(*patterns, ref, 0, NULL))
 			return 1;
 	return 0;
 }
diff --git a/diffcore-order.c b/diffcore-order.c
index fe7f1f4..53ea4d1 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -73,7 +73,7 @@ static int match_order(const char *path)
 		strbuf_addstr(&p, path);
 		while (p.buf[0]) {
 			char *cp;
-			if (!fnmatch(order[i], p.buf, 0))
+			if (!wildmatch(order[i], p.buf, 0, NULL))
 				return i;
 			cp =3D strrchr(p.buf, '/');
 			if (!cp)
diff --git a/dir.c b/dir.c
index b35b633..59ccb52 100644
--- a/dir.c
+++ b/dir.c
@@ -49,7 +49,9 @@ int strncmp_icase(const char *a, const char *b, size_=
t count)
=20
 int fnmatch_icase(const char *pattern, const char *string, int flags)
 {
-	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
+	return wildmatch(pattern, string,
+			 flags | (ignore_case ? WM_CASEFOLD : 0),
+			 NULL);
 }
=20
 inline int git_fnmatch(const struct pathspec_item *item,
@@ -58,7 +60,7 @@ inline int git_fnmatch(const struct pathspec_item *it=
em,
 {
 	if (prefix > 0) {
 		if (ps_strncmp(item, pattern, string, prefix))
-			return FNM_NOMATCH;
+			return WM_NOMATCH;
 		pattern +=3D prefix;
 		string +=3D prefix;
 	}
@@ -76,8 +78,9 @@ inline int git_fnmatch(const struct pathspec_item *it=
em,
 				 NULL);
 	else
 		/* wildmatch has not learned no FNM_PATHNAME mode yet */
-		return fnmatch(pattern, string,
-			       item->magic & PATHSPEC_ICASE ? FNM_CASEFOLD : 0);
+		return wildmatch(pattern, string,
+				 item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0,
+				 NULL);
 }
=20
 static int fnmatch_icase_mem(const char *pattern, int patternlen,
diff --git a/refs.c b/refs.c
index 89228e2..f89d589 100644
--- a/refs.c
+++ b/refs.c
@@ -1477,7 +1477,7 @@ static int filter_refs(const char *refname, const=
 unsigned char *sha1, int flags
 		       void *data)
 {
 	struct ref_filter *filter =3D (struct ref_filter *)data;
-	if (fnmatch(filter->pattern, refname, 0))
+	if (wildmatch(filter->pattern, refname, 0, NULL))
 		return 0;
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
diff --git a/revision.c b/revision.c
index a0df72f..6addff1 100644
--- a/revision.c
+++ b/revision.c
@@ -1191,7 +1191,7 @@ int ref_excluded(struct string_list *ref_excludes=
, const char *path)
 	if (!ref_excludes)
 		return 0;
 	for_each_string_list_item(item, ref_excludes) {
-		if (!fnmatch(item->string, path, 0))
+		if (!wildmatch(item->string, path, 0, NULL))
 			return 1;
 	}
 	return 0;
--=20
1.8.5.2.240.g8478abd
