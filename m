From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/6] dir.c: inline convenient *_icase helpers
Date: Sun, 10 Mar 2013 13:14:26 +0700
Message-ID: <1362896070-17456-3-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXX-00019T-Nw
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab3CJGOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:14:53 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:32787 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3CJGOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:14:51 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so2617186pbb.6
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GijRg6miO6FqugDc85FF4HA/0pb8WHHus7WzTcmAV+0=;
        b=LRhA9jEKUTG6wQIrO96Ti88DnQIItL1qx3NHdBpNHKYwSCZtkyaLkVjqSvtJMWh0o3
         G+yxe5B6QOZPr98gbYzN31PXsNjYBmiwRcpizmbbSxzYWUJ+CmFOoEHF7XJvIvvSup0m
         Ujx2tlGpfcB3H8HMdgw8icfr4GuyKYCjqcJKAfyF8KQCYBdgaZq5JQuwuTClbCZ6y/mY
         TaFYWDUQLMqkIzkdU7kbcsg6KtKAViW0tq3ePREXmRqq3AOYRdAY9No+Zxb8h0LeeNIM
         gZMj8hnfZ6lokTG6KbyCodplci23tyj2NoY8hKQOaHmCEanb2RhMn27rbvI4IarcuEtZ
         Ni7A==
X-Received: by 10.68.241.225 with SMTP id wl1mr17022713pbc.170.1362896091433;
        Sat, 09 Mar 2013 22:14:51 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ol7sm13855668pbb.14.2013.03.09.22.14.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:14:50 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:14:46 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217783>

Like the previous patch, this cuts down the number of str*cmp calls in
read_directory (which does _a lot_). Again sorted results on webkit.git=
:

        before      after
user    0m0.554s    0m0.548s
user    0m0.564s    0m0.549s
user    0m0.571s    0m0.554s
user    0m0.576s    0m0.557s
user    0m0.578s    0m0.558s
user    0m0.579s    0m0.559s
user    0m0.583s    0m0.562s
user    0m0.584s    0m0.564s
user    0m0.586s    0m0.566s
user    0m0.592s    0m0.569s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 16 ----------------
 dir.h | 18 +++++++++++++++---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index b3cd66c..9960a37 100644
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
