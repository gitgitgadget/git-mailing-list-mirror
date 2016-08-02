Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FE41F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 14:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbcHBOP7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 10:15:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:12885 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755756AbcHBOP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 10:15:26 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 0276B8464C;
	Tue,  2 Aug 2016 10:15:05 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v4 7/8] git-status.txt: describe --porcelain=v2 format
Date:	Tue,  2 Aug 2016 10:12:16 -0400
Message-Id: <1470147137-17498-8-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update status manpage to include information about
porcelain V2 format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 Documentation/git-status.txt | 123 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 6b1454b..76e7c92 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -183,12 +183,12 @@ in which case `XY` are `!!`.
 
 If -b is used the short-format status is preceded by a line
 
-## branchname tracking info
+    ## branchname tracking info
 
-Porcelain Format
-~~~~~~~~~~~~~~~~
+Porcelain Format Version 1
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The porcelain format is similar to the short format, but is guaranteed
+Version 1 porcelain format is similar to the short format, but is guaranteed
 not to change in a backwards-incompatible way between Git versions or
 based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
@@ -210,6 +210,121 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Porcelain Format Version 2
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Version 2 format adds more detailed information about the state of
+the worktree and changed items.  Version 2 also defines an extensible
+set of easy to parse optional headers.
+
+Header lines start with "#" and are added in response to specific
+command line arguments.  Parsers should ignore headers they
+don't recognize.
+
+### Branch Headers
+
+If `--branch` is given, a series of header lines are printed with
+information about the current branch.
+
+    Line                                     Notes
+    ------------------------------------------------------------
+    # branch.oid <commit> | (initial)        Current commit.
+    # branch.head <branch> | (detached)      Current branch.
+    # branch.upstream <upstream_branch>      If upstream is set.
+    # branch.ab +<ahead> -<behind>           If upstream is set and
+                                             the commit is present.
+    ------------------------------------------------------------
+
+### Changed Tracked Entries
+
+Following the headers, a series of lines are printed for tracked
+entries.  One of three different line formats may be used to describe
+an entry depending on the type of change.  Tracked entries are printed
+in an undefined order; parsers should allow for a mixture of the 3
+line types in any order.
+
+Ordinary changed entries have the following format:
+
+    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
+
+Renamed or copied entries have the following format:
+
+    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path><sep><pathSrc>
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
+    <sep>       When the `-z` option is used, the 2 pathnames are separated
+                with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
+                byte separates them.
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
+### Other Items
+
+Following the tracked entries (and if requested), a series of
+lines will be printed for untracked and then ignored items
+found in the worktree.
+
+Untracked items have the following format:
+
+    ? <path>
+
+Ignored items have the following format:
+
+    ! <path>
+
+### Pathname Format Notes and -z
+
+When the `-z` option is given, pathnames are printed as is and
+without any quoting and lines are terminated with a NUL (ASCII 0x00)
+byte.
+
+Otherwise, all pathnames will be "C-quoted" if they contain any tab,
+linefeed, double quote, or backslash characters. In C-quoting, these
+characters will be replaced with the corresponding C-style escape
+sequences and the resulting pathname will be double quoted.
+
+
 CONFIGURATION
 -------------
 
-- 
2.8.0.rc4.17.gac42084.dirty

