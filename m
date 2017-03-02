Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 193FA2027B
	for <e@80x24.org>; Thu,  2 Mar 2017 15:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdCBPm6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 10:42:58 -0500
Received: from avasout05.plus.net ([84.93.230.250]:58838 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdCBPlh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 10:41:37 -0500
Received: from deneb ([80.229.24.9])
        by avasout05 with smtp
        id r3eH1u0020BmcFC013eJvs; Thu, 02 Mar 2017 15:38:19 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Hr8GIwbS c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=8nJEP1OIZ-IA:10 a=6Iz7jQTuP9IA:10 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8
 a=-An2I_7KAAAA:8 a=VJPanoOk9c1QfeT2JC0A:9 a=6RyHdP9wf0s6W1bbVaoE2bQoMl4=:19
 a=wPNLvfGTeEIA:10 a=PwKx63F5tFurRwaNxrlG:22 a=nJcEw6yWrPvoIXZ49MH8:22
 a=Sq34B_EcNBM9_nrAYB9S:22
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1cjSo5-00053C-H7; Thu, 02 Mar 2017 15:38:17 +0000
Date:   Thu, 2 Mar 2017 15:38:17 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: git status reports file modified when only line-endings have changed
 (was git diff --quiet exits with 1 on clean tree with CRLF conversions)
Message-ID: <20170302153817.GC7821@mcrowe.com>
References: <20170217212633.GA24937@mcrowe.com>
 <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
 <20170217221958.GA12163@mcrowe.com>
 <20170220153322.GA8352@mcrowe.com>
 <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
 <20170225153230.GA30565@mcrowe.com>
 <xmqqefyjwfql.fsf@gitster.mtv.corp.google.com>
 <d98aa589-3e08-249d-0c88-72dbcee1a568@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d98aa589-3e08-249d-0c88-72dbcee1a568@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 28 February 2017 at 19:06:44 +0100, Torsten Bögershausen wrote:
> My understanding is that git diff --quiet should be quiet, when
> git add will not do anything (but the file is "touched".
> The touched means that Git will detect e.g a new mtime or inode
> or file size when doing lstat().

Does the same apply to "git status"?

If so, then whilst investigating the "git diff --quiet" problems in this
thread I've found a similar bug with "git status". It reports the file has
modifications even if only the line-endings have changed, and issuing "git
add" causes the perceived modification to disappear.

It can be very confusing for users if "git status" reports a modification
but for "git diff" to claim that the files are identical.

This bug is still reproducible even with the fix from
https://public-inbox.org/git/xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com/T/#m67cbfad1f2efe721f0c2afac2a1523b743bb57ca

Here's the test case. Test 3 is the part that currently fails:

commit de5f3f1d9161cdd46342689abe38a046fc71850e
Author: Mike Crowe <mac@mcrowe.com>
Date:   Sat Feb 25 09:28:37 2017 +0000

    status: Add tests for status output when file line endings change

diff --git a/t/t7518-status-eol-change.sh b/t/t7518-status-eol-change.sh
new file mode 100755
index 0000000..e18186f
--- /dev/null
+++ b/t/t7518-status-eol-change.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Mike Crowe
+#
+
+test_description='git status with files that require CRLF conversion'
+
+. ./test-lib.sh
+
+cat >expected_no_change <<EOF
+On branch master
+nothing to commit, working tree clean
+EOF
+
+test_expect_success setup '
+	echo "* text=auto" > .gitattributes &&
+	printf "Hello\r\nWorld\r\n" > crlf.txt &&
+	printf "expected_no_change\nactual\n" > .gitignore &&
+	git add .gitignore .gitattributes crlf.txt &&
+	git commit -m "initial"
+'
+test_expect_success 'git status reports no change if file regenerated' '
+	printf "Hello\r\nWorld\r\n" > crlf.txt &&
+	git status >actual &&
+	test_cmp expected_no_change actual
+'
+test_expect_success 'git status reports no change if line endings change' '
+	printf "Hello\nWorld\n" > crlf.txt &&
+	git status >actual &&
+	test_cmp expected_no_change actual
+'
+test_expect_success 'git status reports no change if line ending change is staged' '
+	git add crlf.txt &&
+	git status >actual &&
+	test_cmp expected_no_change actual
+'
+test_done
