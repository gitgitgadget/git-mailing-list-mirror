From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/9] sequencer: let "git sequencer--helper" callers set
	"allow_dirty"
Date: Sat, 22 Aug 2009 06:16:09 +0200
Message-ID: <20090822041616.4261.91862.chriscool@tuxfamily.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 06:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeiZa-0005aq-Mi
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 06:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbZHVEuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 00:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbZHVEus
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 00:50:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38305 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbZHVEuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 00:50:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0E312818083;
	Sat, 22 Aug 2009 06:50:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D182D818042;
	Sat, 22 Aug 2009 06:50:34 +0200 (CEST)
X-git-sha1: 9cc088addbbad5b06a73d9172f9ad0b8cb5b3b13 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090822041157.4261.92491.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126789>

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
