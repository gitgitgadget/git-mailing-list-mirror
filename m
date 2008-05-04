From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 2/3] Add history graph API
Date: Sun,  4 May 2008 03:36:53 -0700
Message-ID: <1209897414-10091-3-git-send-email-adam@adamsimpkins.net>
References: <1209897414-10091-1-git-send-email-adam@adamsimpkins.net>
 <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 12:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsbcZ-00071l-2t
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 12:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbYEDKhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 06:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbYEDKhg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 06:37:36 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:50473 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643AbYEDKg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 06:36:58 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 7915B1B4036;
	Sun,  4 May 2008 06:36:56 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 6633C1B401D;
	Sun,  4 May 2008 06:36:55 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 5641114100C3; Sun,  4 May 2008 03:36:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.128.gc15ea
In-Reply-To: <1209897414-10091-2-git-send-email-adam@adamsimpkins.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81167>

This new API allows the commit history to be displayed as a text-based
graphical representation.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>
---
 Documentation/technical/api-history-graph.txt |  176 +++++
 Makefile                                      |    2 +
 graph.c                                       |  903 +++++++++++++++++++++++++
 graph.h                                       |  121 ++++
 4 files changed, 1202 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-history-graph.txt
 create mode 100644 graph.c
 create mode 100644 graph.h

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
new file mode 100644
index 0000000..5f6465f
--- /dev/null
+++ b/Documentation/technical/api-history-graph.txt
@@ -0,0 +1,176 @@
+history graph API
+=================
+
+The graph API is used to draw a text-based representation of the commit
+history.  The API generates the graph in a line-by-line fashion.
+
+Functions
+---------
+
+Core functions:
+
+* `graph_init()` creates a new `struct git_graph`
+
+* `graph_release()` destroys a `struct git_graph`, and frees the memory
+  associated with it.
+
+* `graph_update()` moves the graph to a new commit.
+
+* `graph_next_line()` outputs the next line of the graph into a strbuf.  It
+  does not add a terminating newline.
+
+* `graph_padding_line()` outputs a line of vertical padding in the graph.  It
+  is similar to `graph_next_line()`, but is guaranteed to never print the line
+  containing the current commit.  Where `graph_next_line()` would print the
+  commit line next, `graph_padding_line()` prints a line that simply extends
+  all branch lines downwards one row, leaving their positions unchanged.
+
+* `graph_is_commit_finished()` determines if the graph has output all lines
+  necessary for the current commit.  If `graph_update()` is called before all
+  lines for the current commit have been printed, the next call to
+  `graph_next_line()` will output an ellipsis, to indicate that a portion of
+  the graph was omitted.
+
+The following utility functions are wrappers around `graph_next_line()` and
+`graph_is_commit_finished()`.  They always print the output to stdout.
+They can all be called with a NULL graph argument, in which case no graph
+output will be printed.
+
+* `graph_show_commit()` calls `graph_next_line()` until it returns non-zero.
+  This prints all graph lines up to, and including, the line containing this
+  commit.  Output is printed to stdout.  The last line printed does not contain
+  a terminating newline.  This should not be called if the commit line has
+  already been printed, or it will loop forever.
+
+* `graph_show_oneline()` calls `graph_next_line()` and prints the result to
+  stdout.  The line printed does not contain a terminating newline.
+
+* `graph_show_padding()` calls `graph_padding_line()` and prints the result to
+  stdout.  The line printed does not contain a terminating newline.
+
+* `graph_show_remainder()` calls `graph_next_line()` until
+  `graph_is_commit_finished()` returns non-zero.  Output is printed to stdout.
+  The last line printed does not contain a terminating newline.  Returns 1 if
+  output was printed, and 0 if no output was necessary.
+
+* `graph_show_strbuf()` prints the specified strbuf to stdout, prefixing all
+  lines but the first with a graph line.  The caller is responsible for
+  ensuring graph output for the first line has already been printed to stdout.
+  (This can be done with `graph_show_commit()` or `graph_show_oneline()`.)  If
+  a NULL graph is supplied, the strbuf is printed as-is.
+
+* `graph_show_commit_msg()` is similar to `graph_show_strbuf()`, but it also
+  prints the remainder of the graph, if more lines are needed after the strbuf
+  ends.  It is better than directly calling `graph_show_strbuf()` followed by
+  `graph_show_remainder()` since it properly handles buffers that do not end in
+  a terminating newline.  The output printed by `graph_show_commit_msg()` will
+  end in a newline if and only if the strbuf ends in a newline.
+
+Data structure
+--------------
+`struct git_graph` is an opaque data type used to store the current graph
+state.
+
+Calling sequence
+----------------
+
+* Create a `struct git_graph` by calling `graph_init()`.
+
+* Use the revision walking API to walk through a group of contiguous commits.
+
+* For each commit traversed, call `graph_update()` to move the graph to the
+  next commit.  Once `graph_update()` has been called, call `graph_next_line()`
+  repeatedly, until `graph_is_commit_finished()` returns non-zero.  Each call
+  to `graph_next_line()` will output a single line of the graph.  The resulting
+  lines will not contain any newlines.  `graph_next_line()` returns 1 if the
+  resulting line contains the current commit, or 0 if this is merely a line
+  needed to adjust the graph before or after the current commit.  This return
+  value can be used to determine where to print the commit summary information
+  alongside the graph output.
+
+Limitations
+-----------
+
+* `graph_update()` must be called with commits in topological order.  It should
+  not be called on a commit if it has already been invoked with an ancestor of
+  that commit, or the graph output will be incorrect.
+
+* `graph_update()` must be called on a contiguous group of commits.  If
+  `graph_update()` is called on a particular commit, it should later be called
+  on all parents of that commit.  Parents must not be skipped, or the graph
+  output will appear incorrect.
++
+`graph_update()` may be used on a pruned set of commits only if the parent list
+has been rewritten so as to include only ancestors from the pruned set.
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
+not include any commit summary information--callers are responsible for
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
index 9d84c8d..d42b117 100644
--- a/Makefile
+++ b/Makefile
@@ -346,6 +346,7 @@ LIB_H += diff.h
 LIB_H += dir.h
 LIB_H += fsck.h
 LIB_H += git-compat-util.h
