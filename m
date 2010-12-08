From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [WIP/RFH] format-patch: Allow diffs for first-parent history
Date: Wed,  8 Dec 2010 11:18:35 +0100
Message-ID: <f60b93ae61c0e3088112cd6e1185d9c66f623813.1291803440.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 11:21:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQH8y-0000gT-9D
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab0LHKU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:20:59 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60464 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754185Ab0LHKU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 05:20:58 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B21A83A0
	for <git@vger.kernel.org>; Wed,  8 Dec 2010 05:20:57 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 08 Dec 2010 05:20:57 -0500
X-Sasl-enc: l+OKQGjBVBjkfFXnz2YVv/Xs42r7nXU9219zk74mMPvk 1291803657
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 354E95E89A8;
	Wed,  8 Dec 2010 05:20:57 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.660.g7cc83
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163183>

Introduce a new option "--first-parent" to format-patch which allows
to export the "main development" line as a series of patches, where
merge commits are represented by their diff against the first parent.

This is useful for keeping development steps and history in side
branches and exporting the cleaned up main line for upstream ("mergy
rebase").

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This does not work yet! Work In Progress/Request For Help

"git log -p -m --first-parent" does exactly what I want to achieve,
since the parent rewriting done by "--first-parent" makes "-p -m" output
the diff to the first parent only.

The attached patch teaches format-patch not to ignore merges (on
"--first-parent"), but I failed to track how "diff-tree" sets options
based on "-m" and how to do that for "format-patch". I am sure someone
here can help me!

 builtin/log.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 4191d9c..34d01d3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -983,6 +983,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
+	int first_parent = 0;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -1023,6 +1024,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_BOOLEAN, 'p', "no-stat", &use_patch_format, NULL,
 		  "show patch format instead of default (patch + stat)",
 		  PARSE_OPT_NONEG | PARSE_OPT_NOARG },
+		OPT_BOOLEAN(0, "first-parent", &first_parent,
+			    "follow first parents"),
 		OPT_GROUP("Messaging"),
 		{ OPTION_CALLBACK, 0, "add-header", NULL, "header",
 			    "add email header", 0, header_callback },
@@ -1055,7 +1058,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.no_merges = 1;
+	rev.no_merges = !first_parent;
+	rev.first_parent_only = first_parent;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
-- 
1.7.3.2.660.g7cc83
