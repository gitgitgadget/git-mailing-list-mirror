From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] reset: add option "--merge-dirty" to "git reset"
Date: Thu, 10 Sep 2009 22:23:31 +0200
Message-ID: <20090910202333.3722.37592.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 22:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlqBh-0001WS-Fk
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 22:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbZIJUYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbZIJUYB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 16:24:01 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49971 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbZIJUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 16:23:58 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 81CEF818197;
	Thu, 10 Sep 2009 22:23:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 754368181C3;
	Thu, 10 Sep 2009 22:23:50 +0200 (CEST)
X-git-sha1: 4fc8eff960ebcb537edf65df5f5888a2d3beaa6b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090910200334.3722.20140.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128141>

From: Stephan Beyer <s-beyer@gmx.net>

This option is nearly like "--merge" except that it is
a little bit safer as it seems that it tries to keep
changes in the index. On the contrary "--merge", only
keep changes in the work tree.

This will be shown in the next patch that adds some
test cases for "--merge-dirty".

In fact with "--merge-dirty", changes that are both in
the work tree and the index are kept in the work tree
after the reset (but discarded in the index). As with
"--merge", changes that are in both the work tree and
the index are discarded after the reset.

So "--merge-dirty" is probably a very bad name for
this new option. Perhaps "--merge-safe" is better?

The code comes from the sequencer GSoC project:

git://repo.or.cz/git/sbeyer.git

(at commit 5a78908b70ceb5a4ea9fd4b82f07ceba1f019079)

Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-reset.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index ddb81f3..be7aa8d 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -22,13 +22,15 @@
 #include "cache-tree.h"
 
 static const char * const git_reset_usage[] = {
-	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
+	"git reset [--mixed | --soft | --hard | --merge | --merge-dirty] [-q] [<commit>]",
 	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
 };
 
-enum reset_type { MIXED, SOFT, HARD, MERGE, NONE };
-static const char *reset_type_names[] = { "mixed", "soft", "hard", "merge", NULL };
+enum reset_type { MIXED, SOFT, HARD, MERGE, MERGE_DIRTY, NONE };
+static const char *reset_type_names[] = {
+	"mixed", "soft", "hard", "merge", "merge_dirty", NULL
+};
 
 static char *args_to_str(const char **argv)
 {
@@ -84,6 +86,7 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 	case MERGE:
 		opts.update = 1;
 		break;
+	case MERGE_DIRTY:
 	case HARD:
 		opts.update = 1;
 		/* fallthrough */
@@ -95,6 +98,16 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 
 	read_cache_unmerged();
 
+	if (reset_type == MERGE_DIRTY) {
+		unsigned char *head_sha1;
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
+		OPT_SET_INT(0, "merge-dirty", &reset_type,
+				"reset HEAD, index and working tree",
+				MERGE_DIRTY),
 		OPT_BOOLEAN('q', NULL, &quiet,
 				"disable showing new HEAD in hard reset and progress message"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
@@ -324,9 +340,13 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (reset_type == SOFT) {
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
+	} else {
+		int err = reset_index_file(sha1, reset_type, quiet);
+		if (reset_type == MERGE_DIRTY)
+			err = err || reset_index_file(sha1, MIXED, quiet);
+		if (err)
+			die("Could not reset index file to revision '%s'.", rev);
 	}
-	else if (reset_index_file(sha1, reset_type, quiet))
-		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
 	 * saving the previous head in ORIG_HEAD before. */
-- 
1.6.4.271.ge010d
