From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/4] reset: use "unpack_trees()" directly instead of "git
	read-tree"
Date: Wed, 16 Sep 2009 06:14:40 +0200
Message-ID: <20090916041443.3737.91512.chriscool@tuxfamily.org>
References: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnm0X-0007HV-FV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 06:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbZIPEUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 00:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZIPEUc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 00:20:32 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:54689 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbZIPEU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 00:20:29 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 019118180F5;
	Wed, 16 Sep 2009 06:20:23 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E56168180D5;
	Wed, 16 Sep 2009 06:20:20 +0200 (CEST)
X-git-sha1: dd0f005757b34b162dc85bd6b780728850ba00ec 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090916035131.3737.33020.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128605>

From: Stephan Beyer <s-beyer@gmx.net>

This patch makes "reset_index_file()" call "unpack_trees()" directly
instead of forking and execing "git read-tree". So the code is more
efficient.

And it's also easier to see which unpack_tree() options will be used,
as we don't need to follow "git read-tree"'s command line parsing
which is quite complex.

As Daniel Barkalow found, there is a difference between this new
version and the old one. The old version gives an error for
"git reset --merge" with unmerged entries and the new version does
not. But this can be seen as a bug fix, because "--merge" was the
only "git reset" option with this behavior and this behavior was
not documented.

The code comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |   51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..ddb81f3 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,6 +18,8 @@
 #include "tree.h"
 #include "branch.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
+#include "cache-tree.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
@@ -52,29 +54,56 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
+static int parse_and_init_tree_desc(const unsigned char *sha1,
+					     struct tree_desc *desc)
+{
+	struct tree *tree = parse_tree_indirect(sha1);
+	if (!tree)
+		return 1;
+	init_tree_desc(desc, tree->buffer, tree->size);
+	return 0;
+}
+
 static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
 {
-	int i = 0;
-	const char *args[6];
+	int nr = 1;
+	int newfd;
+	struct tree_desc desc[2];
+	struct unpack_trees_options opts;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
-	args[i++] = "read-tree";
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.fn = oneway_merge;
+	opts.merge = 1;
 	if (!quiet)
-		args[i++] = "-v";
+		opts.verbose_update = 1;
 	switch (reset_type) {
 	case MERGE:
-		args[i++] = "-u";
-		args[i++] = "-m";
+		opts.update = 1;
 		break;
 	case HARD:
-		args[i++] = "-u";
+		opts.update = 1;
 		/* fallthrough */
 	default:
-		args[i++] = "--reset";
+		opts.reset = 1;
 	}
-	args[i++] = sha1_to_hex(sha1);
-	args[i] = NULL;
 
-	return run_command_v_opt(args, RUN_GIT_CMD);
+	newfd = hold_locked_index(lock, 1);
+
+	read_cache_unmerged();
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
 }
 
 static void print_new_head_line(struct commit *commit)
-- 
1.6.5.rc0.150.g38fe6
