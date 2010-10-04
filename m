From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v4 4/4] tg-graph: print dependency graph like git log --graph
Date: Tue,  5 Oct 2010 00:28:20 +0200
Message-ID: <1286231300-29268-4-git-send-email-bert.wesarg@googlemail.com>
References: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
 <1286231300-29268-2-git-send-email-bert.wesarg@googlemail.com>
 <1286231300-29268-3-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tWk-0000W6-1m
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab0JDW2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:28:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58423 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab0JDW2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:28:35 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4091341bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=r8olRSgLhFpsL6JrtHP8IRtAQ93Q7RY2SPAACeC2WKU=;
        b=JsYoqgHdIU021tjJh6Qc0ngjCwLPXzUEi6j/qNOyhQzT2hx8Ao7OaD27oJGRBwmyQX
         FrF8ZfP1+IcwteK7z3UKPHik+saOOjX7HEg+UwGZ2OUKp7W9jkMYyGNcetODDNdFQRLW
         8kllXEGF6AkZ7qRwiFkj87AavwZGq1q0QRoxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JeoPmceU7ryeyOY3Z7NBIu6MCjcfhXt0L35xHWIgAwzkBqiQVJichg6kap9ByyI5ge
         i0ZAzlufQXwGjGM+2TfYdaWQVCl8FNbVeNZ1cwOzGeht6kn5DJv6iXc1T1yoJ0mb1oAG
         DlAil4bknratapAkIJvu17yhtV+IcydRtPQRM=
Received: by 10.204.121.84 with SMTP id g20mr7724116bkr.37.1286231314630;
        Mon, 04 Oct 2010 15:28:34 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id y19sm4252721bkw.18.2010.10.04.15.28.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:28:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286231300-29268-3-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158133>

Just want to send it out again. I'm not pushing this for 0.9.

The graph engine comes from the git projects graph.c file, which was written by
Adam Simpkins.

Thanks,
Bert

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Note the dependency on bw/tred is only historical, it depends only bw/fan-in-out.

ChangeLog:
 v4:
   * --fan-in and --fan-out option
   * --subject option
   * color tips dep chain on other color

 v3:
   * option to ignore tip-topics

 v2:
   * fix rename bug which caused random segfaults in gvpr
   * add --decorate option, to print horizontal line from graph node to patch
     name (like gitk do it for commits with tags or branch decorations)
   * in dfs mode we should maintain the order given by the input
   * make dfs mode the default

 .gitignore                 |    2 +
 Makefile                   |    1 +
 README                     |    7 +
 contrib/tg-completion.bash |   37 ++
 share/graph.gvpr           | 1100 ++++++++++++++++++++++++++++++++++++++++++++
 tg-graph.sh                |  108 +++++
 tg-summary.sh              |   37 ++-
 tg.sh                      |   64 +++-
 8 files changed, 1344 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 290cfdc..b79ab0e 100644 .gitignore
--- a/.gitignore
+++ b/.gitignore
@@ -22,6 +22,8 @@
 /tg-depend.txt
 /tg-export
 /tg-export.txt
+/tg-graph
+/tg-graph.txt
 /tg-import
 /tg-import.txt
 /tg-info
diff --git a/Makefile b/Makefile
index 3ce39a5..0de1277 100644 Makefile
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
index 4f49015..3ba8c35 100644 README
--- a/README
+++ b/README
@@ -566,6 +566,13 @@ tg tred
 	TODO: tg tred -r for reducing recursive all from the current/named
 	      branch
 
+tg graph
+~~~~~~~~
+	Prints the dependency graph like git log --graph to the console.
+
+	TODO: document options
+	TODO: -i/-w options
+
 TODO: tg rename
 
 
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 026b9fd..d8e3e02 100755 contrib/tg-completion.bash
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -313,6 +313,38 @@ _tg_export ()
 	esac
 }
 
