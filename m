Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A351C201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 21:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934951AbdBQVeP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 16:34:15 -0500
Received: from avasout06.plus.net ([212.159.14.18]:46700 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934415AbdBQVeO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 16:34:14 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Feb 2017 16:34:14 EST
Received: from deneb ([80.229.24.9])
        by avasout06 with smtp
        id lxSZ1u0030BmcFC01xSbSw; Fri, 17 Feb 2017 21:26:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=QoEu5R6d c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=n2v9WMKugxEA:10 a=8mQH5kNUae4DCTJlzd4A:9 a=CjuIK1q_8ugA:10
Received: from mac by deneb with local (Exim 4.84_2)
        (envelope-from <mac@mcrowe.com>)
        id 1ceq2z-0002Tm-TM
        for git@vger.kernel.org; Fri, 17 Feb 2017 21:26:33 +0000
Date:   Fri, 17 Feb 2017 21:26:33 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     git@vger.kernel.org
Subject: git diff --quiet exits with 1 on clean tree with CRLF conversions
Message-ID: <20170217212633.GA24937@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If "git diff --quiet" finds it necessary to compare actual file contents,
and a file requires CRLF conversion, then it incorrectly exits with an exit
code of 1 even if there have been no changes.

The patch below adds a test file that shows the problem.

The first test of diff without --quiet correctly has an exit status of zero
on both invocations.

The second test of diff with --quiet has an exit code of zero on the first
invocation, but an exit code of one on the second invocation. Further
invocations (not included in the test) may yield an exit code of 1. Calling
"git status" always fixes things.

(The touching with "tomorrow" was my attempt to avoid the sleep, but that
didn't seem to help - it appears that time must pass in order to ensure
that the cache is not used.)

The culprit would appear to be in diff_filespec_check_stat_unmatch where it
assumes that the files are different if their sizes are different:

	if (!DIFF_FILE_VALID(p->one) || /* (1) */
	    !DIFF_FILE_VALID(p->two) ||
	    (p->one->oid_valid && p->two->oid_valid) ||
	    (p->one->mode != p->two->mode) ||
	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
	    (p->one->size != p->two->size) ||
	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
		p->skip_stat_unmatch_result = 1;

In the failing case p->one->size == 14 and p->two->size == 12.

Mike.

diff --git a/t/t4063-diff-converted.sh b/t/t4063-diff-converted.sh
new file mode 100755
index 0000000..a108dfb
--- /dev/null
+++ b/t/t4063-diff-converted.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Mike Crowe
+#
+
+test_description='git diff with files that require CRLF conversion'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* text=auto" > .gitattributes &&
+	printf "Hello\r\nWorld\r\n" > crlf.txt &&
+	git add .gitattributes crlf.txt &&
+	git commit -m "initial"
+'
+test_expect_success 'noisy diff works on file that requires CRLF conversion' '
+	git status >/dev/null &&
+	git diff >/dev/null &&
+	sleep 1 &&
+	touch --date=tomorrow crlf.txt &&
+	git diff >/dev/null
+'
+# The sleep is required for reasons I don't fully understand
+test_expect_success 'quiet diff works on file that requires CRLF conversion with no changes' '
+	git status &&
+	git diff --quiet &&
+	sleep 1 &&
+	touch --date=tomorrow crlf.txt &&
+	git diff --quiet
+'
+
+test_done
