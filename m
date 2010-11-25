From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 13/18] revert: add option parsing for option --continue
Date: Thu, 25 Nov 2010 22:20:44 +0100
Message-ID: <20101125212050.5188.59731.chriscool@tuxfamily.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:56:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrIg-0007NM-4X
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438Ab0KZFzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:55:25 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47872 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab0KZFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:55:23 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7384AA614F;
	Fri, 26 Nov 2010 06:55:16 +0100 (CET)
X-git-sha1: d1e5cec84dd97f91c0c9d643ac7272bae5adcd0b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162200>

Right now this new option does nothing. It is just a start.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 27e9d6f..12a2409 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -29,11 +29,13 @@
 
 static const char * const revert_usage[] = {
 	"git revert [options] <commit-ish>",
+	"git revert --continue",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
 	"git cherry-pick [options] <commit-ish>",
+	"git cherry-pick --continue",
 	NULL
 };
 
@@ -48,6 +50,7 @@ struct args_info {
 	int signoff;
 	int allow_ff;
 	int allow_rerere_auto;
+	int continuing;
 	const char *strategy;
 	const char **commit_argv;
 	int commit_argc;
@@ -72,6 +75,8 @@ static void parse_args(int argc, const char **argv, struct args_info *info)
 {
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "continue", &info->continuing,
+			    "continue after resolving a conflict"),
 		OPT_BOOLEAN('n', "no-commit", &info->no_commit,
 			    "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &info->edit, "edit the commit message"),
@@ -102,7 +107,18 @@ static void parse_args(int argc, const char **argv, struct args_info *info)
 					  PARSE_OPT_KEEP_UNKNOWN);
 	info->commit_argv = argv;
 
-	if (info->commit_argc < 2)
+	if (info->continuing) {
+		if (info->commit_argc != 1)
+			usage_msg_opt("No argument can be passed along "
+				      "with option --continue!",
+				      info->usage_str, options);
+		if (info->no_commit || info->edit || info->signoff ||
+		    info->mainline || info->allow_rerere_auto || info->strategy ||
+		    info->no_replay || info->allow_ff)
+			usage_msg_opt("No other option can be passed along "
+				      "with option --continue!",
+				      info->usage_str, options);
+	} else if (info->commit_argc < 2)
 		usage_with_options(info->usage_str, options);
 }
 
@@ -712,7 +728,10 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
 	infos.action = revert ? REVERT : CHERRY_PICK;
 	parse_args(argc, argv, &infos);
 
-	res = pick_commits(&infos, &done_list);
+	if (infos.continuing)
+		res = 0;
+	else
+		res = pick_commits(&infos, &done_list);
 
 	free_commit_list(done_list);
 
-- 
1.7.3.2.504.g59d466
