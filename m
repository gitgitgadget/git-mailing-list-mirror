From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/5] am: teach StGit patch parser how to read from stdin
Date: Mon,  8 Jun 2015 23:48:48 +0800
Message-ID: <1433778531-18260-3-git-send-email-pyokagan@gmail.com>
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
	id 1Z1zJX-00016Z-A1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbbFHPuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:50:03 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35334 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbbFHPt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:49:57 -0400
Received: by pacyx8 with SMTP id yx8so63007220pac.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iCwKknCSrAa8lc6/fvHwuMpBhceZ66A4hAN1Yabwiso=;
        b=RGVxc9DBwv/Vx8Qussngpll0EImiL+RezUFgu8jFpYWgPh37/dcb6UY3XpzOVm9zvb
         QeslX4SoPakaWunZRx6VzKGBUUAjpnHJ8frQZ0fb4JodTY7oLC564zVzk/YmJ+qNXFCb
         s36rs5sKeO71xCA0mxOeK5W8ZhXV/Ur/mt+dRECSUItmLkPt/RStIncksWY+4mfweNBA
         NlKUFY3Ey8KJKzTIEEDK+ZoAA3+IovPhZ51V3qUJAKvHnnY6SrT4l/M0PbMHSt+YkJ8O
         l+RmzYjtO9hniSSDIZRKcRprwZUJ4IZhGPjQVYqtQJpqmiK6f8G8bGnQakoMXu2Frh6c
         hacw==
X-Received: by 10.70.128.68 with SMTP id nm4mr30973430pdb.74.1433778595937;
        Mon, 08 Jun 2015 08:49:55 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id vn7sm2998792pab.26.2015.06.08.08.49.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jun 2015 08:49:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433778531-18260-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271055>

git-mailsplit, which splits mbox patches, will read the patch from stdin
when the filename is "-" or there are no files listed on the
command-line.

To be consistent with this behavior, teach the StGit patch parser to
read from stdin if the filename is "-" or no files are listed on the
command-line.

Based-on-patch-by: Chris Packham <judge.packham@gmail.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-am.sh     |  5 +++--
 t/t4150-am.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 761befb..83f2ea6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -297,6 +297,7 @@ split_patches () {
 		;;
 	stgit)
 		this=0
+		test 0 -eq "$#" && set -- -
 		for stgit in "$@"
 		do
 			this=$(expr "$this" + 1)
@@ -305,7 +306,7 @@ split_patches () {
 			# not starting with Author, From or Date is the
 			# subject, and the body starts with the next nonempty
 			# line not starting with Author, From or Date
-			@@PERL@@ -ne 'BEGIN { $subject = 0 }
+			cat "$stgit" | @@PERL@@ -ne 'BEGIN { $subject = 0 }
 				if ($subject > 1) { print ; }
 				elsif (/^\s+$/) { next ; }
 				elsif (/^Author:/) { s/Author/From/ ; print ;}
@@ -318,7 +319,7 @@ split_patches () {
 					print "Subject: ", $_ ;
 					$subject = 1;
 				}
-			' < "$stgit" > "$dotest/$msgnum" || clean_abort
+			' >"$dotest/$msgnum" || clean_abort
 		done
 		echo "$this" > "$dotest/last"
 		this=
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 0ead529..51962e4 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -209,6 +209,16 @@ test_expect_success 'am applies stgit patch' '
 	test_cmp_rev second^ HEAD^
 '
 
+test_expect_success 'am --patch-format=stgit applies stgit patch' '
+	rm -fr .git/rebase-apply &&
+	git checkout -f first &&
+	git am --patch-format=stgit <patch1-stgit.eml &&
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
