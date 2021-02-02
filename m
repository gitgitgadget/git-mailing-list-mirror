Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F7CC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE5B64E4B
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhBBUFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:05:00 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34235 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbhBBUEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:04:16 -0500
X-Originating-IP: 103.82.80.138
Received: from localhost.localdomain (unknown [103.82.80.138])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9A87260008;
        Tue,  2 Feb 2021 20:03:20 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH] git-gui: remove lines starting with the comment character
Date:   Wed,  3 Feb 2021 01:33:01 +0530
Message-Id: <20210202200301.44282-1-me@yadavpratyush.com>
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
the comment character. If the config is not set, '#' is taken as the
default.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 lib/commit.tcl | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/commit.tcl b/lib/commit.tcl
index 11379f8..3c3035f 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -209,6 +209,28 @@ You must stage at least 1 file before you can commit.
 	#
 	set msg [string trim [$ui_comm get 1.0 end]]
 	regsub -all -line {[ \t\r]+$} $msg {} msg
+
+	# Remove lines starting with the comment character.
+	set comment_char [get_config core.commentchar]
+	if {[string length $comment_char] > 1} {
+		error_popup [mc "core.commitchar should only be one character."]
+		unlock_index
+		return
+	}
+
+	if {$comment_char eq {}} {
+		set comment_char "#"
+	}
+
+	# If the comment character is not alphabetical, then we need to escape it
+	# with a backslash to make sure it is not interpreted as a special character
+	# in the regex.
+	if {![string is alpha $comment_char]} {
+		set comment_char "\\$comment_char"
+	}
+
+	regsub -all -line "$comment_char.*(\\n|\\Z)" $msg {} msg
+
 	if {$msg eq {}} {
 		error_popup [mc "Please supply a commit message.

--
2.30.0

