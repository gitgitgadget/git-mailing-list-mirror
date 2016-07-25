Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EA3203E3
	for <e@80x24.org>; Mon, 25 Jul 2016 19:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbcGYT3B (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:29:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:27472 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbcGYT26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:28:58 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 9040384607;
	Mon, 25 Jul 2016 15:28:56 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 7/8] status: update git-status.txt for --porcelain=v2
Date:	Mon, 25 Jul 2016 15:25:49 -0400
Message-Id: <1469474750-49075-8-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
References: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Update status manpage to include information about
porcelain v2 format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt | 83 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6b1454b..e64b1b8 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -185,10 +185,10 @@ If -b is used the short-format status is preceded by a line
 
 ## branchname tracking info
 
-Porcelain Format
-~~~~~~~~~~~~~~~~
+Porcelain Format Version 1
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The porcelain format is similar to the short format, but is guaranteed
+Version 1 porcelain format is similar to the short format, but is guaranteed
 not to change in a backwards-incompatible way between Git versions or
 based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
@@ -210,6 +210,83 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Porcelain Format Version 2
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Version 2 format adds more detailed information about the state of
+the worktree and the changed items.
+
+If `--branch` is given, a header line showing branch tracking information
+is printed.  This line begins with "### branch: ".  Fields are separated
+by a single space.
+
+    Field                    Meaning
+    --------------------------------------------------------
+    <sha> | (initial)        Current commit
+    <branch> | (detached)    Current branch
+    <upstream>               Upstream branch, if set
+    +<ahead>                 Ahead count, if upstream present
+    -<behind>                Behind count, if upstream present
+    --------------------------------------------------------
+
+A series of lines are then displayed for the tracked entries.
+Ordinary changed entries have the following format; the first
+character is a 'c' to distinguish them from unmerged entries.
+
+    c <xy> <sub> <mH> <mI> <mW> <hH> <hI> R<nr> <path>[\t<pathSrc>]
+
+    Field       Meaning
+    --------------------------------------------------------
+    <xy>        A 2 character field containing the staged and
+                unstaged XY values described in the short format,
+                with unchanged indicated by a "." rather than
+                a space.
+    <sub>       A 4 character field describing the submodule state.
+                "N..." when the entry is not a submodule.
+                "S<c><m><u>" when the entry is a submodule.
+                <c> is "C" if the commit changed; otherwise ".".
+                <m> is "M" if it has tracked changes; otherwise ".".
+                <u> is "U" if there are untracked changes; otherwise ".".
+    <m*>        The 6 character octal file modes for head, index,
+                and worktree.
+    <h*>        The head and index SHA1 values.
+    R<nr>       The rename percentage score.
+    <path>      The current pathname. It is C-Quoted if it contains
+                special control characters.
+    <pathSrc>   The original path. This is only present for staged renames.
+                It is C-Quoted if necessary.
+    --------------------------------------------------------
+
+Unmerged entries have the following format; the first character is
+a "u" to distinguish from ordinary changed entries.
+
+    u <xy> <sub> <m1> <m2> <m3> <h1> <h2> <h3> <path>
+
+    Field       Meaning
+    --------------------------------------------------------
+    <xy>        A 2 character field describing the conflict type
+                as described in the short format.
+    <sub>       A 4 character field describing the submodule state
+                as described above.
+    <m*>        The 6 character octal file modes for the stage 1,
+                stage 2, stage 3, and worktree.
+                For regular entries, these are the head, index, and
+                worktree modes; the fourth is zero.
+    <h*>        The stage 1, stage 2, and stage 3 SHA1 values.
+    <path>      The current pathname. It is C-Quoted if necessary.
+    --------------------------------------------------------
+
+A series of lines are then displayed for untracked and ignored entries.
+
+    <x> <path>
+
+Where <x> is "?" for untracked entries and "!" for ignored entries.
+
+When the `-z` option is given, a NUL (zero) byte follows each pathname;
+serving as both a separator and line termination. No pathname quoting
+or backslash escaping is performed. All fields are output in the same
+order.
+
 CONFIGURATION
 -------------
 
-- 
2.8.0.rc4.17.gac42084.dirty

