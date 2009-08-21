From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/9] sequencer: let "git sequencer--helper" callers set
	"allow_dirty"
Date: Fri, 21 Aug 2009 07:49:54 +0200
Message-ID: <20090821055001.3726.56268.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN6Z-0001bm-Iw
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbZHUFzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZHUFzr
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:47 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56357 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbZHUFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 05E568180D7;
	Fri, 21 Aug 2009 07:55:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C57BF818100;
	Fri, 21 Aug 2009 07:55:34 +0200 (CEST)
X-git-sha1: bbe07aba9d00218e4ddc302449b9c2e5fce0dff5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126682>

This flag can be set when using --reset-hard or --fast-forward, and
in this case changes in the work tree will be kept.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index bd72f65..71a7fef 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -18,8 +18,10 @@ static unsigned char head_sha1[20];
 
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
-	"git sequencer--helper --reset-hard <commit> <reflog-msg> <verbosity>",
-	"git sequencer--helper --fast-forward <commit> <reflog-msg> <verbosity>",
+	"git sequencer--helper --reset-hard <commit> <reflog-msg> "
+		"<verbosity> [<allow-dirty>]",
+	"git sequencer--helper --fast-forward <commit> <reflog-msg> "
+		"<verbosity> [<allow-dirty>]",
 	NULL
 };
 
@@ -247,7 +249,7 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 		char *commit = ff_commit ? ff_commit : reset_commit;
 
-		if (argc != 2)
+		if (argc != 2 && argc != 3)
 			usage_with_options(git_sequencer_helper_usage,
 					   options);
 
@@ -263,6 +265,9 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 			return 1;
 		}
 
+		if (argc == 3 && *argv[2] && strcmp(argv[2], "0"))
+			allow_dirty = 1;
+
 		if (ff_commit)
 			return do_fast_forward(sha1);
 		else
-- 
1.6.4.271.ge010d
