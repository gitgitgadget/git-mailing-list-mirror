From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/9] revert: add --ff option to allow fast forward when
	cherry-picking
Date: Sat, 06 Feb 2010 00:11:07 +0100
Message-ID: <20100205231112.3689.67634.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXLg-0008Fb-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933111Ab0BEXMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:08 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53990 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932319Ab0BEXMC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:12:02 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DF3448180A9;
	Sat,  6 Feb 2010 00:11:51 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CC908818034;
	Sat,  6 Feb 2010 00:11:48 +0100 (CET)
X-git-sha1: 69a3f2657d09101aabfd1951327831a813256806 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139111>

As "git merge" fast forwards if possible, it seems sensible to
have such a feature for "git cherry-pick" too, especially as it
could be used in git-rebase--interactive.sh.

Maybe this option could be made the default in the long run, with
another --no-ff option to disable this default behavior, but that
could make some scripts backward incompatible and/or that would
require testing if some GIT_AUTHOR_* environment variables are
set. So we don't do that for now.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-revert.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 7488d4c..b78926f 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "pick.h"
+#include "reset.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -31,13 +32,19 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_commit, mainline, signoff;
+static int edit, no_commit, mainline, signoff, ff_ok;
 static int flags;
 static struct commit *commit;
 static int allow_rerere_auto;
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
+static void die_if_ff_incompatible(int opt_set, const char *opt_name)
+{
+	if (opt_set)
+		die ("options --ff and %s are incompatible", opt_name);
+}
+
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
@@ -51,6 +58,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BIT('x', NULL, &flags, "append commit name when cherry-picking", PICK_ADD_NOTE),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+		OPT_BOOLEAN(0, "ff", &ff_ok, "allow fast forward"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
@@ -71,6 +79,12 @@ static void parse_args(int argc, const char **argv)
 	}
 	if (commit->object.type != OBJ_COMMIT)
 		die ("'%s' does not point to a commit", arg);
+	if (ff_ok) {
+		die_if_ff_incompatible(edit, "--edit");
+		die_if_ff_incompatible(flags & PICK_ADD_NOTE, "-x");
+		die_if_ff_incompatible(no_commit, "--no-commit");
+		die_if_ff_incompatible(signoff, "--signoff");
+	}
 }
 
 static char *get_encoding(const char *message)
@@ -191,7 +205,7 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	const char *me;
 	struct strbuf msgbuf;
@@ -209,6 +223,19 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (!no_commit && index_differs_from("HEAD", 0))
 		die_dirty_index(me);
 
+	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
+		unsigned char head_sha1[20];
+		if (get_sha1("HEAD", head_sha1))
+			die("You do not have a valid HEAD.");
+		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
+			char *hex = sha1_to_hex(commit->object.sha1);
+			int res = reset(hex, prefix, HARD, 0, 0, 0, NULL);
+			if (!res)
+				fprintf(stderr, "Fast-forward to %s\n", hex);
+			return res;
+		}
+	}
+
 	if (!commit->buffer)
 		return error("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
@@ -270,11 +297,11 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	if (isatty(0))
 		edit = 1;
 	flags = PICK_REVERSE | PICK_ADD_NOTE;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	flags = 0;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
-- 
1.6.6.1.557.g77031
