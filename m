Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5324C433E9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9BC64EB4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhBRSwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:52:49 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:46911 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBRSUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:20:35 -0500
Received: from localhost.localdomain (unknown [103.82.80.82])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BCDB4100003;
        Thu, 18 Feb 2021 18:19:45 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2] git-gui: remove lines starting with the comment character
Date:   Thu, 18 Feb 2021 23:49:37 +0530
Message-Id: <20210218181937.83419-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment character is specified by the config variable
'core.commentchar'. Any lines starting with this character is considered
a comment and should not be included in the final commit message.

Teach git-gui to filter out lines in the commit message that start with
the comment character using git-stripspace. If the config is not set,
'#' is taken as the default. Also add a message educating users about
the comment character.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---

Changes in v2:
- Use git-stripspace to sanitize the commit message.
- Add a message above the commit message buffer mentioning what the
  comment character is.

 git-gui.sh     |  5 +++++
 lib/commit.tcl | 18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 201524c..236bc4e 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -875,6 +875,7 @@ set default_config(merge.summary) false
 set default_config(merge.verbosity) 2
 set default_config(user.name) {}
 set default_config(user.email) {}
+set default_config(core.commentchar) "#"

 set default_config(gui.encoding) [encoding system]
 set default_config(gui.matchtrackingbranch) false
@@ -3436,6 +3437,10 @@ proc trace_commit_type {varname args} {
 	merge         {set txt [mc "Merge Commit Message:"]}
 	*             {set txt [mc "Commit Message:"]}
 	}
+
+	set comment_char [get_config core.commentchar]
+	set txt [string cat $txt \
+				 [mc " (Lines starting with '$comment_char' will be ignored)"]]
 	$ui_coml conf -text $txt
 }
 trace add variable commit_type write trace_commit_type
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 11379f8..23d67d4 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -141,6 +141,20 @@ proc setup_commit_encoding {msg_wt {quiet 0}} {
 	}
 }

+proc strip_msg {msg} {
+	set cmd [concat [list | ] [_git_cmd stripspace] --strip-comments]
+	_trace_exec $cmd
+	set fd [open $cmd r+]
+	fconfigure $fd -translation binary -encoding utf-8
+
+	puts -nonewline $fd $msg
+	close $fd w
+	set result [read $fd]
+	close $fd
+
+	return $result
+}
+
 proc commit_tree {} {
 	global HEAD commit_type file_states ui_comm repo_config
 	global pch_error
@@ -207,8 +221,8 @@ You must stage at least 1 file before you can commit.

 	# -- A message is required.
 	#
-	set msg [string trim [$ui_comm get 1.0 end]]
-	regsub -all -line {[ \t\r]+$} $msg {} msg
+	set msg [strip_msg [$ui_comm get 1.0 end]]
+
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.

--
2.30.0

