From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Support printing diffs in the raw and patch format at once
Date: Tue, 11 Apr 2006 01:55:39 +0200
Message-ID: <20060410235539.2690.45543.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 11 01:55:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6EX-0002cw-IE
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWDJXzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWDJXzf
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:55:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16554 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932124AbWDJXzc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Apr 2006 19:55:32 -0400
Received: (qmail 2706 invoked from network); 11 Apr 2006 01:55:40 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 11 Apr 2006 01:55:40 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18599>

This is required when using cg-Xfollowrenames as a backend for
a tool which wants to show the end-user patches; parsing patches
properly is a nightmare, so we need to receive the diff in the
raw diff format from git-diff-tree, while also receiving the diff
in the patch format for further processing by the frontend.

This patch adds a -P option which is similar to the -p option
and achieves this. First the raw diff format is printed, then
a line terminator and then the patch.

It is fairly simple and should be straightforward, so it would be
great if this could yet make it to 1.3.0, or cg-log patch output
would have to stay with broken rename detection until the next Git
major release. :-(

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/diff-options.txt |    3 +++
 combine-diff.c                 |   32 ++++++++++++++++++++++++++------
 diff-files.c                   |    2 +-
 diff-index.c                   |    2 +-
 diff-stages.c                  |    2 +-
 diff-tree.c                    |    4 ++--
 diff.c                         |   29 +++++++++++++++++++++--------
 diff.h                         |    3 ++-
 8 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ec6811c..67c8867 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -4,6 +4,9 @@
 -u::
 	Synonym for "-p".
 
+-P::
+	Generate patch but keep also the default raw diff output.
+
 -z::
 	\0 line termination on output
 
diff --git a/combine-diff.c b/combine-diff.c
index eb0d757..65e110e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -816,10 +816,33 @@ int show_combined_diff(struct combine_di
 
 	default:
 	case DIFF_FORMAT_PATCH:
+	case DIFF_FORMAT_RAW_PATCH:
 		return show_patch_diff(p, num_parent, dense, header, opt);
 	}
 }
 
+const char *show_combined_diffs(struct combine_diff_path *paths,
+                                int num_parent, int dense,
+				const char *header, struct diff_options *opt)
+{
+	struct combine_diff_path *p;
+
+	if (opt->output_format == DIFF_FORMAT_RAW_PATCH) {
+		opt->output_format = DIFF_FORMAT_RAW;
+		header = show_combined_diffs(paths, num_parent, dense,
+		                             header, opt);
+		putchar(opt->line_termination);
+		opt->output_format = DIFF_FORMAT_RAW_PATCH;
+	}
+
+	for (p = paths; p; p = p->next) {
+		if (show_combined_diff(p, num_parent, dense,
+				       header, opt))
+			header = NULL;
+	}
+	return header;
+}
+
 const char *diff_tree_combined_merge(const unsigned char *sha1,
 			     const char *header, int dense,
 			     struct diff_options *opt)
@@ -849,7 +872,7 @@ const char *diff_tree_combined_merge(con
 			       &diffopts);
 		diffcore_std(&diffopts);
 		paths = intersect_paths(paths, i, num_parent);
-		diff_flush(&diffopts);
+		diff_flush(&diffopts, 1);
 	}
 
 	/* find out surviving paths */
@@ -858,11 +881,8 @@ const char *diff_tree_combined_merge(con
 			num_paths++;
 	}
 	if (num_paths) {
-		for (p = paths; p; p = p->next) {
-			if (show_combined_diff(p, num_parent, dense,
-					       header, opt))
-				header = NULL;
-		}
+		header = show_combined_diffs(paths, num_parent, dense,
+		                             header, opt);
 	}
 
 	/* Clean things up */
diff --git a/diff-files.c b/diff-files.c
index 3e7f5f1..4e2e5cb 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -208,6 +208,6 @@ int main(int argc, const char **argv)
 			      ce->name);
 	}
 	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
+	diff_flush(&diff_options, 1);
 	return 0;
 }
diff --git a/diff-index.c b/diff-index.c
index e376d65..dade539 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -248,6 +248,6 @@ int main(int argc, const char **argv)
 	ret = diff_cache(active_cache, active_nr, pathspec);
 
 	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
