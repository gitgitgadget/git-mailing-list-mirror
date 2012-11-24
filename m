From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] pathspec: do exact comparison on the leading non-wildcard part
Date: Sat, 24 Nov 2012 11:33:49 +0700
Message-ID: <1353731631-20593-3-git-send-email-pclouds@gmail.com>
References: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 05:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc7Rm-0005gC-8J
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 05:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726Ab2KXEeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2012 23:34:17 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2KXEeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 23:34:16 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6867625pbc.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 20:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iQ5032z1JpNf6gUrtWVfm6Xwru1iIABbeJcu+05XE3o=;
        b=oOOReHiEcjS7JPmgWsqfdkhTp9//678QAw8J1oPWt3U/1WhWHDFQFnDbzwn51/oDuY
         3tWWg2mhBMEwzll9FRcWEiorjiv58jR07wBrHI9bG0npct3uWyON/hNrljnGyCnTWuA9
         1pw74GM8cwOjemKa8c72M03gGqwqiYQCvGIJDopw/xWL1gKV1UVSrHTODf68U4U4mq9C
         mlTDtapCxVrM+/bxIKbF7htSxghsYgLNf/z2zcAWxB96B/XINFJhxSZab59ztma3KyHe
         tSb/PdoAJEBOyZtzzpqpUHDjkWA651RioDh+4x1qmWnSX9/FuCEJS09bvWSFuMcZnkMk
         6W4w==
Received: by 10.68.237.167 with SMTP id vd7mr19298470pbc.161.1353731655516;
        Fri, 23 Nov 2012 20:34:15 -0800 (PST)
Received: from lanh ([115.74.35.242])
        by mx.google.com with ESMTPS id oi2sm4844522pbb.62.2012.11.23.20.34.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 20:34:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 24 Nov 2012 11:34:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1353731631-20593-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210312>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c       | 18 +++++++++++++++++-
 dir.h       |  8 ++++++++
 tree-walk.c |  6 ++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index c391d46..f81e1d2 100644
--- a/dir.c
+++ b/dir.c
@@ -34,6 +34,21 @@ int fnmatch_icase(const char *pattern, const char *s=
tring, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
 }
=20
+inline int git_fnmatch(const char *pattern, const char *string,
+		       int flags, int prefix)
+{
+	int fnm_flags =3D 0;
+	if (flags & GFNM_PATHNAME)
+		fnm_flags |=3D FNM_PATHNAME;
+	if (prefix > 0) {
+		if (strncmp(pattern, string, prefix))
+			return FNM_NOMATCH;
+		pattern +=3D prefix;
+		string +=3D prefix;
+	}
+	return fnmatch(pattern, string, fnm_flags);
+}
+
 static size_t common_prefix_len(const char **pathspec)
 {
 	const char *n, *first;
@@ -230,7 +245,8 @@ static int match_pathspec_item(const struct pathspe=
c_item *item, int prefix,
 			return MATCHED_RECURSIVELY;
 	}
=20
-	if (item->nowildcard_len < item->len && !fnmatch(match, name, 0))
+	if (item->nowildcard_len < item->len &&
+	    !git_fnmatch(match, name, 0, item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
=20
 	return 0;
diff --git a/dir.h b/dir.h
index f5c89e3..0e8ae84 100644
--- a/dir.h
+++ b/dir.h
@@ -139,4 +139,12 @@ extern int strcmp_icase(const char *a, const char =
*b);
 extern int strncmp_icase(const char *a, const char *b, size_t count);
 extern int fnmatch_icase(const char *pattern, const char *string, int =
flags);
=20
+/*
+ * The prefix part of pattern must not contains wildcards.
+ */
+#define GFNM_PATHNAME 1		/* similar to FNM_PATHNAME */
+
+extern int git_fnmatch(const char *pattern, const char *string,
+		       int flags, int prefix);
+
 #endif
diff --git a/tree-walk.c b/tree-walk.c
index af871c5..2fcf3c0 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -627,7 +627,8 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				return entry_interesting;
=20
 			if (item->nowildcard_len < item->len) {
-				if (!fnmatch(match + baselen, entry->path, 0))
+				if (!git_fnmatch(match + baselen, entry->path,
+						 0, item->nowildcard_len - baselen))
 					return entry_interesting;
=20
 				/*
@@ -652,7 +653,8 @@ match_wildcards:
=20
 		strbuf_add(base, entry->path, pathlen);
=20
-		if (!fnmatch(match, base->buf + base_offset, 0)) {
+		if (!git_fnmatch(match, base->buf + base_offset,
+				 0, item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
 			return entry_interesting;
 		}
--=20
1.8.0.rc2.23.g1fb49df
