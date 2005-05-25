From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Tue, 24 May 2005 23:24:22 -0700
Message-ID: <7vmzqjn7qh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
	<7vsm0hpbub.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505202025480.2206@ppc970.osdl.org>
	<Pine.LNX.4.62.0505231724270.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 08:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DapII-0006bM-Eg
	for gcvg-git@gmane.org; Wed, 25 May 2005 08:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVEYGYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 02:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVEYGYq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 02:24:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61312 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261333AbVEYGY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 02:24:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525062422.MWQA16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 02:24:22 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505231724270.16151@localhost.localdomain> (Nicolas
 Pitre's message of "Mon, 23 May 2005 17:49:27 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry, I did not get back to you earlier.

My only hesitation is that I'd rather want to see outputs from
"git-diff-tree -r $O $A" and "git-read-tree $A && git-diff-cache
--cached $O" exactly match by default, but this is quite minor (I
cannot even justify why myself).

As you already know, diff-helper knows it cannot do anything
about trees, so that is not a reason to fear your change.

That said, I have already acquired a habit of running diff-tree
with raw output to see what files have changed between two
trees, relying on the traditional behaviour of showing only
blobs and not trees, so turning this "tree" output on by default
is a minor nuisance to adjust to (it is minor --- I just need to
filter them out by looking at the first 7 bytes of each line).

How about this patch instead?  Does it do what you need?  My
understanding of your needs is that you do not like having to
call diff-tree (w/o recursive) only to get tree IDs involved,
because you are indeed interested in the whole tree and prefer
recursive behaviour; for that reason I made -t to imply -r.

Only lightly tested.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -6,6 +6,7 @@ static int show_root_diff = 0;
 static int verbose_header = 0;
 static int ignore_merges = 1;
 static int recursive = 0;
+static int show_tree_entry_in_recursive = 0;
 static int read_stdin = 0;
 static int diff_output_format = DIFF_FORMAT_HUMAN;
 static int detect_rename = 0;
@@ -123,6 +124,8 @@ static int compare_tree_entry(void *tree
 	if (recursive && S_ISDIR(mode1)) {
 		int retval;
 		char *newbase = malloc_base(base, path1, pathlen1);
+		if (show_tree_entry_in_recursive)
+			diff_change(mode1, mode2, sha1, sha2, base, path1);
 		retval = diff_tree_sha1(sha1, sha2, newbase);
 		free(newbase);
 		return retval;
@@ -463,7 +466,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static char *diff_tree_usage =
-"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-m] [-s] [-v] <tree-ish> <tree-ish>";
+"git-diff-tree [-p] [-r] [-z] [--stdin] [-M] [-C] [-R] [-S<string>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish>";
 
 int main(int argc, const char **argv)
 {
@@ -498,6 +501,10 @@ int main(int argc, const char **argv)
 			recursive = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-t")) {
+			recursive = show_tree_entry_in_recursive = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-R")) {
 			reverse_diff = 1;
 			continue;

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and
 
 SYNOPSIS
 --------
-'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [-m] [-s] [-v] <tree-ish> <tree-ish> [<pattern>]\*
+'git-diff-tree' [-p] [-r] [-z] [--stdin] [-M] [-R] [-C] [-S<string>] [-m] [-s] [-v] [-t] <tree-ish> <tree-ish> [<pattern>]\*
 
 DESCRIPTION
 -----------
@@ -48,6 +48,9 @@ OPTIONS
 -r::
 	recurse
 
+-t::
+	show tree entry itself as well as subtrees.  Implies -r.
+
 -z::
 	\0 line termination on output
 


