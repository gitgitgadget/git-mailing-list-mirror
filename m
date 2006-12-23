From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 17/17] Test suite for sliding window mmap implementation.
Date: Sat, 23 Dec 2006 02:34:51 -0500
Message-ID: <20061223073451.GR9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:35:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1PJ-0001wo-GL
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbWLWHez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbWLWHez
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38835 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbWLWHey (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1Om-0003EP-N3; Sat, 23 Dec 2006 02:34:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6595F20FB65; Sat, 23 Dec 2006 02:34:51 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35297>

This is a basic set of tests for the sliding window mmap.  We mostly
focus on the verify-pack and pack-objects implementations (including
delta reuse) as these commands appear to cover the bulk of the
affected portions of sha1_file.c.

The test cases don't verify the virtual memory size used, as
this can differ from system to system.  Instead it just verifies
that we can run with very low values for core.packedGitLimit and
core.packedGitWindowSize.

Adding pack_report() to the end of both builtin-verify-pack.c and
builtin-pack-objects.c and manually inspecting the statistics output
can help to verify that the total virtual memory size attributed
to pack mmap usage is what one might expect on the current system.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5301-sliding-window.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
new file mode 100755
index 0000000..5a7232a
--- /dev/null
+++ b/t/t5301-sliding-window.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Shawn Pearce
+#
+
+test_description='mmap sliding window tests'
+. ./test-lib.sh
+
+test_expect_success \
+    'setup' \
+    'rm -f .git/index*
+     for i in a b c
+     do
+         echo $i >$i &&
+         dd if=/dev/urandom bs=32k count=1 >>$i &&
+         git-update-index --add $i || return 1
+     done &&
+     echo d >d && cat c >>d && git-update-index --add d &&
+     tree=`git-write-tree` &&
+     commit1=`git-commit-tree $tree </dev/null` &&
+     git-update-ref HEAD $commit1 &&
+     git-repack -a -d &&
+     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     pack1=`ls .git/objects/pack/*.pack` &&
+     test -f "$pack1"'
+
+test_expect_success \
+    'verify-pack -v, defaults' \
+    'git-verify-pack -v "$pack1"'
+
+test_expect_success \
+    'verify-pack -v, packedGitWindowSize == 1 page' \
+    'git-repo-config core.packedGitWindowSize 512 &&
+     git-verify-pack -v "$pack1"'
+
+test_expect_success \
+    'verify-pack -v, packedGit{WindowSize,Limit} == 1 page' \
+    'git-repo-config core.packedGitWindowSize 512 &&
+     git-repo-config core.packedGitLimit 512 &&
+     git-verify-pack -v "$pack1"'
+
+test_expect_success \
+    'repack -a -d, packedGit{WindowSize,Limit} == 1 page' \
+    'git-repo-config core.packedGitWindowSize 512 &&
+     git-repo-config core.packedGitLimit 512 &&
+     commit2=`git-commit-tree $tree -p $commit1 </dev/null` &&
+     git-update-ref HEAD $commit2 &&
+     git-repack -a -d &&
+     test "`git-count-objects`" = "0 objects, 0 kilobytes" &&
+     pack2=`ls .git/objects/pack/*.pack` &&
+     test -f "$pack2"
+     test "$pack1" \!= "$pack2"'
+
+test_expect_success \
+    'verify-pack -v, defaults' \
+    'git-repo-config --unset core.packedGitWindowSize &&
+     git-repo-config --unset core.packedGitLimit &&
+     git-verify-pack -v "$pack2"'
+
+test_done
-- 
1.4.4.3.g87d8
