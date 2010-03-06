From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/7] revert: add --ff option to allow fast forward when
	cherry-picking
Date: Sat, 06 Mar 2010 21:34:42 +0100
Message-ID: <20100306203447.2960.42019.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6E9-0003Eu-5H
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab0CGC1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:27:52 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45489 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398Ab0CGC1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:48 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8343F818096;
	Sun,  7 Mar 2010 03:27:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 40B2F818068;
	Sun,  7 Mar 2010 03:27:36 +0100 (CET)
X-git-sha1: d12fc0bb436a731c91201df6c17aadb760538283 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141637>

From: Junio C Hamano <gitster@pobox.com>

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
 builtin/revert.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index eff5268..476f41e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "merge-recursive.h"
+#include "refs.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -35,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff;
+static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static const char *commit_name;
@@ -60,8 +61,19 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
+		OPT_END(),
+		OPT_END(),
 	};
 
+	if (action == CHERRY_PICK) {
+		struct option cp_extra[] = {
+			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_END(),
+		};
+		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
+			die("program error");
+	}
+
 	if (parse_options(argc, argv, NULL, options, usage_str, 0) != 1)
 		usage_with_options(usage_str, options);
 
@@ -244,6 +256,17 @@ static NORETURN void die_dirty_index(const char *me)
 	}
 }
 
+static int fast_forward_to(const unsigned char *to, const unsigned char *from)
+{
+	struct ref_lock *ref_lock;
+
+	read_cache();
+	if (checkout_fast_forward(from, to))
+		exit(1); /* the callee should have complained already */
+	ref_lock = lock_any_ref_for_update("HEAD", from, 0);
+	return write_ref_sha1(ref_lock, to, "cherry-pick");
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -265,6 +288,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	if (action == REVERT && !no_replay)
 		die("revert is incompatible with replay");
 
+	if (allow_ff) {
+		if (signoff)
+			die("cherry-pick --ff cannot be used with --signoff");
+		if (no_commit)
+			die("cherry-pick --ff cannot be used with --no-commit");
+		if (no_replay)
+			die("cherry-pick --ff cannot be used with -x");
+		if (edit)
+			die("cherry-pick --ff cannot be used with --edit");
+	}
+
 	if (read_cache() < 0)
 		die("git %s: failed to read the index", me);
 	if (no_commit) {
@@ -284,8 +318,6 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	}
 	discard_cache();
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	if (!commit->parents) {
 		if (action == REVERT)
 			die ("Cannot revert a root commit");
@@ -314,6 +346,9 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	else
 		parent = commit->parents->item;
 
+	if (allow_ff && !hashcmp(parent->object.sha1, head))
+		return fast_forward_to(commit->object.sha1, head);
+
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));
@@ -343,6 +378,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	oneline = get_oneline(message);
 
+	index_fd = hold_locked_index(&index_lock, 1);
+
 	if (action == REVERT) {
 		char *oneline_body = strchr(oneline, ' ');
 
-- 
1.7.0.1.307.g861f4
