From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 2/3] relative_path should honor dos-drive-prefix
Date: Mon, 14 Oct 2013 10:29:39 +0800
Message-ID: <f352b224b01bc0e99c793eb505c429562894a067.1381717700.git.worldhello.net@gmail.com>
References: <cover.1381717700.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 04:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVXvH-0002kN-FE
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 04:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab3JNCaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 22:30:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62873 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673Ab3JNCaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 22:30:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so6748486pbb.33
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bhTjBD6z1TfT7CK1NbqcR2kgyhTcSpFF6LrTM5kZ3s0=;
        b=qOjC1GH39K/PcvJk2Z/A4H47CigCZgi12Cr4iQL0RslLavtF2s0CwlAT3UBP1DGSyA
         XntTKcBTQUpjvNm8m1fupZ9KQbXpQuwfPL3OcKKCEQ7fon7Pv0Ue+FGi/wgSxwFtommI
         u6RiAbRkZVxdI1c7yCmIa8I38NP582mfgGMI3/AaPg+Gpnta2Htrc3PO5qY4AMn/n74d
         4xSFQoLocKGwmuh68wNZWVXjP0mXjW4mF93E6QRpH8gCh7biGw59O/eiu1s8JU1cCrmd
         qS2QX1nbuhUrT22tvXFeaHymrNNQmsEnPkcxMsXkkPzpznt8dILeQxacFagAbIK0JRnw
         NGww==
X-Received: by 10.68.197.36 with SMTP id ir4mr6455350pbc.96.1381717809372;
        Sun, 13 Oct 2013 19:30:09 -0700 (PDT)
Received: from localhost.localdomain ([114.248.133.111])
        by mx.google.com with ESMTPSA id gh2sm74692626pbc.40.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 19:30:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1381717700.git.worldhello.net@gmail.com>
References: <52570EC8.3050207@gmail.com> <cover.1381717700.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236088>

Tvangeste found that the "relative_path" function could not work
properly on Windows if "in" and "prefix" have DOS drive prefix
(such as "C:/windows"). ($gmane/234434)

E.g., When execute: test-path-utils relative_path "C:/a/b" "D:/x/y",
should return "C:/a/b", but returns "../../C:/a/b", which is wrong.

So make relative_path honor DOS drive prefix, and add test cases
for it in t0060.

Reported-by: Tvangeste <i.4m.l33t@yandex.ru>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.4
