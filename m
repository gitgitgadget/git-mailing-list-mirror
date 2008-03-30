From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH] Add new git-graph command
Date: Sun, 30 Mar 2008 12:58:41 -0700
Message-ID: <20080330195840.GA8695@adamsimpkins.net>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 22:26:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg46G-0002Ma-MG
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 22:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYC3UZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 16:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYC3UZN
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 16:25:13 -0400
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:47713 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbYC3UZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 16:25:10 -0400
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Mar 2008 16:25:10 EDT
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id F245A44C016
	for <git@vger.kernel.org>; Sun, 30 Mar 2008 15:58:44 -0400 (EDT)
Received: by relay1.r1.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 45E5644C002
	for <git@vger.kernel.org>; Sun, 30 Mar 2008 15:58:44 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id E2A0E14100B8; Sun, 30 Mar 2008 12:58:41 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78511>

This is a first pass at a command to print a text-based graph of the commit
history.  It is similar to the history graph shown by gitk, but doesn't
require a windowing system.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---

I added this since I really like gitk, but don't always have easy
access to an X display on some of the systems I use.  I tried using
tig, but I found its graph output very hard to read.  The graph
produced by git-graph is less compact, but much more readable.

Ultimately, it would probably be better to integrate this
functionality into git-log, instead of having it as a standalone
command.  For example, a new --graph option could be added to cause
the graph to be displayed alongside the existing git log output.
However, this would require tighter integration between the graphing
code and the log_tree.c and pretty.c code, which I'm not all that
familiar with.


 .gitignore                         |    1 +
 Documentation/git-graph.txt        |   56 ++++
 Documentation/pretty-formats.txt   |    4 +
 Documentation/rev-list-options.txt |   15 +
 Makefile                           |    1 +
 builtin-graph.c                    |  553 ++++++++++++++++++++++++++++++++++++
 builtin.h                          |    1 +
 git.c                              |    1 +
 8 files changed, 632 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-graph.txt
 create mode 100644 builtin-graph.c

diff --git a/.gitignore b/.gitignore
index 4ff2fec..b9b4c76 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@ git-fsck
 git-fsck-objects
 git-gc
 git-get-tar-commit-id
+git-graph
 git-grep
 git-hash-object
 git-http-fetch
diff --git a/Documentation/git-graph.txt b/Documentation/git-graph.txt
new file mode 100644
index 0000000..022cb09
--- /dev/null
+++ b/Documentation/git-graph.txt
@@ -0,0 +1,56 @@
+git-graph(1)
+============
+
+NAME
+----
+git-graph - Show a graph of commit history
+
+
+SYNOPSIS
+--------
+'git-graph' <option>...
+
+DESCRIPTION
+-----------
+Shows a text-based representation of the commit history graph.
+
+The command takes options applicable to the linkgit:git-rev-list[1]
+command to control what is shown and how.
+
+
+OPTIONS
+-------
+
+-<n>::
+	Limits the number of commits to show.
+
+<since>..<until>::
+	Show only commits between the named two commits.  When
+	either <since> or <until> is omitted, it defaults to
+	`HEAD`, i.e. the tip of the current branch.
+	For a more complete list of ways to spell <since>
+	and <until>, see "SPECIFYING REVISIONS" section in
+	linkgit:git-rev-parse[1].
+
+:git-graph: 1
+include::rev-list-options.txt[]
+
+include::pretty-formats.txt[]
+
+
+See Also
+--------
+linkgit:gitk[1]
+
+Author
+------
+Written by Adam Simpkins <adam@adamsimpkins.net>,
+and the git list <git@vger.kernel.org>
+
+Documentation
+--------------
+Documentation by Adam Simpkins and the git list.
+
+GIT
+---
+Part of the linkgit:git[7] suite
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0193c3c..da76c97 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -1,6 +1,7 @@
 PRETTY FORMATS
 --------------
 
+ifndef::git-graph[]
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
@@ -10,6 +11,7 @@ necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
 only interested in changes related to a certain directory or
 file.
+endif::git-graph[]
 
 Here are some additional details for each format:
 