+LIB_H += graph.h
 LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += list-objects.h
@@ -411,6 +412,7 @@ LIB_OBJS += entry.o
 LIB_OBJS += environment.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fsck.o
+LIB_OBJS += graph.o
 LIB_OBJS += grep.o
 LIB_OBJS += hash.o
 LIB_OBJS += help.o
diff --git a/graph.c b/graph.c
new file mode 100644
index 0000000..b575d10
--- /dev/null
+++ b/graph.c
@@ -0,0 +1,903 @@
+#include "cache.h"
+#include "commit.h"
+#include "graph.h"
+#include "diff.h"
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
+					  int *mapping_index)
+{
+	int i;
+
+	/*
+	 * Ignore uinteresting and pruned commits
+	 */
+	if (commit->object.flags & (UNINTERESTING | TREESAME))
+		return;
+
+	/*
+	 * If the commit is already in the new_columns list, we don't need to
+	 * add it.  Just update the mapping correctly.
+	 */
+	for (i = 0; i < graph->num_new_columns; i++) {
+		if (graph->new_columns[i].commit == commit) {
+			graph->mapping[*mapping_index] = i;
+			*mapping_index += 2;
+			return;
+		}
+	}
+
+	/*
+	 * This commit isn't already in new_columns.  Add it.
+	 */
+	graph->new_columns[graph->num_new_columns].commit = commit;
+	graph->mapping[*mapping_index] = graph->num_new_columns;
+	*mapping_index += 2;
+	graph->num_new_columns++;
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
+	for (i = 0; i < graph->mapping_size; i++)
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
+	for (i = 0; i <= graph->num_columns; i++) {
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
+							      &mapping_idx);
+			}
+		} else {
+			graph_insert_into_new_columns(graph, col_commit,
+						      &mapping_idx);
+		}
+	}
+
+	/*
+	 * Shrink mapping_size to be the minimum necessary
+	 */
+	while (graph->mapping_size > 1 &&
+	       graph->mapping[graph->mapping_size - 1] < 0)
+		graph->mapping_size--;
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
+		graph->num_parents++;
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
+	for (i = 0; i < graph->mapping_size; i++) {
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
+		final_width++;
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
+	for (i = 0; i < graph->num_new_columns; i++) {
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
+	for (i = 0; i < graph->num_columns; i++) {
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
+	graph->expansion_row++;
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
+	for (i = 0; i <= graph->num_columns; i++) {
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
+				for (j = 0; j < num_dashes; j++)
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
+	for (i = 0; i <= graph->num_columns; i++) {
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
+			for (j = 0; j < graph->num_parents - 1; j++)
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
+	for (i = 0; i < graph->mapping_size; i++)
+		graph->new_mapping[i] = -1;
+
+	for (i = 0; i < graph->mapping_size; i++) {
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
+		graph->mapping_size--;
+
+	/*
+	 * Output out a line based on the new mapping info
+	 */
+	for (i = 0; i < graph->mapping_size; i++) {
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
+void graph_padding_line(struct git_graph *graph, struct strbuf *sb)
+{
+	int i, j;
+
+	if (graph->state != GRAPH_COMMIT) {
+		graph_next_line(graph, sb);
+		return;
+	}
+
+	/*
+	 * Output the row containing this commit
+	 * Iterate up to and including graph->num_columns,
+	 * since the current commit may not be in any of the existing
+	 * columns.  (This happens when the current commit doesn't have any
+	 * children that we have already processed.)
+	 */
+	for (i = 0; i < graph->num_columns; i++) {
+		struct commit *col_commit = graph->columns[i].commit;
+		if (col_commit == graph->commit) {
+			strbuf_addch(sb, '|');
+
+			if (graph->num_parents < 3)
+				strbuf_addch(sb, ' ');
+			else {
+				int num_spaces = ((graph->num_parents - 2) * 2);
+				for (j = 0; j < num_spaces; j++)
+					strbuf_addch(sb, ' ');
+			}
+		} else {
+			strbuf_addstr(sb, "| ");
+		}
+	}
+
+	graph_pad_horizontally(graph, sb);
+}
+
+int graph_is_commit_finished(struct git_graph const *graph)
+{
+	return (graph->state == GRAPH_PADDING);
+}
+
+void graph_show_commit(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+	int shown_commit_line = 0;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+
+	while (!shown_commit_line) {
+		shown_commit_line = graph_next_line(graph, &msgbuf);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		if (!shown_commit_line)
+			putchar('\n');
+		strbuf_setlen(&msgbuf, 0);
+	}
+
+	strbuf_release(&msgbuf);
+}
+
+void graph_show_oneline(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+	graph_next_line(graph, &msgbuf);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	strbuf_release(&msgbuf);
+}
+
+void graph_show_padding(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+
+	if (!graph)
+		return;
+
+	strbuf_init(&msgbuf, 0);
+	graph_padding_line(graph, &msgbuf);
+	fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	strbuf_release(&msgbuf);
+}
+
+int graph_show_remainder(struct git_graph *graph)
+{
+	struct strbuf msgbuf;
+	int shown = 0;
+
+	if (!graph)
+		return 0;
+
+	if (graph_is_commit_finished(graph))
+		return 0;
+
+	strbuf_init(&msgbuf, 0);
+	for (;;) {
+		graph_next_line(graph, &msgbuf);
+		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+		strbuf_setlen(&msgbuf, 0);
+		shown = 1;
+
+		if (!graph_is_commit_finished(graph))
+			putchar('\n');
+		else
+			break;
+	}
+	strbuf_release(&msgbuf);
+
+	return shown;
+}
+
+
+void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb)
+{
+	if (!graph) {
+		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		return;
+	}
+
+	/*
+	 * Print the strbuf line by line,
+	 * and display the graph info before each line but the first.
+	 */
+	char *p = sb->buf;
+	while (p) {
+		size_t len;
+		char *next_p = strchr(p, '\n');
+		if (next_p) {
+			next_p++;
+			len = next_p - p;
+		} else {
+			len = (sb->buf + sb->len) - p;
+		}
+		fwrite(p, sizeof(char), len, stdout);
+		if (next_p && *next_p != '\0')
+			graph_show_oneline(graph);
+		p = next_p;
+	}
+}
+
+void graph_show_commit_msg(struct git_graph *graph,
+			   struct strbuf const *sb)
+{
+	if (!graph) {
+		/*
+		 * If there's no graph, just print the message buffer.
+		 *
+		 * The message buffer for CMIT_FMT_ONELINE and
+		 * CMIT_FMT_USERFORMAT are already missing a terminating
+		 * newline.  All of the other formats should have it.
+		 */
+		fwrite(sb->buf, sizeof(char), sb->len, stdout);
+		return;
+	}
+
+	int newline_terminated = (sb->len && sb->buf[sb->len - 1] == '\n');
+
+	/*
+	 * Show the commit message
+	 */
+	graph_show_strbuf(graph, sb);
+
+	/*
+	 * If there is more output needed for this commit, show it now
+	 */
+	if (!graph_is_commit_finished(graph)) {
+		/*
+		 * If sb doesn't have a terminating newline, print one now,
+		 * so we can start the remainder of the graph output on a
+		 * new line.
+		 */
+		if (!newline_terminated)
+			putchar('\n');
+
+		graph_show_remainder(graph);
+
+		/*
+		 * If sb ends with a newline, our output should too.
+		 */
+		if (newline_terminated)
+			putchar('\n');
+	}
+}
diff --git a/graph.h b/graph.h
new file mode 100644
index 0000000..a7748a5
--- /dev/null
+++ b/graph.h
@@ -0,0 +1,121 @@
+#ifndef GRAPH_H
+#define GRAPH_H
+
+/* A graph is a pointer to this opaque structure */
+struct git_graph;
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
+ * Output a padding line in the graph.
+ * This is similar to graph_next_line().  However, it is guaranteed to
+ * never print the current commit line.  Instead, if the commit line is
+ * next, it will simply output a line of vertical padding, extending the
+ * branch lines downwards, but leaving them otherwise unchanged.
+ */
+void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
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
+
+/*
+ * graph_show_*: helper functions for printing to stdout
+ */
+
+
+/*
+ * If the graph is non-NULL, print the history graph to stdout,
+ * up to and including the line containing this commit.
+ * Does not print a terminating newline on the last line.
+ */
+void graph_show_commit(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print one line of the history graph to stdout.
+ * Does not print a terminating newline on the last line.
+ */
+void graph_show_oneline(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print one line of vertical graph padding to
+ * stdout.  Does not print a terminating newline on the last line.
+ */
+void graph_show_padding(struct git_graph *graph);
+
+/*
+ * If the graph is non-NULL, print the rest of the history graph for this
+ * commit to stdout.  Does not print a terminating newline on the last line.
+ */
+int graph_show_remainder(struct git_graph *graph);
+
+/*
+ * Print a strbuf to stdout.  If the graph is non-NULL, all lines but the
+ * first will be prefixed with the graph output.
+ *
+ * If the strbuf ends with a newline, the output will end after this
+ * newline.  A new graph line will not be printed after the final newline.
+ * If the strbuf is empty, no output will be printed.
+ *
+ * Since the first line will not include the graph ouput, the caller is
+ * responsible for printing this line's graph (perhaps via
+ * graph_show_commit() or graph_show_oneline()) before calling
+ * graph_show_strbuf().
+ */
+void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
+
+/*
+ * Print a commit message strbuf and the remainder of the graph to stdout.
+ *
+ * This is similar to graph_show_strbuf(), but it always prints the
+ * remainder of the graph.
+ *
+ * If the strbuf ends with a newline, the output printed by
+ * graph_show_commit_msg() will end with a newline.  If the strbuf is
+ * missing a terminating newline (including if it is empty), the output
+ * printed by graph_show_commit_msg() will also be missing a terminating
+ * newline.
+ */
+void graph_show_commit_msg(struct git_graph *graph, struct strbuf const *sb);
+
+#endif /* GRAPH_H */
-- 
1.5.5.1.128.gc15ea
