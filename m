From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/7] reset: add option "--keep" to "git reset"
Date: Sat, 12 Dec 2009 05:32:55 +0100
Message-ID: <20091212043259.3930.21831.chriscool@tuxfamily.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJdn-0000Ke-0J
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZLLEbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760801AbZLLEbF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:31:05 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36840 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402AbZLLEav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:30:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B0CA481806D;
	Sat, 12 Dec 2009 05:30:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5147E818062;
	Sat, 12 Dec 2009 05:30:45 +0100 (CET)
X-git-sha1: 9f058e64a1de1a250f3ee1da7a16938640c4dbab 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091212042042.3930.54783.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135117>

The purpose of this new option is to discard some of the
last commits but to keep current changes in the work tree.

The use case is when you work on something and commit
that work. And then you work on something else that touches
other files, but you don't commit it yet. Then you realize
that what you commited when you worked on the first thing
is not good or belongs to another branch.

So you want to get rid of the previous commits (at least in
the current branch) but you want to make sure that you keep
the changes you have in the work tree. And you are pretty
sure that your changes are independent from what you
previously commited, so you don't want the reset to succeed
if the previous commits changed a file that you also
changed in your work tree.

The "--keep" option will do what you want.

The table below shows what happens when running
"git reset --option target" to reset the HEAD to another
commit (as a special case "target" could be the same as
HEAD) in the cases where "--merge" and "--keep" behave
differently.

working index HEAD target         working index HEAD
----------------------------------------------------
  A      B     C     D   --keep    (disallowed)
                         --merge   (disallowed)
  A      B     C     C   --keep     A      C     C
                         --merge   (disallowed)
  B      B     C     D   --keep    (disallowed)
                         --merge    C      C     C
  B      B     C     C   --keep     B      C     C
                         --merge    C      C     C

In this table, A, B and C are some different states of
a file. For example the last line of the table means
that if a file is in state B in the working tree and
the index, and in a different state C in HEAD and in
the target, then "git reset --merge target" will put
the file in state C in the working tree, in the index
and in HEAD.

So as can be seen in the table, "--merge" can discard
changes in the working tree, while "--keep" does not.
So if one wants to avoid using "git stash" before and
after using "git reset" to save current changes, it is
better to use "--keep" rather than "--merge".

The following table shows what happens on unmerged entries:

working index HEAD target         working index HEAD
----------------------------------------------------
 X       U     A    B     --keep   X       B     B
                          --merge  X       B     B
 X       U     A    A     --keep   X       A     A
                          --merge (disallowed)

In this table X can be any state and U means an unmerged
entry.

A following patch will add some test cases for
"--keep", where the differences between "--merge" and
"--keep" can also be seen.

The "--keep" option is implemented by doing a 2 way merge
between HEAD and the reset target, and if this succeeds
by doing a mixed reset to the target.

The code comes from the sequencer GSoC project, where
such an option was developed by Stephan Beyer:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

But in the sequencer project the "reset" flag was set
in the "struct unpack_trees_options" passed to
"unpack_trees()". With this flag the changes in the
working tree were discarded if the file was different
between HEAD and the reset target.

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index ac38aaa..859e0d1 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -22,13 +22,15 @@
 #include "cache-tree.h"
 
 static const char * const git_reset_usage[] = {
-	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
+	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]",
 	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, NONE };
-static const char *reset_type_names[] = { "mixed", "soft", "hard", "merge", NULL };
+enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
+static const char *reset_type_names[] = {
+	"mixed", "soft", "hard", "merge", "keep", NULL
+};
 
 static char *args_to_str(const char **argv)
 {
@@ -71,6 +73,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 	if (!quiet)
 		opts.verbose_update = 1;
 	switch (reset_type) {
+	case KEEP:
 	case MERGE:
 		opts.update = 1;
 		break;
@@ -85,6 +88,16 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 
 	read_cache_unmerged();
 
+	if (reset_type == KEEP) {
+		unsigned char head_sha1[20];
+		if (get_sha1("HEAD", head_sha1))
+			return error("You do not have a valid HEAD.");
+		if (!fill_tree_descriptor(desc, head_sha1))
+			return error("Failed to find tree of HEAD.");
+		nr++;
+		opts.fn = twoway_merge;
+	}
+
 	if (!fill_tree_descriptor(desc + nr - 1, sha1))
 		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
 	if (unpack_trees(nr, desc, &opts))
@@ -228,6 +241,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
 				"reset HEAD, index and working tree", MERGE),
+		OPT_SET_INT(0, "keep", &reset_type,
+				"reset HEAD but keep local changes",
+				KEEP),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
@@ -315,9 +331,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == SOFT) {
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
+	} else {
+		int err = reset_index_file(sha1, reset_type, quiet);
+		if (reset_type == KEEP)
+			err = err || reset_index_file(sha1, MIXED, quiet);
+		if (err)
+			die("Could not reset index file to revision '%s'.", rev);
 	}
-	else if (reset_index_file(sha1, reset_type, quiet))
-		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
 	 * saving the previous head in ORIG_HEAD before. */
-- 
1.6.6.rc1.8.gd33ec
