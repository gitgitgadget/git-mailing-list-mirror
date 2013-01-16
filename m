From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v3 3/3] diff: Introduce --diff-algorithm command line option
Date: Wed, 16 Jan 2013 08:51:58 +0100
Message-ID: <9ab743d384a9de33a3410fac9ee3e74acf964700.1358322212.git.mprivozn@redhat.com>
References: <cover.1358322212.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 08:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvNnY-0006KG-MD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 08:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758677Ab3APHwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 02:52:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758660Ab3APHwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 02:52:15 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0G7q7Nq023936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 Jan 2013 02:52:07 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0G7pxJY019996;
	Wed, 16 Jan 2013 02:52:06 -0500
In-Reply-To: <cover.1358322212.git.mprivozn@redhat.com>
In-Reply-To: <cover.1358322212.git.mprivozn@redhat.com>
References: <cover.1358322212.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213733>

Since command line options have higher priority than config file
variables and taking previous commit into account, we need a way
how to specify myers algorithm on command line. However,
inventing `--myers` is not the right answer. We need far more
general option, and that is `--diff-algorithm`.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 Documentation/diff-options.txt         | 21 +++++++++++++++++++++
 contrib/completion/git-completion.bash | 11 +++++++++++
 diff.c                                 | 12 +++++++++++-
 diff.h                                 |  2 ++
 merge-recursive.c                      |  9 +++++++++
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 39f2c50..6f11c34 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -55,6 +55,27 @@ endif::git-format-patch[]
 --histogram::
 	Generate a diff using the "histogram diff" algorithm.
 
+--diff-algorithm={patience|minimal|histogram|myers}::
+	Choose a diff algorithm. The variants are as follows:
++
+--
+`default`, `myers`;;
+	The basic greedy diff algorithm. Currently, this happens to be
+	the default algorithm as well.
+`minimal`;;
+	Spend extra time to make sure the smallest possible diff is
+	produced.
+`patience`;;
+	Use "patience diff" algorithm when generating patches.
+`histogram`;;
+	This algorithm extends the patience algorithm to "support
+	low-occurrence common elements".
+--
++
+For instance, if you configured diff.algorithm variable to a
+non-default value and want to use the default one, then you
+have to use `--diff-algorithm=default` option.
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 33e25dc..d592cf9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1021,6 +1021,8 @@ _git_describe ()
 	__gitcomp_nl "$(__git_refs)"
 }
 
+__git_diff_algorithms="myers minimal patience histogram"
+
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
@@ -1035,6 +1037,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--raw
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
+			--diff-algorithm=
 "
 
 _git_diff ()
@@ -1042,6 +1045,10 @@ _git_diff ()
 	__git_has_doubledash && return
 
 	case "$cur" in
+	--diff-algorithm=*)
+		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
+		return
+		;;
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
@@ -2114,6 +2121,10 @@ _git_show ()
 			" "" "${cur#*=}"
 		return
 		;;
+	--diff-algorithm=*)
+		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
+		return
+		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --oneline
 			$__git_diff_common_options
diff --git a/diff.c b/diff.c
index 7d6cc4c..5fa40e9 100644
--- a/diff.c
+++ b/diff.c
@@ -144,7 +144,7 @@ static int git_config_rename(const char *var, const char *value)
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
-static long parse_algorithm_value(const char *value)
+long parse_algorithm_value(const char *value)
 {
 	if (!value)
 		return -1;
@@ -3634,6 +3634,16 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
+	else if (!prefixcmp(arg, "--diff-algorithm=")) {
+		long value = parse_algorithm_value(arg+17);
+		if (value < 0)
+			return error("option diff-algorithm accepts \"myers\", "
+				     "\"minimal\", \"patience\" and \"histogram\"");
+		/* clear out previous settings */
+		DIFF_XDL_CLR(options, NEED_MINIMAL);
+		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		options->xdl_opts |= value;
+	}
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
diff --git a/diff.h b/diff.h
index a47bae4..54c2590 100644
--- a/diff.h
+++ b/diff.h
@@ -333,6 +333,8 @@ extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
 extern int parse_rename_score(const char **cp_p);
 
+extern long parse_algorithm_value(const char *value);
+
 extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
diff --git a/merge-recursive.c b/merge-recursive.c
index 33ba5dc..ea9dbd3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2068,6 +2068,15 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->xdl_opts = DIFF_WITH_ALG(o, PATIENCE_DIFF);
 	else if (!strcmp(s, "histogram"))
 		o->xdl_opts = DIFF_WITH_ALG(o, HISTOGRAM_DIFF);
+	else if (!strcmp(s, "diff-algorithm=")) {
+		long value = parse_algorithm_value(s+15);
+		if (value < 0)
+			return -1;
+		/* clear out previous settings */
+		DIFF_XDL_CLR(o, NEED_MINIMAL);
+		o->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+		o->xdl_opts |= value;
+	}
 	else if (!strcmp(s, "ignore-space-change"))
 		o->xdl_opts |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(s, "ignore-all-space"))
-- 
1.8.0.2
