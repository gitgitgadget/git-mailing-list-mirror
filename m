From: larsxschneider@gmail.com
Subject: [PATCH v2 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Mon, 14 Sep 2015 18:55:27 +0200
Message-ID: <1442249728-89494-2-git-send-email-larsxschneider@gmail.com>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 18:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbX2X-00073B-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 18:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbbINQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 12:55:34 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33232 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779AbbINQzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 12:55:32 -0400
Received: by ykft14 with SMTP id t14so7001231ykf.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBbF5h15WmdFnJbE5L4jUaY64iG/xtVIARgX4qXgNMk=;
        b=uCC1qi6lp48nIE9x9pIfY421gKnlqZGzhwTNZPljlbrcL5lN0Uu+lSj8PKi2sVNbdC
         G9qeWy6yxbis0TUSJ4KrMqBspS3U5W36Hw3YzCcjTawaoGlfukHUsKJNCPtk1W8XbQQy
         2J7An7xyew78U+CtdLj1c1kQDeRhWfZ/f4a9N9dy1rkyZIIxvceEnJow6Wtm3TmynTVH
         ckOloUYVsJjADJpEYqn2EfricCW+r7FvigUFLbvUJo4I2nCgvNgZ9U+0cNQj6U79DIIV
         0mJmOqzM6lJ+dEhoPGQZw8GvZSVqemge5P2oP8bm3IZMUWCxK0hXfrF4rH7/rkPMQvJB
         pslg==
X-Received: by 10.129.52.10 with SMTP id b10mr14656229ywa.58.1442249732031;
        Mon, 14 Sep 2015 09:55:32 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id lh11sm15264784wic.18.2015.09.14.09.55.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 09:55:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277838>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with
type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
attempts to retrieve the file then the process crashes with a
"Translation of file content failed" error.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9824-git-p4-handle-utf16-without-bom.sh | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh

diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-git-p4-handle-utf16-without-bom.sh
new file mode 100755
index 0000000..fa8043b
--- /dev/null
+++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+test_description='git p4 handle UTF-16 without BOM'
+
+. ./lib-git-p4.sh
+
+UTF16="\\x97\\x0\\x97\\x0"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
+	(
+		cd "$cli" &&
+		echo "file1 -text" > .gitattributes &&
+		perl -e "printf \"$UTF16\"" >file1 &&
+		p4 add -t utf16 file1 &&
+
+		p4 add .gitattributes &&
+		p4 submit -d "file1"
+	) &&
+
+	(
+		cd "db" &&
+		p4d -jc &&
+		# P4D automatically adds a BOM. Remove it here to make the file invalid.
+		perl -i -ne "print unless eof" depot/file1,v &&
+		perl -e "printf \"@$UTF16@\"" >> depot/file1,v &&
+		p4d -jrF checkpoint.1
+	)
+'
+
+test_expect_success 'clone depot with invalid UTF-16 file' '
+	git p4 clone --dest="$git" --verbose //depot &&
+	(
+		cd "$git" &&
+		perl -e "printf \"$UTF16\"" > expect &&
+		test_cmp_bin expect file1
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
2.5.1
