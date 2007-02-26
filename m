From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Mon, 26 Feb 2007 01:44:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702260139290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702260009530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virdprejh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 01:44:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLTyO-0008De-At
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 01:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933723AbXBZAoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933734AbXBZAoH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 19:44:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:50564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933723AbXBZAoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 19:44:05 -0500
Received: (qmail invoked by alias); 26 Feb 2007 00:44:02 -0000
X-Provags-ID: V01U2FsdGVkX19AIoso2WpASqRMJP8XQJf6PfOyAO50YH+ad5gsbd
	oj/A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7virdprejh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40600>

Hi,

On Sun, 25 Feb 2007, Junio C Hamano wrote:

> I think the callers of populate_filespec() may need to pass around 
> diff_options as a parameter for the above to work, but hopefully that 
> should not be a rocket surgery.

That's a good idea! Actually, that pointer can be the pointer in the 
diff_filespec itself!

This is my current version of [4/8] (Gosh, I really _love_ rebase -i ;-):

-- snipsnap --
[PATCH] diff: support reading a file from stdin via "-"

This allows you to say

	echo Hello World | git diff x -

to compare the contents of file "x" with the line "Hello World".
This automatically switches to --no-index mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This gives revs->max_count yet another meaning, oh well...

	The diff is a bit borked, because get_mode() and the first part 
	of the old queue_diff() are apparently a little similar...

 diff-lib.c |   92 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 6678e22..9302d2b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -30,22 +30,61 @@ static int read_directory(const char *path, struct path_list *list)
 	return 0;
 }
 
-static int queue_diff(struct diff_options *o,
-		const char *name1, const char *name2)
+static int get_mode(const char *path, int *mode, int seen_dashdash)
 {
 	struct stat st;
-	int mode1 = 0, mode2 = 0;
 
-	if (name1) {
-		if (stat(name1, &st))
-			return error("Could not access '%s'", name1);
-		mode1 = st.st_mode;
+	if (!path)
+		*mode = 0;
+	else if (!seen_dashdash && !strcmp(path, "-"))
+		*mode = 020600;
+	else if (stat(path, &st))
+		return error("Could not access '%s'", path);
+	else
+		*mode = st.st_mode;
+	return 0;
+}
+
+static void read_stdin(void **buffer, unsigned long *size)
+{
+	char *buf = NULL;
+#define INCREMENT 1024
+	int i = INCREMENT;
+
+	*size = 0;
+	buf = NULL;
+	while (i == INCREMENT) {
+		buf = xrealloc(buf, *size + INCREMENT);
+		i = xread(0, buf + *size, INCREMENT);
+		*size += i;
 	}
-	if (name2) {
-		if (stat(name2, &st))
-			return error("Could not access '%s'", name2);
-		mode2 = st.st_mode;
+	*buffer = buf;
+}
+
+static struct diff_filespec *make_diff_filespec(const char *path, int mode)
+{
+	struct diff_filespec *result;
+	if (!path)
+		path = "/dev/null";
+	result = alloc_filespec(path);
+	fill_filespec(result, null_sha1, mode);
+	if (mode == 020600) {
+		read_stdin(&result->data, &result->size);
+		result->mode = 0100644;
+		result->should_munmap = 0;
+		result->should_free = 1;
 	}
+	return result;
+}
+
+static int queue_diff(struct diff_options *o,
+		const char *name1, const char *name2, int seen_dashdash)
+{
+	int mode1 = 0, mode2 = 0;
+
+	if (get_mode(name1, &mode1, seen_dashdash) ||
+			get_mode(name2, &mode2, seen_dashdash))
+		return -1;
 
 	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
 		return error("file/directory conflict: %s, %s", name1, name2);
@@ -106,7 +145,7 @@ static int queue_diff(struct diff_options *o,
 						PATH_MAX - len2);
 			}
 
-			ret = queue_diff(o, n1, n2);
+			ret = queue_diff(o, n1, n2, 1);
 		}
 		path_list_clear(&p1, 0);
 		path_list_clear(&p2, 0);
@@ -122,14 +161,8 @@ static int queue_diff(struct diff_options *o,
 			tmp_c = name1; name1 = name2; name2 = tmp_c;
 		}
 
-		if (!name1)
-			name1 = "/dev/null";
-		if (!name2)
-			name2 = "/dev/null";
-		d1 = alloc_filespec(name1);
-		d2 = alloc_filespec(name2);
-		fill_filespec(d1, null_sha1, mode1);
-		fill_filespec(d2, null_sha1, mode2);
+		d1 = make_diff_filespec(name1, mode1);
+		d2 = make_diff_filespec(name2, mode2);
 
 		diff_queue(&diff_queued_diff, d1, d2);
 		return 0;
@@ -222,11 +255,12 @@ static int is_outside_repo(const char *path, int nongit, const char *prefix)
 int setup_diff_no_index(struct rev_info *revs,
 		int argc, const char ** argv, int nongit, const char *prefix)
 {
-	int i;
+	int i, seen_dashdash = 0;
 	for (i = 1; i < argc; i++)
-		if (argv[i][0] != '-')
+		if (argv[i][0] != '-' || argv[i][1] == '\0')
 			break;
 		else if (!strcmp(argv[i], "--")) {
+			seen_dashdash = 1;
 			i++;
 			break;
 		} else if (i < argc - 3 && !strcmp(argv[i], "--no-index")) {
@@ -238,7 +272,7 @@ int setup_diff_no_index(struct rev_info *revs,
 		return -1;
 
 	diff_setup(&revs->diffopt);
-	for (i = 1; i < argc - 2; )
+	for (i = 1; i < argc - 2 - seen_dashdash; )
 		if (!strcmp(argv[i], "--no-index"))
 			i++;
 		else {
@@ -250,22 +284,26 @@ int setup_diff_no_index(struct rev_info *revs,
 		}
 	revs->diffopt.paths = argv + argc - 2;
 	revs->diffopt.nr_paths = 2;
-	revs->max_count = -2;
+	revs->max_count = -2 - seen_dashdash;
 	return 0;
 }
 
 int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 {
-	int silent_on_removed;
+	int silent_on_removed, seen_dashdash = 0;
 
-	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
+	if (revs->max_count == -3) {
+		seen_dashdash = 1;
+		revs->max_count = -2;
+	} else if (handle_diff_files_args(revs, argc, argv,
+				&silent_on_removed))
 		return -1;
 
 	if (revs->max_count == -2) {
 		if (revs->diffopt.nr_paths != 2)
 			return error("need two files/directories with --no-index");
 		if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
-				revs->diffopt.paths[1]))
+				revs->diffopt.paths[1], seen_dashdash))
 			return -1;
 		diffcore_std(&revs->diffopt);
 		diff_flush(&revs->diffopt);
-- 
1.5.0.1.784.g105d9-dirty
