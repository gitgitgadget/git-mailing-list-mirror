From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 1/1]   Make git-tar-tree more flexible
Date: Mon, 31 Jul 2006 03:48:47 +1000
Message-ID: <20060730174847.GA32574@eve.kumria.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 30 19:53:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7FTH-0005PT-CQ
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 19:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWG3Rwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 13:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWG3Rwz
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 13:52:55 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:32232 "EHLO
	giskard.kumria.com") by vger.kernel.org with ESMTP id S932393AbWG3Rwz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 13:52:55 -0400
Received: from caliban.kumria.com
	([203.7.227.146] helo=eve.kumria.com ident=anand)
	by giskard.kumria.com with esmtp (Exim 4.50)
	id 1G7FSv-0001mz-5w; Mon, 31 Jul 2006 03:52:49 +1000
Received: from anand by eve.kumria.com with local (Exim 4.62)
	(envelope-from <anand@eve.kumria.com>)
	id 1G7FPD-0008Ts-Ql; Mon, 31 Jul 2006 03:48:47 +1000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 203.7.227.146
X-SA-Exim-Mail-From: anand@eve.kumria.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on giskard.kumria.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on giskard.kumria.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24463>

  If you have a project which is setup like:
     project
     website
  and you decide you wish to generate a tar archive of _just_ the 'project'
  portion, git-tar-tree is not able to help. This patch adds two parameters
  which can assist.

  The first is '--pathlimit', which forces git-tar-tree to only generate the
  tar archive for project; as in:
    'git tar-tree --pathlimit=project project-1.0 tag-1.0'

  The above command will mean that paths in the tar archive look like:
    project-1.0/project/src/main.c
  etc.

  The second parameter allows you two strip the extraneous project, as in:
    'git tar-tree --strippath=project --pathlimit=project project-1.0 tag-1.0     Which will result in tar archives looking like:
    project-1.0/src/main.c

  This patch also updates the documentation to match the new parameters and
  rewrites the argument processing so that arguments can be passed in any
  order by the user

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 Documentation/git-tar-tree.txt |   11 ++++++
 tar-tree.c                     |   70 ++++++++++++++++++++++++++++++----------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 2139b6f..d123329 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -8,7 +8,7 @@ git-tar-tree - Creates a tar archive of 
 
 SYNOPSIS
 --------
-'git-tar-tree' <tree-ish> [ <base> ]
+'git-tar-tree' [--strippath=<path>] [--pathlimit=<path>] <tree-ish> [ <base> ]
 
 DESCRIPTION
 -----------
@@ -23,6 +23,15 @@ commit time as recorded in the reference
 Additionally the commit ID is stored in a global extended pax header.
 It can be extracted using git-get-tar-commit-id.
 
+OPTIONS
+-------
+--strippath::
+	Remove from the created tar archive the specified string from
+	any of the generated paths
+
+--pathlimit::
+	Create the tar archive but limit the included files to be those
+	specified by the pathlimit
 
 Author
 ------
diff --git a/tar-tree.c b/tar-tree.c
index fc60a90..78ae7ff 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -11,7 +11,7 @@ #include "tar.h"
 #define RECORDSIZE	(512)
 #define BLOCKSIZE	(RECORDSIZE * 20)
 
-static const char tar_tree_usage[] = "git-tar-tree <key> [basedir]";
+static const char tar_tree_usage[] = "git-tar-tree [--strippath=<path>] [--pathlimit=<path>] <key> [basedir]";
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
@@ -265,7 +265,7 @@ static void write_global_extended_header
 	free(ext_header.buf);
 }
 
-static void traverse_tree(struct tree_desc *tree, struct strbuf *path)
+static void traverse_tree(struct tree_desc *tree, struct strbuf *path, const char *namelimit, const char *strippath)
 {
 	int pathlen = path->len;
 
@@ -280,14 +280,25 @@ static void traverse_tree(struct tree_de
 		sha1 = tree_entry_extract(tree, &name, &mode);
 		update_tree_entry(tree);
 
+		/* if we have a namelimit and we don't match it, escape */
+		if (namelimit)
+			if (!(strcmp(name,namelimit) == 0))
+				continue;
+
 		eltbuf = read_sha1_file(sha1, elttype, &eltsize);
 		if (!eltbuf)
 			die("cannot read %s", sha1_to_hex(sha1));
 
 		path->len = pathlen;
-		strbuf_append_string(path, name);
-		if (S_ISDIR(mode))
-			strbuf_append_string(path, "/");
+
+		/* if we match the path to strip out,
+		 *  don't append it to the path
+		 */
+		if ((strippath) && (!(strcmp(name,strippath) == 0))) {
+			strbuf_append_string(path, name);
+			if (S_ISDIR(mode))
+				strbuf_append_string(path, "/");
+		}
 
 		write_entry(sha1, path, mode, eltbuf, eltsize);
 
@@ -295,7 +306,7 @@ static void traverse_tree(struct tree_de
 			struct tree_desc subtree;
 			subtree.buf = eltbuf;
 			subtree.size = eltsize;
-			traverse_tree(&subtree, path);
+			traverse_tree(&subtree, path, NULL, strippath);
 		}
 		free(eltbuf);
 	}
@@ -307,6 +318,9 @@ int main(int argc, char **argv)
 	struct commit *commit;
 	struct tree_desc tree;
 	struct strbuf current_path;
+	int i, gotsha1 = 0, gotpath = 0;
+	const char *strippath;
+	const char *pathlimit;
 
 	current_path.buf = xmalloc(PATH_MAX);
 	current_path.alloc = PATH_MAX;
@@ -315,19 +329,41 @@ int main(int argc, char **argv)
 	setup_git_directory();
 	git_config(git_default_config);
 
-	switch (argc) {
-	case 3:
-		strbuf_append_string(&current_path, argv[2]);
-		strbuf_append_string(&current_path, "/");
-		/* FALLTHROUGH */
-	case 2:
-		if (get_sha1(argv[1], sha1) < 0)
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+
+		if (*arg != '-') {
+			/* first assume it is an SHA1 ref */
+			if (!gotsha1) {
+				if (get_sha1(arg, sha1) >= 0) {
+					gotsha1 = 1;
+					continue;
+				}
+			}
+
+			/* now assume it is the path prefix */
+			if (!gotpath) {
+				strbuf_append_string(&current_path, arg);
+				strbuf_append_string(&current_path, "/");
+				gotpath = 1;
+				continue;
+			}
+
+			/* we're still here? */
+			usage(tar_tree_usage);
+
+		} else if (!strncmp(arg, "--strippath=", 12)) {
+			strippath = strdup(arg+12);
+		} else if (!strncmp(arg, "--pathlimit=", 12)) {
+			pathlimit = strdup(arg+12);
+		} else
 			usage(tar_tree_usage);
-		break;
-	default:
-		usage(tar_tree_usage);
 	}
 
+	/* be sure we have an SHA1 ref */
+	if (!gotsha1)
+		usage(tar_tree_usage);
+
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
 		write_global_extended_header(commit->object.sha1);
@@ -343,7 +379,7 @@ int main(int argc, char **argv)
 
 	if (current_path.len > 0)
 		write_entry(tree_sha1, &current_path, 040777, NULL, 0);
-	traverse_tree(&tree, &current_path);
+	traverse_tree(&tree, &current_path, pathlimit, strippath);
 	write_trailer();
 	free(current_path.buf);
 	return 0;
-- 
1.4.1
