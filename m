Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE332047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdIQW6W (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:58:22 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55928 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdIQW6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:58:21 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id AmyK1w0010M91Ur01myLFi; Sun, 17 Sep 2017 23:58:20 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=A1X0JdhQAAAA:8 a=1QWimv5NHQjfUDsYsR8A:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=Df3jFdWbhGDLdZNm0fyq:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] t9010-*.sh: skip all tests if the PIPE prereq is missing
Message-ID: <ffcf72e9-b724-3312-ca63-c21d0b8a235c@ramsayjones.plus.com>
Date:   Sun, 17 Sep 2017 23:58:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Every test in this file, except one, is marked with the PIPE prereq.
However, that lone test ('set up svn repo'), only performs some setup
work and checks whether the following test should be executed (by
setting an additional SVNREPO prerequisite). Since the following test
also requires the PIPE prerequisite, performing the setup test, when the
PIPE preequisite is missing, is simply wasted effort. Use the skip-all
test facility to skip all tests when the PIPE prerequisite is missing.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t9010-svn-fe.sh | 55 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 6dafe7e99..8eaaca6f9 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -4,12 +4,13 @@ test_description='check svn dumpfile importer'
 
 . ./test-lib.sh
 
+if test_have_prereq !PIPE
+then
+	skip_all="svn dumpfile importer testing requires the PIPE prerequisite"
+	test_done
+fi
+
 reinit_git () {
-	if ! test_declared_prereq PIPE
-	then
-		echo >&4 "reinit_git: need to declare PIPE prerequisite"
-		return 127
-	fi
 	rm -fr .git &&
 	rm -f stream backflow &&
 	git init &&
@@ -54,19 +55,19 @@ text_no_props () {
 
 >empty
 
-test_expect_success PIPE 'empty dump' '
+test_expect_success 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
 	try_dump input
 '
 
-test_expect_success PIPE 'v4 dumps not supported' '
+test_expect_success 'v4 dumps not supported' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 4" >v4.dump &&
 	try_dump v4.dump must_fail
 '
 
-test_expect_failure PIPE 'empty revision' '
+test_expect_failure 'empty revision' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
 	cat >emptyrev.dump <<-\EOF &&
@@ -86,7 +87,7 @@ test_expect_failure PIPE 'empty revision' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'empty properties' '
+test_expect_success 'empty properties' '
 	reinit_git &&
 	printf "rev <nobody, nobody@local>: %s\n" "" "" >expect &&
 	cat >emptyprop.dump <<-\EOF &&
@@ -109,7 +110,7 @@ test_expect_success PIPE 'empty properties' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'author name and commit message' '
+test_expect_success 'author name and commit message' '
 	reinit_git &&
 	echo "<author@example.com, author@example.com@local>" >expect.author &&
 	cat >message <<-\EOF &&
@@ -143,7 +144,7 @@ test_expect_success PIPE 'author name and commit message' '
 	test_cmp expect.author actual.author
 '
 
-test_expect_success PIPE 'unsupported properties are ignored' '
+test_expect_success 'unsupported properties are ignored' '
 	reinit_git &&
 	echo author >expect &&
 	cat >extraprop.dump <<-\EOF &&
@@ -168,7 +169,7 @@ test_expect_success PIPE 'unsupported properties are ignored' '
 	test_cmp expect actual
 '
 
-test_expect_failure PIPE 'timestamp and empty file' '
+test_expect_failure 'timestamp and empty file' '
 	echo author@example.com >expect.author &&
 	echo 1999-01-01 >expect.date &&
 	echo file >expect.files &&
@@ -210,7 +211,7 @@ test_expect_failure PIPE 'timestamp and empty file' '
 	test_cmp empty file
 '
 
-test_expect_success PIPE 'directory with files' '
+test_expect_success 'directory with files' '
 	reinit_git &&
 	printf "%s\n" directory/file1 directory/file2 >expect.files &&
 	echo hi >hi &&
@@ -263,7 +264,7 @@ test_expect_success PIPE 'directory with files' '
 	test_cmp hi directory/file2
 '
 
-test_expect_success PIPE 'branch name with backslash' '
+test_expect_success 'branch name with backslash' '
 	reinit_git &&
 	sort <<-\EOF >expect.branch-files &&
 	trunk/file1
@@ -362,7 +363,7 @@ test_expect_success PIPE 'branch name with backslash' '
 	test_cmp expect.branch-files actual.branch-files
 '
 
-test_expect_success PIPE 'node without action' '
+test_expect_success 'node without action' '
 	reinit_git &&
 	cat >inaction.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
@@ -383,7 +384,7 @@ test_expect_success PIPE 'node without action' '
 	try_dump inaction.dump must_fail
 '
 
-test_expect_success PIPE 'action: add node without text' '
+test_expect_success 'action: add node without text' '
 	reinit_git &&
 	cat >textless.dump <<-\EOF &&
 	SVN-fs-dump-format-version: 3
@@ -405,7 +406,7 @@ test_expect_success PIPE 'action: add node without text' '
 	try_dump textless.dump must_fail
 '
 
-test_expect_failure PIPE 'change file mode but keep old content' '
+test_expect_failure 'change file mode but keep old content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -481,7 +482,7 @@ test_expect_failure PIPE 'change file mode but keep old content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success PIPE 'NUL in property value' '
+test_expect_success 'NUL in property value' '
 	reinit_git &&
 	echo "commit message" >expect.message &&
 	{
@@ -507,7 +508,7 @@ test_expect_success PIPE 'NUL in property value' '
 	test_cmp expect.message actual.message
 '
 
-test_expect_success PIPE 'NUL in log message, file content, and property name' '
+test_expect_success 'NUL in log message, file content, and property name' '
 	# Caveat: svnadmin 1.6.16 (r1073529) truncates at \0 in the
 	# svn:specialQnotreally example.
 	reinit_git &&
@@ -587,7 +588,7 @@ test_expect_success PIPE 'NUL in log message, file content, and property name' '
 	test_cmp expect.hello2 actual.hello2
 '
 
-test_expect_success PIPE 'change file mode and reiterate content' '
+test_expect_success 'change file mode and reiterate content' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -667,7 +668,7 @@ test_expect_success PIPE 'change file mode and reiterate content' '
 	test_cmp hello actual.target
 '
 
-test_expect_success PIPE 'deltas supported' '
+test_expect_success 'deltas supported' '
 	reinit_git &&
 	{
 		# (old) h + (inline) ello + (old) \n
@@ -731,7 +732,7 @@ test_expect_success PIPE 'deltas supported' '
 	try_dump delta.dump
 '
 
-test_expect_success PIPE 'property deltas supported' '
+test_expect_success 'property deltas supported' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -796,7 +797,7 @@ test_expect_success PIPE 'property deltas supported' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'properties on /' '
+test_expect_success 'properties on /' '
 	reinit_git &&
 	cat <<-\EOF >expect &&
 	OBJID
@@ -850,7 +851,7 @@ test_expect_success PIPE 'properties on /' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'deltas for typechange' '
+test_expect_success 'deltas for typechange' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -935,7 +936,7 @@ test_expect_success PIPE 'deltas for typechange' '
 	test_cmp expect actual
 '
 
-test_expect_success PIPE 'deltas need not consume the whole preimage' '
+test_expect_success 'deltas need not consume the whole preimage' '
 	reinit_git &&
 	cat >expect <<-\EOF &&
 	OBJID
@@ -1040,7 +1041,7 @@ test_expect_success PIPE 'deltas need not consume the whole preimage' '
 	test_cmp expect.3 actual.3
 '
 
-test_expect_success PIPE 'no hang for delta trying to read past end of preimage' '
+test_expect_success 'no hang for delta trying to read past end of preimage' '
 	reinit_git &&
 	{
 		# COPY 1
@@ -1087,7 +1088,7 @@ test_expect_success 'set up svn repo' '
 	fi
 '
 
-test_expect_success SVNREPO,PIPE 't9135/svn.dump' '
+test_expect_success SVNREPO 't9135/svn.dump' '
 	mkdir -p simple-git &&
 	(
 		cd simple-git &&
-- 
2.14.0