+	diff_flush(&diff_options, 1);
 	return ret;
 }
diff --git a/diff-stages.c b/diff-stages.c
index dcd20e7..fa146a9 100644
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -99,6 +99,6 @@ int main(int ac, const char **av)
 
 	diff_stages(stage1, stage2, pathspec);
 	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
+	diff_flush(&diff_options, 1);
 	return 0;
 }
diff --git a/diff-tree.c b/diff-tree.c
index d1265d7..5327df8 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -23,7 +23,7 @@ static int call_diff_flush(void)
 	if (diff_queue_is_empty()) {
 		int saved_fmt = diff_options.output_format;
 		diff_options.output_format = DIFF_FORMAT_NO_OUTPUT;
-		diff_flush(&diff_options);
+		diff_flush(&diff_options, 1);
 		diff_options.output_format = saved_fmt;
 		return 0;
 	}
@@ -32,7 +32,7 @@ static int call_diff_flush(void)
 			printf("%s%c", header, diff_options.line_termination);
 		header = NULL;
 	}
-	diff_flush(&diff_options);
+	diff_flush(&diff_options, 1);
 	return 1;
 }
 
diff --git a/diff.c b/diff.c
index 2fa285a..f57d82e 100644
--- a/diff.c
+++ b/diff.c
@@ -862,6 +862,8 @@ int diff_opt_parse(struct diff_options *
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 		options->output_format = DIFF_FORMAT_PATCH;
+	else if (!strcmp(arg, "-P"))
+		options->output_format = DIFF_FORMAT_RAW_PATCH;
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -1270,7 +1272,7 @@ static void diff_resolve_rename_copy(voi
 	diff_debug_queue("resolve-rename-copy done", q);
 }
 
-void diff_flush(struct diff_options *options)
+void diff_flush(struct diff_options *options, int shall_free)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -1278,6 +1280,13 @@ void diff_flush(struct diff_options *opt
 	int diff_output_format = options->output_format;
 	int line_termination = options->line_termination;
 
+	if (diff_output_format == DIFF_FORMAT_RAW_PATCH) {
+		options->output_format = DIFF_FORMAT_RAW;
+		diff_flush(options, 0);
+		putchar(options->line_termination);
+		options->output_format = DIFF_FORMAT_RAW_PATCH;
+	}
+
 	if (!line_termination)
 		inter_name_termination = 0;
 
@@ -1292,15 +1301,16 @@ void diff_flush(struct diff_options *opt
 			break;
 		default:
 			switch (diff_output_format) {
-			case DIFF_FORMAT_PATCH:
-				diff_flush_patch(p, options);
-				break;
 			case DIFF_FORMAT_RAW:
 			case DIFF_FORMAT_NAME_STATUS:
 				diff_flush_raw(p, line_termination,
 					       inter_name_termination,
 					       options);
 				break;
+			case DIFF_FORMAT_PATCH:
+			case DIFF_FORMAT_RAW_PATCH:
+				diff_flush_patch(p, options);
+				break;
 			case DIFF_FORMAT_NAME:
 				diff_flush_name(p,
 						inter_name_termination,
@@ -1310,11 +1320,14 @@ void diff_flush(struct diff_options *opt
 				break;
 			}
 		}
-		diff_free_filepair(p);
+		if (shall_free)
+			diff_free_filepair(p);
 	}
-	free(q->queue);
-	q->queue = NULL;
-	q->nr = q->alloc = 0;
+	if (shall_free) {
+		free(q->queue);
+		q->queue = NULL;
+		q->nr = q->alloc = 0;
+	}
 }
 
 static void diffcore_apply_filter(const char *filter)
diff --git a/diff.h b/diff.h
index a02ef28..a2dacac 100644
--- a/diff.h
+++ b/diff.h
@@ -135,8 +135,9 @@ #define DIFF_FORMAT_PATCH	2
 #define DIFF_FORMAT_NO_OUTPUT	3
 #define DIFF_FORMAT_NAME	4
 #define DIFF_FORMAT_NAME_STATUS	5
+#define DIFF_FORMAT_RAW_PATCH	6
 
-extern void diff_flush(struct diff_options*);
+extern void diff_flush(struct diff_options *, int shall_free);
 
 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
