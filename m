From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 02/15] sequencer: add "make_patch" function to save a patch
Date: Fri, 28 Aug 2009 06:47:32 +0200
Message-ID: <20090828044746.4307.75314.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 06:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtYY-00060R-0x
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 06:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZH1E7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZH1E7J
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49708 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZH1E7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 50B9A8180D1;
	Fri, 28 Aug 2009 06:59:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0E47F818093;
	Fri, 28 Aug 2009 06:58:59 +0200 (CEST)
X-git-sha1: f5794567b3de4de1a1433e49030e4291c19cde7b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127253>

From: Stephan Beyer <s-beyer@gmx.net>

This function generates an informational patch file. The file name
is fixed to "$SEQ_DIR/patch".

The "make_patch" and the "get_commit" functions are copied from the
GSoC sequencer project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-sequencer--helper.c |   79 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 721c0d8..1dda525 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -1,15 +1,87 @@
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "run-command.h"
+
+#define SEQ_DIR "rebase-merge"
+
+#define PATCH_FILE	git_path(SEQ_DIR "/patch")
 
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
 	NULL
 };
 
+/* Generate purely informational patch file */
+static void make_patch(struct commit *commit)
+{
+	struct commit_list *parents = commit->parents;
+	const char **args;
+	struct child_process chld;
+	int i;
+	int fd = open(PATCH_FILE, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0)
+		return;
+
+	memset(&chld, 0, sizeof(chld));
+	if (!parents) {
+		write(fd, "Root commit\n", 12);
+		close(fd);
+		return;
+	} else if (!parents->next) {
+		args = xcalloc(5, sizeof(char *));
+		args[0] = "diff-tree";
+		args[1] = "-p";
+		args[2] = xstrdup(sha1_to_hex(parents->item->object.sha1));
+		args[3] = xstrdup(sha1_to_hex(((struct object *)commit)->sha1));
+	} else {
+		int count = 1;
+
+		for (; parents; parents = parents->next)
+			++count;
+
+		i = 0;
+		args = xcalloc(count + 3, sizeof(char *));
+		args[i++] = "diff";
+		args[i++] = "--cc";
+		args[i++] = xstrdup(sha1_to_hex(commit->object.sha1));
+
+		for (parents = commit->parents; parents;
+		     parents = parents->next) {
+			char *hex = sha1_to_hex(parents->item->object.sha1);
+			args[i++] = xstrdup(hex);
+		}
+	}
+
+	chld.argv = args;
+	chld.git_cmd = 1;
+	chld.out = fd;
+
+	/* Run, ignore errors. */
+	if (!start_command(&chld))
+		finish_command(&chld);
+
+	for (i = 2; args[i]; i++)
+		free((char *)args[i]);
+	free(args);
+}
+
+/* Return a commit object of "arg" */
+static struct commit *get_commit(const char *arg)
+{
+	unsigned char sha1[20];
+
+	if (get_sha1(arg, sha1)) {
+		error("Could not find '%s'", arg);
+		return NULL;
+	}
+	return lookup_commit_reference(sha1);
+}
+
 int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 {
 	char *commit = NULL;
+	struct commit *c;
 	struct option options[] = {
 		OPT_STRING(0, "make-patch", &commit, "commit",
 			   "create a patch from commit"),
@@ -22,6 +94,11 @@ int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 	if (!commit)
 		usage_with_options(git_sequencer_helper_usage, options);
 
-	/* Nothing to do yet */
+	c = get_commit(commit);
+	if (!c)
+		return 1;
+
+	make_patch(c);
+
 	return 0;
 }
-- 
1.6.4.271.ge010d
