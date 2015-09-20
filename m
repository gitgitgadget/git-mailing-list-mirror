From: larsxschneider@gmail.com
Subject: [PATCH v3 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Sun, 20 Sep 2015 18:22:10 +0200
Message-ID: <1442766131-45017-2-git-send-email-larsxschneider@gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, tboegi@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 18:22:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdhNg-0000gb-P3
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 18:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbbITQWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 12:22:17 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38703 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbbITQWP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 12:22:15 -0400
Received: by wiclk2 with SMTP id lk2so83228545wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OjhX+37FkFhtCXTaYMDAgC8RFSeld32OsSFl6ykfJFc=;
        b=XaZ8aSmdgptvDWg8QPYwRifYTKQp2hnsLHYeaHNp1ypfCdjPL2kPLeU8dkxK1/YhKP
         8p68bLhbojGo+1LWH/qetOK0jvqf+H0glr3Kst+BWrBVBCwn4BBpzgFC30sypKJVaQoI
         WOTuIRdKDQf1Cg1XsxsbFZsXZdABWy9RajzrH5fe9z/kIV/6NcgMMvA1vEkh5YRVsnW5
         wGxq4Q7jVw1YTYBluYBRcIZNPnnhu4kw54OsHZ9huoH0P8YcImpdKYO/8dSn+lcDwxOu
         5aGBo3fT0YhQIhUUDmwWJm6iKzV7cfFhIeTli3t2Yh1BZ8vlNOxsoI3u8cgGAxmIYztI
         7HSA==
X-Received: by 10.194.91.193 with SMTP id cg1mr21188881wjb.88.1442766134451;
        Sun, 20 Sep 2015 09:22:14 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id nf15sm9018570wic.22.2015.09.20.09.22.13
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 09:22:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278246>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with
type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
attempts to retrieve the file then the process crashes with a
"Translation of file content failed" error.

More info here: http://answers.perforce.com/articles/KB/3117

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9824-git-p4-handle-utf16-without-bom.sh | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh

diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-git-p4-handle-utf16-without-bom.sh
new file mode 100755
index 0000000..517f6da
--- /dev/null
+++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
@@ -0,0 +1,49 @@
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
+		sed -i.bak "$ d" depot/file1,v &&
+		printf "@$UTF16@" >>depot/file1,v &&
+		p4d -jrF checkpoint.1
+	)
+'
+
+test_expect_success 'clone depot with invalid UTF-16 file in verbose mode' '
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
