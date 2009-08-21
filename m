From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/9] sequencer: add "--fast-forward" option to "git
	sequencer--helper"
Date: Fri, 21 Aug 2009 07:49:53 +0200
Message-ID: <20090821055001.3726.28215.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN6Y-0001bm-0U
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbZHUFzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbZHUFzq
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:46 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56349 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbZHUFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 772F9818127;
	Fri, 21 Aug 2009 07:55:36 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6D9E68180FE;
	Fri, 21 Aug 2009 07:55:34 +0200 (CEST)
X-git-sha1: c392148e7f33a05c1eb18de501ce36ca7d7fadbe 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126679>

This new option uses the "do_fast_forward()" function to perform
a fast forward.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 0cd7e98..bd72f65 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -19,6 +19,7 @@ static unsigned char head_sha1[20];
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
 	"git sequencer--helper --reset-hard <commit> <reflog-msg> <verbosity>",
+	"git sequencer--helper --fast-forward <commit> <reflog-msg> <verbosity>",
 	NULL
 };
 
@@ -218,11 +219,14 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 {
 	char *patch_commit = NULL;
 	char *reset_commit = NULL;
+	char *ff_commit = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "make-patch", &patch_commit, "commit",
 			   "create a patch from commit"),
 		OPT_STRING(0, "reset-hard", &reset_commit, "commit",
 			   "reset to commit"),
+		OPT_STRING(0, "fast-forward", &ff_commit, "commit",
+			   "fast forward to commit"),
 		OPT_END()
 	};
 
@@ -239,15 +243,16 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (reset_commit) {
+	if (ff_commit || reset_commit) {
 		unsigned char sha1[20];
+		char *commit = ff_commit ? ff_commit : reset_commit;
 
 		if (argc != 2)
 			usage_with_options(git_sequencer_helper_usage,
 					   options);
 
-		if (get_sha1(reset_commit, sha1)) {
-			error("Could not find '%s'", reset_commit);
+		if (get_sha1(commit, sha1)) {
+			error("Could not find '%s'", commit);
 			return 1;
 		}
 
@@ -258,7 +263,10 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			return 1;
 		}
 
-		return reset_almost_hard(sha1);
+		if (ff_commit)
+			return do_fast_forward(sha1);
+		else
+			return reset_almost_hard(sha1);
 	}
 
 	usage_with_options(git_sequencer_helper_usage, options);
-- 
1.6.4.271.ge010d
