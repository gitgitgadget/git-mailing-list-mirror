From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-commit: fix "git add x y && git commit y" committing
 x, too
Date: Thu, 15 Nov 2007 16:11:42 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711151611090.30886@racer.site>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
 <1195138198-24511-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshKb-0007Lk-2U
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759105AbXKOQMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759035AbXKOQMN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:12:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:52716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758722AbXKOQML (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:12:11 -0500
Received: (qmail invoked by alias); 15 Nov 2007 16:12:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 15 Nov 2007 17:12:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XA1EaTJjXgzBYOn0qtKRPldhsdERLSshzJ3yQ0q
	7OkHVLlcI6PBND
X-X-Sender: gene099@racer.site
In-Reply-To: <1195138198-24511-1-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65133>


Earlier, builtin commit would implicitly commit also the staged
changes.

This patch fixes that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	The function reset_index_to_head() could be moved to somewhere
	more central and be reused in builtin-reset.c instead of
	reset_index_file() later...

 builtin-add.c     |    1 +
 builtin-commit.c  |   30 +++++++++++++++++++++++++++++-
 t/t7500-commit.sh |   10 ++++++++++
 3 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 77dcde6..017c8f2 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -100,6 +100,7 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_ADDED:
 			add_file_to_cache(path, verbose);
 			break;
 		case DIFF_STATUS_DELETED:
diff --git a/builtin-commit.c b/builtin-commit.c
index 535039c..0dc6e1c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -19,6 +19,7 @@
 #include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "unpack-trees.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git-commit [options] [--] <filepattern>...",
@@ -77,6 +78,31 @@ static struct option builtin_commit_options[] = {
 	OPT_END()
 };
 
+static int reset_index_to_head(void)
+{
+	struct unpack_trees_options opts;
+	struct tree_desc tree_desc;
+	struct tree *tree;
+	unsigned char sha1[20];
+
+	/* ignore if it is an initial commit */
+	if (get_sha1("HEAD", sha1))
+		return 0;
+	tree = parse_tree_indirect(sha1);
+	if (!tree || parse_tree(tree))
+		return error("Could not get HEAD's tree");
+	init_tree_desc(&tree_desc, tree->buffer, tree->size);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.index_only = 1;
+	opts.merge = 1;
+	opts.head_idx = 1;
+	opts.fn = oneway_merge;
+	if (unpack_trees(1, &tree_desc, &opts))
+		return error("Could not reset temporary index to HEAD");
+	return 0;
+}
+
 static char *prepare_index(const char **files, const char *prefix)
 {
 	int fd;
@@ -120,12 +146,14 @@ static char *prepare_index(const char **files, const char *prefix)
 			die("failed to read HEAD tree object");
 	}
 
+	if (reset_index_to_head())
+		die ("failed to reset temporary index to HEAD");
+
 	/* Use a lock file to garbage collect the temporary index file. */
 	next_index_lock = xmalloc(sizeof(*next_index_lock));
 	fd = hold_lock_file_for_update(next_index_lock,
 				       git_path("next-index-%d", getpid()), 1);
 	add_files_to_cache(verbose, prefix, files);
-	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write new_index file");
 
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index c9d65e5..d4d7ed7 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -139,4 +139,14 @@ test_expect_success '--signoff' '
 	diff expect output
 '
 
+test_expect_success 'implicit --only only commits specified files' '
+	echo "tonight: " > take &&
+	echo "over the" > world &&
+	git add world take &&
+	test_tick &&
+	git commit -m partial world &&
+	git diff-tree HEAD^..HEAD -- take &&
+	! git diff-index --cached --exit-code HEAD -- take
+'
+
 test_done
-- 
1.5.3.5.1786.gdaaa