@@ -19,6 +21,7 @@ Here are some additional details for each format:
 +
 This is designed to be as compact as possible.
 
+ifndef::git-graph[]
 * 'short'
 
 	  commit <sha1>
@@ -75,6 +78,7 @@ displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts nor history
 simplification into account.
+endif::git-graph[]
 
 * 'format:'
 +
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2648a55..b461478 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -9,6 +9,7 @@ endif::git-rev-list[]
 
 include::pretty-options.txt[]
 
+ifndef::git-graph[]
 --relative-date::
 
 	Synonym for `--date=relative`.
@@ -37,11 +38,13 @@ format, often found in E-mail messages.
 
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
+endif::git-graph[]
 
 --parents::
 
 	Print the parents of the commit.
 
+ifndef::git-graph[]
 --timestamp::
 	Print the raw commit timestamp.
 
@@ -104,6 +107,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
 -t::
 
 	Show the tree objects in the diff output. This implies '-r'.
+endif::git-graph[]
 
 Commit Limiting
 ~~~~~~~~~~~~~~~
@@ -136,6 +140,7 @@ ifdef::git-rev-list[]
 	Limit the commits output to specified time range.
 endif::git-rev-list[]
 
+ifndef::git-graph[]
 --author='pattern', --committer='pattern'::
 
 	Limit the commits output to ones with author/committer
@@ -184,6 +189,7 @@ endif::git-rev-list[]
 	adjusting to updated upstream from time to time, and
 	this option allows you to ignore the individual commits
 	brought in to your history by such a merge.
+endif::git-graph[]
 
 --not::
 
@@ -195,6 +201,7 @@ endif::git-rev-list[]
 	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
 	command line as '<commit>'.
 
+ifndef::git-graph[]
 --stdin::
 
 	In addition to the '<commit>' listed on the command
@@ -260,6 +267,7 @@ merges that do not touch the given paths.
 Use the '--sparse' flag to makes the command output all eligible commits
 (still subject to count and age limitation), but apply merge
 simplification nevertheless.
+endif::git-graph[]
 
 ifdef::git-rev-list[]
 --bisect::
@@ -316,7 +324,12 @@ endif::git-rev-list[]
 Commit Ordering
 ~~~~~~~~~~~~~~~
 
+ifndef::git-graph[]
 By default, the commits are shown in reverse chronological order.
+endif::git-graph[]
+ifdef::git-graph[]
+By default, the commits are shown in topological order.
+endif::git-graph[]
 
 --topo-order::
 
@@ -329,6 +342,7 @@ By default, the commits are shown in reverse chronological order.
 	parent comes before all of its children, but otherwise things
 	are still ordered in the commit timestamp order.
 
+ifndef::git-graph[]
 --reverse::
 
 	Output the commits in reverse order.
@@ -366,3 +380,4 @@ These options are mostly targeted for packing of git repositories.
 --do-walk::
 
 	Overrides a previous --no-walk.
+endif::git-graph[]
diff --git a/Makefile b/Makefile
index 7c70b00..da4ce9d 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,7 @@ BUILTIN_OBJS += builtin-fmt-merge-msg.o
 BUILTIN_OBJS += builtin-for-each-ref.o
 BUILTIN_OBJS += builtin-fsck.o
 BUILTIN_OBJS += builtin-gc.o
+BUILTIN_OBJS += builtin-graph.o
 BUILTIN_OBJS += builtin-grep.o
 BUILTIN_OBJS += builtin-init-db.o
 BUILTIN_OBJS += builtin-log.o
