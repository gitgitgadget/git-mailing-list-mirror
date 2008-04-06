From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 1/4] Add history graph API
Date: Sun,  6 Apr 2008 11:42:08 -0700
Message-ID: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Cc: Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 20:43:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiZpb-0004Dg-3r
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 20:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbYDFSm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYDFSm0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 14:42:26 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:56658 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYDFSmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 14:42:16 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 09E3C1B4119;
	Sun,  6 Apr 2008 14:42:14 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id EC8201B40DB;
	Sun,  6 Apr 2008 14:42:12 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 0973714100BB; Sun,  6 Apr 2008 11:42:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78911>

This new API allows the commit history to be displayed as a text-based
graphical representation.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
This is a replacement for the git-graph patch I submitted last weekend.
It adds the graph functionality as a new API.  A subsequent commit
updates "git log" and "git rev-list" to use the new API.

I saw that Jan Engelhardt also submitted a patch for his git-forest
script this past week.  It looks like a fine tool, too.

I think there are benefits to having the graphing functionality built in
to git.  This way all of the existing log functionality (argument
parsing, pretty formats, etc) can be easily re-used.  Other builtin
parts of git can also take advantage of the graphing API.  It is also
one less tool for system administrators to install and maintain
(although this depends on how the distros decide to package things, I
suppose).

