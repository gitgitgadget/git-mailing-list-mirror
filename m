Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0DA1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 00:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeLaAbx (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 19:31:53 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:44613 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLaAbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 19:31:52 -0500
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181231003151.YKSX4101.fed1rmfepo101.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Sun, 30 Dec 2018 19:31:51 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id B7DBDB8380C;
        Sun, 30 Dec 2018 17:31:50 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5C296377.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=L8upvNb8 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=2ur7OfE09M0A:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=61RRfQX-yyrNk2VQgeQA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Stephen P . Smith" <ischis2@cox.net>
Subject: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Sun, 30 Dec 2018 17:31:50 -0700
Message-Id: <20181231003150.8031-4-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20181231003150.8031-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
Reply-To: alpine.LFD.2.21.999.1807071502260.18818@i7.lan
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `human` date format varies based on two inputs: the date in the
reference time which is constant and the local computers date which
varies.  Using hardcoded test expected output dates would require
holding the local machines date and time constant which is not
desireable.

Alternatively, letting the local date vary, which is the normal
situation, implies that the tests would be checking for formating
changes based on on a ref date relative to the local computers time.

When using `human` several fields are suppressed depending on the time
difference between the reference date and the local computer date. In
cases where the difference is less than a year, the year field is
supppressed. If the time is less than a day; the month and year is
suppressed.

Test using a regular expression to verify that fields that are
expected to be suppressed are not displayed.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t0006-date.sh | 24 ++++++++++++++++++++++++
 t/t4202-log.sh  | 24 ++++++++++++++++++++++++
 t/t7007-show.sh | 25 +++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index ffb2975e48..f208a80867 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -40,6 +40,16 @@ check_show () {
 	'
 }
 
+check_human_date () {
+	time=$1
+	expect=$2
+	test_expect_success "check date ($format:$time)" '
+		echo "$time -> $expect" >expect &&
+		TZ=${zone:-$TZ} test-tool date show:"$format" "$time" >actual &&
+		grep "$expect" actual 
+	'
+}
+
 # arbitrary but sensible time for examples
 TIME='1466000000 +0200'
 check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
@@ -52,6 +62,20 @@ check_show unix "$TIME" '1466000000'
 check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 check_show raw-local "$TIME" '1466000000 +0000'
 check_show unix-local "$TIME" '1466000000'
+check_show human "$TIME" 'Jun 15 2016'
+
+# Subtract some known constant time and look for expected field format
+TODAY_REGEX='5 hours ago'
+THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
+MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
+check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
+check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
+check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
+check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
+check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
+check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
+check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
+check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
 
 check_show 'format:%z' "$TIME" '+0200'
 check_show 'format-local:%z' "$TIME" '+0000'
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 819c24d10e..d7f3b73650 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1707,4 +1707,28 @@ test_expect_success '--exclude-promisor-objects does not BUG-crash' '
 	test_must_fail git log --exclude-promisor-objects source-a
 '
 
+check_human_date() {
+	commit_date=$1
+	expect=$2
+	test_expect_success "$commit_date" "
+		echo $expect $commit_date >dates && 
+		git add dates &&
+		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
+		git log -1 --date=human | grep \"^Date:\" >actual &&
+		grep \"$expect\" actual
+"
+}
+
+TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
+THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
+MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
+check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
+check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
+check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
+check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
+check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
+check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
+check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
+check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
+
 test_done
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db6246..0a0334a8b5 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -128,4 +128,29 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+check_human_date() {
+	commit_date=$1
+	expect=$2
+	test_expect_success "$commit_date" "
+		echo $expect $commit_date >dates && 
+		git add dates &&
+		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
+		git show --date=human | grep \"^Date:\" >actual &&
+		grep \"$expect\" actual
+"
+}
+
+TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
+THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [012][0-9]:[0-6][0-9]'
+MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]'
+check_human_date "$(($(date +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago
+check_human_date "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
+check_human_date "$(($(date +%s)-1728000)) +0200" $THIS_YEAR_REGEX # 3 weeks ago
+check_human_date "$(($(date +%s)-13000000)) +0200" $THIS_YEAR_REGEX # 5 months ago
+check_human_date "$(($(date +%s)-31449600)) +0200" $THIS_YEAR_REGEX # 12 months ago
+check_human_date "$(($(date +%s)-37500000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 2 months ago
+check_human_date "$(($(date +%s)-55188000)) +0200" $MORE_THAN_A_YEAR_REGEX # 1 year, 9 months ago
+check_human_date "$(($(date +%s)-630000000)) +0200" $MORE_THAN_A_YEAR_REGEX # 20 years ago
+
+
 test_done
-- 
2.20.1.2.gb21ebb671b

