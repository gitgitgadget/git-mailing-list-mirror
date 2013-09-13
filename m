From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/3] relative_path should honor dos_drive_prefix
Date: Fri, 13 Sep 2013 13:08:13 +0800
Message-ID: <79cfcc0c66eb19e3621fff2dafefdddbcbc824cf.1379048276.git.worldhello.net@gmail.com>
References: <cover.1379048276.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 07:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKLet-00074c-7D
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 07:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348Ab3IMFLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 01:11:04 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:54309 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3IMFLC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 01:11:02 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so751803pbc.2
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 22:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HMlAr3mozi5quJpTzNOXYANz7Nebf1TKaGOR4B4ASRo=;
        b=DbpBa7CvmFm78v8rAE3qNEa9UCmGXqGZ1NfXZpi2ZdW/IJgoLgGt/LUIG2k/JvK78l
         oFUl9uStZcXNw4+HAMoSg6NXtu/5KlsfwDBomc84T3qNhBNLB7FH1js013WG+lbC6Qdh
         6s5oA7cG5rDLmIFZ+0L90lT7lYEgnD2Xj3M580vE1pU3H0uZO6QS6NXn4pUNZzGEUZp3
         xWfI4SS3ZgmJkW/yeW0Dj0wKSo2rF8MfmD2yjM31dc2HXvX/u4L8vOJqLVGgBI5J6B7u
         wELD/jlceuUZfxyrtuJtgWHnwNxGx8mn3/L2bW4iMas2mqK7AVFDvzITP7XNkTK1Cpfc
         2/wA==
X-Received: by 10.66.146.42 with SMTP id sz10mr13455159pab.100.1379049062539;
        Thu, 12 Sep 2013 22:11:02 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id qa9sm8985593pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 22:11:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.459.gd80d422
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379048276.git.worldhello.net@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <cover.1379048276.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234727>

Tvangeste found that the "relative_path" function could not work
properly on Windows if "in" and "prefix" have dos driver prefix.
($gmane/234434)

e.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
should return "C:/a/b", but returns "../../C:/a/b", which is wrong.

So make relative_path honor dos_drive_prefix, and add test cases
for it in t0060.

Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 path.c                | 20 ++++++++++++++++++++
 t/t0060-path-utils.sh |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/path.c b/path.c
index 9fd28bcd..65d376d 100644
--- a/path.c
+++ b/path.c
@@ -434,6 +434,16 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+static int have_same_root(const char *path1, const char *path2)
+{
+	int is_abs1, is_abs2;
+
+	is_abs1 = is_absolute_path(path1);
+	is_abs2 = is_absolute_path(path2);
+	return (is_abs1 && is_abs2 && tolower(path1[0]) == tolower(path2[0])) ||
+	       (!is_abs1 && !is_abs2);
+}
+
 /*
  * Give path as relative to prefix.
  *
@@ -454,6 +464,16 @@ const char *relative_path(const char *in, const char *prefix,
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
index 82a6f21..0187d11 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -210,6 +210,10 @@ relative_path foo/a/b/		foo/a/b		./
 relative_path foo/a		foo/a/b		../
 relative_path foo/x/y		foo/a/b		../../x/y
 relative_path foo/a/c		foo/a/b		../c
+relative_path foo/a/b		/foo/x/y	foo/a/b
+relative_path /foo/a/b		foo/x/y		/foo/a/b
+relative_path d:/a/b		D:/a/c		../b		MINGW
+relative_path C:/a/b		D:/a/c		C:/a/b		MINGW
 relative_path foo/a/b		"<empty>"	foo/a/b
 relative_path foo/a/b 		"<null>"	foo/a/b
 relative_path "<empty>"		/foo/a/b	./
-- 
1.8.4.459.gd80d422
