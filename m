From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Teach mailsplit about Maildir
Date: Fri, 27 Apr 2007 15:23:13 +0200
Message-ID: <20070427132313.GA5237@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 15:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhQQE-0006FU-7O
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 15:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXD0NX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 09:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbXD0NX3
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 09:23:29 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:50319
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbXD0NX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 09:23:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id A08568D316;
	Fri, 27 Apr 2007 15:00:47 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17654-09; Fri, 27 Apr 2007 15:00:36 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id CB3158D305;
	Fri, 27 Apr 2007 15:00:35 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Fri, 27 Apr 2007 15:23:13 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45715>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---

	This time I changed the documentation of git-am and git-mailsplit to
	state that it can also split Maildirs.

	Instead of taking an arbitrary order (like my last patch) it now
	relies on filenames to be sorted. Although the Maildir 'spec'
	prohibits it, at leas

 Documentation/git-am.txt        |    7 +-
 Documentation/git-mailsplit.txt |   11 +++-
 builtin-mailsplit.c             |  122 ++++++++++++++++++++++++++++++++------
 builtin.h                       |    2 +-
 4 files changed, 115 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index f0405a3..3b392f0 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-am' [--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
          [--interactive] [--whitespace=<option>] [-C<n>] [-p<n>]
-	 <mbox>...
+	 <mbox>|<Maildir>...
 'git-am' [--skip | --resolved]
 
 DESCRIPTION
@@ -22,9 +22,10 @@ current branch.
 
 OPTIONS
 -------
-<mbox>...::
+<mbox>|<Maildir>...::
 	The list of mailbox files to read patches from. If you do not
-	supply this argument, reads from the standard input.
+	supply this argument, reads from the standard input. If you supply
+	directories, they'll be treated as Maildirs.
 
 -s, --signoff::
 	Add `Signed-off-by:` line to the commit message, using
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index c11d6a5..35a74b8 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -7,12 +7,12 @@ git-mailsplit - Simple UNIX mbox splitter program
 
 SYNOPSIS
 --------
-'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>...]
+'git-mailsplit' [-b] [-f<nn>] [-d<prec>] -o<directory> [--] [<mbox>|<Maildir>...]
 
 DESCRIPTION
 -----------
-Splits a mbox file into a list of files: "0001" "0002" ..  in the specified
-directory so you can process them further from there.
+Splits a mbox file or a Maildir into a list of files: "0001" "0002" ..  in the
+specified directory so you can process them further from there.
 
 OPTIONS
 -------
@@ -20,6 +20,11 @@ OPTIONS
 	Mbox file to split.  If not given, the mbox is read from
 	the standard input.
 
+<Maildir>::
+	Root of the Maildir to split. This directory should contain the cur, tmp
+	and new subdirectories. git-mailsplit relies on filenames being sorted to
+	output patches in the correct order.
+
 <directory>::
 	Directory in which to place the individual messages.
 
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 3bca855..1d096d6 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -6,9 +6,10 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "path-list.h"
 
 static const char git_mailsplit_usage[] =
-"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>...";
+"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
 
 static int is_from_line(const char *line, int len)
 {
@@ -96,44 +97,106 @@ static int split_one(FILE *mbox, const char *name, int allow_bare)
 	exit(1);
 }
 
