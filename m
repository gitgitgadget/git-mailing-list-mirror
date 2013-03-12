From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/13] dir.c: inline convenient *_icase helpers
Date: Tue, 12 Mar 2013 20:04:50 +0700
Message-ID: <1363093500-16796-4-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOuN-0007Yu-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab3CLNFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:05:38 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:59467 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab3CLNFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:05:36 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so4981557pbb.20
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=x7A2SZeZdpkqwWYCNZrYO4WTOeCPbxBu6KVN2N8ZN6o=;
        b=gCd7L7TBuMZYVUbJrHXUvLTtwgtZKBdEYtCTOyfCHWXNd+aDGGyX330uIo5xJT+nd6
         Zb9MJOzy6qJ2UEvUy42mk2mjh0QHyelc1WA2fnPLzCtMNo8hO2r6qdjrtPiWsoTN1tzp
         p69ThOT01ExzA8qbrkliZPwZ6J52+bUj+MvHHxEPhv/e0m4+6VSnOv7oqzotU1CiOFIt
         ANQ+JjTh4AAqGTwIVpMulEf9Bh//yuNJyXm8E1jwwMgDgcm9NsmCxC9FLCOKCAkbIdEU
         eePdfREUEdXkNq0jEXj9v+xC3vX1Cmet3fOLGIJPj18r6yCxTeWfEci50FxzPct4v/w5
         S4Sg==
X-Received: by 10.68.12.103 with SMTP id x7mr37044214pbb.37.1363093536438;
        Tue, 12 Mar 2013 06:05:36 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id zm1sm24989968pbc.26.2013.03.12.06.05.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:05:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:05:30 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217953>

Like the previous patch, this cuts down the number of str*cmp calls in
read_directory (which does _a lot_). Again sorted results on webkit.git=
:

treat_leading_path:   0.000  0.000
read_directory:       3.674  3.558
+treat_one_path:      2.427  2.305
++is_excluded:        2.221  2.098
+++prep_exclude:      0.224  0.223
+++matching:          1.650  1.529
++dir_exist:          0.035  0.035
++index_name_exists:  0.288  0.291
lazy_init_name_hash:  0.257  0.257
+simplify_away:       0.085  0.086
+dir_add_name:        0.441  0.445

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 16 ----------------
 dir.h | 18 +++++++++++++++---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index 32a3adb..a69c8ac 100644
--- a/dir.c
+++ b/dir.c
@@ -47,22 +47,6 @@ static int read_directory_recursive(struct dir_struc=
t *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
-/* helper string functions with support for the ignore_case flag */
-int strcmp_icase(const char *a, const char *b)
-{
-	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
-}
-
-int strncmp_icase(const char *a, const char *b, size_t count)
-{
-	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
-}
-
-int fnmatch_icase(const char *pattern, const char *string, int flags)
-{
-	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
-}
-
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
diff --git a/dir.h b/dir.h
index c3eb4b5..560ade4 100644
--- a/dir.h
+++ b/dir.h
@@ -200,9 +200,21 @@ extern int remove_dir_recursively(struct strbuf *p=
ath, int flag);
 /* tries to remove the path with empty directories along it, ignores E=
NOENT */
 extern int remove_path(const char *path);
=20
-extern int strcmp_icase(const char *a, const char *b);
-extern int strncmp_icase(const char *a, const char *b, size_t count);
-extern int fnmatch_icase(const char *pattern, const char *string, int =
flags);
+/* helper string functions with support for the ignore_case flag */
+static inline int strcmp_icase(const char *a, const char *b)
+{
+	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+static inline int strncmp_icase(const char *a, const char *b, size_t c=
ount)
+{
+	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+}
+
+static inline int fnmatch_icase(const char *pattern, const char *strin=
g, int flags)
+{
+	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
+}
=20
 /*
  * The prefix part of pattern must not contains wildcards.
--=20
1.8.1.2.536.gf441e6d
