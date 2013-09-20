From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 2/3] relative_path should honor dos-driver-prefix
Date: Fri, 20 Sep 2013 10:38:47 +0800
Message-ID: <b7d2432db756e16e9addb2fcccf5538c6fad342f.1379644482.git.worldhello.net@gmail.com>
References: <cover.1379644482.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 04:41:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMqf8-0002kk-N2
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 04:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab3ITClk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 22:41:40 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:62192 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3ITClj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 22:41:39 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so9114606pdi.5
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 19:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ogBfhLEaz2Y1cZEithvq3xzoBSEbwtinAwzgAf3vywg=;
        b=uF+LURmXHo+2wYEG5cmBS1hyxC9GGNvaph4Gm8mfeqlLVq5ixhcLwPvlCnYxGbX2ig
         yoiOj9TiG/xGCXjh9szADNvJjnUvN38ZG78v1pJ/sf+druwDYAkPdfI0zBszs1JzBItw
         ykxG/U3G345tJmrINsSCzogg7z2HsCNIdXBZoB+1aFRvHgNRWmUNHdtcfB+bKuEWItZr
         PtOnEOJxeRv3+8U4Lt3ZFsHoMIn1Kd93w4kNmybEhULcFJobczpseFagFMt7EgP5nfeO
         unCIX5TvhPBwtse2c5dbuDHT4eAiO6k/LFc0QHOorOTNTffwkEVtOz7XPr1kr50bKZPo
         BJvg==
X-Received: by 10.66.136.227 with SMTP id qd3mr5997930pab.113.1379644898059;
        Thu, 19 Sep 2013 19:41:38 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id wp8sm12412723pbc.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 19:41:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.gbed9cb4
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1379644482.git.worldhello.net@gmail.com>
References: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com> <cover.1379644482.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235048>

Tvangeste found that the "relative_path" function could not work
properly on Windows if "in" and "prefix" have DOS driver prefix
(such as "C:/windows"). ($gmane/234434)

E.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
should return "C:/a/b", but returns "../../C:/a/b", which is wrong.

So make relative_path honor dos-driver-prefix, and add test cases
for it in t0060.

Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 path.c                | 20 ++++++++++++++++++++
 t/t0060-path-utils.sh |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/path.c b/path.c
index 7f3324a..0c16dc5 100644
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
+	return (is_abs1 && is_abs2 && tolower(path1[0]) == tolower(path2[0])) ||
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
index 92976e0..40dfa2d 100755
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
1.8.4.460.gbed9cb4
