X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (resend)] gitweb: Use --no-commit-id in git_commit and git_commitdiff
Date: Thu, 26 Oct 2006 01:59:46 -0700
Message-ID: <7vejsvpi4d.fsf@assigned-by-dhcp.cox.net>
References: <200610261050.21214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 08:59:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610261050.21214.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 26 Oct 2006 10:50:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30158>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd15c-0005EY-Dv for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752119AbWJZI7s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 04:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWJZI7s
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:59:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41718 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1752119AbWJZI7r
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:59:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026085947.NHUI12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 04:59:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ewzV1V00B1kojtg0000000 Thu, 26 Oct 2006
 04:59:29 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Use --no-commit-id option to git-diff-tree command in git_commit and
> git_commitdiff to filter out commit ID output that git-diff-tree adds
> when called with only one <tree-ish> (not only for --stdin). Remove
> filtering commit IDs from git-diff-tree output.
>
> This option is in git since at least v1.0.0, so make use of it.

*BLUSH*

I think we would need something like this, if only for
completeness.

-- >8 --
[PATCH] combine-diff: honour --no-commit-id

Somehow we forgot to look at no_commit_id flag in these
codepaths.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 combine-diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 01a8437..8ff46e8 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -737,7 +737,7 @@ static void show_patch_diff(struct combi
 		int added = 0;
 		int deleted = 0;
 
-		if (rev->loginfo)
+		if (rev->loginfo && !rev->no_commit_id)
 			show_log(rev, opt->msg_sep);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
 				 elem->path, c_meta, c_reset);
@@ -815,7 +815,7 @@ static void show_raw_diff(struct combine
 	if (!line_termination)
 		inter_name_termination = 0;
 
-	if (rev->loginfo)
+	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev, opt->msg_sep);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
@@ -887,7 +887,7 @@ void diff_tree_combined(const unsigned c
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diffopts.recursive = 1;
 
-	show_log_first = !!rev->loginfo;
+	show_log_first = !!rev->loginfo && !rev->no_commit_id;
 	needsep = 0;
 	/* find set of paths that everybody touches */
 	for (i = 0; i < num_parent; i++) {
