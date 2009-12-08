From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/6] reset: add option "--keep-local-changes" to "git reset"
Date: Tue, 08 Dec 2009 08:56:12 +0100
Message-ID: <20091208075616.4475.31260.chriscool@tuxfamily.org>
References: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 09:05:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHv4P-00014T-C4
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZLHIEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 03:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbZLHIEu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:04:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38854 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbZLHIEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 03:04:44 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 38789818124;
	Tue,  8 Dec 2009 09:04:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D0579818064;
	Tue,  8 Dec 2009 09:04:38 +0100 (CET)
X-git-sha1: eaa6b94c1d60ce94612b5df78f815a45b407df54 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091208075005.4475.26582.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134838>

The purpose of this new option is to discard some of the
last commits but to keep current changes in the work tree
and the index.

The table below shows what happens when running
"git reset --option target" to reset the HEAD to another
commit (as a special case "target" could be the same as
HEAD) in the cases where "--merge" and
"--keep-local-changes" (abreviated --k-l-c) behave
differently.

working index HEAD target         working index HEAD
----------------------------------------------------
  B      B     A     A   --k-l-c    B      A     A
                         --merge    A      A     A
  B      B     A     C   --k-l-c       (disallowed)
                         --merge    C      C     C

In this table, A, B and C are some different states of
a file. For example the first line of the table means
that if a file is in state B in the working tree and
the index, and in a different state A in HEAD and in
the target, then "git reset --keep-local-changes target"
will put the file in state B in the working tree and in
state A in the index and HEAD.

So as can be seen in the table, "--merge" discards changes
in the index, while "--keep-local-changes" does not. So
if one wants to avoid using "git stash" before and after
using "git reset" to save current changes, it is better to
use "--keep-local-changes" rather than "--merge".

The following table shows what happens on unmerged entries:

working index HEAD target         working index HEAD
----------------------------------------------------
 X       U     A    B     --k-l-c  X       B     B
                          --merge  X       B     B
 X       U     A    A     --k-l-c  X       A     A
                          --merge (disallowed)

In this table X can be any state and U means an unmerged
entry.

A following patch will add some test cases for
"--keep-local-changes", where the differences between
"--merge" and "--keep-local-changes" can also be seen.

The "--keep-local-changes" option is implemented by doing
a 2 way merge between HEAD and the reset target, and if
this succeeds by doing a mixed reset to the target.

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
index ddb81f3..3cbc4fd 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -22,13 +22,15 @@
 #include "cache-tree.h"
 
 static const char * const git_reset_usage[] = {
-	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
+	"git reset [--mixed | --soft | --hard | --merge | --keep-local-changes] [-q] [<commit>]",
 	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, NONE };
-static const char *reset_type_names[] = { "mixed", "soft", "hard", "merge", NULL };
+enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP_LOCAL_CHANGES, NONE };
+static const char *reset_type_names[] = {
+	"mixed", "soft", "hard", "merge", "keep_local_changes", NULL
+};
 
 static char *args_to_str(const char **argv)
 {
@@ -81,6 +83,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 	if (!quiet)
 		opts.verbose_update = 1;
 	switch (reset_type) {
+	case KEEP_LOCAL_CHANGES:
 	case MERGE:
 		opts.update = 1;
 		break;
@@ -95,6 +98,16 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 
 	read_cache_unmerged();
 
+	if (reset_type == KEEP_LOCAL_CHANGES) {
+		unsigned char head_sha1[20];
+		if (get_sha1("HEAD", head_sha1))
+			return error("You do not have a valid HEAD.");
+		if (parse_and_init_tree_desc(head_sha1, desc))
+			return error("Failed to find tree of HEAD.");
+		nr++;
+		opts.fn = twoway_merge;
+	}
+
 	if (parse_and_init_tree_desc(sha1, desc + nr - 1))
 		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
 	if (unpack_trees(nr, desc, &opts))
@@ -238,6 +251,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				"reset HEAD, index and working tree", HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
 				"reset HEAD, index and working tree", MERGE),
+		OPT_SET_INT(0, "keep-local-changes", &reset_type,
+				"reset HEAD but keep local changes",
+				KEEP_LOCAL_CHANGES),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
@@ -324,9 +340,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == SOFT) {
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
+	} else {
+		int err = reset_index_file(sha1, reset_type, quiet);
+		if (reset_type == KEEP_LOCAL_CHANGES)
+			err = err || reset_index_file(sha1, MIXED, quiet);
+		if (err)
+			die("Could not reset index file to revision '%s'.", rev);
 	}
-	else if (reset_index_file(sha1, reset_type, quiet))
-		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
 	 * saving the previous head in ORIG_HEAD before. */
-- 
1.6.5.1.gaf97d
