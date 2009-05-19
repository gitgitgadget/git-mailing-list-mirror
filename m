From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-graph: print dependency graph like git log --graph
Date: Tue, 19 May 2009 07:44:35 +0200
Message-ID: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue May 19 07:44:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6I8A-0006M7-KE
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 07:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZESFok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 01:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZESFoj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 01:44:39 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:38722 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZESFoh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 01:44:37 -0400
Received: by ewy24 with SMTP id 24so4618690ewy.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 22:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hjAEB4HFcBWuMlDiq/asdHlTq7nf99k1fAYhIUZFzTg=;
        b=NkwMpHdx3gnateMboZ7NJbC09e+OCaej/B+X6oUUktUhqi2NqCQ1NtHXK41hGn4tFi
         JeK68Ied+giWF43ta85k7qjGWcGpd9TiFOZ4SU/pP2TxcYLdbZFnHgMx1ljixNXQSY1F
         dbHjVKXvWI+7z8k+BC3Pj4DwL42ufpVXtfsXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k0wnMBEcC2oOM5fc7aYVCjID/3uoSbgKXRnnbup1MAdiSXaaW4DrZmtUlmqjeNimcr
         7eayaz8WuynQCw4xkp/J0QuUiNSarXxBFskg65BKW+/RRHr0/P/UMlhdavMlqQMQqbVJ
         mRyyeP5Hj122lKjN4QStztEm37aRfHxgxMGNU=
Received: by 10.210.58.17 with SMTP id g17mr5390661eba.4.1242711876688;
        Mon, 18 May 2009 22:44:36 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id 7sm2760632eyb.55.2009.05.18.22.44.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 22:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.32.g0d05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119493>

Finally, I have managed to work on an old idea: to display the dependency graph
line-by-line on the console.  The insiration comes from the git log --graph
command, the implementation too.  I have ported the graph.c file from the
GIT project into the GVPR graph processing language from the graphviz package.
Thats why I have Cc'ed Adam, the original author of the GIT graph API and I
would like to thank him for it.  But I must also apologize to him that I
haven't gave him credit in this first patch (only here in the message).  Which
should be done, before accepting into the topgit.git.

Actually, this is still a proof-of-concept, because I'm uncertain wheather we
need a new command for this or not.

As you can see from the tg graph options, there is many you can tweak.  I think
the dfs options gives compacter graphs for depending topics.  Dfs gives
compacter graphs for the reversed dependencies (i.e. master as first line) for
me too.  So dfs should probably the default.

Please try.

Thanks,
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 .gitignore                 |    2 +
 Makefile                   |    1 +
 README                     |    6 +
 contrib/tg-completion.bash |   25 +
 share/graph.gvpr           | 1043 ++++++++++++++++++++++++++++++++++++++++++++
 tg-graph.sh                |   74 ++++
 tg-summary.sh              |   47 ++-
 7 files changed, 1189 insertions(+), 9 deletions(-)

diff --git a/.gitignore b/.gitignore
index eb56446..fcc7f95 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,6 +21,8 @@
 /tg-import.txt
 /tg-remote
 /tg-remote.txt
+/tg-graph
+/tg-graph.txt
 /tg
 .*.swp
 
diff --git a/Makefile b/Makefile
index 3ce39a5..0de1277 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,7 @@ install:: all
 	install $(hooks_out) "$(DESTDIR)$(hooksdir)"
 	install -d -m 755 "$(DESTDIR)$(sharedir)"
 	install -m 644 $(help_out) "$(DESTDIR)$(sharedir)"
+	install -m 644 share/graph.gvpr "$(DESTDIR)$(sharedir)"
 
 clean::
 	rm -f tg $(commands_out) $(hooks_out) $(help_out)
diff --git a/README b/README
index d2f095d..7965d70 100644
--- a/README
+++ b/README
@@ -480,6 +480,12 @@ tg update
 
 	TODO: tg update -a for updating all topic branches
 
+tg graph
+~~~~~~~~
+	Prints the dependency graph like git log --graph to the console.
+
+	TODO: fan-in and fan-out graphs
+
 TODO: tg rename
 
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index de8a7b5..5124928 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -302,6 +302,30 @@ _tg_export ()
 	esac
 }
 
+_tg_graph ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			--color
+			--no-color
+			--bfs
+			--dfs
+			--reverse
+			--no-reverse
+			--header
+			--no-header
+			--body
+			--no-body
+		"
+		;;
+	*)
+		__tgcomp "$(__tg_refs)"
+	esac
+}
+
 _tg_help ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -444,6 +468,7 @@ _tg ()
 	delete)      _tg_delete ;;
 	depend)      _tg_depend ;;
 	export)      _tg_export ;;
