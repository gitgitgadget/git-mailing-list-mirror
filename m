Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5785F203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbcGZVNx (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:13:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:54048 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161041AbcGZVNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:50 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 831A184619;
	Tue, 26 Jul 2016 17:13:48 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 7/8] status: update git-status.txt for --porcelain=v2
Date:	Tue, 26 Jul 2016 17:11:22 -0400
Message-Id: <1469567483-58794-8-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update status manpage to include information about
porcelain v2 format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 Documentation/git-status.txt | 93 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6b1454b..ed3590d 100644
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
@@ -210,6 +210,93 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Porcelain Format Version 2
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Version 2 format adds more detailed information about the state of
+the worktree and changed items.
+
+If `--branch` is given, a series of header lines are printed with
+information about the current branch.
+
+    Line                                 Notes
+    --------------------------------------------------------
+    # branch.oid <commit> | (initial)    Current commit
+    # branch.head <branch> | (detached)  Current branch
+    # branch.upstream <upstream_branch>  If set
+    # branch.ab +<ahead> -<behind>       If set and present
+    --------------------------------------------------------
+
+A series of lines are then displayed for the tracked entries.
+Ordinary changed entries have the following format:
+
+    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
+
+Renamed or copied entries have the following format:
+
+    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path>\t<pathSrc>
+
+    Field       Meaning
+    --------------------------------------------------------
+    <XY>        A 2 character field containing the staged and
+                unstaged XY values described in the short format,
+                with unchanged indicated by a "." rather than
+                a space.
+    <sub>       A 4 character field describing the submodule state.
+                "N..." when the entry is not a submodule.
+                "S<c><m><u>" when the entry is a submodule.
+                <c> is "C" if the commit changed; otherwise ".".
+                <m> is "M" if it has tracked changes; otherwise ".".
+                <u> is "U" if there are untracked changes; otherwise ".".
+    <mH>        The 6 character octal file mode in the HEAD.
+    <mI>        The octal file mode in the index.
+    <mW>        The octal file mode in the worktree.
+    <hH>        The SHA1 value in the HEAD.
+    <hI>        The SHA1 value in the index.
+    <X><nr>     The rename or copied percentage score. For example "R100"
+                or "C75".
+    <path>      The current pathname.
+    <pathSrc>   The original path. This is only present when the entry
+                has been renamed or copied.
+    --------------------------------------------------------
+
+Unmerged entries have the following format; the first character is
+a "u" to distinguish from ordinary changed entries.
+
+    u <xy> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
+
+    Field       Meaning
+    --------------------------------------------------------
+    <XY>        A 2 character field describing the conflict type
+                as described in the short format.
+    <sub>       A 4 character field describing the submodule state
+                as described above.
+    <m1>        The octal file mode for stage 1.
+    <m2>        The octal file mode for stage 2.
+    <m3>        The octal file mode for stage 3.
+    <mW>        The octal file mode in the worktree.
+    <h1>        The SHA1 value for stage 1.
+    <h2>        The SHA1 value for stage 2.
+    <h3>        The SHA1 value for stage 3.
+    <path>      The current pathname.
+    --------------------------------------------------------
+
+A series of lines are then displayed for untracked and ignored entries.
+
+    <x> <path>
+
+Where <x> is "?" for untracked entries and "!" for ignored entries.
+
+In all 3 line formats, pathnames will be "C Quoted" if they contain
+any of the following characters: TAB, LF, double quotes, or backslashes.
+These characters will be replaced with \t, \n, \", and \\, respectively,
+and the pathname will be enclosed in double quotes.
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

