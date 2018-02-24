Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7A71F404
	for <e@80x24.org>; Sat, 24 Feb 2018 01:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeBXBWW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 20:22:22 -0500
Received: from avasout01.plus.net ([84.93.230.227]:39536 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeBXBWW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 20:22:22 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id pOXbepkSsH3zXpOXceyooa; Sat, 24 Feb 2018 01:22:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IJQs9DnG c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=PBAUDbRNK6YJlSXjkD0A:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 2/2] t5536: simplify checking of messages output to stderr
Message-ID: <550fb3f4-8d25-c5c4-0ecd-3a4e61ea13f4@ramsayjones.plus.com>
Date:   Sat, 24 Feb 2018 01:22:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBd6WZLwysBEOpmIOexlHoUmfjjlo0CCXBA1DQrW4IiAN9nn6riEHIjHmRsHeneQdT6D/kVNNJqaS155DrqnGmDQdvNQ9vo5VE6+KTYvse3CAGZ17kYI
 sQCt3JMOuAuSDI5hL5cSGHHPmdlugtzMMf6NDK3UrZqpANpGf57nzpDSAswCiIUQGLIK6yXP1VE9ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

Commit 2071e05ed2 ("t5536: new test of refspec conflicts when
fetching", 2013-10-30), introduced the verify_stderr() function
which was used to verify that certain fatal/warning messages were
issued by a given git command. In addition, verify_stderr() would
filter a specific "fatal: The remote end hung up unexpectedly"
message, which may, or may not, be present (depending on the
relative timing of the git-fetch and git-upload-pack processes).

The verify_stderr() function has seen several modifications, which
has introduced a couple of minor problems. For example, commit
1edbaac3bb ("tests: use test_i18n* functions to suppress false
positives", 2016-06-17) introduced an inappropriate test_i18ngrep
call and commit f096e6e826 ("fetch: improve the error messages
emitted for conflicting refspecs", 2013-10-30) included an
ineffective invocation of sort at the end of a grep pipeline.

Instead of fixing these minor problems in verify_stderr(), we take
the simpler approach of directly searching the error file, using
test_i18ngrep, for the specific message(s) we expect. (The only
minor downside is that we would not notice any new messages).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t5536-fetch-conflicts.sh | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 644736b8a..91f28c2f7 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -18,14 +18,6 @@ setup_repository () {
 	)
 }
 
-verify_stderr () {
-	cat >expected &&
-	# We're not interested in the error
-	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' error | grep -v 'hung up' >actual | sort &&
-	test_i18ncmp expected actual
-}
-
 test_expect_success 'setup' '
 	git commit --allow-empty -m "Initial" &&
 	git branch branch1 &&
@@ -48,9 +40,7 @@ test_expect_success 'fetch conflict: config vs. config' '
 		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
 		cd ccc &&
 		test_must_fail git fetch origin 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -77,9 +67,7 @@ test_expect_success 'fetch conflict: arg vs. arg' '
 		test_must_fail git fetch origin \
 			refs/heads/*:refs/remotes/origin/* \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1
-		EOF
+		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/branch2 to refs/remotes/origin/branch1" error
 	)
 '
 
@@ -90,10 +78,8 @@ test_expect_success 'fetch conflict: criss-cross args' '
 		git fetch origin \
 			refs/heads/branch1:refs/remotes/origin/branch2 \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		verify_stderr <<-\EOF
-		warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2
-		warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1
-		EOF
+		test_i18ngrep "warning: refs/remotes/origin/branch1 usually tracks refs/heads/branch1, not refs/heads/branch2" error &&
+		test_i18ngrep "warning: refs/remotes/origin/branch2 usually tracks refs/heads/branch2, not refs/heads/branch1" error
 	)
 '
 
-- 
2.16.0
