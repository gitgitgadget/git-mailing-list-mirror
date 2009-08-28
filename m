From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 05/15] sequencer: add "--reset-hard" option to "git
	sequencer--helper"
Date: Fri, 28 Aug 2009 06:47:35 +0200
Message-ID: <20090828044746.4307.86010.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZh-0006Ec-1o
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbZH1E7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbZH1E7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:16 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49762 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbZH1E7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:13 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5F9CD8180E5;
	Fri, 28 Aug 2009 06:59:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1F51E8180BC;
	Fri, 28 Aug 2009 06:59:00 +0200 (CEST)
X-git-sha1: 712e378980ffa747179ba9ffe5d2334c65ee867c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127257>

This new option uses the "reset_almost_hard()" function to perform
a reset.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-sequencer--helper.c |   65 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index a15139c..be030bc 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -18,6 +18,7 @@ static unsigned char head_sha1[20];
 
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
+	"git sequencer--helper --reset-hard <commit> <reflog-msg> <verbosity>",
 	NULL
 };
 
@@ -185,27 +186,71 @@ static int set_verbosity(int verbose)
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
1.6.4.271.ge010d
