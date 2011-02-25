From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 2/3] git-commit: rename --all to --track
Date: Fri, 25 Feb 2011 15:45:53 +0100
Message-ID: <3873657a89ba3464b68d7b0388d151ab68e44c27.1298644872.git.git@drmicha.warpmail.net>
References: <cover.1298644872.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 25 15:49:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsyzA-0005lg-EV
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 15:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab1BYOtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 09:49:19 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55537 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754927Ab1BYOtS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 09:49:18 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2CBDB2099A;
	Fri, 25 Feb 2011 09:49:18 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Feb 2011 09:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=hPg/YXreM6cw2eWU547BTWAY8NE=; b=GRs32jq9sVs0sFRAJSkIV0m+A8wt9kLGXBBSG47dDCvaSIA4Upb2LGPVRUWz+cPo8JRtqv77Rc/QPTOW7znvgTFobn0qqano8qTBuhuEGwf9RXEYGp7Ia1DQVlMjCWeFQBcAFTfJfR+BNAALbV9oj/Yr/D+j0jzKWpEWRlSvBg8=
X-Sasl-enc: szHj53W05JYXx4NmgmFIISV7jn2VPERgoXVkbG48f2Q2 1298645357
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 95AFA440EA3;
	Fri, 25 Feb 2011 09:49:17 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <cover.1298644872.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167909>

Currently, the long option "--all" does different things for "add" (it
is "-A") and "commit" (it is "-a").

Rename the "commit" long option to "--tracked" which conveys the fact
that it is about all tracked files only.

Also, rename the corresponding static int in code from "all" to
"alltracked" to help future coders.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-commit.txt |    2 +-
 builtin/commit.c             |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 411fa68..0163d6d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -54,7 +54,7 @@ that, you can recover from it with 'git reset'.
 OPTIONS
 -------
 -a::
---all::
+--tracked::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
 	told git about are not affected.
diff --git a/builtin/commit.c b/builtin/commit.c
index d279a84..002cf03 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -83,7 +83,7 @@ static const char *template_file;
 static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int alltracked, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -149,7 +149,7 @@ static struct option builtin_commit_options[] = {
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
-	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
+	OPT_BOOLEAN('a', "tracked", &alltracked, "commit all changed tracked files"),
 	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
 	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
@@ -367,7 +367,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 * (A) if all goes well, commit the real index;
 	 * (B) on failure, rollback the real index.
 	 */
-	if (all || (also && pathspec && *pathspec)) {
+	if (alltracked || (also && pathspec && *pathspec)) {
 		fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(also ? prefix : NULL, pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
@@ -1040,8 +1040,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		author_message_buffer = read_commit_message(author_message);
 	}
 
-	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.");
+	if (!!also + !!only + !!alltracked + !!interactive > 1)
+		die("Only one of --include/--only/--tracked/--interactive can be used.");
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
@@ -1061,7 +1061,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	handle_untracked_files_arg(s);
 
-	if (all && argc > 0)
+	if (alltracked && argc > 0)
 		die("Paths with -a does not make sense.");
 	else if (interactive && argc > 0)
 		die("Paths with --interactive does not make sense.");
-- 
1.7.4.1.224.gefc87
