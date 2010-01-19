From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/5] reset: add option "--keep" to "git reset"
Date: Tue, 19 Jan 2010 05:25:57 +0100
Message-ID: <20100119042602.4510.24100.chriscool@tuxfamily.org>
References: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:24:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5eB-00074w-NS
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab0ASEYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754588Ab0ASEYU
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:24:20 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53629 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab0ASEYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:24:15 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 410BC81805F;
	Tue, 19 Jan 2010 05:23:58 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D02EB818068;
	Tue, 19 Jan 2010 05:23:55 +0100 (CET)
X-git-sha1: bde4bd10547fc90d7461ef33de4d542d9a4d4269 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137420>

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

The table below shows what happens when running
"git reset --keep target" to reset the HEAD to another
commit (as a special case "target" could be the same as
HEAD).

working index HEAD target         working index HEAD
----------------------------------------------------
  A      B     C     D   --keep    (disallowed)
  A      B     C     C   --keep     A      C     C
  B      B     C     D   --keep    (disallowed)
  B      B     C     C   --keep     B      C     C

In this table, A, B and C are some different states of
a file. For example the last line of the table means
that if a file is in state B in the working tree and
the index, and in a different state C in HEAD and in
the target, then "git reset --keep target" will put
the file in state B in the working tree, and in state
C in the index and in HEAD.

The following table shows what happens on unmerged entries:

working index HEAD target         working index HEAD
----------------------------------------------------
 X       U     A    B     --keep  (disallowed)
 X       U     A    A     --keep   X       A     A

In this table X can be any state and U means an unmerged
entry.

Though the error message when "reset --keep" is disallowed
on unmerged entries is something like:

error: Entry 'file1' would be overwritten by merge. Cannot merge.
fatal: Could not reset index file to revision 'HEAD^'.

which is not very nice.

A following patch will add some test cases for "--keep".

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
 builtin-reset.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index 0f5022e..da61f20 100644
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
@@ -229,6 +242,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
 				"reset HEAD, index and working tree", MERGE),
+		OPT_SET_INT(0, "keep", &reset_type,
+				"reset HEAD but keep local changes", KEEP),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		OPT_END()
 	};
@@ -317,9 +332,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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
1.6.6.271.gc8799
