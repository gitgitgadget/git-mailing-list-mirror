From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 1/7] Add several testcases for --dirstat and friends
Date: Thu, 28 Apr 2011 03:17:16 +0200
Message-ID: <1303953442-26536-2-git-send-email-johan@herland.net>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFFrh-0005BT-0t
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 03:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846Ab1D1BRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 21:17:42 -0400
Received: from smtp.getmail.no ([84.208.15.66]:46644 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758209Ab1D1BRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 21:17:33 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC00GOA8X4P940@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:28 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A88A71EA5981_DB8C028B	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:28 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 162B51EA38CE_DB8C025F	for <git@vger.kernel.org>; Thu,
 28 Apr 2011 01:17:25 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKC0058L8X0LO10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Apr 2011 03:17:25 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303953442-26536-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172305>

Currently, t4013 is the only selftest that exercises the --dirstat machinery,
but it only does a superficial verification of --dirstat's output.

This patch adds a new selftest - t4047-diff-dirstat.sh - which prepares a
commit containing:
 - unchanged files, changed files and files with rearranged lines
 - copied files, moved files, and unmoved files

It then verifies the correct dirstat output for that commit in the following
dirstat modes:
 - --dirstat
 - -X
 - --dirstat=0
 - -X0
 - --cumulative
 - --dirstat-by-file
 - (plus combinations of the above)

Each of the above tests are also run with:
 - no rename detection
 - rename detection (-M)
 - expensive copy detection (-C -C)

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t4047-diff-dirstat.sh |  580 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 580 insertions(+), 0 deletions(-)
 create mode 100755 t/t4047-diff-dirstat.sh

diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
new file mode 100755
index 0000000..eb6bf47
--- /dev/null
+++ b/t/t4047-diff-dirstat.sh
@@ -0,0 +1,580 @@
+#!/bin/sh
+
+test_description='diff --dirstat tests'
+. ./test-lib.sh
+
+# set up two commits where the second commit has these files
+# (10 lines in each file):
+#
+#   unchanged/text           (unchanged from 1st commit)
+#   changed/text             (changed 1st line)
+#   rearranged/text          (swapped 1st and 2nd line)
+#   dst/copy/unchanged/text  (copied from src/copy/unchanged/text, unchanged)
+#   dst/copy/changed/text    (copied from src/copy/changed/text, changed)
+#   dst/copy/rearranged/text (copied from src/copy/rearranged/text, rearranged)
+#   dst/move/unchanged/text  (moved from src/move/unchanged/text, unchanged)
+#   dst/move/changed/text    (moved from src/move/changed/text, changed)
+#   dst/move/rearranged/text (moved from src/move/rearranged/text, rearranged)
+
+test_expect_success 'setup' '
+	mkdir unchanged &&
+	mkdir changed &&
+	mkdir rearranged &&
+	mkdir src &&
+	mkdir src/copy &&
+	mkdir src/copy/unchanged &&
+	mkdir src/copy/changed &&
+	mkdir src/copy/rearranged &&
+	mkdir src/move &&
+	mkdir src/move/unchanged &&
+	mkdir src/move/changed &&
+	mkdir src/move/rearranged &&
+	cat <<EOF >unchanged/text &&
+unchanged       line #0
+unchanged       line #1
+unchanged       line #2
+unchanged       line #3
+unchanged       line #4
+unchanged       line #5
+unchanged       line #6
+unchanged       line #7
+unchanged       line #8
+unchanged       line #9
+EOF
+	cat <<EOF >changed/text &&
+changed         line #0
+changed         line #1
+changed         line #2
+changed         line #3
+changed         line #4
+changed         line #5
+changed         line #6
+changed         line #7
+changed         line #8
+changed         line #9
+EOF
+	cat <<EOF >rearranged/text &&
+rearranged      line #0
+rearranged      line #1
+rearranged      line #2
+rearranged      line #3
+rearranged      line #4
+rearranged      line #5
+rearranged      line #6
+rearranged      line #7
+rearranged      line #8
+rearranged      line #9
+EOF
+	cat <<EOF >src/copy/unchanged/text &&
+copy  unchanged line #0
+copy  unchanged line #1
+copy  unchanged line #2
+copy  unchanged line #3
+copy  unchanged line #4
+copy  unchanged line #5
+copy  unchanged line #6
+copy  unchanged line #7
+copy  unchanged line #8
+copy  unchanged line #9
+EOF
+	cat <<EOF >src/copy/changed/text &&
+copy    changed line #0
+copy    changed line #1
+copy    changed line #2
+copy    changed line #3
+copy    changed line #4
+copy    changed line #5
+copy    changed line #6
+copy    changed line #7
+copy    changed line #8
+copy    changed line #9
+EOF
+	cat <<EOF >src/copy/rearranged/text &&
+copy rearranged line #0
+copy rearranged line #1
+copy rearranged line #2
+copy rearranged line #3
+copy rearranged line #4
+copy rearranged line #5
+copy rearranged line #6
+copy rearranged line #7
+copy rearranged line #8
+copy rearranged line #9
+EOF
+	cat <<EOF >src/move/unchanged/text &&
+move  unchanged line #0
+move  unchanged line #1
+move  unchanged line #2
+move  unchanged line #3
+move  unchanged line #4
+move  unchanged line #5
+move  unchanged line #6
+move  unchanged line #7
+move  unchanged line #8
+move  unchanged line #9
+EOF
+	cat <<EOF >src/move/changed/text &&
+move    changed line #0
+move    changed line #1
+move    changed line #2
+move    changed line #3
+move    changed line #4
+move    changed line #5
+move    changed line #6
+move    changed line #7
+move    changed line #8
+move    changed line #9
+EOF
+	cat <<EOF >src/move/rearranged/text &&
+move rearranged line #0
+move rearranged line #1
+move rearranged line #2
+move rearranged line #3
+move rearranged line #4
+move rearranged line #5
+move rearranged line #6
+move rearranged line #7
+move rearranged line #8
+move rearranged line #9
+EOF
+	git add . &&
+	git commit -m "initial" &&
+	mkdir dst &&
+	mkdir dst/copy &&
+	mkdir dst/copy/unchanged &&
+	mkdir dst/copy/changed &&
+	mkdir dst/copy/rearranged &&
+	mkdir dst/move &&
+	mkdir dst/move/unchanged &&
+	mkdir dst/move/changed &&
+	mkdir dst/move/rearranged &&
+	cat <<EOF >changed/text &&
+CHANGED XXXXXXX line #0
+changed         line #1
+changed         line #2
+changed         line #3
+changed         line #4
+changed         line #5
+changed         line #6
+changed         line #7
+changed         line #8
+changed         line #9
+EOF
+	cat <<EOF >rearranged/text &&
+rearranged      line #1
+rearranged      line #0
+rearranged      line #2
+rearranged      line #3
+rearranged      line #4
+rearranged      line #5
+rearranged      line #6
+rearranged      line #7
+rearranged      line #8
+rearranged      line #9
+EOF
+	cat <<EOF >dst/copy/unchanged/text &&
+copy  unchanged line #0
+copy  unchanged line #1
+copy  unchanged line #2
+copy  unchanged line #3
+copy  unchanged line #4
+copy  unchanged line #5
+copy  unchanged line #6
+copy  unchanged line #7
+copy  unchanged line #8
+copy  unchanged line #9
+EOF
+	cat <<EOF >dst/copy/changed/text &&
+copy XXXCHANGED line #0
+copy    changed line #1
+copy    changed line #2
+copy    changed line #3
+copy    changed line #4
+copy    changed line #5
+copy    changed line #6
+copy    changed line #7
+copy    changed line #8
+copy    changed line #9
+EOF
+	cat <<EOF >dst/copy/rearranged/text &&
+copy rearranged line #1
+copy rearranged line #0
+copy rearranged line #2
+copy rearranged line #3
+copy rearranged line #4
+copy rearranged line #5
+copy rearranged line #6
+copy rearranged line #7
+copy rearranged line #8
+copy rearranged line #9
+EOF
+	cat <<EOF >dst/move/unchanged/text &&
+move  unchanged line #0
+move  unchanged line #1
+move  unchanged line #2
+move  unchanged line #3
+move  unchanged line #4
+move  unchanged line #5
+move  unchanged line #6
+move  unchanged line #7
+move  unchanged line #8
+move  unchanged line #9
+EOF
+	cat <<EOF >dst/move/changed/text &&
+move XXXCHANGED line #0
+move    changed line #1
+move    changed line #2
+move    changed line #3
+move    changed line #4
+move    changed line #5
+move    changed line #6
+move    changed line #7
+move    changed line #8
+move    changed line #9
+EOF
+	cat <<EOF >dst/move/rearranged/text &&
+move rearranged line #1
+move rearranged line #0
+move rearranged line #2
+move rearranged line #3
+move rearranged line #4
+move rearranged line #5
+move rearranged line #6
+move rearranged line #7
+move rearranged line #8
+move rearranged line #9
+EOF
+	git add . &&
+	git rm -r src/move/unchanged &&
+	git rm -r src/move/changed &&
+	git rm -r src/move/rearranged &&
+	git commit -m "changes"
+'
+
+cat <<EOF >expect_diff_stat
+ changed/text             |    2 +-
+ dst/copy/changed/text    |   10 ++++++++++
+ dst/copy/rearranged/text |   10 ++++++++++
+ dst/copy/unchanged/text  |   10 ++++++++++
+ dst/move/changed/text    |   10 ++++++++++
+ dst/move/rearranged/text |   10 ++++++++++
+ dst/move/unchanged/text  |   10 ++++++++++
+ rearranged/text          |    2 +-
+ src/move/changed/text    |   10 ----------
+ src/move/rearranged/text |   10 ----------
+ src/move/unchanged/text  |   10 ----------
+ 11 files changed, 62 insertions(+), 32 deletions(-)
+EOF
+
+cat <<EOF >expect_diff_stat_M
+ changed/text                      |    2 +-
+ dst/copy/changed/text             |   10 ++++++++++
+ dst/copy/rearranged/text          |   10 ++++++++++
+ dst/copy/unchanged/text           |   10 ++++++++++
+ {src => dst}/move/changed/text    |    2 +-
+ {src => dst}/move/rearranged/text |    2 +-
+ {src => dst}/move/unchanged/text  |    0
+ rearranged/text                   |    2 +-
+ 8 files changed, 34 insertions(+), 4 deletions(-)
+EOF
+
+cat <<EOF >expect_diff_stat_CC
+ changed/text                      |    2 +-
+ {src => dst}/copy/changed/text    |    2 +-
+ {src => dst}/copy/rearranged/text |    2 +-
+ {src => dst}/copy/unchanged/text  |    0
+ {src => dst}/move/changed/text    |    2 +-
+ {src => dst}/move/rearranged/text |    2 +-
+ {src => dst}/move/unchanged/text  |    0
+ rearranged/text                   |    2 +-
+ 8 files changed, 6 insertions(+), 6 deletions(-)
+EOF
+
+test_expect_success 'sanity check setup (--stat)' '
+	git diff --stat HEAD^..HEAD >actual_diff_stat &&
+	test_cmp expect_diff_stat actual_diff_stat &&
+	git diff --stat -M HEAD^..HEAD >actual_diff_stat_M &&
+	test_cmp expect_diff_stat_M actual_diff_stat_M &&
+	git diff --stat -C -C HEAD^..HEAD >actual_diff_stat_CC &&
+	test_cmp expect_diff_stat_CC actual_diff_stat_CC
+'
+
+# changed/text and rearranged/text falls below default 3% threshold
+cat <<EOF >expect_diff_dirstat
+  10.8% dst/copy/changed/
+  10.8% dst/copy/rearranged/
+  10.8% dst/copy/unchanged/
+  10.8% dst/move/changed/
+  10.8% dst/move/rearranged/
+  10.8% dst/move/unchanged/
+  10.8% src/move/changed/
+  10.8% src/move/rearranged/
+  10.8% src/move/unchanged/
+EOF
+
+# rearranged/text falls below default 3% threshold
+cat <<EOF >expect_diff_dirstat_M
+   5.8% changed/
+  29.3% dst/copy/changed/
+  29.3% dst/copy/rearranged/
+  29.3% dst/copy/unchanged/
+   5.8% dst/move/changed/
+EOF
+
+# rearranged/text falls below default 3% threshold
+cat <<EOF >expect_diff_dirstat_CC
+  32.6% changed/
+  32.6% dst/copy/changed/
+  32.6% dst/move/changed/
+EOF
+
+test_expect_success 'vanilla --dirstat' '
+	git diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'vanilla -X' '
+	git diff -X HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff -X -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff -X -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+# rearranged/text falls below 0% threshold (1 / (240 * 9 + 48 + 1) ~= 0.045 %)
+cat <<EOF >expect_diff_dirstat
+   2.1% changed/
+  10.8% dst/copy/changed/
+  10.8% dst/copy/rearranged/
+  10.8% dst/copy/unchanged/
+  10.8% dst/move/changed/
+  10.8% dst/move/rearranged/
+  10.8% dst/move/unchanged/
+  10.8% src/move/changed/
+  10.8% src/move/rearranged/
+  10.8% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+   5.8% changed/
+  29.3% dst/copy/changed/
+  29.3% dst/copy/rearranged/
+  29.3% dst/copy/unchanged/
+   5.8% dst/move/changed/
+   0.1% dst/move/rearranged/
+   0.1% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  32.6% changed/
+  32.6% dst/copy/changed/
+   0.6% dst/copy/rearranged/
+  32.6% dst/move/changed/
+   0.6% dst/move/rearranged/
+   0.6% rearranged/
+EOF
+
+test_expect_success '--dirstat=0' '
+	git diff --dirstat=0 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=0 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=0 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success '-X0' '
+	git diff -X0 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff -X0 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff -X0 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+# rearranged/text falls below 0% threshold (1 / (240 * 9 + 48 + 1) ~= 0.045 %)
+cat <<EOF >expect_diff_dirstat
+   2.1% changed/
+  10.8% dst/copy/changed/
+  10.8% dst/copy/rearranged/
+  10.8% dst/copy/unchanged/
+  32.5% dst/copy/
+  10.8% dst/move/changed/
+  10.8% dst/move/rearranged/
+  10.8% dst/move/unchanged/
+  32.5% dst/move/
+  65.1% dst/
+  10.8% src/move/changed/
+  10.8% src/move/rearranged/
+  10.8% src/move/unchanged/
+  32.5% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+   5.8% changed/
+  29.3% dst/copy/changed/
+  29.3% dst/copy/rearranged/
+  29.3% dst/copy/unchanged/
+  88.0% dst/copy/
+   5.8% dst/move/changed/
+   0.1% dst/move/rearranged/
+   5.9% dst/move/
+  94.0% dst/
+   0.1% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  32.6% changed/
+  32.6% dst/copy/changed/
+   0.6% dst/copy/rearranged/
+  33.3% dst/copy/
+  32.6% dst/move/changed/
+   0.6% dst/move/rearranged/
+  33.3% dst/move/
+  66.6% dst/
+   0.6% rearranged/
+EOF
+
+test_expect_success '--dirstat=0 --cumulative' '
+	git diff --dirstat=0 --cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=0 --cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=0 --cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+cat <<EOF >expect_diff_dirstat
+   9.0% changed/
+   9.0% dst/copy/changed/
+   9.0% dst/copy/rearranged/
+   9.0% dst/copy/unchanged/
+   9.0% dst/move/changed/
+   9.0% dst/move/rearranged/
+   9.0% dst/move/unchanged/
+   9.0% rearranged/
+   9.0% src/move/changed/
+   9.0% src/move/rearranged/
+   9.0% src/move/unchanged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  14.2% changed/
+  14.2% dst/copy/changed/
+  14.2% dst/copy/rearranged/
+  14.2% dst/copy/unchanged/
+  14.2% dst/move/changed/
+  14.2% dst/move/rearranged/
+  14.2% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.6% changed/
+  16.6% dst/copy/changed/
+  16.6% dst/copy/rearranged/
+  16.6% dst/move/changed/
+  16.6% dst/move/rearranged/
+  16.6% rearranged/
+EOF
+
+test_expect_success '--dirstat-by-file' '
+	git diff --dirstat-by-file HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat-by-file -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat-by-file -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+cat <<EOF >expect_diff_dirstat
+  27.2% dst/copy/
+  27.2% dst/move/
+  27.2% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  14.2% changed/
+  14.2% dst/copy/changed/
+  14.2% dst/copy/rearranged/
+  14.2% dst/copy/unchanged/
+  14.2% dst/move/changed/
+  14.2% dst/move/rearranged/
+  14.2% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.6% changed/
+  16.6% dst/copy/changed/
+  16.6% dst/copy/rearranged/
+  16.6% dst/move/changed/
+  16.6% dst/move/rearranged/
+  16.6% rearranged/
+EOF
+
+test_expect_success '--dirstat-by-file=10' '
+	git diff --dirstat-by-file=10 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat-by-file=10 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat-by-file=10 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+cat <<EOF >expect_diff_dirstat
+   9.0% changed/
+   9.0% dst/copy/changed/
+   9.0% dst/copy/rearranged/
+   9.0% dst/copy/unchanged/
+  27.2% dst/copy/
+   9.0% dst/move/changed/
+   9.0% dst/move/rearranged/
+   9.0% dst/move/unchanged/
+  27.2% dst/move/
+  54.5% dst/
+   9.0% rearranged/
+   9.0% src/move/changed/
+   9.0% src/move/rearranged/
+   9.0% src/move/unchanged/
+  27.2% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  14.2% changed/
+  14.2% dst/copy/changed/
+  14.2% dst/copy/rearranged/
+  14.2% dst/copy/unchanged/
+  42.8% dst/copy/
+  14.2% dst/move/changed/
+  14.2% dst/move/rearranged/
+  28.5% dst/move/
+  71.4% dst/
+  14.2% rearranged/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  16.6% changed/
+  16.6% dst/copy/changed/
+  16.6% dst/copy/rearranged/
+  33.3% dst/copy/
+  16.6% dst/move/changed/
+  16.6% dst/move/rearranged/
+  33.3% dst/move/
+  66.6% dst/
+  16.6% rearranged/
+EOF
+
+test_expect_success '--dirstat-by-file --cumulative' '
+	git diff --dirstat-by-file --cumulative HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat-by-file --cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat-by-file --cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_done
-- 
1.7.5.rc1.3.g4d7b
