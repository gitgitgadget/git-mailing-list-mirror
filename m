From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Thu, 12 Sep 2013 17:12:42 +0800
Message-ID: <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 11:13:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK2xQ-0005nG-6y
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 11:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab3ILJM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 05:12:56 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43498 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3ILJMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 05:12:55 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so831101pad.18
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PV4QqO+TTXCUv4MrK7DYV/VDUOaSaPehGF6SFq/1pKI=;
        b=DcYu/pbQCOrvlGiO4COSdyE2hDTdCIGjAndbVt5lg+qZOqEGtih2kuh8NXfQr0f8Vr
         PmKoQP+dqzr9+efmiJBAKb5KFJqMgLkYtOhd6dRSZEJFS/bBaJz+GGRuGCqCFvwvmhkv
         ogptCtbqeCWYWrfYY8UlBAawXssXeCSn2JaR3+s3rGGCg5aNWqy34pgdzyXc3Of1htRf
         T0ZzlpBsgxTvLC02FyiA7MGPu+G4HRgnOgD+QwbTRNZ7e3LLQFtGOkH2Lhv99aBrPoJ7
         q9g+pZoOY+0fik1dZ0wRlO8Vw/ZeaCJp0ayn+D/LGQ5XJI/7yv3Q/GYAIvQDgQ2LryGu
         MP3w==
X-Received: by 10.68.216.227 with SMTP id ot3mr6575345pbc.80.1378977174752;
        Thu, 12 Sep 2013 02:12:54 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id ry4sm9391271pab.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 02:12:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.14.g5ac1b82
In-Reply-To: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234630>

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
index 7f3324a..ffcdea1 100644
--- a/path.c
+++ b/path.c
@@ -441,6 +441,16 @@ int adjust_shared_perm(const char *path)
 	return 0;
 }
 
+static int have_same_root(const char *path1, const char *path2)
+{
+	int is_abs1, is_abs2;
+
+	is_abs1 = is_absolute_path(path1);
+	is_abs2 = is_absolute_path(path2);
+	return (is_abs1 && is_abs2 && !strncasecmp(path1, path2, 1)) ||
+	       (!is_abs1 && !is_abs2);
+}
+
 /*
  * Give path as relative to prefix.
  *
@@ -461,6 +471,16 @@ const char *relative_path(const char *in, const char *prefix,
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
index 76c7792..c3c3b33 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -208,6 +208,10 @@ relative_path a/b/	a/b		./
 relative_path a		a/b		../
 relative_path x/y	a/b		../../x/y
 relative_path a/c	a/b		../c
+relative_path a/b	/x/y		a/b
+relative_path /a/b	x/y		/a/b	POSIX
+relative_path d:/a/b	D:/a/c		../b	MINGW
+relative_path C:/a/b	D:/a/c		C:/a/b	MINGW
 relative_path a/b	"<empty>"	a/b
 relative_path a/b 	"<null>"	a/b
 relative_path "<empty>"	/a/b		./
-- 
1.8.3.rc2.14.g5ac1b82
