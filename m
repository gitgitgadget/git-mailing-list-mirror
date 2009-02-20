From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [HALF A PATCH] Teach the '--exclude' option to 'diff --no-index'
Date: Fri, 20 Feb 2009 15:12:28 +0100 (CET)
Message-ID: <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de>
References: <499E92FD.8000900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 15:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaW8m-0003QS-Vl
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758323AbZBTOMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 09:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbZBTOMd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:12:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:60473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758218AbZBTOMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 09:12:31 -0500
Received: (qmail invoked by alias); 20 Feb 2009 14:12:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 20 Feb 2009 15:12:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nCGMeUGynvIFjBqDDUaCuWt8wOftXDd1FLxP/90
	hbsVCF6WPUyhsj
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499E92FD.8000900@alum.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110846>

With this patch, it is possible to exclude files based on basename
patterns.  Example:

	$ git diff --no-index -x Makefile -x Makefile.in a/ b/

In this example, the recursive diff between a/ and b/ will be shown
modulo changes in files named 'Makefile' or 'Makefile.in'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Michael wrote:

	> I can't think offhand of a more portable tool that could replace 
	> "diff -r -x" here (suggestions, anyone?).

	Maybe something like this?

	Note: before it can be included in git.git, documentation and 
	tests have to be added; also, it might be a good idea to extend it 
	to the "non-no-index" case (maybe I can beat Peff in the number of 
	double negations one day...)

	So why only half a patch?  From time to time, I have to remember 
	that I work on Git for fun.  And this was the fun part, as far as 
	I am concerned.

 diff-no-index.c |   50 ++++++++++++++++++++++++++++++++++++++++++++------
 diff.c          |    9 +++++++++
 diff.h          |    6 ++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 0a14268..0dc924a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,42 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+void add_basename_exclude(const char *exclude, struct diff_options *opts)
+{
+	if (!opts->basename_excludes) {
+		opts->basename_excludes =
+			xcalloc(sizeof(struct string_list), 1);
+		opts->basename_excludes->strdup_strings = 1;
+	}
+
+	string_list_append(exclude, opts->basename_excludes);
+}
+
+int basename_is_excluded(const char *basename, struct diff_options *options)
+{
+	int i;
+
+	if (!options->basename_excludes)
+		return 0;
+
+	for (i = 0; i < options->basename_excludes->nr; i++)
+		if (!fnmatch(options->basename_excludes->items[i].string,
+					basename, 0))
+			return 1;
+	return 0;
+}
+
+void free_basename_excludes(struct diff_options *options)
+{
+	if (!options->basename_excludes)
+		return;
+	string_list_clear(options->basename_excludes, 0);
+	free(options->basename_excludes);
+	options->basename_excludes = NULL;
+}
+
+static int read_directory(const char *path, struct string_list *list,
+	struct diff_options *options)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -25,7 +60,8 @@ static int read_directory(const char *path, struct string_list *list)
 		return error("Could not open directory %s", path);
 
 	while ((e = readdir(dir)))
-		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+		if (strcmp(".", e->d_name) && strcmp("..", e->d_name) &&
+				!basename_is_excluded(e->d_name, options))
 			string_list_insert(e->d_name, list);
 
 	closedir(dir);
@@ -63,9 +99,9 @@ static int queue_diff(struct diff_options *o,
 		struct string_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
 		int len1 = 0, len2 = 0, i1, i2, ret = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory(name1, &p1, o))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory(name2, &p2, o)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
@@ -177,10 +213,12 @@ void diff_no_index(struct rev_info *revs,
 			i++;
 			break;
 		}
-		if (!strcmp(argv[i], "--no-index"))
-			no_index = 1;
 		if (argv[i][0] != '-')
 			break;
+		if (!strcmp(argv[i], "--no-index"))
+			no_index = 1;
+		else if (!strcmp(argv[i], "-x"))
+			i++;
 	}
 
 	if (!no_index && !nongit) {
diff --git a/diff.c b/diff.c
index 55d73a1..29c0dd5 100644
--- a/diff.c
+++ b/diff.c
@@ -2653,6 +2653,14 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!prefixcmp(arg, "--output=")) {
 		options->file = fopen(arg + strlen("--output="), "w");
 		options->close_file = 1;
+	}
+	else if (!prefixcmp(arg, "--exclude="))
+		add_basename_exclude( arg + strlen("--exclude="), options);
+	else if (!strcmp(arg, "-x")) {
+		if (ac < 2)
+			die ("-x needs a parameter");
+		add_basename_exclude(av[1], options);
+		return 2;
 	} else
 		return 0;
 	return 1;
@@ -3306,6 +3314,7 @@ free_queue:
 	q->nr = q->alloc = 0;
 	if (options->close_file)
 		fclose(options->file);
+	free_basename_excludes(options);
 }
 
 static void diffcore_apply_filter(const char *filter)
diff --git a/diff.h b/diff.h
index 6703a4f..38f3acd 100644
--- a/diff.h
+++ b/diff.h
@@ -113,6 +113,7 @@ struct diff_options {
 	add_remove_fn_t add_remove;
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
+	struct string_list *basename_excludes;
 };
 
 enum color_diff {
@@ -267,4 +268,9 @@ extern void diff_no_index(struct rev_info *, int, const char **, int, const char
 
 extern int index_differs_from(const char *def, int diff_flags);
 
+extern int basename_is_excluded(const char *path, struct diff_options *options);
+extern void add_basename_exclude(const char *exclude,
+		struct diff_options *options);
+extern void free_basename_excludes(struct diff_options *options);
+
 #endif /* DIFF_H */
-- 
1.6.2.rc1.350.g6caf6
