From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/15] sequencer: add "reset_almost_hard()" and related
	functions
Date: Fri, 28 Aug 2009 06:47:34 +0200
Message-ID: <20090828044746.4307.88742.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZf-0006Ec-IC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbZH1E7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZH1E7K
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:10 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49723 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbZH1E7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C239D8180D6;
	Fri, 28 Aug 2009 06:59:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B7FD18180B5;
	Fri, 28 Aug 2009 06:58:59 +0200 (CEST)
X-git-sha1: 03bee5eb73301c3b8aa0e7c9d0bd8d5e55644086 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127255>

From: Stephan Beyer <s-beyer@gmx.net>

This patch adds the "reset_almost_hard()" function, some related
static variables and the related following functions:

	- parse_and_init_tree_desc()
	- reset_index_file()
	- set_verbosity()

"reset_almost_hard()" can be used to do a "git reset --hard". It
should be faster as it calls "unpack_trees()" directly, and it can
optionnaly preserve changes in the work tree if the "allow_dirty"
global is set. Preserving changes in the work tree can be usefull
if for example you want to get rid of the last commit but keep
your current not yet commited work.

In this patch the "allow_dirty" global is not used but a following
patch will make it possible to set it, and in the end the code
should be simpler with a global.

The code comes as is from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-sequencer--helper.c |  107 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/builtin-sequencer--helper.c b/builtin-sequencer--helper.c
index 1dda525..a15139c 100644
--- a/builtin-sequencer--helper.c
+++ b/builtin-sequencer--helper.c
@@ -2,16 +2,108 @@
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
+ * If allow_dirty is set and there is a dirty work tree,
+ * then the changes in the work tree are to be kept.
+ *
+ * This should be faster than calling "git reset --hard" because
+ * this calls "unpack_trees()" directly (instead of forking and
+ * execing "git read-tree").
+ *
+ * Unmerged entries in the index will be discarded.
+ *
+ * If allow_dirty is set and fast forwarding the work tree
+ * fails because it is dirty, then the work tree will not be
+ * updated.
+ *
+ * No need to read or discard the index before calling this
+ * function.
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
@@ -78,6 +170,21 @@ static struct commit *get_commit(const char *arg)
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
1.6.4.271.ge010d
