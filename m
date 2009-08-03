From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] sequencer: add "reset_almost_hard()" and related functions
Date: Mon, 03 Aug 2009 04:40:20 +0200
Message-ID: <20090803024023.3794.90748.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 06:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXpOl-0004to-AD
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 06:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbZHCEnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 00:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZHCEne
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 00:43:34 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36783 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311AbZHCEnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 00:43:32 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B368681804E;
	Mon,  3 Aug 2009 06:43:23 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 553F9818057;
	Mon,  3 Aug 2009 06:43:20 +0200 (CEST)
X-git-sha1: 7a2dabec8cbf25f4c01b1248dc9be383e1decc19 
X-Mailer: git-mail-commits v0.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124685>

From: Stephan Beyer <s-beyer@gmx.net>

This patch adds some code that comes as is from the sequencer GSoC
project:

git://repo.or.cz/git/sbeyer.git

(commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)

It adds some static variables and the following functions:

	- parse_and_init_tree_desc()
	- reset_index_file()
	- reset_almost_hard()
	- set_verbosity()

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-sequencer--helper.c |   94 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 1dda525..82a830d 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -2,16 +2,95 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "refs.h"
+#include "diff.h"
+#include "unpack-trees.h"
 
 #define SEQ_DIR "rebase-merge"
 
 #define PATCH_FILE	git_path(SEQ_DIR "/patch")
 
+static char *reflog;
+
+static int allow_dirty = 0, verbosity = 1, advice = 1;
+
+static unsigned char head_sha1[20];
+
 static const char * const git_sequencer_helper_usage[] = {
 	"git sequencer--helper --make-patch <commit>",
 	NULL
 };
 
+static int parse_and_init_tree_desc(const unsigned char *sha1,
+				    struct tree_desc *desc)
+{
+	struct tree *tree = parse_tree_indirect(sha1);
+	if (!tree)
+		return 1;
+	init_tree_desc(desc, tree->buffer, tree->size);
+	return 0;
+}
+
+static int reset_index_file(const unsigned char *sha1, int update, int dirty)
+{
+	int nr = 1;
+	int newfd;
+	struct tree_desc desc[2];
+	struct unpack_trees_options opts;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.reset = 1; /* ignore unmerged entries and overwrite wt files */
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	if (verbosity > 2)
+		opts.verbose_update = 1;
+	if (update) /* update working tree */
+		opts.update = 1;
+
+	newfd = hold_locked_index(lock, 1);
+
+	read_cache_unmerged();
+
+	if (dirty) {
+		if (get_sha1("HEAD", head_sha1))
+			return error("You do not have a valid HEAD.");
+		if (parse_and_init_tree_desc(head_sha1, desc))
+			return error("Failed to find tree of HEAD.");
+		nr++;
+		opts.fn = twoway_merge;
+	}
+
+	if (parse_and_init_tree_desc(sha1, desc + nr - 1))
+		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
+	if (unpack_trees(nr, desc, &opts))
+		return -1;
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock))
+		return error("Could not write new index file.");
+
+	return 0;
+}
+
+/*
+ * Realize reset --hard behavior.
+ * If allow_dirty is set and there is a dirty working tree,
+ * then the changes are to be kept.
+ */
+static int reset_almost_hard(const unsigned char *sha)
+{
+	int err = allow_dirty ?
+		(reset_index_file(sha, 1, 1) || reset_index_file(sha, 0, 0)) :
+		reset_index_file(sha, 1, 0);
+	if (err)
+		return error("Could not reset index.");
+
+	return update_ref(reflog, "HEAD", sha, NULL, 0, MSG_ON_ERR);
+}
+
 /* Generate purely informational patch file */
 static void make_patch(struct commit *commit)
 {
@@ -78,6 +157,21 @@ static struct commit *get_commit(const char *arg)
 	return lookup_commit_reference(sha1);
 }
 
+static int set_verbosity(int verbose)
+{
+	char tmp[] = "0";
+	verbosity = verbose;
+	if (verbosity <= 0) {
+		verbosity = 0;
+		advice = 0;
+	} else if (verbosity > 5)
+		verbosity = 5;
+	/* Git does not run on EBCDIC, so we rely on ASCII: */
+	tmp[0] += verbosity;
+	setenv("GIT_MERGE_VERBOSITY", tmp, 1);
+	return 0;
+}
+
 int cmd_sequencer__helper(int argc, const char **argv, const char *prefix)
 {
 	char *commit = NULL;
-- 
1.6.4.133.g8a5c8
