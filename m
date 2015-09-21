From: larsxschneider@gmail.com
Subject: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 21 Sep 2015 12:01:40 +0200
Message-ID: <1442829701-2347-2-git-send-email-larsxschneider@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 12:02:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdxv6-0004Wd-Jn
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbbIUKB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:01:56 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33932 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbbIUKBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:01:55 -0400
Received: by wicfx3 with SMTP id fx3so137811298wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv7rKUxprCB+mS/TtIL5T+OhlepK0W1w9ST2LGUZXDw=;
        b=xZ+WpvmvIGoIeGj9UW4n2SOgdbHt6ibgss2iG+N6z58K+4+oTgvKe8CdHefIownT2a
         8Jbdn/7ks3u51aRUoZCeO4jIePnYxwZsequHLal+e4Dy734556ZdPzbytxJF2Hf9qkKd
         M649f9VSAnaS6pxlYo+PxZ1WaT5DdZ4qzm/YWcf1yl2FSPRxHzuznANfbXn16IAdyJr9
         07IH8uXH6xsdlYQEvdXAPBGF98zQ9HXolMD+ztOUd+CYw7qjgKbVQiAYnsbvWsYoJ/FR
         tlybuqEZNuAAWXxv56tRpm/qVB9p2ma6/EtasfOQe9bB2swAoFufe7kXuEvIL7qhvP+c
         X8pw==
X-Received: by 10.194.90.20 with SMTP id bs20mr23875208wjb.87.1442829714416;
        Mon, 21 Sep 2015 03:01:54 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id kb9sm23192082wjb.49.2015.09.21.03.01.43
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 03:01:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278296>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with
type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
attempts to retrieve the file then the process crashes with a
"Translation of file content failed" error.

More info here: http://answers.perforce.com/articles/KB/3117

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9825-git-p4-handle-utf16-without-bom.sh | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 t/t9825-git-p4-handle-utf16-without-bom.sh

diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
new file mode 100755
index 0000000..65c3c4e
--- /dev/null
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='git p4 handling of UTF-16 files without BOM'
+
+. ./lib-git-p4.sh
+
+UTF16="\227\000\227\000"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
+	(
+		cd "$cli" &&
+		printf "$UTF16" >file1 &&
+		p4 add -t utf16 file1 &&
+		p4 submit -d "file1"
+	) &&
+
+	(
+		cd "db" &&
+		p4d -jc &&
+		# P4D automatically adds a BOM. Remove it here to make the file invalid.
+		sed -e "$ d" depot/file1,v >depot/file1,v.new &&
+		mv -- depot/file1,v.new depot/file1,v &&
+		printf "@$UTF16@" >>depot/file1,v &&
+		p4d -jrF checkpoint.1
+	)
+'
+
+test_expect_failure 'clone depot with invalid UTF-16 file in verbose mode' '
+	git p4 clone --dest="$git" --verbose //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		printf "$UTF16" >expect &&
+		test_cmp_bin expect file1
+	)
+'
+
+test_expect_failure 'clone depot with invalid UTF-16 file in non-verbose mode' '
+	git p4 clone --dest="$git" //depot
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
