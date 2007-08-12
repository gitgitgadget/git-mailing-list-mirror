From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule update - don't run git-fetch if sha1 available
Date: Sat, 11 Aug 2007 18:19:59 -0700
Message-ID: <7vfy2plfb4.fsf@assigned-by-dhcp.cox.net>
References: <e7bda7770708111048s77fbf416k9d0352486aee6b4a@mail.gmail.com>
	<7vfy2pn9eb.fsf@assigned-by-dhcp.cox.net>
	<e7bda7770708111703u40f89c1fx17bfac4b9aed9d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Torgil Svensson" <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:20:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK28C-0007fP-Dr
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbXHLBUO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbXHLBUN
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:20:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38440 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHLBUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:20:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812012000.SJUE3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 21:20:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id apKz1X00L1kojtg0000000; Sat, 11 Aug 2007 21:19:59 -0400
In-Reply-To: <e7bda7770708111703u40f89c1fx17bfac4b9aed9d2e@mail.gmail.com>
	(Torgil Svensson's message of "Sun, 12 Aug 2007 02:03:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55654>

"Torgil Svensson" <torgil.svensson@gmail.com> writes:

> Do we know in this state that the ref can be reached from a reference?
> Say you've managed to do this:
>
> $ cd <submodule>
> $ git checkout master
> $ work.. commit .. work ..commit
> $ cd ..
> $ git add <submodule>
> $ git commit
> $ cd <submodule>
> $ git reset --hard HEAD~2
>
> Is it okay to fail the supermodule update in this state? Obviously
> we've thrown away things for a purpose.

It would make more sense if the last command you ran in the
subproject directory were "git checkout HEAD~2".  If you have
checked out the subproject in the context of the superproject,
you have no business *resetting* its branches.  Then the updated
HEAD is reachable from the branch tip.

But even when you did "reset --hard" to rewind, you _could_
avoid fetching if you wanted to.  In fact, this alternative
technique is probably needed if you built new commits on top of
existing refs of the 'origin' repository of subproject, or even
on a detached HEAD.

What you need to prove is that whatever commit the superproject
wants to check out can be checked out.  Strictly speaking, the
commit does not even have to have histories leading to it in the
repository.  So in addition to the check you initially proposed
in your patch (by the way, I would do "git cat-file -t $commit"
and see if it is a commit object, instead of "rev-list" of count
zero), minimally you need to prove that all trees and blobs
exist in the repository.

That can be done from the script level by doing something silly
like:

	git archive "$commit^{tree}" >/dev/null

To make it more efficient (the above proves all the trees and
blobs exist by actually extracting all of them, which is an
unnecessary work), you may want to add a more lightweight
built-in command to do so.  Perhaps...

-- >8 --
Subject: ls-tree --check

You can run "ls-tree --check" to make sure that all necessary
objects exist in the repository to complete a tree object.  This
may be useful to make sure that the subproject commit bound to a
superproject index can be checked out in its entirety.

---

 builtin-ls-tree.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index cb4be4f..4a19e86 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -16,6 +16,7 @@ static int line_termination = '\n';
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
 #define LS_SHOW_SIZE 16
+#define LS_CHECK 32
 static int abbrev;
 static int ls_options;
 static const char **pathspec;
@@ -23,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-l] [-z] [--check] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -107,6 +108,16 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
 				       abbrev ? find_unique_abbrev(sha1, abbrev)
 				              : sha1_to_hex(sha1),
 				       '-');
+		} else if (ls_options & LS_CHECK) {
+			if (S_ISGITLINK(mode))
+				/*
+				 * subproject commit does not have to be
+				 * in this repository.
+				 */
+				; /* noop */
+			else if (sha1_object_info(sha1, &size) < 0)
+				retval = -1;
+			return retval;
 		} else
 			printf("%06o %s %s\t", mode, type,
 			       abbrev ? find_unique_abbrev(sha1, abbrev)
@@ -171,6 +182,10 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 				abbrev = DEFAULT_ABBREV;
 				break;
 			}
+			if (!strcmp(argv[1]+2, "check")) {
+				ls_options = LS_CHECK|LS_RECURSIVE;
+				break;
+			}
 			/* otherwise fallthru */
 		default:
 			usage(ls_tree_usage);
@@ -191,7 +206,5 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
-
-	return 0;
+	return read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
 }