+_tg_graph ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+
+	case "$cur" in
+	-*)
+		__tgcomp "
+			--fan-out
+			--fan-in
+			--color
+			--no-color
+			--bfs
+			--dfs
+			--reverse
+			--no-reverse
+			--subject
+			--no-subject
+			--header
+			--no-header
+			--body
+			--no-body
+			--decorate
+			--no-decorate
+			--ignore-tips
+			--no-ignore-tips
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
@@ -434,9 +466,13 @@ _tg_summary ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
 	case "$cur" in
+	--graphviz=*)
+		__tgcomp "verbose" "" "${cur##--graphviz=}"
+		;;
 	*)
 		__tgcomp "
 			--graphviz
+			--graphviz=
 			-t
 		"
 	esac
@@ -509,6 +545,7 @@ _tg ()
 	delete)      _tg_delete ;;
 	depend)      _tg_depend ;;
 	export)      _tg_export ;;
+	graph)       _tg_graph ;;
 	help)        _tg_help ;;
 	import)      _tg_import ;;
 	info)        _tg_info ;;
diff --git a/share/graph.gvpr b/share/graph.gvpr
new file mode 100755
index 0000000..457ff0b share/graph.gvpr
--- /dev/null
+++ b/share/graph.gvpr
@@ -0,0 +1,1100 @@
+BEGIN {
+    int use_stack = 1;
+    int use_color = 1;
+    int rev_order = 0;
+    int use_subject = 0;
+    int show_header = 0;
+    int show_body = 0;
+    int point_at_node = 0;
+    int ignore_tips = 0;
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
+        else if (ARGV[argi] == "subject")
+            use_subject = 1;
+        else if (ARGV[argi] == "no-subject")
+            use_subject = 0;
+        else if (ARGV[argi] == "header")
+            show_header = 1;
+        else if (ARGV[argi] == "no-header")
+            show_header = 0;
+        else if (ARGV[argi] == "body")
+            show_body = 1;
+        else if (ARGV[argi] == "no-body")
+            show_body = 0;
+        else if (ARGV[argi] == "pointer")
+            point_at_node = 1;
+        else if (ARGV[argi] == "no-pointer")
+            point_at_node = 0;
+        else if (ARGV[argi] == "ignore-tips")
+            ignore_tips = 1;
+        else if (ARGV[argi] == "no-ignore-tips")
+            ignore_tips = 0;
+    }
+
+    edge_t first_edge(node_t fe_n)
+    {
+        edge_t fe;
+
+        if (!rev_order) {
+            fe = fstout(fe_n);
+        } else {
+            fe = fstin(fe_n);
+        }
+
+        return fe;
+    }
+
+    edge_t next_edge(edge_t ne_e)
+    {
+        edge_t ne;
+
+        if (!rev_order) {
+            ne = nxtout(ne_e);
+        } else {
+            ne = nxtin(ne_e);
+        }
+
+        return ne;
+    }
+
+    node_t adj_node(edge_t an_e)
+    {
+        node_t an;
+
+        if (!rev_order) {
+            an = an_e.head;
+        } else {
+            an = an_e.tail;
+        }
+
+        return an;
+    }
+
+    int node_deg(node_t nd_n)
+    {
+        int nd;
+
+        if (!rev_order) {
+            nd = nd_n.indegree;
+        } else {
+            nd = nd_n.outdegree;
+        }
+
+        return nd;
+    }
+
+    int node_num_parents(node_t nnp_n)
+    {
+        int nnp;
+
+        if (!rev_order) {
+            nnp = nnp_n.outdegree;
+        } else {
+            nnp = nnp_n.indegree;
+        }
+
+        return nnp;
+    }
+
+    void assert(int assert_a) {
+        if (!assert_a)
+            exit(1);
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
+    string gg_write_column(node_t gg_wc_n, string gg_wc_col_char)
+    {
+        assert(gg_wc_n);
+        return gg_wc_n.col_color + gg_wc_col_char + gg_wc_n.col_color_end;
+    }
+
+    void graph_set_current_column_color(node_t gg_ccc_n)
+    {
+        if (!use_color) {
+            gg_ccc_n.col_color     = "";
+            gg_ccc_n.col_color_end = "";
+        } else {
+            gg_ccc_n.col_color     = gg_column_colors[gg_default_column_color];
+            gg_ccc_n.col_color_end = GIT_COLOR_RESET;
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
+    void graph_set_commit_color(node_t gg_scc_n)
+    {
+        if (gg_scc_n.need_col_color == "yes")
+            graph_set_current_column_color(gg_scc_n);
+        gg_scc_n.need_col_color = "no";
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
+    void graph_update_width(int gg_uw_is_commit_in_existing_columns)
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
+        if (gg_uw_is_commit_in_existing_columns)
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
+        int gg_uc_i, gg_uc_seen_this, gg_uc_is_commit_in_columns;
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
+        gg_uc_is_commit_in_columns = 1;
+        for (gg_uc_i = 0; gg_uc_i <= gg_num_columns; gg_uc_i++) {
+            node_t gg_uc_col_n;
+
+            if (gg_uc_i == gg_num_columns) {
+                if (gg_uc_seen_this)
+                    break;
+                gg_uc_is_commit_in_columns = 0;
+                gg_uc_col_n = gg_n;
+            } else {
+                gg_uc_col_n = gg_columns[gg_uc_i];
+            }
+
+            if (gg_uc_col_n == gg_n) {
+                int gg_uc_old_mapping_idx = gg_uc_mapping_idx;
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
+                /*
+                 * We always need to increment mapping_idx by at
+                 * least 2, even if it has no interesting parents.
+                 * The current commit always takes up at least 2
+                 * spaces.
+                 */
+                if (gg_uc_mapping_idx == gg_uc_old_mapping_idx)
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
+        graph_update_width(gg_uc_is_commit_in_columns);
+    }
+
+    void graph_update_state(int gg_us_s)
+    {
+        gg_prev_state = gg_state;
+        gg_state = gg_us_s;
+    }
+
+    void graph_update(node_t gg_u_n) {
+        gg_n = gg_u_n;
+        gg_num_parents = node_num_parents(gg_u_n);
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
+    string graph_pad_horizontally(int gg_ph_chars_written)
+    {
+        int gg_ph_extra, gg_ph_i;
+        string gg_ph_sb = "";
+
+        if (gg_ph_chars_written >= gg_width)
+            return gg_ph_sb;
+
+        gg_ph_extra = gg_width - gg_ph_chars_written;
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
+        assert(gg_num_parents >= 3);
+        gg_opcl_num_expansion_rows = (gg_num_parents - 2) * 2;
+
+        /*
+         * gg_expansion_row tracks the current expansion row we are on.
+         * It should be in the range [0, gg_opcl_num_expansion_rows - 1]
+         */
+        assert(0 <= gg_expansion_row &&
+               gg_expansion_row < gg_opcl_num_expansion_rows);
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
+                    gg_prev_n_index < gg_opcl_i)
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
+
+            if (gg_ocl_i == gg_num_columns) {
+                if (gg_ocl_seen_this)
+                    break;
+                gg_ocl_n = gg_n;
+                gg_ocl_seen_this = 1;
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
+            if (point_at_node && gg_ocl_seen_this)
+                gg_ocl_sb += "-";
+            else
+                gg_ocl_sb += " ";
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
+
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
+            assert(gg_oCl_target * 2 <= gg_oCl_i);
+
+            if (gg_oCl_target * 2 == gg_oCl_i) {
+                /*
+                 * This column is already in the
+                 * correct place
+                 */
+                assert(gg_new_mapping[gg_oCl_i] == -1);
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
+                assert(gg_new_mapping[gg_oCl_i - 1] > gg_oCl_target);
+                assert(gg_new_mapping[gg_oCl_i - 2] < 0);
+                assert(gg_new_mapping[gg_oCl_i - 3] == gg_oCl_target);
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
+    $.tg_tip_deg = node_deg($);
+    if ((int)$.ts_deg == 0)  {
+        ts_empty_deg[ts_tail] = $;
+        ts_tail++;
+    }
+    $.need_col_color = "yes";
+    $.tg_in_tips = "";
+}
+E {
+    $.ts_deleted = "false";
+}
+END_G {
+    int i, j;
+    node_t switch_node;
+
+    /* reverse initial entries to maintain a somewhat stable order */
+    if (use_stack) {
+        i = 0;
+        j = ts_tail - 1;
+        while (i < j) {
+            switch_node = ts_empty_deg[i];
+            ts_empty_deg[i++]  = ts_empty_deg[j];
+            ts_empty_deg[j--]  = switch_node;
+        }
+    }
+
+    while (use_stack ? ts_tail > 0 : ts_head < ts_tail) {
+        string label;
+        node_t n;
+        edge_t e;
+        int lines;
+        int remove_tip_deps;
+
+        if (use_stack) {
+            n = ts_empty_deg[--ts_tail];
+        } else {
+            n = ts_empty_deg[ts_head];
+            ts_head++;
+        }
+
+        remove_tip_deps = 0;
+        if (ignore_tips && n.tg_tip_deg == 0 && aget(n, "tg_is_tip")) {
+            remove_tip_deps = 1;
+        }
+
+        if (use_stack)
+            i = ts_tail;
+
+        for (e = first_edge(n); e; e = next_edge(e)) {
+            if (e.ts_deleted == "false") {
+                node_t d = adj_node(e);
+
+                d.ts_deg = (int)d.ts_deg - 1;
+
+                if (remove_tip_deps) {
+                    label = n.name;
+                    if (aget(n, "label")) {
+                        label = aget(n, "label");
+                    }
+                    d.tg_tip_deg = (int)d.tg_tip_deg - 1;
+                    d.tg_in_tips = " <- " + label + n.tg_in_tips;
+                }
+
+                if ((int)d.ts_deg == 0)  {
+                    ts_empty_deg[ts_tail] = d;
+                    ts_tail++;
+                }
+
+                e.ts_deleted = "true";
+            }
+        }
+
+        /* reverse new entries to maintain a somewhat stable order */
+        if (use_stack) {
+            j = ts_tail - 1;
+            while (i < j) {
+                switch_node = ts_empty_deg[i];
+                ts_empty_deg[i++]  = ts_empty_deg[j];
+                ts_empty_deg[j--]  = switch_node;
+            }
+        }
+
+        if (remove_tip_deps)
+            continue;
+
+        graph_update(n);
+
+        /* print lines till commit line */
+        while (gg_state != GRAPH_COMMIT) {
+            printf("%s\n", graph_next_line());
+        }
+
+        /* print 'commit message'  */
+        label = n.name;
+        if (use_subject && aget(n, "tg_subject")) {
+            label = label + ": " + aget(n, "tg_subject");
+        } else if (aget(n, "label")) {
+            label = aget(n, "label");
+        }
+        if (use_color) {
+            printf("%s%s%s%s%s%s%s\n", graph_next_line(),
+                                 GIT_COLOR_YELLOW, label, GIT_COLOR_RESET,
+                                 GIT_COLOR_CYAN, n.tg_in_tips, GIT_COLOR_RESET);
+        } else {
+            printf("%s%s\n", graph_next_line(), label);
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
+        /* print remaining graph lines */
+        while (gg_state != GRAPH_PADDING) {
+            printf("%s\n", graph_next_line());
+        }
+    }
+}
diff --git a/tg-graph.sh b/tg-graph.sh
new file mode 100644
index 0000000..d013a6f tg-graph.sh
--- /dev/null
+++ b/tg-graph.sh
@@ -0,0 +1,108 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# (c) Petr Baudis <pasky@suse.cz>  2008
+# (c) Bert Wesarg <Bert.Wesarg@googlemail.com>  2009
+# GPLv2
+
+color=
+do_dfs=false
+do_bfs=false
+stack=
+reverse=
+subject=
+header=
+body=
+pointer=
+ignore_tips=
+graph_mode=full
+
+_graph_verbose=
+
+# a wrapper around tg summary --graphviz
+graph_full()
+{
+	local summary_graphviz=--graphviz
+	[ -z "$_graph_verbose" ] ||
+		summary_graphviz=--graphviz=verbose
+	$tg summary $summary_graphviz | ccomps -x
+}
+
+name=
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	--fan-out)
+		graph_mode=fan_out;;
+	--fan-in)
+		graph_mode=fan_in;;
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
+	--subject)
+		subject="subject";;
+	--no-subject)
+		subject="no-subject";;
+	--header)
+		header="header";;
+	--no-header)
+		header="no-header";;
+	--body)
+		body="body";;
+	--no-body)
+		body="no-body";;
+	--decorate)
+		pointer="pointer";;
+	--no-decorate)
+		pointer="no-pointer";;
+	--ignore-tips)
+		ignore_tips="ignore-tips";;
+	--no-ignore-tips)
+		ignore_tips="no-ignore-tips";;
+	-*)
+		echo >&2 "Usage: tg [...] graph [--color] [--bfs|--dfs] [--reverse] [--ignore-tips]"
+		echo >&2 "                      [--header] [--body] [--fan-out | --fan-in] [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] ||
+			die "branch already specified ($branch)"
+		name="$arg";;
+	esac
+done
+
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+
+[ -r "@sharedir@"/graph.gvpr ] || 
+	die "Can't find graph.gvpr file in \`@sharedir@'"
+
+[ "$subject$header$body$ignore_tips" != "no-subjectno-headerno-bodyno-ignore_tips" ] &&
+	_graph_verbose=1
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
+# disable color output if pager is not active
+[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
+	color="no-color"
+
+graph_$graph_mode "$name" |
+	gvpr -a "$color $stack $reverse $subject $header $body $pointer $ignore_tips" \
+	     -f "@sharedir@"/graph.gvpr
diff --git a/tg-summary.sh b/tg-summary.sh
index af16888..9650c8a 100644 tg-summary.sh
--- a/tg-summary.sh
+++ b/tg-summary.sh
@@ -7,7 +7,7 @@ terse=
 graphviz=
 sort=
 deps=
-
+graphviz_verbose=
 
 ## Parse options
 
@@ -18,6 +18,9 @@ while [ -n "$1" ]; do
 		terse=1;;
 	--graphviz)
 		graphviz=1;;