diff --git a/builtin-graph.c b/builtin-graph.c
new file mode 100644
index 0000000..1b8be2c
--- /dev/null
+++ b/builtin-graph.c
@@ -0,0 +1,553 @@
+/*
+ * Builtin "git graph"
+ */
+#include "cache.h"
+#include "color.h"
+#include "commit.h"
+#include "diff.h"
+#include "log-tree.h"
+#include "revision.h"
+
+/*
+ * TODO:
+ * - Add colors to the graph.
+ *   Pick a color for each column, and print all characters
+ *   in that column with the specified color.
+ *
+ * - Limit the number of columns, similar to the way gitk does.
+ *   If we reach more than a specified number of columns, omit
+ *   sections of some columns.
+ *
+ * - Get rid of some unnecessary memory allocations.
+ *   graph_commit() allocates new_columns, mapping, and new_mapping each
+ *   time it is called.  These could be stored in the struct graph, and
+ *   re-used each time.  They only need to be re-allocated if the number
+ *   of columns grows too big.  (If we place a limit on the max number of
+ *   columns to be displayed, we may never need to reallocate them.)
+ *
+ * - It would be nice to support other --pretty formats.
+ *   Currently things don't work well if print_commit_info() prints
+ *   multiple lines.  However, we could make it always prefix the output
+ *   with the right characters.  It wouldn't be too hard to prefix it with
+ *   the correct branch lines, using "|" characters (we could hijack
+ *   opts->diffopt.line_termination).  It would be nicer if we could get it
+ *   to work so that the extra info was printed along side the
+ *   "branch collapsing" phase.
+ *
+ * - Perhaps this entire command could just be merged into git-log.
+ *   It would certainly be nicer if git-log just had a --graph option that
+ *   caused the output to be prefixed by the graph.  This would require
+ *   the graphing code be integrated with the log-tree.c and pretty.c code.
+ */
+
+struct column {
+	/*
+	 * The parent commit of this column.
+	 */
+	struct commit *commit;
+	/*
+	 * XXX: Once we add support for colors, struct column could also
+	 * contain the color of its branch line.
+	 */
+};
+
+struct graph {
+	int num_columns;
+	struct column *columns;
+};
+
+static void update_columns(struct commit *commit,
+			  struct column *columns,
+			  int *num_columns,
+			  int *mapping,
+			  int mapping_index)
+{
+	int i;
+
+	/*
+	 * If the commit is already in the columns list, we don't need to
+	 * add it.  Just update the mapping correctly.
+	 */
+	for (i = 0; i < *num_columns; ++i) {
+		if (columns[i].commit == commit) {
+			mapping[mapping_index] = i;
+			return;
+		}
+	}
+
+	/*
+	 * This commit isn't already in columns.  Add it.
+	 */
+	columns[*num_columns].commit = commit;
+	mapping[mapping_index] = *num_columns;
+	++*num_columns;
+}
+
+static int is_mapping_correct(int const *mapping, int mapping_size)
+{
+	int i;
+
+	/*
+	 * The mapping is up to date if each entry is at its target,
+	 * or is 1 greater than its target.
+	 * (If it is 1 greater than the target, '/' will be printed, so it
+	 * will look correct on the next row.)
+	 */
+	for (i = 0; i < mapping_size; ++i) {
+		int target = mapping[i];
+		if (target < 0)
+			continue;
+		if (target == (i / 2))
+			continue;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void draw_pre_commit_rows(struct rev_info *opts,
+				 struct commit *commit,
+				 struct graph *graph,
+				 int num_parents)
+{
+    int num_expansion_rows;
+    int i, j, seen_this;
+
+    /*
+     * If there are less than 3 parents, we don't need to do anything.
+     * We can immediately draw the commit line.
+     */
+    if (num_parents < 3)
+	return;
+
+    /*
+     * This commit has more than 2 parents, so we need to expand the
+     * branch lines around it to allow more room for it.
+     *
+     * We need 2 extra rows for every parent over 2
+     */
+    num_expansion_rows = (num_parents - 2) * 2;
+    for (i = 0; i < num_expansion_rows; ++i) {
+	seen_this = 0;
+	for (j = 0; j < graph->num_columns; ++j) {
+	    struct column *col = &graph->columns[j];
+	    if (col->commit == commit) {
+		seen_this = 1;
+		printf("| %*s", i, "");
+	    } else if (seen_this) {
+		printf("\\ ");
+	    } else {
+		printf("| ");
+	    }
+	}
+	printf("\n");
+    }
+}
+
+static void print_commit_info(struct rev_info *opts, struct commit *commit)
+{
+	log_tree_commit(opts, commit);
+
+	/*
+	 * log_tree_commit doesn't quite do what we want with respect to
+	 * newlines.  Unless CMIT_FMT_ONELINE is being used, it wants to
+	 * print the newline just before each log message, instead of after
+	 * it.  Manually print the line terminator, and stop
+	 * log_tree_commit() from printing one the next time it is called.
+	 */
+	if (opts->commit_format != CMIT_FMT_ONELINE)
+	{
+		putchar(opts->diffopt.line_termination);
+		opts->shown_one = 0;
+	}
+}
+
+static void draw_commit_row(struct rev_info *opts,
+			    struct commit *commit,
+			    struct graph *graph,
+			    int num_parents)
+{
+    int seen_this = 0;
+    int i, j;
+
+    /*
+     * Print the row containing this commit
+     */
+    seen_this = 0;
+    for (i = 0; i <= graph->num_columns; ++i) {
+	struct commit *col_commit;
+	if (i == graph->num_columns) {
+	    if (seen_this)
+		break;
+	    col_commit = commit;
+	} else {
+	    col_commit = graph->columns[i].commit;
+	}
+
+	if (col_commit == commit) {
+	    seen_this = 1;
+	    if (num_parents > 1)
+		putchar('M');
+	    else
+		putchar('*');
+
+	    if (num_parents < 2)
+		putchar(' ');
+	    else if (num_parents == 2)
+		printf("  ");
+	    else {
+		int num_dashes = ((num_parents - 2) * 2) - 1;
+		for (j = 0; j < num_dashes; ++j)
+		    putchar('-');
+		putchar('.');
+		putchar(' ');
+	    }
+	} else if (seen_this && (num_parents > 1)) {
+	    printf("\\ ");
+	} else {
+	    printf("| ");
+	}
+    }
+
+    /*
+     * Print the commit description.
+     * This will include a newline.
+     */
+    print_commit_info(opts, commit);
+}
+
+static void draw_post_commit_row(struct rev_info *opts,
+				 struct commit *commit,
+				 struct graph *graph,
+				 int num_parents)
+{
+    int seen_this = 0;
+    int i, j;
+
+    /*
+     * Unless this is a merge commit, we don't have anything to do
+     */
+    if (num_parents < 2)
+	return;
+
+    /*
+     * For merge commits, we need 1 additional row after the commit
+     * row to straighten out the branch lines
+     */
+    for (i = 0; i <= graph->num_columns; ++i) {
+	struct commit *col_commit;
+	if (i == graph->num_columns) {
+	    if (seen_this)
+		break;
+	    col_commit = commit;
+	} else {
+	    col_commit = graph->columns[i].commit;
+	}
+
+	if (col_commit == commit) {
+	    seen_this = 1;
+	    putchar('|');
+	    for (j = 0; j < num_parents - 1; ++j)
+		printf("\\ ");
+	    if (num_parents == 2)
+		putchar(' ');
+	} else if (seen_this && (num_parents > 2)) {
+	    printf("\\ ");
+	} else {
+	    printf("| ");
+	}
+    }
+    putchar('\n');
+}
+
+static void graph_commit(struct rev_info *opts, struct commit *commit,
+			  struct graph *graph)
+{
+	struct commit_list *parent;
+	int num_parents = 0;
+	int seen_this = 0;
+	int i;
+	int num_new_columns, max_new_columns;
+	struct column *new_columns;
+	int *mapping;
+	int *new_mapping;
+	int mapping_size, mapping_idx;
+
+	/*
+	 * Count how many parents this commit has
+	 */
+	for (parent = commit->parents; parent; parent = parent->next)
+		++num_parents;
+
+	draw_pre_commit_rows(opts, commit, graph, num_parents);
+	draw_commit_row(opts, commit, graph, num_parents);
+	draw_post_commit_row(opts, commit, graph, num_parents);
+
+	/*
+	 * Allocate room for the updated column info.
+	 * At most, there will be graph->num_columns + num_parents
+	 * columns for the next commit.
+	 *
+	 * XXX: We could avoid this allocation.  We really only need 2
+	 * column arrays, and we can swap between them each time
+	 * graph_commit() is called.
+	 */
+	max_new_columns = graph->num_columns + num_parents;
+	new_columns = xmalloc(sizeof(struct column) * max_new_columns);
+
+	mapping_size = max_new_columns * 2;
+	mapping = xmalloc(sizeof(int) * mapping_size);
+	new_mapping = xmalloc(sizeof(int) * mapping_size);
+	for (i = 0; i < mapping_size; ++i)
+		mapping[i] = -1;
+
+	/*
+	 * Some of the parents of this commit may already be in
+	 * graph->columns.  If so, we need to collapse them with the
+	 * existing branch lines.
+	 */
+	num_new_columns = 0;
+	seen_this = 0;
+	mapping_idx = 0;
+	for (i = 0; i <= graph->num_columns; ++i) {
+		struct commit *col_commit;
+		if (i == graph->num_columns) {
+			if (seen_this)
+				break;
+			col_commit = commit;
+		} else {
+			col_commit = graph->columns[i].commit;
+		}
+
+		if (col_commit == commit) {
+			seen_this = 1;
+			for (parent = commit->parents;
+			     parent;
+			     parent = parent->next) {
+				update_columns(parent->item, new_columns,
+					       &num_new_columns, mapping,
+					       mapping_idx);
+				mapping_idx += 2;
+			}
+		} else {
+			update_columns(col_commit, new_columns,
+				       &num_new_columns, mapping, mapping_idx);
+			mapping_idx += 2;
+		}
+	}
+
+	/*
+	 * Shrink mapping_size to be the minimum necessary
+	 */
+	while (mapping_size > 1 && mapping[mapping_size - 1] < 0)
+		--mapping_size;
+
+	/*
+	 * mapping now indicates a mapping between incoming branch lines
+	 * and which column they need to go to.
+	 *
+	 * Print lines to match the branch lines up to the correct column.
+	 */
+	while (!is_mapping_correct(mapping, mapping_size))
+	{
+		int *tmp_mapping;
+
+		for (i = 0; i < mapping_size; ++i)
+			new_mapping[i] = -1;
+
+		for (i = 0; i < mapping_size; ++i) {
+			int target = mapping[i];
+			if (target < 0)
+				continue;
+
+			/*
+			 * Since update_columns() always inserts the
+			 * leftmost column first, each branch's target
+			 * location should always be either its current
+			 * location or to the left of its current location.
+			 *
+			 * We never have to move branches to the right.
+			 * This makes the graph much more legible, since
+			 * whenever branches cross, only one is moving
+			 * directions.
+			 */
+			assert(target * 2 <= i);
+
+			if (target * 2 == i) {
+				/*
+				 * This column is already in the
+				 * correct place
+				 */
+				assert(new_mapping[i] == -1);
+				new_mapping[i] = target;
+			} else if (new_mapping[i - 1] < 0) {
+				/*
+				 * Nothing is to the left.
+				 * Move to the left by one
+				 */
+				new_mapping[i - 1] = target;
+			} else if (new_mapping[i - 1] == target) {
+				/*
+				 * There is a branch line to our left
+				 * already, and it is our target.  We
+				 * combine with this line, since we share
+				 * the same parent commit.
+				 *
+				 * We don't have to add anything to the
+				 * output or new_mapping, since the
+				 * existing branch line has already taken
+				 * care of it.
+				 */
+			} else {
+				/*
+				 * There is a branch line to our left,
+				 * but it isn't our target.  We need to
+				 * cross over it.
+				 *
+				 * The space just to the left of this
+				 * branch should always be empty.
+				 */
+				assert(new_mapping[i - 1] > target);
+				assert(new_mapping[i - 2] < 0);
+				new_mapping[i - 2] = target;
+			}
+		}
+
+		/*
+		 * The new mapping may be 1 smaller than the old mapping
+		 */
+		if (new_mapping[mapping_size - 1] < 0)
+			--mapping_size;
+
+		/*
+		 * Print out a line based on the new mapping info
+		 */
+		for (i = 0; i < mapping_size; ++i) {
+			int target = new_mapping[i];
+			if (target < 0)
+				putchar(' ');
+			else if (target * 2 == i)
+				putchar('|');
+			else
+				putchar('/');
+		}
+		putchar('\n');
+
+		/*
+		 * Swap mapping and new_mapping
+		 */
+		tmp_mapping = mapping;
+		mapping = new_mapping;
+		new_mapping = tmp_mapping;
+	}
+
+	/*
+	 * Update the graph with the new branch line info.
+	 */
+	graph->num_columns = num_new_columns;
+	free(graph->columns);
+	graph->columns = new_columns;
+
+	free(mapping);
+	free(new_mapping);
+}
+
+static int cmd_graph_walk(struct rev_info *opts)
+{
+	struct commit *commit;
+
+	struct graph graph;
+	graph.num_columns = 0;
+	graph.columns = NULL;
+
+	/*
+	 * XXX: Should we handle opts->early_output?
+	 */
+
+	if (prepare_revision_walk(opts))
+		die("revision walk setup failed");
+
+	/*
+	 * Walk through the commits.
+	 *
+	 * XXX: This only works if the commits form a contiguous group.
+	 * graph_commit() expects to see all commits in a particular chain.
+	 * If intervening commits are left out, it doesn't work
+	 * properly--it can't detect the parent-child relationships, and
+	 * incorrectly displays commits with missing children as the tip of
+	 * a new branch.  For example, this happens when you run
+	 * "git graph <path>".
+	 */
+	while ((commit = get_revision(opts)) != NULL) {
+		graph_commit(opts, commit, &graph);
+	}
+
+	return 0;
+}
+
+static void cmd_graph_init(int ac, const char **av, const char *prefix,
+			   struct rev_info *opts)
+{
+	int i;
+
+	git_config(git_diff_ui_config);
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
+	init_revisions(opts, prefix);
+
+	opts->always_show_header = 1;
+	opts->abbrev = DEFAULT_ABBREV;
+	opts->topo_order = 1;
+	opts->commit_format = CMIT_FMT_ONELINE;
+	opts->verbose_header = 1;
+
+	/*
+	 * XXX: We don't really want to allow all of the options
+	 * that setup_revisions() parses.  In particular, most of the
+	 * diff-related options don't apply to us.
+	 */
+	ac = setup_revisions(ac, av, opts, "HEAD");
+
+	/*
+	 * XXX: At the moment, we can't handle --reverse
+	 */
+	if (opts->reverse)
+		die("--reverse is unsupported");
+
+	/*
+	 * Only CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT make sense,
+	 * since the commit info needs to be on a single line.
+	 *
+	 * XXX: It would be nice to have access to cmt_fmts from pretty.c,
+	 * so we could print the name of the unsupported format.
+	 */
+	if (opts->commit_format != CMIT_FMT_ONELINE &&
+	    opts->commit_format != CMIT_FMT_USERFORMAT)
+		die("--pretty must be oneline or format");
+
+	/*
+	 * We don't handle first_parent_only yet.
+	 * (It isn't too hard to implement, but it doesn't seem terribly
+	 * useful.)
+	 */
+	if (opts->first_parent_only)
+	    die("--first-parent is not implemented for git-graph");
+
+	/*
+	 * Handle remaining arguments.
+	 * Eventually we may support other options here.
+	 */
+	for (i = 1; i < ac; i++) {
+		const char *arg = av[i];
+		die("unrecognized argument: %s", arg);
+	}
+}
+
+int cmd_graph(int ac, const char **av, const char *prefix)
+{
+	struct rev_info opts;
+
+	cmd_graph_init(ac, av, prefix, &opts);
+	return cmd_graph_walk(&opts);
+}
diff --git a/builtin.h b/builtin.h
index 95126fd..1801993 100644
--- a/builtin.h
+++ b/builtin.h
@@ -43,6 +43,7 @@ extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
+extern int cmd_graph(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_http_fetch(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index b7729d7..9d5fd09 100644
--- a/git.c
+++ b/git.c
@@ -306,6 +306,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
+		{ "graph", cmd_graph, RUN_SETUP | USE_PAGER },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
 		{ "help", cmd_help },
 #ifndef NO_CURL
-- 
1.5.5.rc2.1.ge6b5a.dirty
