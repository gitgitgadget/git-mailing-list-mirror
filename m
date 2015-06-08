From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 4/5] am: use gmtime() to parse mercurial patch date
Date: Mon,  8 Jun 2015 23:48:50 +0800
Message-ID: <1433778531-18260-5-git-send-email-pyokagan@gmail.com>
References: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Chris Packham <judge.packham@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 17:50:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zJY-00016Z-FJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbbFHPuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:50:13 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33316 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbFHPuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:50:03 -0400
Received: by padev16 with SMTP id ev16so42896809pad.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIvoMVXzEGTJSYQcEE4wTYAX4HcMLPhRtuPEvDlfUVw=;
        b=EmFx1q3ZgzGbkDCx5MUMSaCO9RTy0xrGDBp7vQaXzD0cBvHCtTwQVjlJoMaecY1f6B
         iXlhtGyGiSf2ZRPhwNH4eW0KAE3CBaxRwbdpM2j5fDpRgO+KBwrSCioq/ME0w37OVn1S
         Kyt3nnWmylA57sKbb/cy57gNL2gDbI9dGW3Is5q6CvRFYqVQOLcb+wzjGPCeafTIFQbl
         ggpW6+v0JG1N0ux+wIcc6yil/67H/Gy6dEUsUjifbVK4KB8L19vbnx438l6n2UIFHFo9
         d3OUfFVTtiJy67qsGTYjd6wubwLbxBClA0wG+XiRy9+KgVxhmRT0lHL6opWQ84kSy81B
         eygQ==
X-Received: by 10.70.38.105 with SMTP id f9mr23234017pdk.14.1433778602352;
        Mon, 08 Jun 2015 08:50:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.49.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:50:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271054>

An example of the line in a mercurial patch that specifies the date of
the commit would be:

	# Date 1433753301 25200

where the first number is the number of seconds since the unix epoch (in
UTC), and the second number is the offset of the timezone, in second s
west of UTC (negative if the timezone is east of UTC).

git-am uses localtime() to break down the first number into its
components (year, month, day, hours, minutes, seconds etc.). However,
the returned components are relative to the user's time zone. As a
result, if the user's time zone does not match the time zone specified
in the patch, the resulting commit will have the wrong author date.

Fix this by using gmtime() instead, which uses UTC instead of the user's
time zone.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh     |  6 +++---
 t/t4150-am.sh | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 83f2ea6..d97da85 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -343,11 +343,11 @@ split_patches () {
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
 				elsif (/^\# Date /) {
 					my ($hashsign, $str, $time, $tz) = split ;
-					$tz = sprintf "%+05d", (0-$tz)/36;
+					$tz_str = sprintf "%+05d", (0-$tz)/36;
 					print "Date: " .
 					      strftime("%a, %d %b %Y %H:%M:%S ",
-						       localtime($time))
-					      . "$tz\n";
+						       gmtime($time-$tz))
+					      . "$tz_str\n";
 				} elsif (/^\# /) { next ; }
 				else {
 					print "\n", $_ ;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 7aad8f8..4beb4b3 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -122,6 +122,19 @@ test_expect_success setup '
 		echo "# This series applies on GIT commit $(git rev-parse first)" &&
 		echo "patch"
 	} >stgit-series/series &&
+	{
+		echo "# HG changeset patch" &&
+		echo "# User $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" &&
+		echo "# Date $test_tick 25200" &&
+		echo "#      $(git show --pretty="%aD" -s second)" &&
+		echo "# Node ID $_z40" &&
+		echo "# Parent  $_z40" &&
+		cat msg &&
+		echo &&
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
+		echo &&
+		git diff-tree --no-commit-id -p second
+	} >patch1-hg.eml &&
 
 
 	sed -n -e "3,\$p" msg >file &&
@@ -236,6 +249,16 @@ test_expect_success 'am applies stgit series' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am applies hg patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am patch1-hg.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	test_cmp_rev second^ HEAD^
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.1.4