+	graph)       _tg_graph ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
diff --git a/share/graph.gvpr b/share/graph.gvpr
new file mode 100755
index 0000000..1a96c22
--- /dev/null
+++ b/share/graph.gvpr
@@ -0,0 +1,1043 @@
+BEGIN {
+    int use_stack = 0;
+    int use_color = 1;
+    int rev_order = 0;
+    int show_header = 0;
+    int show_body = 0;
+
+    int argi;
+    for (argi = 0; argi < ARGC; argi++) {
+        if      (ARGV[argi] == "color")
+            use_color = 1;
+        else if (ARGV[argi] == "no-color")
+            use_color = 0;
+        else if (ARGV[argi] == "stack")
+            use_stack = 1;
+        else if (ARGV[argi] == "no-stack")
+            use_stack = 0;
+        else if (ARGV[argi] == "reverse")
+            rev_order = 1;
+        else if (ARGV[argi] == "no-reverse")
+            rev_order = 0;
+        else if (ARGV[argi] == "header")
+            show_header = 1;
+        else if (ARGV[argi] == "no-header")
+            show_header = 0;
+        else if (ARGV[argi] == "body")
+            show_body = 1;
+        else if (ARGV[argi] == "no-body")
+            show_body = 0;
+    }
+
+    edge_t first_edge(node_t n)
+    {
+        edge_t fe;
+
+        if (!rev_order) {
+            fe = fstout(n);
+        } else {
+            fe = fstin(n);
+        }
+
+        return fe;
+    }
+
+    edge_t next_edge(edge_t e)
+    {
+        edge_t ne;
+
+        if (!rev_order) {
+            ne = nxtout(e);
+        } else {
+            ne = nxtin(e);
+        }
+
+        return ne;
+    }
+
+    node_t adj_node(edge_t e)
+    {
+        node_t an;
+
+        if (!rev_order) {
+            an = e.head;
+        } else {
+            an = e.tail;
+        }
+
+        return an;
+    }
+
+    int node_deg(node_t n)
+    {
+        int nd;
+
+        if (!rev_order) {
+            nd = n.indegree;
+        } else {
+            nd = n.outdegree;
+        }
+
+        return nd;
+    }
+
+    int node_num_parents(node_t n)
+    {
+        int nnp;
+
+        if (!rev_order) {
+            nnp = n.outdegree;
+        } else {
+            nnp = n.indegree;
+        }
+
+        return nnp;
+    }
+
+    /* enum graph_state */
+    int GRAPH_PADDING    = 0;
+    int GRAPH_SKIP       = 1;
+    int GRAPH_PRE_COMMIT = 2;
+    int GRAPH_COMMIT     = 3;
+    int GRAPH_POST_MERGE = 4;
+    int GRAPH_COLLAPSING = 5;
+
+    /*
+     * The list of available column colors.
+     */
+    string GIT_COLOR_NORMAL     = "";
+    string GIT_COLOR_RESET      = "\033[m";
+    string GIT_COLOR_BOLD       = "\033[1m";
+    string GIT_COLOR_RED        = "\033[31m";
+    string GIT_COLOR_GREEN      = "\033[32m";
+    string GIT_COLOR_YELLOW     = "\033[33m";
+    string GIT_COLOR_BLUE       = "\033[34m";
+    string GIT_COLOR_MAGENTA    = "\033[35m";
+    string GIT_COLOR_CYAN       = "\033[36m";
+    string GIT_COLOR_BG_RED     = "\033[41m";
+
+    string gg_column_colors[];
+    gg_column_colors[ 0] = GIT_COLOR_RED;
+    gg_column_colors[ 1] = GIT_COLOR_GREEN;
+    gg_column_colors[ 2] = GIT_COLOR_YELLOW;
+    gg_column_colors[ 3] = GIT_COLOR_BLUE;
+    gg_column_colors[ 4] = GIT_COLOR_MAGENTA;
+    gg_column_colors[ 5] = GIT_COLOR_CYAN;
+    gg_column_colors[ 6] = GIT_COLOR_BOLD + GIT_COLOR_RED;
+    gg_column_colors[ 7] = GIT_COLOR_BOLD + GIT_COLOR_GREEN;
+    gg_column_colors[ 8] = GIT_COLOR_BOLD + GIT_COLOR_YELLOW;
+    gg_column_colors[ 9] = GIT_COLOR_BOLD + GIT_COLOR_BLUE;
+    gg_column_colors[10] = GIT_COLOR_BOLD + GIT_COLOR_MAGENTA;
+    gg_column_colors[11] = GIT_COLOR_BOLD + GIT_COLOR_CYAN;
+    int COLUMN_COLORS_MAX = 12;
+
+    /*
+     * The node currently being processed
+     */
+    node_t gg_n;
+    /*
+     * The number of interesting parents that this commit has.
+     */
+    int gg_num_parents;
+    /*
+     * The width of the graph output for this commit.
+     * All rows for this commit are padded to this width, so that
+     * messages printed after the graph output are aligned.
+     */
+    int gg_width;
+    /*
+     * The next expansion row to print
+     * when state is GRAPH_PRE_COMMIT
+     */
+    int gg_expansion_row;
+    /*
+     * The current output state.
+     * This tells us what kind of line graph_next_line() should output.
+     */
+    int gg_state;
+    /*
+     * The output state for the previous line of output.
+     * This is primarily used to determine how the first merge line
+     * should appear, based on the last line of the previous commit.
+     */
+    int gg_prev_state;
+    /*
+     * The index of the column that refers to this commit.
+     *
+     * If none of the incoming columns refer to this commit,
+     * this will be equal to num_columns.
+     */
+    int gg_n_index;
+    /*
+     * The commit_index for the previously displayed commit.
+     *
+     * This is used to determine how the first line of a merge
+     * graph output should appear, based on the last line of the
+     * previous commit.
+     */
+    int gg_prev_n_index;
+    /*
+     * The number of columns (also called "branch lines" in some places)
+     */
+    int gg_num_columns;
+    /*
+     * The number of columns in the new_columns array
+     */
+    int gg_num_new_columns;
+    /*
+     * The number of entries in the mapping array
+     */
+    int gg_mapping_size;
+    /*
+     * The column state before we output the current commit.
+     */
+    node_t gg_columns[];
+    /*
+     * The new column state after we output the current commit.
+     * Only valid when state is GRAPH_COLLAPSING.
+     */
+    node_t gg_new_columns[];
+    /*
+     * An array that tracks the current state of each
+     * character in the output line during state GRAPH_COLLAPSING.
+     * Each entry is -1 if this character is empty, or a non-negative
+     * integer if the character contains a branch line.  The value of
+     * the integer indicates the target position for this branch line.
+     * (I.e., this array maps the current column positions to their
+     * desired positions.)
+     *
+     * The maximum capacity of this array is always
+     * sizeof(int) * 2 * column_capacity.
+     */
+    int gg_mapping[];
+    /*
+     * A temporary array for computing the next mapping state
+     * while we are outputting a mapping line.  This is stored as part
+     * of the git_graph simply so we dont have to allocate a new
+     * temporary array each time we have to output a collapsing line.
+     */
+    int gg_new_mapping[];
+    /*
+     * The current default column color being used.  This is
+     * stored as an index into the array column_colors.
+     */
+    unsigned gg_default_column_color;
+
+    string gg_write_column(node_t n, string col_char)
+    {
+        return n.col_color + col_char + n.col_color_end;
+    }
+
+    void graph_set_current_column_color(node_t n)
+    {
+        if (!use_color) {
+            n.col_color     = "";
+            n.col_color_end = "";
+        } else {
+            n.col_color     = gg_column_colors[gg_default_column_color];
+            n.col_color_end = GIT_COLOR_RESET;
+        }
+    }
+
+    /*
+     * Update the graph's default column color.
+     */
+    void graph_increment_column_color(void)
+    {
+        gg_default_column_color = (gg_default_column_color + 1) %
+                COLUMN_COLORS_MAX;
+    }
+
+    void graph_set_commit_color(node_t n)
+    {
+        if (n.need_col_color == "yes")
+            graph_set_current_column_color(n);
+        n.need_col_color = "no";
+    }
+
+    int graph_insert_into_new_columns(node_t gg_iinc_n, int gg_iinc_mapping_index)
+    {
+        int gg_iinc_i;
+
+        /*
+         * If the commit is already in the new_columns list, we do not need to
+         * add it.  Just update the mapping correctly.
+         */
+        for (gg_iinc_i = 0; gg_iinc_i < gg_num_new_columns; gg_iinc_i++) {
+            if (gg_new_columns[gg_iinc_i] == gg_iinc_n) {
+                gg_mapping[gg_iinc_mapping_index] = gg_iinc_i;
+                return gg_iinc_mapping_index + 2;
+            }
+        }
+
+        /*
+         * This commit is not already in new_columns.  Add it.
+         */
+        gg_new_columns[gg_num_new_columns] = gg_iinc_n;
+        graph_set_commit_color(gg_iinc_n);
+        gg_mapping[gg_iinc_mapping_index] = gg_num_new_columns;
+        gg_num_new_columns++;
+
+        return gg_iinc_mapping_index + 2;
+    }
+
+    void graph_update_width(int is_commit_in_existing_columns)
+    {
+        /*
+         * Compute the width needed to display the graph for this commit.
+         * This is the maximum width needed for any row.  All other rows
+         * will be padded to this width.
+         *
+         * Compute the number of columns in the widest row:
+         * Count each existing column (gg_num_columns), and each new
+         * column added by this commit.
+         */
+        int gg_uw_max_cols = gg_num_columns + gg_num_parents;
+
+        /*
+         * Even if the current commit has no parents to be printed, it
+         * still takes up a column for itself.
+         */
+        if (gg_num_parents < 1)
+            gg_uw_max_cols++;
+
+        /*
+         * We added a column for the the current commit as part of
+         * gg_num_parents.  If the current commit was already in
+         * gg_columns, then we have double counted it.
+         */
+        if (is_commit_in_existing_columns)
+            gg_uw_max_cols--;
+
+        /*
+         * Each column takes up 2 spaces
+         */
+        gg_width = gg_uw_max_cols * 2;
+    }
+
+    void graph_update_columns(void)
+    {
+        edge_t gg_uc_e;
+        int gg_uc_mapping_idx;
+        int gg_uc_i, gg_uc_seen_this, is_commit_in_columns;
+
+        /*
+         * Swap gg_columns with gg_new_columns
+         * gg_columns contains the state for the previous commit,
+         * and new_columns now contains the state for our commit.
+         */
+        for (gg_uc_i = 0; gg_uc_i < gg_num_new_columns; gg_uc_i++)
+            gg_columns[gg_uc_i] = gg_new_columns[gg_uc_i];
+        gg_num_columns = gg_num_new_columns;
+        gg_num_new_columns = 0;
+
+        /*
+         * Clear out gg_mapping
+         */
+        gg_mapping_size = 2 * (gg_num_columns + gg_num_parents);
+        for (gg_uc_i = 0; gg_uc_i < gg_mapping_size; gg_uc_i++)
+            gg_mapping[gg_uc_i] = -1;
+
+        /*
+         * Populate gg_new_columns and gg_mapping
+         *
+         * Some of the parents of this commit may already be in
+         * gg_columns.  If so, gg_new_columns should only contain a
+         * single entry for each such commit.  gg_mapping should
+         * contain information about where each current branch line is
+         * supposed to end up after the collapsing is performed.
+         */
+        gg_uc_seen_this = 0;
+        gg_uc_mapping_idx = 0;
+        is_commit_in_columns = 1;
+        for (gg_uc_i = 0; gg_uc_i <= gg_num_columns; gg_uc_i++) {
+            node_t gg_uc_col_n;
+            if (gg_uc_i == gg_num_columns) {
+                if (gg_uc_seen_this)
+                    break;
+                is_commit_in_columns = 0;
+                gg_uc_col_n = gg_n;
+            } else {
+                gg_uc_col_n = gg_columns[gg_uc_i];
+            }
+
+            if (gg_uc_col_n == gg_n) {
+                int old_mapping_idx = gg_uc_mapping_idx;
+                gg_uc_seen_this = 1;
+                gg_n_index = gg_uc_i;
+                for (gg_uc_e = first_edge(gg_n); gg_uc_e; gg_uc_e = next_edge(gg_uc_e)) {
+                    /*
+                     * If this is a merge increment the current
+                     * color.
+                     */
+                    if (gg_num_parents > 1)
+                             graph_increment_column_color();
+                    
+                    gg_uc_mapping_idx = graph_insert_into_new_columns(
+                            adj_node(gg_uc_e), gg_uc_mapping_idx);
+                }
+                if (gg_uc_mapping_idx == old_mapping_idx)
+                    gg_uc_mapping_idx += 2;
+            } else {
+                gg_uc_mapping_idx = graph_insert_into_new_columns(gg_uc_col_n,
+                        gg_uc_mapping_idx);
+            }
+        }
+
+        /*
+         * Shrink mapping_size to be the minimum necessary
+         */
+        while (gg_mapping_size > 1 &&
+               gg_mapping[gg_mapping_size - 1] < 0)
+            gg_mapping_size--;
+
+        /*
+         * Compute gg_width for this commit
+         */
+        graph_update_width(is_commit_in_columns);
+    }
+
+    void graph_update_state(int gg_us_s)
+    {
+        gg_prev_state = gg_state;
+        gg_state = gg_us_s;
+    }
+
+    void graph_update(node_t n) {
+        gg_n = n;
+        gg_num_parents = node_num_parents(n);
+        gg_prev_n_index = gg_n_index;
+        graph_update_columns();
+        gg_expansion_row = 0;
+        if (gg_state != GRAPH_PADDING)
+            gg_state = GRAPH_SKIP;
+        else if (gg_num_parents >= 3 &&
+                 gg_n_index < (gg_num_columns - 1))
+            gg_state = GRAPH_PRE_COMMIT;
+        else
+            gg_state = GRAPH_COMMIT;
+    }
+
+    string graph_pad_horizontally(int chars_written)
+    {
+        int gg_ph_extra, gg_ph_i;
+        string gg_ph_sb = "";
+
+        if (chars_written >= gg_width)
+            return gg_ph_sb;
+
+        gg_ph_extra = gg_width - chars_written;
+        for (gg_ph_i = 0; gg_ph_i < gg_ph_extra; gg_ph_i++)
+            gg_ph_sb += " ";
+
+        return gg_ph_sb;
+    }
+
+    string graph_output_padding_line(void)
+    {
+        int gg_opl_i;
+        string gg_opl_sb = "";
+
+        for (gg_opl_i = 0; gg_opl_i < gg_num_new_columns; gg_opl_i++) {
+            gg_opl_sb += gg_write_column(gg_new_columns[gg_opl_i], "|");
+            gg_opl_sb += " ";
+        }
+
+        gg_opl_sb += graph_pad_horizontally(gg_num_new_columns * 2);
+
+        return gg_opl_sb;
+    }
+
+    string graph_output_skip_line(void)
+    {
+        string gg_osl_sb = "";
+        /*
+         * Output an ellipsis to indicate that a portion
+         * of the graph is missing.
+         */
+        gg_osl_sb += "...";
+        gg_osl_sb += graph_pad_horizontally(3);
+
+        if (gg_num_parents >= 3 && gg_n_index < (gg_num_columns - 1))
+            graph_update_state(GRAPH_PRE_COMMIT);
+        else
+            graph_update_state(GRAPH_COMMIT);
+
+        return gg_osl_sb;
+    }
+
+    string graph_output_pre_commit_line(void)
+    {
+        int gg_opcl_num_expansion_rows;
+        int gg_opcl_i, gg_opcl_j, gg_opcl_seen_this;
+        int gg_opcl_chars_written;
+        string gg_opcl_sb = "";
+
+        /*
+         * This function formats a row that increases the space around a commit
+         * with multiple parents, to make room for it.  It should only be
+         * called when there are 3 or more parents.
+         *
+         * We need 2 extra rows for every parent over 2.
+         */
+        if (!(gg_num_parents >= 3))
+            exit(1);
+        gg_opcl_num_expansion_rows = (gg_num_parents - 2) * 2;
+
+        /*
+         * gg_expansion_row tracks the current expansion row we are on.
+         * It should be in the range [0, gg_opcl_num_expansion_rows - 1]
+         */
+        if (!(0 <= gg_expansion_row &&
+               gg_expansion_row < gg_opcl_num_expansion_rows))
+            exit(1);
+
+        /*
+         * Output the row
+         */
+        gg_opcl_seen_this = 0;
+        gg_opcl_chars_written = 0;
+        for (gg_opcl_i = 0; gg_opcl_i < gg_num_columns; gg_opcl_i++) {
+            if (gg_columns[gg_opcl_i] == gg_n) {
+                gg_opcl_seen_this = 1;
+                gg_opcl_sb += gg_write_column(gg_columns[gg_opcl_i], "|");
+                for (gg_opcl_j = 0; gg_opcl_j < gg_expansion_row; gg_opcl_j++)
+                    gg_opcl_sb += " ";
+                gg_opcl_chars_written += 1 + gg_expansion_row;
+            } else if (gg_opcl_seen_this && (gg_expansion_row == 0)) {
+                /*
+                 * This is the first line of the pre-commit output.
+                 * If the previous commit was a merge commit and
+                 * ended in the GRAPH_POST_MERGE state, all branch
+                 * lines after gg_prev_commit_index were
+                 * printed as "\" on the previous line.  Continue
+                 * to print them as "\" on this line.  Otherwise,
+                 * print the branch lines as "|".
+                 */
+                if (gg_prev_state == GRAPH_POST_MERGE &&
+                    gg_prev_commit_index < gg_opcl_i)
+                    gg_opcl_sb += gg_write_column(gg_columns[gg_opcl_i], "\\");
+                else
+                    gg_opcl_sb += gg_write_column(gg_columns[gg_opcl_i], "|");
+                gg_opcl_chars_written++;
+            } else if (gg_opcl_seen_this && (gg_expansion_row > 0)) {
+                gg_opcl_sb += gg_write_column(gg_columns[gg_opcl_i], "\\");
+                gg_opcl_chars_written++;
+            } else {
+                gg_opcl_sb += gg_write_column(gg_columns[gg_opcl_i], "|");
+                gg_opcl_chars_written++;
+            }
+            gg_opcl_sb += " ";
+            gg_opcl_chars_written++;
+        }
+
+        gg_opcl_sb += graph_pad_horizontally(gg_opcl_chars_written);
+
+        /*
+         * Increment gg_expansion_row,
+         * and move to state GRAPH_COMMIT if necessary
+         */
+        gg_expansion_row++;
+        if (gg_expansion_row >= gg_opcl_num_expansion_rows)
+            graph_update_state(GRAPH_COMMIT);
+
+        return gg_opcl_sb;
+    }
+
+    /*
+     * Here dashless_commits represents the number of parents
+     * which do not need to have dashes (because their edges fit
+     * neatly under the commit).
+     */
+    int gg_dom_dashless_commits = 2;
+    int graph_draw_octopus_merge_width(void)
+    {
+        return ((gg_num_parents - gg_dom_dashless_commits) * 2);
+    }
+
+    string graph_draw_octopus_merge(void)
+    {
+        int gg_dom_i;
+        int gg_dom_col_num;
+        string gg_dom_sb = "";
+        int gg_dom_num_dashes = graph_draw_octopus_merge_width() - 1;
+
+        for (gg_dom_i = 0; gg_dom_i < gg_dom_num_dashes; gg_dom_i++) {
+            gg_dom_col_num = (gg_dom_i / 2) + gg_dom_dashless_commits;
+            gg_dom_sb += gg_write_column(gg_new_columns[gg_dom_col_num], "-");
+        }
+        gg_dom_col_num = (gg_dom_i / 2) + gg_dom_dashless_commits;
+        gg_dom_sb += gg_write_column(gg_new_columns[gg_dom_col_num], ".");
+
+        return gg_dom_sb;
+    }
+
+    int graph_is_mapping_correct(void)
+    {
+        int gg_imc_i;
+
+        /*
+         * The mapping is up to date if each entry is at its target,
+         * or is 1 greater than its target.
+         * (If it is 1 greater than the target, '/' will be printed, so it
+         * will look correct on the next row.)
+         */
+        for (gg_imc_i = 0; gg_imc_i < gg_mapping_size; gg_imc_i++) {
+            int gg_imc_target = gg_mapping[gg_imc_i];
+            if (gg_imc_target < 0)
+                continue;
+            if (gg_imc_target == (gg_imc_i / 2))
+                continue;
+            return 0;
+        }
+
+        return 1;
+    }
+
+    string graph_output_commit_line(void)
+    {
+        int gg_ocl_seen_this = 0;
+        int gg_ocl_i, gg_ocl_chars_written;
+        string gg_ocl_sb = "";
+
+        /*
+         * Output the row containing this commit
+         * Iterate up to and including gg_num_columns,
+         * since the current commit may not be in any of the existing
+         * columns.  (This happens when the current commit does not have any
+         * children that we have already processed.)
+         */
+        gg_ocl_seen_this = 0;
+        gg_ocl_chars_written = 0;
+        for (gg_ocl_i = 0; gg_ocl_i <= gg_num_columns; gg_ocl_i++) {
+            node_t gg_ocl_n;
+            if (gg_ocl_i == gg_num_columns) {
+                if (gg_ocl_seen_this)
+                    break;
+                gg_ocl_n = gg_n;
+            } else {
+                gg_ocl_n = gg_columns[gg_ocl_i];
+            }
+
+            if (gg_ocl_n == gg_n) {
+                gg_ocl_seen_this = 1;
+                gg_ocl_sb += "*";
+                gg_ocl_chars_written++;
+
+                if (gg_num_parents > 2) {
+                    gg_ocl_sb            += graph_draw_octopus_merge();
+                    gg_ocl_chars_written += graph_draw_octopus_merge_width();
+                }
+            } else if (gg_ocl_seen_this && (gg_num_parents > 2)) {
+                gg_ocl_sb += gg_write_column(gg_columns[gg_ocl_i], "\\");
+                gg_ocl_chars_written++;
+            } else if (gg_ocl_seen_this && (gg_num_parents == 2)) {
+                /*
+                 * This is a 2-way merge commit.
+                 * There is no GRAPH_PRE_COMMIT stage for 2-way
+                 * merges, so this is the first line of output
+                 * for this commit.  Check to see what the previous
+                 * line of output was.
+                 */
+                if (gg_prev_state == GRAPH_POST_MERGE &&
+                    gg_prev_n_index < gg_ocl_i)
+                    gg_ocl_sb += gg_write_column(gg_columns[gg_ocl_i], "\\");
+                else
+                    gg_ocl_sb += gg_write_column(gg_columns[gg_ocl_i], "|");
+                gg_ocl_chars_written++;
+            } else {
+                gg_ocl_sb += gg_write_column(gg_columns[gg_ocl_i], "|");
+                gg_ocl_chars_written++;
+            }
+            gg_ocl_sb += " ";
+            gg_ocl_chars_written++;
+        }
+
+        gg_ocl_sb += graph_pad_horizontally(gg_ocl_chars_written);
+
+        /*
+         * Update gg_state
+         */
+        if (gg_num_parents > 1)
+            graph_update_state(GRAPH_POST_MERGE);
+        else if (graph_is_mapping_correct())
+            graph_update_state(GRAPH_PADDING);
+        else
+            graph_update_state(GRAPH_COLLAPSING);
+
+        return gg_ocl_sb;
+    }
+
+    node_t find_new_column_by_commit(node_t n)
+    {
+        int gg_fnc_i;
+
+        for (gg_fnc_i = 0; gg_fnc_i < gg_num_new_columns; gg_fnc_i++) {
+            if (gg_new_columns[gg_fnc_i] == n)
+                return gg_new_columns[gg_fnc_i];
+        }
+
+        return NULL;
+    }
+
+    string graph_output_post_merge_line(void)
+    {
+        int gg_opml_seen_this = 0;
+        int gg_opml_i, gg_opml_j, gg_opml_chars_written;
+        string gg_opml_sb = "";
+
+        /*
+         * Output the post-merge row
+         */
+        gg_opml_chars_written = 0;
+        for (gg_opml_i = 0; gg_opml_i <= gg_num_columns; gg_opml_i++) {
+            node_t gg_opml_col_n;
+            if (gg_opml_i == gg_num_columns) {
+                if (gg_opml_seen_this)
+                    break;
+                gg_opml_col_n = gg_n;
+            } else {
+                gg_opml_col_n = gg_columns[gg_opml_i];
+            }
+
+            if (gg_opml_col_n == gg_n) {
+                edge_t gg_opml_edge;
+                node_t gg_opml_par_column;
+                /*
+                 * Since the current commit is a merge find
+                 * the columns for the parent commits in
+                 * new_columns and use those to format the
+                 * edges.
+                 */
+                gg_opml_seen_this = 1;
+
+                gg_opml_edge = first_edge(gg_n);
+                gg_opml_par_column = adj_node(gg_opml_edge);
+
+                gg_opml_sb += gg_write_column(gg_opml_par_column, "|");
+                gg_opml_chars_written++;
+                for (gg_opml_j = 0; gg_opml_j < gg_num_parents - 1; gg_opml_j++) {
+                    gg_opml_edge = next_edge(gg_opml_edge);
+                    gg_opml_par_column = adj_node(gg_opml_edge);
+                    gg_opml_sb += gg_write_column(gg_opml_par_column, "\\");
+                    gg_opml_sb += " ";
+                }
+                gg_opml_chars_written += gg_opml_j * 2;
+
+            } else if (gg_opml_seen_this) {
+                gg_opml_sb += gg_write_column(gg_columns[gg_opml_i], "\\");
+                gg_opml_sb += " ";
+                gg_opml_chars_written += 2;
+
+            } else {
+                gg_opml_sb += gg_write_column(gg_columns[gg_opml_i], "|");
+                gg_opml_sb += " ";
+                gg_opml_chars_written += 2;
+            }
+        }
+
+        gg_opml_sb += graph_pad_horizontally(gg_opml_chars_written);
+
+        /*
+         * Update gg_state
+         */
+        if (graph_is_mapping_correct())
+            graph_update_state(GRAPH_PADDING);
+        else
+            graph_update_state(GRAPH_COLLAPSING);
+
+        return gg_opml_sb;
+    }
+
+    string graph_output_collapsing_line(void)
+    {
+        int gg_oCl_i;
+        int gg_oCl_target;
+        int gg_oCl_used_horizontal = 0;
+        int gg_oCl_horizontal_edge = -1;
+        int gg_oCl_horizontal_edge_target = -1;
+        string gg_oCl_sb = "";
+ 
+        /*
+         * Clear out the new_mapping array
+         */
+        for (gg_oCl_i = 0; gg_oCl_i < gg_mapping_size; gg_oCl_i++)
+            gg_new_mapping[gg_oCl_i] = -1;
+
+        for (gg_oCl_i = 0; gg_oCl_i < gg_mapping_size; gg_oCl_i++) {
+            gg_oCl_target = gg_mapping[gg_oCl_i];
+            if (gg_oCl_target < 0)
+                continue;
+
+            /*
+             * Since update_columns() always inserts the leftmost
+             * column first, each branch's target location should
+             * always be either its current location or to the left of
+             * its current location.
+             *
+             * We never have to move branches to the right.  This makes
+             * the graph much more legible, since whenever branches
+             * cross, only one is moving directions.
+             */
+            if (!(gg_oCl_target * 2 <= gg_oCl_i))
+                exit(1);
+
+            if (gg_oCl_target * 2 == gg_oCl_i) {
+                /*
+                 * This column is already in the
+                 * correct place
+                 */
+                if (!(gg_new_mapping[gg_oCl_i] == -1))
+                    exit(1);
+                gg_new_mapping[gg_oCl_i] = gg_oCl_target;
+            } else if (gg_new_mapping[gg_oCl_i - 1] < 0) {
+                /*
+                 * Nothing is to the left.
+                 * Move to the left by one
+                 */
+                gg_new_mapping[gg_oCl_i - 1] = gg_oCl_target;
+                /*
+                 * If there isn't already an edge moving horizontally
+                 * select this one.
+                 */
+                if (gg_oCl_horizontal_edge == -1) {
+                        int gg_oCl_j;
+                        gg_oCl_horizontal_edge = gg_oCl_i;
+                        gg_oCl_horizontal_edge_target = gg_oCl_target;
+                        /*
+                         * The variable target is the index of the graph
+                         * column, and therefore target*2+3 is the
+                         * actual screen column of the first horizontal
+                         * line.
+                         */
+                        for (gg_oCl_j = (gg_oCl_target * 2) + 3;
+                             gg_oCl_j < (gg_oCl_i - 2);
+                             gg_oCl_j += 2)
+                                gg_new_mapping[gg_oCl_j] = gg_oCl_target;
+                }
+            } else if (gg_new_mapping[gg_oCl_i - 1] == gg_oCl_target) {
+                /*
+                 * There is a branch line to our left
+                 * already, and it is our target.  We
+                 * combine with this line, since we share
+                 * the same parent commit.
+                 *
+                 * We don't have to add anything to the
+                 * output or new_mapping, since the
+                 * existing branch line has already taken
+                 * care of it.
+                 */
+            } else {
+                /*
+                 * There is a branch line to our left,
+                 * but it isn't our target.  We need to
+                 * cross over it.
+                 *
+                 * The space just to the left of this
+                 * branch should always be empty.
+                 *
+                 * The branch to the left of that space
+                 * should be our eventual target.
+                 */
+                if (!(gg_new_mapping[gg_oCl_i - 1] > gg_oCl_target))
+                    exit(1);
+                if (!(gg_new_mapping[gg_oCl_i - 2] < 0))
+                    exit(1);
+                if (!(gg_new_mapping[gg_oCl_i - 3] == gg_oCl_target))
+                    exit(1);
+                gg_new_mapping[gg_oCl_i - 2] = gg_oCl_target;
+                /*
+                 * Mark this branch as the horizontal edge to
+                 * prevent any other edges from moving
+                 * horizontally.
+                 */
+                if (gg_oCl_horizontal_edge == -1)
+                    gg_oCl_horizontal_edge = gg_oCl_i;
+            }
+        }
+
+        /*
+         * The new mapping may be 1 smaller than the old mapping
+         */
+        if (gg_new_mapping[gg_mapping_size - 1] < 0)
+            gg_mapping_size--;
+
+        /*
+         * Output out a line based on the new mapping info
+         */
+        for (gg_oCl_i = 0; gg_oCl_i < gg_mapping_size; gg_oCl_i++) {
+            gg_oCl_target = gg_new_mapping[gg_oCl_i];
+            if (gg_oCl_target < 0)
+                gg_oCl_sb += " ";
+            else if (gg_oCl_target * 2 == gg_oCl_i)
+                gg_oCl_sb += gg_write_column(gg_new_columns[gg_oCl_target], "|");
+            else if (gg_oCl_target == gg_oCl_horizontal_edge_target &&
+                     gg_oCl_i != gg_oCl_horizontal_edge - 1) {
+                /*
+                 * Set the mappings for all but the
+                 * first segment to -1 so that they
+                 * won't continue into the next line.
+                 */
+                if (gg_oCl_i != (gg_oCl_target * 2) + 3)
+                        gg_new_mapping[gg_oCl_i] = -1;
+                gg_oCl_used_horizontal = 1;
+                gg_oCl_sb += gg_write_column(gg_new_columns[gg_oCl_target], "_");
+            } else {
+                if (gg_oCl_used_horizontal && gg_oCl_i < gg_oCl_horizontal_edge)
+                        gg_new_mapping[gg_oCl_i] = -1;
+                gg_oCl_sb += gg_write_column(gg_new_columns[gg_oCl_target], "/");
+            }
+        }
+
+        gg_oCl_sb += graph_pad_horizontally(gg_mapping_size);
+
+        /*
+         * Swap mapping and new_mapping
+         */
+        for (gg_oCl_i = 0; gg_oCl_i < gg_mapping_size; gg_oCl_i++) {
+            int gg_oCl_tmp = gg_mapping[gg_oCl_i];
+            gg_mapping[gg_oCl_i] = gg_new_mapping[gg_oCl_i];
+            gg_new_mapping[gg_oCl_i] = gg_oCl_tmp;
+        }
+
+        /*
+         * If gg_mapping indicates that all of the branch lines
+         * are already in the correct positions, we are done.
+         * Otherwise, we need to collapse some branch lines together.
+         */
+        if (graph_is_mapping_correct())
+            graph_update_state(GRAPH_PADDING);
+
+        return gg_oCl_sb;
+    }
+
+    int graph_next_line_is_commit(void)
+    {
+        int gg_nlic_ret = 0;
+
+        if (gg_state == GRAPH_COMMIT) {
+            gg_nlic_ret = 1;
+        }
+
+        return gg_nlic_ret;
+    }
+
+    string graph_next_line(void)
+    {
+        string gg_nl_ret = "";
+
+        if        (gg_state == GRAPH_PADDING) {
+            gg_nl_ret += graph_output_padding_line();
+        } else if (gg_state == GRAPH_SKIP) {
+            gg_nl_ret += graph_output_skip_line();
+        } else if (gg_state == GRAPH_PRE_COMMIT) {
+            gg_nl_ret += graph_output_pre_commit_line();
+        } else if (gg_state == GRAPH_COMMIT) {
+            gg_nl_ret += graph_output_commit_line();
+        } else if (gg_state == GRAPH_POST_MERGE) {
+            gg_nl_ret += graph_output_post_merge_line();
+        } else if (gg_state == GRAPH_COLLAPSING) {
+            gg_nl_ret += graph_output_collapsing_line();
+        }
+
+        return gg_nl_ret;
+    }
+
+}
+BEG_G {
+    node_t ts_empty_deg[];
+    int ts_head = 0, ts_tail = 0;
+    int ts_nedges = 0;
+    $tvtype = TV_ne;
+
+    gg_n = NULL;
+    gg_num_parents = 0;
+    gg_width = 0;
+    gg_expansion_row = 0;
+    gg_state = GRAPH_PADDING;
+    gg_prev_state = GRAPH_PADDING;
+    gg_n_index = 0;
+    gg_prev_n_index = 0;
+    gg_num_columns = 0;
+    gg_num_new_columns = 0;
+    gg_mapping_size = 0;
+    gg_default_column_color = 0;
+}
+N {
+    $.ts_deg = node_deg($);
+    if ($.ts_deg == 0)  {
+        ts_empty_deg[ts_tail] = $;
+        ts_tail++;
+    }
+    $.need_col_color = "yes";
+}
+E {
+    $.ts_deleted = "false";
+}
+END_G {
+    while (use_stack ? ts_tail > 0 : ts_head < ts_tail) {
+        node_t n;
+        edge_t e;
+        int i;
+        int lines;
+
+        if (use_stack) {
+            n = ts_empty_deg[--ts_tail];
+        } else {
+            n = ts_empty_deg[ts_head];
+            ts_head++;
+        }
+
+        graph_update(n);
+
+        /* print lines till commit line */
+        while (gg_state != GRAPH_PADDING) {
+            if (graph_next_line_is_commit())
+                break;
+            printf("%s\n", graph_next_line());
+        }
+
+        /* print 'commit message'  */
+        if (use_color) {
+            printf("%s%s%s%s\n", graph_next_line(),
+                                 GIT_COLOR_YELLOW, n.name, GIT_COLOR_RESET);
+        } else {
+            printf("%s%s\n", graph_next_line(), n.name);
+        }
+
+        if (show_header && aget(n, "tg_header_lines")) {
+            lines = aget(n, "tg_header_lines");
+            for (i = 0; i < lines; i++) {
+                printf("%s%s\n", graph_next_line(), aget(n, sprintf("tg_header_%d", i)));
+            }
+            printf("%s\n", graph_next_line());
+        }
+
+        if (show_body && aget(n, "tg_body_lines")) {
+            lines = aget(n, "tg_body_lines");
+            for (i = 0; i < lines; i++) {
+                printf("%s    %s\n", graph_next_line(), aget(n, sprintf("tg_body_%d", i)));
+            }
+            printf("%s\n", graph_next_line());
+        }
+
+        /* print remaing graph lines */
+        while (gg_state != GRAPH_PADDING) {
+            printf("%s\n", graph_next_line());
+        }
+
+        for (e = first_edge(n); e; e = next_edge(e)) {
+            if (e.ts_deleted == "false") {
+                node_t d = adj_node(e);
+                d.ts_deg = (int)d.ts_deg - 1;
+
+                if (d.ts_deg == 0)  {
+                    ts_empty_deg[ts_tail] = d;
+                    ts_tail++;
+                }
+
+                e.ts_deleted = "true";
+            }
+        }
+    }
+}
diff --git a/tg-graph.sh b/tg-graph.sh
new file mode 100755
index 0000000..f997b28
--- /dev/null
+++ b/tg-graph.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+color=
+do_dfs=false
+do_bfs=false
+stack=
+reverse=
+header=
+body=
+
+summary_graphviz=--graphviz
+
+name=
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	--color)
+		color="color";;
+	--no-color)
+		color="no-color";;
+	--dfs)
+		do_dfs=true;;
+	--bfs)
+		do_bfs=true;;
+	--reverse)
+		reverse="reverse";;
+	--no-reverse)
+		reverse="no-reverse";;
+	--header)
+		header="header";;
+	--no-header)
+		header="no-header";;
+	--body)
+		body="body";;
+	--no-body)
+		body="no-body";;
+	-*)
+		echo "Usage: tg [...] graph [--color] [--bfs|--dfs] [--reverse] [--header] [--body] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] ||
+			die "branch already specified ($branch)"
+		name="$arg";;
+	esac
+done
+
+[ -z "$name" ] || git rev-parse --verify "$name" 2>/dev/null ||
+		die "invalid branch name: $name"
+
+[ -z "$name" ] || name="-X \"$name\""
+
+[ -r "@sharedir@"/graph.gvpr ] || 
+	die "Can't find graph.gvpr file in \`@sharedir@'"
+
+[ "$header" = "header" -o "$body" = "body" ] &&
+	summary_graphviz=--graphviz=verbose
+
+$do_dfs && $do_bfs &&
+	die "--bfs and --dfs options are mutual exclusive"
+$do_bfs && stack="no-stack"
+$do_dfs && stack="stack"
+
+type ccomps >/dev/null 2>&1 ||
+	die "need the ccomps(1) tool from the graphviz package"
+type gvpr >/dev/null 2>&1 ||
+	die "need the gvpr(1) tool from the graphviz package"
+
+setup_pager
+
+$tg summary $summary_graphviz |
+	ccomps -x $name |
+	gvpr -a "$color $stack $reverse $header $body" \
+	     -f "@sharedir@"/graph.gvpr
diff --git a/tg-summary.sh b/tg-summary.sh
index 50ee883..ed6fda2 100644
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -5,7 +5,7 @@
 
 terse=
 graphviz=
