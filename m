Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9731FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbcLOR2M (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 12:28:12 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:34410
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751088AbcLOR2L (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Dec 2016 12:28:11 -0500
X-Greylist: delayed 762 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Dec 2016 12:28:11 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1481822079;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=r5fWtGpDJ617NSN00O6rk4CkaAMyjJFkKBZa/CQWJbg=;
        b=QyL2OGPb1KZ1Ok/PJvXOXGeAhJX/TZfppJlEI71jPZ3Ws/IP8pbyiuvZ1Im9NsBt
        +0V4U7z4/awmm9czsxeepWCYzlZixSq+MFe8ysX0wnqZ+Qijl9/jUhY0QciudDUeuqG
        LGzK/2bhdvjF8Bvbvbn/NQD9jvNYzwdS/79AzWuo=
From:   George Vanburgh <george@vanburgh.me>
To:     git@vger.kernel.org
Message-ID: <01020159037a8995-2d1da9d4-4a27-4b98-818b-432fc0ad8a52-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-p4: Fix multi-path changelist empty commits
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Dec 2016 17:14:39 +0000
X-SES-Outgoing: 2016.12.15-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: George Vanburgh <gvanburgh@bloomberg.net>

When importing from multiple perforce paths - we may attempt to import a changelist that contains files from two (or more) of these depot paths. Currently, this results in multiple git commits - one containing the changes, and the other(s) as empty commits. This behavior was introduced in commit 1f90a64 ("git-p4: reduce number of server queries for fetches", 2015-12-19).

Reproduction Steps:

1. Have a git repo cloned from a perforce repo using multiple depot paths (e.g. //depot/foo and //depot/bar).
2. Submit a single change to the perforce repo that makes changes in both //depot/foo and //depot/bar.
3. Run "git p4 sync" to sync the change from #2.

Change is synced as multiple commits, one for each depot path that was affected.

Using a set, instead of a list inside p4ChangesForPaths() ensures that each changelist is unique to the returned list, and therefore only a single commit is generated for each changelist.

Reported-by: James Farwell <jfarwell@vmware.com>
Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
---
 git-p4.py               |  4 ++--
 t/t9800-git-p4-basic.sh | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52..6307bc8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -822,7 +822,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
                 die("cannot use --changes-block-size with non-numeric revisions")
             block_size = None
 
-    changes = []
+    changes = set()
 
     # Retrieve changes a block at a time, to prevent running
     # into a MaxResults/MaxScanRows error from the server.
@@ -841,7 +841,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
 
         # Insert changes in chronological order
         for line in reversed(p4_read_pipe_lines(cmd)):
-            changes.append(int(line.split(" ")[1]))
+            changes.add(int(line.split(" ")[1]))
 
         if not block_size:
             break
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 0730f18..4d72e0b 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -131,6 +131,26 @@ test_expect_success 'clone two dirs, @all, conflicting files' '
 	)
 '
 
+test_expect_success 'clone two dirs, each edited by submit, single git commit' '
+	(
+		cd "$cli" &&
+		echo sub1/f4 >sub1/f4 &&
+		p4 add sub1/f4 &&
+		echo sub2/f4 >sub2/f4 &&
+		p4 add sub2/f4 &&
+		p4 submit -d "sub1/f4 and sub2/f4"
+	) &&
+	git p4 clone --dest="$git" //depot/sub1@all //depot/sub2@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git"
+		git ls-files >lines &&
+		test_line_count = 4 lines &&
+		git log --oneline p4/master >lines &&
+		test_line_count = 5 lines
+	)
+'
+
 revision_ranges="2000/01/01,#head \
 		 1,2080/01/01 \
 		 2000/01/01,2080/01/01 \
@@ -147,7 +167,7 @@ test_expect_success 'clone using non-numeric revision ranges' '
 		(
 			cd "$git" &&
 			git ls-files >lines &&
-			test_line_count = 6 lines
+			test_line_count = 8 lines
 		)
 	done
 '

--
https://github.com/git/git/pull/311
