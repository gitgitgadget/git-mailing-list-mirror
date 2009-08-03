From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] sequencer: add "--reset-hard" option to "git
	sequencer--helper"
Date: Mon, 03 Aug 2009 04:40:21 +0200
Message-ID: <20090803024023.3794.44226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 06:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXpOm-0004to-1F
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 06:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbZHCEnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 00:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZHCEnf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 00:43:35 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36788 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbZHCEnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 00:43:32 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 14F2E818075;
	Mon,  3 Aug 2009 06:43:23 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CA23981806B;
	Mon,  3 Aug 2009 06:43:20 +0200 (CEST)
X-git-sha1: 3b54ea83ee396633ee66d7af58d4759e892cf46a 
X-Mailer: git-mail-commits v0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124684>

This new option uses the "reset_almost_hard()" function to perform
a reset.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   65 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 82a830d..e173671 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -18,6 +18,7 @@ static unsigned char head_sha1[20];
 
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
+	"git sequencer--helper --reset-hard <commit> <reflog-msg> <verbosity>",
 	NULL
 };
 
@@ -172,27 +173,71 @@ static int set_verbosity(int verbose)
 	return 0;
 }
 
+/* v should be "" or "t" or "\d" */
+static int parse_verbosity(const char *v)
+{
+	/* "" means verbosity = 1 */
+	if (!v[0])
+		return set_verbosity(1);
+
+	if (v[1])
+		return 1;
+
+	if (v[0] == 't')
+		return set_verbosity(2);
+
+	if (!isdigit(v[0]))
+		return 1;
+
+	return set_verbosity(v[0] - '0');
+}
+
 int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 {
-	char *commit = NULL;
-	struct commit *c;
+	char *patch_commit = NULL;
+	char *reset_commit = NULL;
 	struct option options[] = {
-		OPT_STRING(0, "make-patch", &commit, "commit",
+		OPT_STRING(0, "make-patch", &patch_commit, "commit",
 			   "create a patch from commit"),
+		OPT_STRING(0, "reset-hard", &reset_commit, "commit",
+			   "reset to commit"),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_sequencer_helper_usage, 0);
 
-	if (!commit)
-		usage_with_options(git_sequencer_helper_usage, options);
+	if (patch_commit) {
+		struct commit *c = get_commit(patch_commit);
+		if (!c)
+			return 1;
 
-	c = get_commit(commit);
-	if (!c)
-		return 1;
+		make_patch(c);
 
-	make_patch(c);
+		return 0;
+	}
 
-	return 0;
+	if (reset_commit) {
+		unsigned char sha1[20];
+
+		if (argc != 2)
+			usage_with_options(git_sequencer_helper_usage,
+					   options);
+
+		if (get_sha1(reset_commit, sha1)) {
+			error("Could not find '%s'", reset_commit);
+			return 1;
+		}
+
+		reflog = (char *)argv[0];
+
+		if (parse_verbosity(argv[1])) {
+			error("bad verbosity '%s'", argv[1]);
+			return 1;
+		}
+
+		return reset_almost_hard(sha1);
+	}
+
+	usage_with_options(git_sequencer_helper_usage, options);
 }
-- 
1.6.4.133.g8a5c8
