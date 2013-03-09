From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] dir.c: inline convenient *_icase helpers
Date: Sat,  9 Mar 2013 11:09:49 +0700
Message-ID: <1362802190-7331-3-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 05:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEB7d-0006q6-FR
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 05:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933566Ab3CIEKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 23:10:12 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:33272 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760321Ab3CIEKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 23:10:11 -0500
Received: by mail-da0-f51.google.com with SMTP id z17so266732dal.24
        for <git@vger.kernel.org>; Fri, 08 Mar 2013 20:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ZxbF2+N9j218vk1T/4kQHr5sbUXQ8zBqoILBVKZoeYs=;
        b=ojb8F+m9YOu8JAeEiaTnLPaijbaMtUqgT04+W+bEFJu5ncwqkYLIK/5AEintt0lgwN
         TwTHe6Sc7cIQiw5tNE8bYo4kee+iJqtUCa5CSgB5PyD5sCviNbE155TuWLd0NoLCEmnh
         MPuCG5C1hyzG9ERE0gW30fcbdN9IukPQ+KVFwEqpGYrXjaWGps7yBqz0wdIJxJ7dcs89
         elHZ8DEWpjMBiD71tIl+JjiLEo1HbISSJb4SxHG2Hziidw+drL0Wn14jXzpLGOl7+nsp
         +ol8oMhuavM8YU2tqZWPyiO7+of95cqJOSGKSJ9KEbeJcFW8NdRF9bPO/lulrtpBa1Bk
         RDqg==
X-Received: by 10.68.49.106 with SMTP id t10mr8131189pbn.63.1362802210700;
        Fri, 08 Mar 2013 20:10:10 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id wm3sm8158964pbc.4.2013.03.08.20.10.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Mar 2013 20:10:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 09 Mar 2013 11:10:05 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217698>

Like the previous patch, this cuts down the number of str*cmp calls in
read_directory (which does _a lot_). Again sorted results on webkit.git=
:

        before      after
user    0m0.546s    0m0.519s
user    0m0.549s    0m0.521s
user    0m0.550s    0m0.523s
user    0m0.558s    0m0.532s
user    0m0.560s    0m0.534s
user    0m0.561s    0m0.536s
user    0m0.562s    0m0.537s
user    0m0.566s    0m0.545s
user    0m0.568s    0m0.546s
user    0m0.573s    0m0.548s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 16 ----------------
 dir.h | 18 +++++++++++++++---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index 669cf80..f58320d 100644
--- a/dir.c
+++ b/dir.c
@@ -21,22 +21,6 @@ static int read_directory_recursive(struct dir_struc=
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
