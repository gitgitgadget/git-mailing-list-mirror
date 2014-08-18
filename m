From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 04/27] fake_editor: leave standard output unchanged
Date: Mon, 18 Aug 2014 23:22:47 +0200
Message-ID: <b0667f0b0de6f9881dd8c81903b266e39663abb0.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPG-0000N5-6B
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbaHRVXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:23:50 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43377 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbaHRVXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:23:48 -0400
Received: by mail-lb0-f177.google.com with SMTP id s7so4571547lbd.8
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vBj4xSnixAKPItV+PgU7JTBVI7IzYnV1pje2am+4pbA=;
        b=ad4KGZCMPMzintsBbYUzvSPXlwrA4nhk+7S7/5R3b3x/2uY69n/AhBpxYOzzYCMOlP
         ow26MxWYKrHr8G5YbKO4pFSo+9UdgKDdqDhB3j1rq/cTjyx5Jou+d08cDD/K2vpyItaC
         D0Dh5CAd4MxglD3+QNdolj4MEw82U+n/1zBIYShycszu2pMw4seJtBSnYhwZVjvaCYcr
         w7928fJg7nM6B7tcfw7Ed+87VPAlTU0/6RrPEnLgrdozDCJWj6lnBBGbZJMfA+nVg5vK
         JdXLCMu6eWeTzJjXK1RRDw/6VomSmwnGiKpEedWZwedccK39bbnYDprCigsg8Jk6wECK
         LMHQ==
X-Received: by 10.112.78.38 with SMTP id y6mr5316024lbw.94.1408397027213;
        Mon, 18 Aug 2014 14:23:47 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255416>

The helper function `set_fake_editor` installs a script as
`GIT_EDITOR` that applies pre-defined editing rules to the files it
is called with, which is a quite powerful tool when writing test
cases for git-rebase--interactive. To aid in debugging the changes it
makes, the installed script dumps the file contents to stdout before
and after editing. That interferes with the output from
git-rebase--interactive, however, and the debug information has to be
removed from stdout in a error-prone way. Print the editor contents
on stderr instead.

When a test case wants to analyse stderr, we need to come up with a
different solution. The less convenient possibility that always
remains is to store the debug output in a file in the "trash"
directory or even keeping copies of the edited files before and after
editing.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 t/lib-rebase.sh               |  8 ++++----
 t/t3404-rebase-interactive.sh | 18 ++++++------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 6bd2522..0cd1193 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -41,8 +41,8 @@ set_fake_editor () {
 	test -z "$FAKE_LINES" && exit
 	grep -v '^#' < "$1" > "$1".tmp
 	rm -f "$1"
-	echo 'rebase -i script before editing:'
-	cat "$1".tmp
+	echo 'rebase -i script before editing:' >&2
+	cat "$1".tmp >&2
 	action=pick
 	for line in $FAKE_LINES; do
 		case $line in
@@ -59,8 +59,8 @@ set_fake_editor () {
 			action=pick;;
 		esac
 	done
-	echo 'rebase -i script after editing:'
-	cat "$1"
+	echo 'rebase -i script after editing:' >&2
+	cat "$1" >&2
 	EOF
 
 	test_set_editor "$(pwd)/fake-editor.sh"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f4e886f..7cc6ebf 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -882,9 +882,8 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -896,9 +895,8 @@ test_expect_success 'running "git rebase --exec git show HEAD -i"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -910,9 +908,8 @@ test_expect_success 'running "git rebase -ix git show HEAD"' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -924,9 +921,8 @@ test_expect_success 'rebase -ix with several <CMD>' '
 	(
 		FAKE_LINES="1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,9d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -939,9 +935,8 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 		FAKE_LINES="1 exec_git_show_HEAD exec_pwd 2
 				exec_git_show_HEAD exec_pwd" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~2 >expect
+		git rebase -i HEAD~2 >expected
 	) &&
-	sed -e "1,11d" expect >expected &&
 	test_cmp expected actual
 '
 
@@ -965,9 +960,8 @@ test_expect_success 'rebase -ix with --autosquash' '
 		git checkout -b autosquash_expected &&
 		FAKE_LINES="1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
 		export FAKE_LINES &&
-		git rebase -i HEAD~4 >expect
+		git rebase -i HEAD~4 >expected
 	) &&
-	sed -e "1,13d" expect >expected &&
 	test_cmp expected actual
 '
 
-- 
2.0.1
