From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/12] revert: add --ff option to allow fast forward when
	cherry-picking
Date: Sun, 28 Feb 2010 23:22:03 +0100
Message-ID: <20100228222208.2260.59537.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrXn-0006Rr-T1
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032152Ab0B1WW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:57 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48569 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032134Ab0B1WWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D433581812A;
	Sun, 28 Feb 2010 23:22:40 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C0F93818111;
	Sun, 28 Feb 2010 23:22:37 +0100 (CET)
X-git-sha1: c50ea90edc2b21abfa9401b10c439dd617fbf767 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141285>

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
 builtin/revert.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 764cd41..b3e1fea 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "pick.h"
+#include "reset.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -31,7 +32,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_commit, mainline, signoff;
+static int edit, no_commit, mainline, signoff, ff_ok;
 static int flags;
 static struct commit *commit;
 static const char *commit_name;
@@ -39,6 +40,12 @@ static int allow_rerere_auto;
 
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
@@ -65,6 +73,12 @@ static void parse_args(int argc, const char **argv)
 	commit = lookup_commit_reference(sha1);
 	if (!commit)
 		exit(1);
+	if (ff_ok) {
+		die_if_ff_incompatible(edit, "--edit");
+		die_if_ff_incompatible(flags & PICK_ADD_NOTE, "-x");
+		die_if_ff_incompatible(no_commit, "--no-commit");
+		die_if_ff_incompatible(signoff, "--signoff");
+	}
 }
 
 static char *get_encoding(const char *message)
@@ -187,7 +201,7 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	const char *me;
 	struct strbuf msgbuf;
@@ -206,6 +220,25 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (!no_commit && index_differs_from("HEAD", 0))
 		die_dirty_index(me);
 
+	failed = check_parent(commit, mainline, flags, &parent);
+	if (failed)
+		return failed;
+
+	if (ff_ok && parent) {
+		unsigned char head_sha1[20];
+
+		if (get_sha1("HEAD", head_sha1))
+			die("You do not have a valid HEAD.");
+
+		if (!hashcmp(parent->object.sha1, head_sha1)) {
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
@@ -218,10 +251,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 					git_commit_encoding, encoding)))
 		commit->buffer = reencoded_message;
 
-	failed = check_parent(commit, mainline, flags, &parent);
-	if (failed)
-		return failed;
-
 	failed = pick_commit(commit, parent, flags, &msgbuf);
 	if (failed < 0) {
 		exit(1);
@@ -271,11 +300,11 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
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
1.7.0.321.g2d270
