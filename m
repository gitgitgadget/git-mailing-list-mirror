From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-list: make --dense the default (and introduce "--sparse")
Date: Tue, 25 Oct 2005 15:24:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 00:26:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUXEC-0006O8-Gp
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVJYWZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 18:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVJYWZB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 18:25:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932443AbVJYWZA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 18:25:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9PMOuFC023381
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Oct 2005 15:24:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9PMOtZZ000990;
	Tue, 25 Oct 2005 15:24:55 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10626>


This actually does three things:

 - make "--dense" the default for git-rev-list. Since dense is a no-op if 
   no filenames are given, this doesn't actually change any historical 
   behaviour, but it's logically the right default (if we want to prune on 
   filenames, do it fully. The sparse "merge-only" thing may be useful, 
   but it's not what you'd normally expect)

 - make "git-rev-parse" show the default revision control before it shows 
   any pathnames.

   This was a real bug, but nobody would ever have noticed, because 
   the default thing tends to only make sense for git-rev-list, and 
   git-rev-list didn't use to take pathnames.

 - it changes "git-rev-list" to match the other commands that take a mix 
   of revisions and filenames - it no longer requires the "--" before 
   filenames (although you still need to do it if a filename could be 
   confused with a revision name, eg "gitk" in the git archive)

This all just makes for much more pleasant and obvous usage. Just doing a

	gitk t/

does the obvious thing: it will show the history as it concerns the "t/" 
subdirectory.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! None of this will change anything that used to work before. But 
things that used to make git-rev-list die with a usage message will now 
possibly do things. In particular, it may do something that you don't 
expect.

For example, let's say that you mis-type a revision name, and do

	gitk v0.99.88

with one "8" too much. It used to cause gitk to die on you, echoing the 
usage string from git-rev-list. Now it will cause gitk to start up 
happily, and say "No commits selected", because there is no _file_ called 
"v0.99.88" anywhere, so git-rev-list will end up with empty output.

So it does change behaviour, even if it doesn't change anything that was 
_successful_ before.

For the same reasons, a

	git-rev-list $(git-rev-parse --default HEAD v0.99.88)

will now give an empty list rather than an error usage string.

(But doing

	git-rev-list v0.99.88

will still cause an error, since that doesn't have any revision at all!)

Comments? It really makes usage more "obvious", I think.


diff --git a/rev-list.c b/rev-list.c
index edf3b37..ac7a47f 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -28,7 +28,7 @@ static const char rev_list_usage[] =
 		      "  --merge-order [ --show-breaks ]\n"
 		      "  --topo-order";
 
-static int dense = 0;
+static int dense = 1;
 static int unpacked = 0;
 static int bisect_list = 0;
 static int tag_objects = 0;
@@ -619,7 +619,7 @@ static struct commit *get_commit_referen
 	struct object *object;
 
 	if (get_sha1(name, sha1))
-		usage(rev_list_usage);
+		return NULL;
 	object = parse_object(sha1);
 	if (!object)
 		die("bad object %s", name);
@@ -793,12 +793,12 @@ int main(int argc, const char **argv)
 			dense = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--sparse")) {
+			dense = 0;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
-			paths = get_pathspec(prefix, argv + i + 1);
-			if (paths) {
-				limited = 1;
-				diff_tree_setup_paths(paths);
-			}
+			i++;
 			break;
 		}
 
@@ -830,9 +830,20 @@ int main(int argc, const char **argv)
 			limited = 1;
 		}
 		commit = get_commit_reference(arg, flags);
+		if (!commit)
+			break;
 		handle_one_commit(commit, &list);
 	}
 
+	if (!list)
+		usage(rev_list_usage);
+
+	paths = get_pathspec(prefix, argv + i);
+	if (paths) {
+		limited = 1;
+		diff_tree_setup_paths(paths);
+	}
+
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
 
diff --git a/rev-parse.c b/rev-parse.c
index 243f89f..adfc68c 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -153,6 +153,7 @@ static void show_datestring(const char *
 
 static void show_file(const char *arg)
 {
+	show_default();
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV))
 		show(arg);
 }
@@ -174,7 +175,6 @@ int main(int argc, char **argv)
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
 				as_is = 1;
-				show_default();
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
