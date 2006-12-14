X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-show: grok blobs, trees and tags, too
Date: Thu, 14 Dec 2006 11:31:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:31:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34302>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gunrr-0006SQ-SU for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751851AbWLNKbI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWLNKbI
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:31:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:46307 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751851AbWLNKbH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:31:07 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:31:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 14 Dec 2006 11:31:05 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


Since git-show is pure Porcelain, it is the ideal candidate to
pretty print other things than commits, too.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/git-show.txt |   40 ++++++++++++++++++---
 builtin-log.c              |   82 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 4c880a8..1d9d781 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -3,20 +3,27 @@ git-show(1)
 
 NAME
 ----
-git-show - Show one commit with difference it introduces
+git-show - Show blobs, trees, tags and commits with difference they introduce
 
 
 SYNOPSIS
 --------
-'git-show' <option>...
+'git-show' [options] <object>...
 
 DESCRIPTION
 -----------
-Shows commit log and textual diff for a single commit.  The
-command internally invokes 'git-rev-list' piped to
-'git-diff-tree', and takes command line options for both of
-these commands. It also presents the merge commit in a special
-format as produced by 'git-diff-tree --cc'.
+Shows one or more objects.
+
+For commits it shows the log message and textual diff. It also
+presents the merge commit in a special format as produced by
+'git-diff-tree --cc'.
+
+For tags, it shows the tag message and the referenced objects.
+
+For trees, it shows the names (equivalent to gitlink:git-ls-tree[1]
+with \--name-only).
+
+For plain blobs, it shows the plain contents.
 
 This manual page describes only the most frequently used options.
 
@@ -28,6 +35,25 @@ OPTIONS
 
 include::pretty-formats.txt[]
 
+
+EXAMPLES
+--------
+
+git show v1.0.0::
+	Shows the tag `v1.0.0`.
+
+git show v1.0.0^{tree}::
+	Shows the tree pointed to by the tag `v1.0.0`.
+
+git show next~10:Documentation/README
+	Shows the contents of the file `Documentation/README` as
+	they were current in the 10th last commit of the branch
+	`next`.
+
+git show master:Makefile master:t/Makefile
+	Concatenates the contents of said Makefiles in the head
+	of the branch `master`.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org> and
diff --git a/builtin-log.c b/builtin-log.c
index 6821a08..17014f7 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "tag.h"
 #include <time.h>
 #include <sys/time.h>
 
@@ -71,9 +72,43 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	return cmd_log_walk(&rev);
 }
 
+static int show_object(const unsigned char *sha1, int suppress_header)
+{
+	unsigned long size;
+	char type[20];
+	char *buf = read_sha1_file(sha1, type, &size);
+	int offset = 0;
+
+	if (!buf)
+		return error("Could not read object %s", sha1_to_hex(sha1));
+
+	if (suppress_header)
+		while (offset < size && buf[offset++] != '\n') {
+			int new_offset = offset;
+			while (new_offset < size && buf[new_offset++] != '\n')
+				; /* do nothing */
+			offset = new_offset;
+		}
+
+	if (offset < size)
+		fwrite(buf + offset, size - offset, 1, stdout);
+	free(buf);
+	return 0;
+}
+
+static int show_tree_object(const unsigned char *sha1,
+		const char *base, int baselen,
+		const char *pathname, unsigned mode, int stage)
+{
+	printf("%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
+	return 0;
+}
+
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
+	struct object_array_entry *objects;
+	int i, count, ret = 0;
 
 	git_config(git_log_config);
 	init_revisions(&rev, prefix);
@@ -85,7 +120,52 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
 	cmd_log_init(argc, argv, prefix, &rev);
-	return cmd_log_walk(&rev);
+
+	count = rev.pending.nr;
+	objects = rev.pending.objects;
+	for (i = 0; i < count && !ret; i++) {
+		struct object *o = objects[i].item;
+		const char *name = objects[i].name;
+		switch (o->type) {
+		case OBJ_BLOB:
+			ret = show_object(o->sha1, 0);
+			break;
+		case OBJ_TAG: {
+			struct tag *t = (struct tag *)o;
+
+			printf("%stag %s%s\n\n",
+					diff_get_color(rev.diffopt.color_diff,
+						DIFF_COMMIT),
+					t->tag,
+					diff_get_color(rev.diffopt.color_diff,
+						DIFF_RESET));
+			ret = show_object(o->sha1, 1);
+			objects[i].item = (struct object *)t->tagged;
+			i--;
+			break;
+		}
+		case OBJ_TREE:
+			printf("%stree %s%s\n\n",
+					diff_get_color(rev.diffopt.color_diff,
+						DIFF_COMMIT),
+					name,
+					diff_get_color(rev.diffopt.color_diff,
+						DIFF_RESET));
+			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
+					show_tree_object);
+			break;
+		case OBJ_COMMIT:
+			rev.pending.nr = rev.pending.alloc = 0;
+			rev.pending.objects = NULL;
+			add_object_array(o, name, &rev.pending);
+			ret = cmd_log_walk(&rev);
+			break;
+		default:
+			ret = error("Unknown type: %d", o->type);
+		}
+	}
+	free(objects);
+	return ret;
 }
 