I also prefer the output of my graphing API better than that of
git-forest (although, as the author, I'm a bit biased).  It is more
similar to gitk's graph, which many people are already familiar with.
It also doesn't require a terminal with Unicode support.

I do like the fact that git-forest prints the names of the refs that
point to each commit.  For the graphing API, we could perhaps add a "%r"
specifier to --pretty=format to print the refs pointing to the commit.

 Documentation/technical/api-history-graph.txt |  108 ++++
 Makefile                                      |    2 +
 graph.c                                       |  711 +++++++++++++++++++++++++
 graph.h                                       |   57 ++
 4 files changed, 878 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-history-graph.txt
 create mode 100644 graph.c
 create mode 100644 graph.h

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
new file mode 100644
index 0000000..56a0a1e
--- /dev/null
+++ b/Documentation/technical/api-history-graph.txt
@@ -0,0 +1,108 @@
+history graph API
+=================
+
+The graph API is used to draw a text-based representation of the commit
+history.  The API generates the graph in a line-by-line fashion.
+
+Calling sequence
+----------------
+
+* Create a `struct git_graph` by calling `graph_init()`
+
+* Use the revision walking API to walk through a group of contiguous commits.
+
+* For each commit you walk through, call `graph_update()`.  Then call
+  `graph_next_line()` repeatedly, until `graph_is_commit_finished()` returns
+  non-zero.  Each call go `graph_next_line()` will output a single line of the
+  graph.  The resulting lines will not contain any newlines.
+  `graph_next_line()` returns 1 if the resulting line contains the current
+  commit, or 0 if this is merely a line needed to adjust the graph before or
+  after the current commit.  This return value can be used to determine where
+  to print the commit summary information alongside the graph output.
+
+Data structure
+--------------
+`struct git_graph` is an opaque data type used to store the current graph
+state.
+
+Limitations
+-----------
+
+* `graph_update()` must be called with commits in topological order.  The
+  commits must also be a contiguous group--intervening parents should not
+  be ommitted.  Otherwise, the graph API cannot determine the proper
+  parent-child relationships between the commits.  If intervening parents
+  are ommitted, the next ancestor that is used will appear to be on a
+  separate branch in the graph.
+
+* The graph API does not currently support reverse commit ordering.  In
+  order to implement reverse ordering, the graphing API needs an
+  (efficient) mechanism to find the children of a commit.
+
+Sample usage
+------------
+
+------------
+struct commit *commit;
+struct git_graph *graph = graph_init();
+
+while ((commit = get_revision(opts)) != NULL) {
+	graph_update(graph, commit);
+	while (!graph_is_commit_finished(graph))
+	{
+		struct strbuf sb;
+		int is_commit_line;
+
+		strbuf_init(&sb, 0);
+		is_commit_line = graph_next_line(graph, &sb);
+		fputs(sb.buf, stdout);
+
+		if (is_commit_line)
+			log_tree_commit(opts, commit);
+		else
+			putchar(opts->diffopt.line_termination);
+	}
+}
+
+graph_release(graph);
+------------
+
+Sample output
+-------------
+
+The following is an example of the output from the graph API.  This output does
+not include any commit summary information--callers of responsible for
+outputting that information, if desired.
+
+------------
+*
+*
+M
+|\
+* |
+| | *
+| \ \
+|  \ \
+M-. \ \
+|\ \ \ \
+| | * | |
+| | | | | *
+| | | | | *
+| | | | | M
+| | | | | |\
+| | | | | | *
+| * | | | | |
+| | | | | M  \
+| | | | | |\  |
+| | | | * | | |
+| | | | * | | |
+* | | | | | | |
+| |/ / / / / /
+|/| / / / / /
+* | | | | | |
+|/ / / / / /
+* | | | | |
+| | | | | *
+| | | | |/
+| | | | *
+------------
diff --git a/Makefile b/Makefile
index 7c70b00..3395b59 100644
--- a/Makefile
+++ b/Makefile
@@ -345,6 +345,7 @@ LIB_H += diff.h
 LIB_H += dir.h
 LIB_H += fsck.h
 LIB_H += git-compat-util.h
+LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += list-objects.h
@@ -409,6 +410,7 @@ LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fsck.o
+LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
 LIB_OBJS += help.o
diff --git a/graph.c b/graph.c
new file mode 100644
index 0000000..d8cb7d4
--- /dev/null
+++ b/graph.c
@@ -0,0 +1,711 @@
+#include "cache.h"
+#include "commit.h"
+#include "graph.h"
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
+ * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING states
+ *   could be made more compact by printing horizontal lines, instead of
+ *   long diagonal lines.  For example, during collapsing, something like
+ *   this:          instead of this:
+ *   | | | | |      | | | | |
+ *   | |_|_|/       | | | |/
+ *   |/| | |        | | |/|
+ *   | | | |        | |/| |
+ *                  |/| | |
+ *                  | | | |
+ *
+ *   If there are several parallel diagonal lines, they will need to be
+ *   replaced with horizontal lines on subsequent rows.
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
+enum graph_state {
+	GRAPH_PADDING,
+	GRAPH_SKIP,
+	GRAPH_PRE_COMMIT,
+	GRAPH_COMMIT,
+	GRAPH_POST_MERGE,
+	GRAPH_COLLAPSING
+};
+
+struct git_graph {
+	/*
+	 * The commit currently being processed
+	 */
+	struct commit *commit;
+	/*
+	 * The number of parents this commit has.
+	 * (Stored so we don't have to walk over them each time we need
+	 * this number)
+	 */
+	int num_parents;
+	/*
+	 * The next expansion row to print
+	 * when state is GRAPH_PRE_COMMIT
+	 */
+	int expansion_row;
+	/*
+	 * The current output state.
+	 * This tells us what kind of line graph_next_line() should output.
+	 */
+	enum graph_state state;
+	/*
+	 * The maximum number of columns that can be stored in the columns
+	 * and new_columns arrays.  This is also half the number of entries
+	 * that can be stored in the mapping and new_mapping arrays.
+	 */
+	int column_capacity;
+	/*
+	 * The number of columns (also called "branch lines" in some places)
+	 */
+	int num_columns;
+	/*
+	 * The number of columns in the new_columns array
+	 */
+	int num_new_columns;
+	/*
+	 * The number of entries in the mapping array
+	 */
+	int mapping_size;
+	/*
+	 * The column state before we output the current commit.
+	 */
+	struct column *columns;
+	/*
+	 * The new column state after we output the current commit.
+	 * Only valid when state is GRAPH_COLLAPSING.
+	 */
+	struct column *new_columns;
+	/*
+	 * An array that tracks the current state of each
+	 * character in the output line during state GRAPH_COLLAPSING.
+	 * Each entry is -1 if this character is empty, or a non-negative
+	 * integer if the character contains a branch line.  The value of
+	 * the integer indicates the target position for this branch line.
+	 * (I.e., this array maps the current column positions to their
+	 * desired positions.)
+	 *
+	 * The maximum capacity of this array is always
+	 * sizeof(int) * 2 * column_capacity.
+	 */
+	int *mapping;
+	/*
+	 * A temporary array for computing the next mapping state
+	 * while we are outputting a mapping line.  This is stored as part
+	 * of the git_graph simply so we don't have to allocate a new
+	 * temporary array each time we have to output a collapsing line.
+	 */
+	int *new_mapping;
+};
+
+struct git_graph *graph_init()
+{
+	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
+	graph->commit = NULL;
+	graph->num_parents = 0;
+	graph->expansion_row = 0;
+	graph->state = GRAPH_PADDING;
+	graph->num_columns = 0;
+	graph->num_new_columns = 0;
+	graph->mapping_size = 0;
+
+	/*
+	 * Allocate a reasonably large default number of columns
+	 * We'll automatically grow columns later if we need more room.
+	 */
+	graph->column_capacity = 30;
+	graph->columns = xmalloc(sizeof(struct column) *
+				 graph->column_capacity);
+	graph->new_columns = xmalloc(sizeof(struct column) *
+				     graph->column_capacity);
+	graph->mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
+	graph->new_mapping = xmalloc(sizeof(int) * 2 * graph->column_capacity);
+
+	return graph;
+}
+
+void graph_release(struct git_graph *graph)
+{
+	free(graph->columns);
+	free(graph->new_columns);
+	free(graph->mapping);
+	free(graph);
+}
+
+static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
+{
+	if (graph->column_capacity >= num_columns)
+		return;
+
+	do {
+		graph->column_capacity *= 2;
+	} while (graph->column_capacity < num_columns);
+
+	graph->columns = xrealloc(graph->columns,
+				  sizeof(struct column) *
+				  graph->column_capacity);
+	graph->new_columns = xrealloc(graph->new_columns,
+				      sizeof(struct column) *
+				      graph->column_capacity);
+	graph->mapping = xrealloc(graph->mapping,
+				  sizeof(int) * 2 * graph->column_capacity);
+	graph->new_mapping = xrealloc(graph->new_mapping,
+				      sizeof(int) * 2 * graph->column_capacity);
+}
+
+static void graph_insert_into_new_columns(struct git_graph *graph,
+					  struct commit *commit,
+					  int mapping_index)
+{
+	int i;
+
+	/*
+	 * If the commit is already in the new_columns list, we don't need to
+	 * add it.  Just update the mapping correctly.
+	 */
+	for (i = 0; i < graph->num_new_columns; ++i) {
+		if (graph->new_columns[i].commit == commit) {
+			graph->mapping[mapping_index] = i;
+			return;
+		}
+	}
+
+	/*
+	 * This commit isn't already in new_columns.  Add it.
+	 */
+	graph->new_columns[graph->num_new_columns].commit = commit;
+	graph->mapping[mapping_index] = graph->num_new_columns;
+	++graph->num_new_columns;
+}
+
+static void graph_update_columns(struct git_graph *graph)
+{
+	struct commit_list *parent;
+	struct column *tmp_columns;
+	int max_new_columns;
+	int mapping_idx;
+	int i, seen_this;
+
+	/*
+	 * Swap graph->columns with graph->new_columns
+	 * graph->columns contains the state for the previous commit,
+	 * and new_columns now contains the state for our commit.
+	 *
+	 * We'll re-use the old columns array as storage to compute the new
+	 * columns list for the commit after this one.
+	 */
+	tmp_columns = graph->columns;
+	graph->columns = graph->new_columns;
+	graph->num_columns = graph->num_new_columns;
+
+	graph->new_columns = tmp_columns;
+	graph->num_new_columns = 0;
+
+	/*
+	 * Now update new_columns and mapping with the information for the
+	 * commit after this one.
+	 *
+	 * First, make sure we have enough room.  At most, there will
+	 * be graph->num_columns + graph->num_parents columns for the next
+	 * commit.
+	 */
+	max_new_columns = graph->num_columns + graph->num_parents;
+	graph_ensure_capacity(graph, max_new_columns);
+
+	/*
+	 * Clear out graph->mapping
+	 */
+	graph->mapping_size = 2 * max_new_columns;
+	for (i = 0; i < graph->mapping_size; ++i)
+		graph->mapping[i] = -1;
+
+	/*
+	 * Populate graph->new_columns and graph->mapping
+	 *
+	 * Some of the parents of this commit may already be in
+	 * graph->columns.  If so, graph->new_columns should only contain a
+	 * single entry for each such commit.  graph->mapping should
+	 * contain information about where each current branch line is
+	 * supposed to end up after the collapsing is performed.
+	 */
+	seen_this = 0;
+	mapping_idx = 0;
+	for (i = 0; i <= graph->num_columns; ++i) {
+		struct commit *col_commit;
+		if (i == graph->num_columns) {
+			if (seen_this)
+				break;
+			col_commit = graph->commit;
+		} else {
+			col_commit = graph->columns[i].commit;
+		}
+
+		if (col_commit == graph->commit) {
+			seen_this = 1;
+			for (parent = graph->commit->parents;
+			     parent;
+			     parent = parent->next) {
+				graph_insert_into_new_columns(graph,
+							      parent->item,
+							      mapping_idx);
+				mapping_idx += 2;
+			}
+		} else {
+			graph_insert_into_new_columns(graph, col_commit,
+						      mapping_idx);
+			mapping_idx += 2;
+		}
+	}
+
+	/*
+	 * Shrink mapping_size to be the minimum necessary
+	 */
+	while (graph->mapping_size > 1 &&
+	       graph->mapping[graph->mapping_size - 1] < 0)
+		--graph->mapping_size;
+}
+
+void graph_update(struct git_graph *graph, struct commit *commit)
+{
+	struct commit_list *parent;
+
+	/*
+	 * Set the new commit
+	 */
+	graph->commit = commit;
+
+	/*
+	 * Count how many parents this commit has
+	 */
+	graph->num_parents = 0;
+	for (parent = commit->parents; parent; parent = parent->next)
+		++(graph->num_parents);
+
+	/*
+	 * Call graph_update_columns() to update
+	 * columns, new_columns, and mapping.
+	 */
+	graph_update_columns(graph);
+
+	graph->expansion_row = 0;
+
+	/*
+	 * Update graph->state.
+	 *
+	 * If the previous commit didn't get to the GRAPH_PADDING state,
+	 * it never finished its output.  Goto GRAPH_SKIP, to print out
+	 * a line to indicate that portion of the graph is missing.
+	 *
+	 * Otherwise, if there are 3 or more parents, we need to print
+	 * extra rows before the commit, to expand the branch lines around
+	 * it and make room for it.
+	 *
+	 * If there are less than 3 parents, we can immediately print the
+	 * commit line.
+	 */
+	if (graph->state != GRAPH_PADDING)
+		graph->state = GRAPH_SKIP;
+	else if (graph->num_parents >= 3)
+		graph->state = GRAPH_PRE_COMMIT;
+	else
+		graph->state = GRAPH_COMMIT;
+}
+
+static int graph_is_mapping_correct(struct git_graph *graph)
+{
+	int i;
+
+	/*
+	 * The mapping is up to date if each entry is at its target,
+	 * or is 1 greater than its target.
+	 * (If it is 1 greater than the target, '/' will be printed, so it
+	 * will look correct on the next row.)
+	 */
+	for (i = 0; i < graph->mapping_size; ++i) {
+		int target = graph->mapping[i];
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
+static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb)
+{
+	/*
+	 * Add additional spaces to the end of the strbuf, so that all
+	 * lines for a particular commit have the same width.
+	 *
+	 * This way, fields printed to the right of the graph will remain
+	 * aligned for the entire commit.
+	 *
+	 * This computation results in 3 extra space to the right in most
+	 * cases, but only 1 extra space if the commit doesn't have any
+	 * children that have already been displayed in the graph (i.e.,
+	 * if the current commit isn't in graph->columns).
+	 */
+	size_t extra;
+	size_t final_width = graph->num_columns + graph->num_parents;
+	if (graph->num_parents < 1)
+		++final_width;
+	final_width *= 2;
+
+	if (sb->len >= final_width)
+		return;
+
+	extra = final_width - sb->len;
+	strbuf_addf(sb, "%*s", extra, "");
+}
+
+static void graph_output_padding_line(struct git_graph *graph,
+				      struct strbuf *sb)
+{
+	int i;
+
+	/*
+	 * We could conceivable be called with a NULL commit
+	 * if our caller has a bug, and invokes graph_next_line()
+	 * immediately after graph_init(), without first calling
+	 * graph_update().  Return without outputting anything in this
+	 * case.
+	 */
+	if (!graph->commit)
+		return;
+
+	/*
+	 * Output a padding row, that leaves all branch lines unchanged
+	 */
+	for (i = 0; i < graph->num_new_columns; ++i) {
+		strbuf_addstr(sb, "| ");
+	}
+
+	graph_pad_horizontally(graph, sb);
+}
+
+static void graph_output_skip_line(struct git_graph *graph, struct strbuf *sb)
+{
+	/*
+	 * Output an ellipsis to indicate that a portion
+	 * of the graph is missing.
+	 */
+	strbuf_addstr(sb, "...");
+	graph_pad_horizontally(graph, sb);
+
+	if (graph->num_parents >= 3)
+		graph->state = GRAPH_PRE_COMMIT;
+	else
+		graph->state = GRAPH_COMMIT;
+}
+
+static void graph_output_pre_commit_line(struct git_graph *graph,
+					 struct strbuf *sb)
+{
+	int num_expansion_rows;
+	int i, seen_this;
+
+	/*
+	 * This function formats a row that increases the space around a commit
+	 * with multiple parents, to make room for it.  It should only be
+	 * called when there are 3 or more parents.
+	 *
+	 * We need 2 extra rows for every parent over 2.
+	 */
+	assert(graph->num_parents >= 3);
+	num_expansion_rows = (graph->num_parents - 2) * 2;
+
+	/*
+	 * graph->expansion_row tracks the current expansion row we are on.
+	 * It should be in the range [0, num_expansion_rows - 1]
+	 */
+	assert(0 <= graph->expansion_row &&
+	       graph->expansion_row < num_expansion_rows);
+
+	/*
+	 * Output the row
+	 */
+	seen_this = 0;
+	for (i = 0; i < graph->num_columns; ++i) {
+		struct column *col = &graph->columns[i];
+		if (col->commit == graph->commit) {
+			seen_this = 1;
+			strbuf_addf(sb, "| %*s", graph->expansion_row, "");
+		} else if (seen_this) {
+			strbuf_addstr(sb, "\\ ");
+		} else {
+			strbuf_addstr(sb, "| ");
+		}
+	}
+
+	graph_pad_horizontally(graph, sb);
+
+	/*
+	 * Increment graph->expansion_row,
+	 * and move to state GRAPH_COMMIT if necessary
+	 */
+	++graph->expansion_row;
+	if (graph->expansion_row >= num_expansion_rows)
+		graph->state = GRAPH_COMMIT;
+}
+
+void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
+{
+	int seen_this = 0;
+	int i, j;
+
+	/*
+	 * Output the row containing this commit
+	 * Iterate up to and including graph->num_columns,
+	 * since the current commit may not be in any of the existing
+	 * columns.  (This happens when the current commit doesn't have any
+	 * children that we have already processed.)
+	 */
+	seen_this = 0;
+	for (i = 0; i <= graph->num_columns; ++i) {
+		struct commit *col_commit;
+		if (i == graph->num_columns) {
+			if (seen_this)
+				break;
+			col_commit = graph->commit;
+		} else {
+			col_commit = graph->columns[i].commit;
+		}
+
+		if (col_commit == graph->commit) {
+			seen_this = 1;
+			if (graph->num_parents > 1)
+				strbuf_addch(sb, 'M');
+			else
+				strbuf_addch(sb, '*');
+
+			if (graph->num_parents < 2)
+				strbuf_addch(sb, ' ');
+			else if (graph->num_parents == 2)
+				strbuf_addstr(sb, "  ");
+			else {
+				int num_dashes =
+					((graph->num_parents - 2) * 2) - 1;
+				for (j = 0; j < num_dashes; ++j)
+					strbuf_addch(sb, '-');
+				strbuf_addstr(sb, ". ");
+			}
+		} else if (seen_this && (graph->num_parents > 1)) {
+			strbuf_addstr(sb, "\\ ");
+		} else {
+			strbuf_addstr(sb, "| ");
+		}
+	}
+
+	graph_pad_horizontally(graph, sb);
+
+	/*
+	 * Update graph->state
+	 */
+	if (graph->num_parents > 1)
+		graph->state = GRAPH_POST_MERGE;
+	else if (graph_is_mapping_correct(graph))
+		graph->state = GRAPH_PADDING;
+	else
+		graph->state = GRAPH_COLLAPSING;
+}
+
+void graph_output_post_merge_line(struct git_graph *graph, struct strbuf *sb)
+{
+	int seen_this = 0;
+	int i, j;
+
+	/*
+	 * Output the post-merge row
+	 */
+	for (i = 0; i <= graph->num_columns; ++i) {
+		struct commit *col_commit;
+		if (i == graph->num_columns) {
+			if (seen_this)
+				break;
+			col_commit = graph->commit;
+		} else {
+			col_commit = graph->columns[i].commit;
+		}
+
+		if (col_commit == graph->commit) {
+			seen_this = 1;
+			strbuf_addch(sb, '|');
+			for (j = 0; j < graph->num_parents - 1; ++j)
+				strbuf_addstr(sb, "\\ ");
+			if (graph->num_parents == 2)
+				strbuf_addch(sb, ' ');
+		} else if (seen_this && (graph->num_parents > 2)) {
+			strbuf_addstr(sb, "\\ ");
+		} else {
+			strbuf_addstr(sb, "| ");
+		}
+	}
+
+	graph_pad_horizontally(graph, sb);
+
+	/*
+	 * Update graph->state
+	 */
+	if (graph_is_mapping_correct(graph))
+		graph->state = GRAPH_PADDING;
+	else
+		graph->state = GRAPH_COLLAPSING;
+}
+
+void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
+{
+	int i;
+	int *tmp_mapping;
+
+	/*
+	 * Clear out the new_mapping array
+	 */
+	for (i = 0; i < graph->mapping_size; ++i)
+		graph->new_mapping[i] = -1;
+
+	for (i = 0; i < graph->mapping_size; ++i) {
+		int target = graph->mapping[i];
+		if (target < 0)
+			continue;
+
+		/*
+		 * Since update_columns() always inserts the leftmost
+		 * column first, each branch's target location should
+		 * always be either its current location or to the left of
+		 * its current location.
+		 *
+		 * We never have to move branches to the right.  This makes
+		 * the graph much more legible, since whenever branches
+		 * cross, only one is moving directions.
+		 */
+		assert(target * 2 <= i);
+
+		if (target * 2 == i) {
+			/*
+			 * This column is already in the
+			 * correct place
+			 */
+			assert(graph->new_mapping[i] == -1);
+			graph->new_mapping[i] = target;
+		} else if (graph->new_mapping[i - 1] < 0) {
+			/*
+			 * Nothing is to the left.
+			 * Move to the left by one
+			 */
+			graph->new_mapping[i - 1] = target;
+		} else if (graph->new_mapping[i - 1] == target) {
+			/*
+			 * There is a branch line to our left
+			 * already, and it is our target.  We
+			 * combine with this line, since we share
+			 * the same parent commit.
+			 *
+			 * We don't have to add anything to the
+			 * output or new_mapping, since the
+			 * existing branch line has already taken
+			 * care of it.
+			 */
+		} else {
+			/*
+			 * There is a branch line to our left,
+			 * but it isn't our target.  We need to
+			 * cross over it.
+			 *
+			 * The space just to the left of this
+			 * branch should always be empty.
+			 */
+			assert(graph->new_mapping[i - 1] > target);
+			assert(graph->new_mapping[i - 2] < 0);
+			graph->new_mapping[i - 2] = target;
+		}
+	}
+
+	/*
+	 * The new mapping may be 1 smaller than the old mapping
+	 */
+	if (graph->new_mapping[graph->mapping_size - 1] < 0)
+		--graph->mapping_size;
+
+	/*
+	 * Output out a line based on the new mapping info
+	 */
+	for (i = 0; i < graph->mapping_size; ++i) {
+		int target = graph->new_mapping[i];
+		if (target < 0)
+			strbuf_addch(sb, ' ');
+		else if (target * 2 == i)
+			strbuf_addch(sb, '|');
+		else
+			strbuf_addch(sb, '/');
+	}
+
+	graph_pad_horizontally(graph, sb);
+
+	/*
+	 * Swap mapping and new_mapping
+	 */
+	tmp_mapping = graph->mapping;
+	graph->mapping = graph->new_mapping;
+	graph->new_mapping = tmp_mapping;
+
+	/*
+	 * If graph->mapping indicates that all of the branch lines
+	 * are already in the correct positions, we are done.
+	 * Otherwise, we need to collapse some branch lines together.
+	 */
+	if (graph_is_mapping_correct(graph))
+		graph->state = GRAPH_PADDING;
+}
+
+int graph_next_line(struct git_graph *graph, struct strbuf *sb)
+{
+	switch (graph->state) {
+	case GRAPH_PADDING:
+		graph_output_padding_line(graph, sb);
+		return 0;
+	case GRAPH_SKIP:
+		graph_output_skip_line(graph, sb);
+		return 0;
+	case GRAPH_PRE_COMMIT:
+		graph_output_pre_commit_line(graph, sb);
+		return 0;
+	case GRAPH_COMMIT:
+		graph_output_commit_line(graph, sb);
+		return 1;
+	case GRAPH_POST_MERGE:
+		graph_output_post_merge_line(graph, sb);
+		return 0;
+	case GRAPH_COLLAPSING:
+		graph_output_collapsing_line(graph, sb);
+		return 0;
+	}
+
+	assert(0);
+	return 0;
+}
+
+int graph_is_commit_finished(struct git_graph const *graph)
+{
+	return (graph->state == GRAPH_PADDING);
+}
diff --git a/graph.h b/graph.h
new file mode 100644
index 0000000..fc23bf2
--- /dev/null
+++ b/graph.h
@@ -0,0 +1,57 @@
+#ifndef GRAPH_H
+#define GRAPH_H
+
+/* A graph is a pointer to this opaque structure */
+struct git_graph;
+
+/* Defined in commit.h */
+struct commit;
+/* Defined in strbuf.h */
+struct strbuf;
+
+/*
+ * Create a new struct git_graph.
+ * The graph should be freed with graph_release() when no longer needed.
+ */
+struct git_graph *graph_init();
+
+/*
+ * Destroy a struct git_graph and free associated memory.
+ */
+void graph_release(struct git_graph *graph);
+
+/*
+ * Update a git_graph with a new commit.
+ * This will cause the graph to begin outputting lines for the new commit
+ * the next time graph_next_line() is called.
+ *
+ * If graph_update() is called before graph_is_commit_finished() returns 1,
+ * the next call to graph_next_line() will output an ellipsis ("...")
+ * to indicate that a portion of the graph is missing.
+ */
+void graph_update(struct git_graph *graph, struct commit *commit);
+
+/*
+ * Output the next line for a graph.
+ * This formats the next graph line into the specified strbuf.  It is not
+ * terminated with a newline.
+ *
+ * Returns 1 if the line includes the current commit, and 0 otherwise.
+ * graph_next_line() will return 1 exactly once for each time
+ * graph_update() is called.
+ */
+int graph_next_line(struct git_graph *graph, struct strbuf *sb);
+
+/*
+ * Determine if a graph has finished outputting lines for the current
+ * commit.
+ *
+ * Returns 1 if graph_next_line() needs to be called again before
+ * graph_update() should be called.  Returns 0 if no more lines are needed
+ * for this commit.  If 0 is returned, graph_next_line() may still be
+ * called without calling graph_update(), and it will merely output
+ * appropriate "vertical padding" in the graph.
+ */
+int graph_is_commit_finished(struct git_graph const *graph);
+
+#endif /* GRAPH_H */
-- 
1.5.3.6
