Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B8A1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757068AbcLPUcV (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 15:32:21 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58533 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754105AbcLPUcS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 15:32:18 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id LkYE1u0070srQBz01kYF32; Fri, 16 Dec 2016 20:32:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=VYWHBBh9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8 a=sKDyxL1ovPikva9dIGwA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22
X-AUTH: ramsayjones@:2500
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: test failure
Message-ID: <dd8decbc-f856-4f68-6d77-7ea9d5f9d126@ramsayjones.plus.com>
Date:   Fri, 16 Dec 2016 20:32:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

For the last two days, I've noticed t0021.15 on the 'pu' branch has been failing intermittently (well it fails with: 'make test >ptest-out', but
when run by hand, it fails only say 1-in-6, 1-in-18, etc.).

[yes, it's a bit strange; this hasn't changed in a couple of weeks!]

I don't have time to investigate further tonight and, since I had not
heard anyone else complain, I thought I should let you know.

See below for the output from a failing run. [Note: this is on Linux
Mint 18, tonight's pu branch @7c7984401].

ATB,
Ramsay Jones

$ ./t0021-conversion.sh -i -v

...

ok 14 - diff does not reuse worktree files that need cleaning

expecting success: 
	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
	test_config_global filter.protocol.required true &&
	rm -rf repo &&
	mkdir repo &&
	(
		cd repo &&
		git init &&

		echo "*.r filter=protocol" >.gitattributes &&
		git add . &&
		git commit -m "test commit 1" &&
		git branch empty-branch &&

		cp "$TEST_ROOT/test.o" test.r &&
		cp "$TEST_ROOT/test2.o" test2.r &&
		mkdir testsubdir &&
		cp "$TEST_ROOT/test3 'sq',\$x=.o" "testsubdir/test3 'sq',\$x=.r" &&
		>test4-empty.r &&

		S=$(file_size test.r) &&
		S2=$(file_size test2.r) &&
		S3=$(file_size "testsubdir/test3 'sq',\$x=.r") &&

		filter_git add . &&
		cat >expected.log <<-EOF &&
			START
			init handshake complete
			IN: clean test.r $S [OK] -- OUT: $S . [OK]
			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
			IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
			STOP
		EOF
		test_cmp_count expected.log rot13-filter.log &&

		filter_git commit -m "test commit 2" &&
		cat >expected.log <<-EOF &&
			START
			init handshake complete
			IN: clean test.r $S [OK] -- OUT: $S . [OK]
			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
			IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
			IN: clean test.r $S [OK] -- OUT: $S . [OK]
			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
			IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
			STOP
		EOF
		test_cmp_count expected.log rot13-filter.log &&

		rm -f test2.r "testsubdir/test3 'sq',\$x=.r" &&

		filter_git checkout --quiet --no-progress . &&
		cat >expected.log <<-EOF &&
			START
			init handshake complete
			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
			IN: smudge testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
			STOP
		EOF
		test_cmp_exclude_clean expected.log rot13-filter.log &&

		filter_git checkout --quiet --no-progress empty-branch &&
		cat >expected.log <<-EOF &&
			START
			init handshake complete
			IN: clean test.r $S [OK] -- OUT: $S . [OK]
			STOP
		EOF
		test_cmp_exclude_clean expected.log rot13-filter.log &&

		filter_git checkout --quiet --no-progress master &&
		cat >expected.log <<-EOF &&
			START
			init handshake complete
			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
			IN: smudge testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
			STOP
		EOF
		test_cmp_exclude_clean expected.log rot13-filter.log &&

		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
		test_cmp_committed_rot13 "$TEST_ROOT/test3 'sq',\$x=.o" "testsubdir/test3 'sq',\$x=.r"
	)

Initialized empty Git repository in /home/ramsay/git/t/trash directory.t0021-conversion/repo/.git/
[master (root-commit) 56d459b] test commit 1
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 .gitattributes
[master 9ea74df] test commit 2
 Author: A U Thor <author@example.com>
 4 files changed, 5 insertions(+)
 create mode 100644 test.r
 create mode 100644 test2.r
 create mode 100644 test4-empty.r
 create mode 100644 testsubdir/test3 'sq',$x=.r
sort: cannot read: rot13-filter.log: No such file or directory
--- expected.log	2016-12-16 20:14:29.037426091 +0000
+++ rot13-filter.log	2016-12-16 20:14:29.041426091 +0000
@@ -1,7 +0,0 @@
-x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
-x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-x IN: clean testsubdir/test3 'sq',$x=.r 49 [OK] -- OUT: 49 . [OK]
-      1 START
-      1 STOP
-      1 init handshake complete
not ok 15 - required process filter should filter data
#	
#		test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
#		test_config_global filter.protocol.required true &&
#		rm -rf repo &&
#		mkdir repo &&
#		(
#			cd repo &&
#			git init &&
#	
#			echo "*.r filter=protocol" >.gitattributes &&
#			git add . &&
#			git commit -m "test commit 1" &&
#			git branch empty-branch &&
#	
#			cp "$TEST_ROOT/test.o" test.r &&
#			cp "$TEST_ROOT/test2.o" test2.r &&
#			mkdir testsubdir &&
#			cp "$TEST_ROOT/test3 'sq',\$x=.o" "testsubdir/test3 'sq',\$x=.r" &&
#			>test4-empty.r &&
#	
#			S=$(file_size test.r) &&
#			S2=$(file_size test2.r) &&
#			S3=$(file_size "testsubdir/test3 'sq',\$x=.r") &&
#	
#			filter_git add . &&
#			cat >expected.log <<-EOF &&
#				START
#				init handshake complete
#				IN: clean test.r $S [OK] -- OUT: $S . [OK]
#				IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
#				IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
#				IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
#				STOP
#			EOF
#			test_cmp_count expected.log rot13-filter.log &&
#	
#			filter_git commit -m "test commit 2" &&
#			cat >expected.log <<-EOF &&
#				START
#				init handshake complete
#				IN: clean test.r $S [OK] -- OUT: $S . [OK]
#				IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
#				IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
#				IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
#				IN: clean test.r $S [OK] -- OUT: $S . [OK]
#				IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
#				IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
#				IN: clean testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
#				STOP
#			EOF
#			test_cmp_count expected.log rot13-filter.log &&
#	
#			rm -f test2.r "testsubdir/test3 'sq',\$x=.r" &&
#	
#			filter_git checkout --quiet --no-progress . &&
#			cat >expected.log <<-EOF &&
#				START
#				init handshake complete
#				IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
#				IN: smudge testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
#				STOP
#			EOF
#			test_cmp_exclude_clean expected.log rot13-filter.log &&
#	
#			filter_git checkout --quiet --no-progress empty-branch &&
#			cat >expected.log <<-EOF &&
#				START
#				init handshake complete
#				IN: clean test.r $S [OK] -- OUT: $S . [OK]
#				STOP
#			EOF
#			test_cmp_exclude_clean expected.log rot13-filter.log &&
#	
#			filter_git checkout --quiet --no-progress master &&
#			cat >expected.log <<-EOF &&
#				START
#				init handshake complete
#				IN: smudge test.r $S [OK] -- OUT: $S . [OK]
#				IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
#				IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
#				IN: smudge testsubdir/test3 'sq',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
#				STOP
#			EOF
#			test_cmp_exclude_clean expected.log rot13-filter.log &&
#	
#			test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
#			test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
#			test_cmp_committed_rot13 "$TEST_ROOT/test3 'sq',\$x=.o" "testsubdir/test3 'sq',\$x=.r"
#		)
#	
$ 