+	--graphviz=verbose)
+		graphviz=1
+		graphviz_verbose=1;;
 	--sort)
 		sort=1;;
 	--deps)
@@ -43,13 +46,13 @@ if [ -n "$graphviz" ]; then
 
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
@@ -121,8 +124,10 @@ git for-each-ref refs/top-bases |
 				if ! "$dep_is_tgish" || ! branch_annihilated $dep; then
 					if [ -n "$graphviz" ]; then
 						echo "\"$name\" -> \"$dep\";"
-						if [ "$name" = "$curname" ] || [ "$dep" = "$curname" ]; then
-							echo "\"$curname\" [style=filled,fillcolor=yellow];"
+						if [ -z "$graphviz_verbose" ]; then
+							if [ "$name" = "$curname" ] || [ "$dep" = "$curname" ]; then
+								echo "\"$curname\" [style=filled,fillcolor=yellow];"
+							fi
 						fi
 					else
 						echo "$name $dep" >&4
@@ -135,6 +140,18 @@ git for-each-ref refs/top-bases |
 	done
 
 if [ -n "$graphviz" ]; then
+	# for-each-ref gives us a sorting order
+	# thats why we put the node attributes after the edges
+	# to somewhat keep the implied order stabel
+	[ -n "$graphviz_verbose" ] && {
+		_graph_topmsg="$(mktemp -t tg-summary.XXXXXX)"
+		trap 'rm -f "$_graph_topmsg"' 0
+		git for-each-ref refs/top-bases |
+			while read rev type ref; do
+				name="${ref#refs/top-bases/}"
+				_graph_verbose=1 _graph_dep_branch "$name"
+			done
+	}
 	echo '}'
 fi
 