-
+graphviz_verbose=
 
 ## Parse options
 
@@ -16,6 +16,9 @@ while [ -n "$1" ]; do
 		terse=1;;
 	--graphviz)
 		graphviz=1;;
+	--graphviz=verbose)
+		graphviz=1
+		graphviz_verbose=1;;
 	*)
 		echo "Usage: tg [...] summary [-t | --graphviz]" >&2
 		exit 1;;
@@ -36,13 +39,13 @@ if [ -n "$graphviz" ]; then
 
 digraph G {
 
-graph [
-  rankdir = "TB"
-  label="TopGit Layout\n\n\n"
-  fontsize = 14
-  labelloc=top
-  pad = "0.5,0.5"
-];
+	graph [
+		rankdir = "TB"
+		label="TopGit Layout\n\n\n"
+		fontsize = 14
+		labelloc=top
+		pad = "0.5,0.5"
+	];
 
 EOT
 fi
@@ -50,6 +53,11 @@ fi
 
 ## List branches
 
+if [ -n "$graphviz_verbose" ]; then
+	tmpmsg="$(mktemp -t tg-summary.XXXXXX)"
+	trap 'rm -f "$tmpmsg"' 0
+fi
+
 git for-each-ref refs/top-bases |
 	while read rev type ref; do
 		name="${ref#refs/top-bases/}"
@@ -62,12 +70,33 @@ git for-each-ref refs/top-bases |
 			continue
 		fi
 		if [ -n "$graphviz" ]; then
+
+			if [ -n "$graphviz_verbose" ]; then
+				type="header"
+				lines=0
+				echo "\t\"$name\" ["
+				git cat-file blob "$name:.topmsg" > "$tmpmsg"
+				while read line; do
+					l="$(echo "$line" | sed -e 's/"/\\"/g')"
+					[ -z "$line" -a "$type" = "header" ] && {
+						type="body"
+						echo "\t\ttg_header_lines = \"$lines\""
+						lines=0
+						continue
+					}
+					echo "\t\ttg_${type}_${lines} = \"$l\""
+					lines=`expr $lines + 1`
+				done < "$tmpmsg"
+				echo "\t\ttg_body_lines = \"$lines\""
+				echo "\t]"
+			fi
+
 			git cat-file blob "$name:.topdeps" | while read dep; do
 				dep_is_tgish=true
 				ref_exists "refs/top-bases/$dep"  ||
 					dep_is_tgish=false
 				if ! "$dep_is_tgish" || ! branch_annihilated $dep; then
-					echo "\"$name\" -> \"$dep\";"
+					echo "\t\"$name\" -> \"$dep\";"
 				fi
 			done
 			continue
-- 
tg: (9f685cd..) bw/graph (depends on: master)