-int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip)
+static int populate_maildir_list(struct path_list *list, const char *path)
 {
-	char *name = xmalloc(strlen(dir) + 2 + 3 * sizeof(skip));
+	DIR *dir;
+	struct dirent *dent;
+
+	if ((dir = opendir(path)) == NULL) {
+		error("cannot diropen %s (%s)", path, strerror(errno));
+		return -1;
+	}
+
+	while ((dent = readdir(dir)) != NULL) {
+		if (dent->d_name[0] == '.')
+			continue;
+		path_list_insert(dent->d_name, list);
+	}
+
+	closedir(dir);
+
+	return 1;
+}
+
+static int split_maildir(const char *maildir, const char *dir,
+	int nr_prec, int skip)
+{
+	char file[PATH_MAX];
+	char curdir[PATH_MAX];
+	char name[PATH_MAX];
 	int ret = -1;
+	struct path_list list = {NULL, 0, 0, 1};
 
-	while (*mbox) {
-		const char *file = *mbox++;
-		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
-		int file_done = 0;
+	snprintf(curdir, sizeof(curdir), "%s/cur", maildir);
+	if (populate_maildir_list(&list, curdir) < 0)
+		goto out;
 
-		if ( !f ) {
-			error("cannot open mbox %s", file);
+	int i;
+	for (i = 0; i < list.nr; i++) {
+		snprintf(file, sizeof(file), "%s/%s", curdir, list.items[i].path);
+		FILE *f = fopen(file, "r");
+		if (!f) {
+			error("cannot open mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
 		if (fgets(buf, sizeof(buf), f) == NULL) {
-			if (f == stdin)
-				break; /* empty stdin is OK */
-			error("cannot read mbox %s", file);
+			error("cannot read mail %s (%s)", file, strerror(errno));
 			goto out;
 		}
 
-		while (!file_done) {
-			sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
-			file_done = split_one(f, name, allow_bare);
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		split_one(f, name, 1);
+
+		fclose(f);
+	}
+
+	path_list_clear(&list, 1);
+
+	ret = skip;
+out:
+	return ret;
+}
+
+int split_mbox(const char *file, const char *dir, int allow_bare,
+		int nr_prec, int skip)
+{
+	char name[PATH_MAX];
+	int ret = -1;
+
+	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
+	int file_done = 0;
+
+	if (!f) {
+		error("cannot open mbox %s", file);
+		goto out;
+	}
+
+	if (fgets(buf, sizeof(buf), f) == NULL) {
+		/* empty stdin is OK */
+		if (f != stdin) {
+			error("cannot read mbox %s", file);
+			goto out;
 		}
+		file_done = 1;
+	}
 
-		if (f != stdin)
-			fclose(f);
+	while (!file_done) {
+		sprintf(name, "%s/%0*d", dir, nr_prec, ++skip);
+		file_done = split_one(f, name, allow_bare);
 	}
+
+	if (f != stdin)
+		fclose(f);
+
 	ret = skip;
 out:
-	free(name);
 	return ret;
 }
+
 int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 {
-	int nr = 0, nr_prec = 4, ret;
+	int nr = 0, nr_prec = 4, ret = 0;
 	int allow_bare = 0;
 	const char *dir = NULL;
 	const char **argp;
@@ -186,7 +249,26 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			argp = stdin_only;
 	}
 
-	ret = split_mbox(argp, dir, allow_bare, nr_prec, nr);
+	while (*argp) {
+		const char *arg = *argp++;
+		struct stat argstat;
+
+		if (arg[0] == '-' && arg[1] == 0) {
+			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
+			continue;
+		}
+
+		if (stat(arg, &argstat) == -1) {
+			error("cannot stat %s (%s)", arg, strerror(errno));
+			return 1;
+		}
+
+		if (S_ISDIR(argstat.st_mode))
+			ret |= split_maildir(arg, dir, nr_prec, nr);
+		else
+			ret |= split_mbox(arg, dir, allow_bare, nr_prec, nr);
+	}
+
 	if (ret != -1)
 		printf("%d\n", ret);
 
diff --git a/builtin.h b/builtin.h
index d3f3a74..39290d1 100644
--- a/builtin.h
+++ b/builtin.h
@@ -8,7 +8,7 @@ extern const char git_usage_string[];
 
 extern void help_unknown_cmd(const char *cmd);
 extern int mailinfo(FILE *in, FILE *out, int ks, const char *encoding, const char *msg, const char *patch);
-extern int split_mbox(const char **mbox, const char *dir, int allow_bare, int nr_prec, int skip);
+extern int split_mbox(const char *file, const char *dir, int allow_bare, int nr_prec, int skip);
 extern void stripspace(FILE *in, FILE *out);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char *prefix);
 extern void prune_packed_objects(int);
-- 
1.5.1.2