diff --git a/tg.sh b/tg.sh
index b85fdd7..460ca6c 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -418,17 +418,73 @@ traverse_fan_out()
 	done
 }
 
+# uses the global temp file in $_graph_topmsg
+_graph_dep_branch()
+{
+	local name=$1
+
+	[ -n "$_graph_verbose" ] ||
+		return 0
+
+	# don't travers non-tgish branches
+	ref_exists "refs/top-bases/$name" ||
+		return 0
+
+	printf "\t\"%s\" [\n" "$name"
+
+	local type="header"
+	local lines=0
+
+	# TODO: honor -i and -w options
+	git cat-file blob "$name:.topmsg" > "$_graph_topmsg"
+
+	if [ ! -s "$_graph_topmsg" ]; then
+		# short-cut if topic has empty .topmsg
+		printf "\t\ttg_is_tip = \"true\"\n"
+		printf "\t];\n"
+		return 0
+	fi
+
+	old_IFS="$IFS"
+	IFS=""
+	while read line; do
+		# escape double-quotes
+		l="$(echo "$line" | sed -e 's/"/\\"/g')"
+		[ -z "$line" -a "$type" = "header" ] && {
+			type="body"
+			printf "\t\ttg_header_lines = \"%s\"\n" "$lines"
+			lines=0
+			continue
+		}
+		printf "\t\ttg_%s_%s = \"%s\"\n" "$type" "$lines" "$l"
+		lines=`expr $lines + 1`
+	done < "$_graph_topmsg"
+	IFS="$old_IFS"
+
+	[ $lines -gt 0 ] &&
+		printf "\t\ttg_%s_lines = \"%s\"\n" "$type" "$lines"
+
+	# extract subject
+	sed -n -e 's/^Subject: \(.*\)$/		tg_subject = "\1"/g p' < "$_graph_topmsg"
+
+	printf "\t];\n"
+}
+
 _graph_dep_edge()
 {
 	printf "\t\"%s\" -> \"%s\";\n" "$1" "$2"
 }
 
 # prints the fan-out as a dot graph with edges
+# set $_graph_verbose to get verbose branch infos in node attributes
 graph_fan_out()
 {
 	printf "digraph G {\n"
 
-	traverse_fan_out : _graph_dep_edge "$1" $2
+	_graph_topmsg="$(mktemp -t tg-summary.XXXXXX)"
+	trap 'rm -f "$_graph_topmsg"' 0
+
+	traverse_fan_out _graph_dep_branch _graph_dep_edge "$1" $2
 
 	printf "}\n"
 }
@@ -506,11 +562,15 @@ traverse_fan_in()
 }
 
 # prints the fan-in as a dot graph with edges
+# set $_graph_verbose to get verbose branch infos in node attributes
 graph_fan_in()
 {
 	printf "digraph G {\n"
 
-	traverse_fan_in : _graph_dep_edge "$1" $2
+	_graph_topmsg="$(mktemp -t tg-summary.XXXXXX)"
+	trap 'rm -f "$_graph_topmsg"' 0
+
+	traverse_fan_in _graph_dep_branch _graph_dep_edge "$1" $2
 
 	printf "}\n"
 }
-- 
tg: (73b09ef..) bw/graph (depends on: bw/fix-echo_-e-in-dash bw/tred)
