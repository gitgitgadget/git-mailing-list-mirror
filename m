From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/3] relative_path should honor DOS and UNC paths
Date: Tue, 17 Sep 2013 16:30:23 +0800
Message-ID: <2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 10:32:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLqht-0004dH-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 10:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3IQIcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 04:32:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44646 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3IQIcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 04:32:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5240299pdj.26
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZnIdgkw8G1ay0kuiUijSacIbFh9tFSVgukj4LJXogN8=;
        b=DUxpv33oZFXhAR5hGw908YpDAFqXizXk8sLpYqWTPLl7buSKCGMKOVAVJogjMYTxQF
         Gs5sEU8KId4esCJ8CsMyB7hDZOvKMFTq8cfPI1F7trCXiEi8IpXv81hTNkpWL7ikCJgH
         n0DbSsjLFyiYfeos8YVaTI5qrPdSErnFVkR9X6YqRHzkCViI61L1v02cKvU+SvHfBDT7
         2DwGS6dyhoa83n6yxs0fTyYRT5wBotHR4xP8R4SqwcQrIhY7BaW7ZQfOnOBxzYdGagBb
         gxyOmkSaVwWMmmo07T6rBQVCGRB5LtIvDzXJXsRmM0G8ltgJbSourvWSegnmoDraWxPC
         BDKw==
X-Received: by 10.68.194.35 with SMTP id ht3mr18598987pbc.88.1379406738531;
        Tue, 17 Sep 2013 01:32:18 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id im2sm36572935pbd.31.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 01:32:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.g2f083d1
In-Reply-To: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
In-Reply-To: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
References: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234862>

Tvangeste found that the "relative_path" function could not work
properly on Windows if "in" and "prefix" have DOS driver prefix
(such as "C:/windows"). And the "relative_path" function won't
work properly if either "in" or "prefix" is a UNC path (like
"//host/share"). ($gmane/234434)

E.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
should return "C:/a/b", but returns "../../C:/a/b", which is wrong.

So make relative_path honor DOS and UNC paths, and add test cases
for it in t0060.

Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 compat/mingw.h        |  9 +++++++++
 git-compat-util.h     |  4 ++++
 path.c                | 25 +++++++++++++++++++++++++
 t/t0060-path-utils.sh |  8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index bd0a88b..06e9f49 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -311,6 +311,15 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
 
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
+static inline int is_unc_path(const char *path)
+{
+	if (!is_dir_sep(*path) || !is_dir_sep(*(path+1)) || is_dir_sep(*(path+2)))
+		return 0;
+	for (path += 2; *path; path++)
+		if (is_dir_sep(*path))
+			return 1;
+	return 0;
+}
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
 	char *ret = NULL;
diff --git a/git-compat-util.h b/git-compat-util.h
index 9549de6..93c2206 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -274,6 +274,10 @@ extern char *gitbasename(char *);
 #define is_dir_sep(c) ((c) == '/')
 #endif
 
+#ifndef is_unc_path
+#define is_unc_path(path) 0
+#endif
+
 #ifndef find_last_dir_sep
 #define find_last_dir_sep(path) strrchr(path, '/')
 #endif
diff --git a/path.c b/path.c
index 9fd28bcd..544d10d 100644
--- a/path.c
+++ b/path.c
@@ -434,6 +434,21 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+static int have_same_root(const char *path1, const char *path2)
+{
+	int is_abs1, is_abs2;
+
+	is_abs1 = is_absolute_path(path1);
+	is_abs2 = is_absolute_path(path2);
+	if (is_abs1 && is_abs2) {
+		if (is_unc_path(path1) ^ is_unc_path(path2))
+			return 0;
+		return tolower(path1[0]) == tolower(path2[0]);
+	} else {
+		return !is_abs1 && !is_abs2;
+	}
+}
+
 /*
  * Give path as relative to prefix.
  *
@@ -454,6 +469,16 @@ const char *relative_path(const char *in, const char *prefix,
 	else if (!prefix_len)
 		return in;
 
+	if (have_same_root(in, prefix)) {
+		/* bypass dos_drive, for "c:" is identical to "C:" */
+		if (has_dos_drive_prefix(in)) {
+			i = 2;
+			j = 2;
+		}
+	} else {
+		return in;
+	}
+
 	while (i < prefix_len && j < in_len && prefix[i] == in[j]) {
 		if (is_dir_sep(prefix[i])) {
 			while (is_dir_sep(prefix[i]))
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 92976e0..830b6d5 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -210,6 +210,14 @@ relative_path foo/a/b/		foo/a/b		./
 relative_path foo/a		foo/a/b		../
 relative_path foo/x/y		foo/a/b		../../x/y
 relative_path foo/a/c		foo/a/b		../c
+relative_path foo/a/b		/foo/x/y	foo/a/b
+relative_path /foo/a/b		foo/x/y		/foo/a/b
+relative_path d:/a/b		D:/a/c		../b		MINGW
+relative_path C:/a/b		D:/a/c		C:/a/b		MINGW
+relative_path //host1/a/b	//host1/a/c	../b
+relative_path //host1/a/b	//host2/a/c	../../../host1/a/b
+relative_path //host1/a/b	/foo/a/c	//host1/a/b	MINGW
+relative_path /foo/a/b		//host2/a/c	/foo/a/b	MINGW
 relative_path foo/a/b		"<empty>"	foo/a/b
 relative_path foo/a/b 		"<null>"	foo/a/b
 relative_path "<empty>"		/foo/a/b	./
-- 
1.8.4.460.g2f083d1
