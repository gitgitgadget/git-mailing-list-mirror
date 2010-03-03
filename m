From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/9] revert: add --ff option to allow fast forward when
	cherry-picking
Date: Wed, 03 Mar 2010 21:11:40 +0100
Message-ID: <20100303201146.23506.55469.chriscool@tuxfamily.org>
References: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0Ro-0008HT-Ra
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab0CDCFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40589 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617Ab0CDCFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:23 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E263D818078;
	Thu,  4 Mar 2010 03:05:09 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A4C13818070;
	Thu,  4 Mar 2010 03:05:06 +0100 (CET)
X-git-sha1: 69e2db0011d3fc339d2aa086e862f21bb2ca404f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141505>

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
 builtin/revert.c |   32 ++++++++++++++++++++++----------
 1 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index a611960..4799073 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "rerere.h"
 #include "merge-recursive.h"
+#include "reset.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -35,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff;
+static int edit, no_replay, no_commit, mainline, signoff, ff_ok;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static const char *commit_name;
@@ -57,6 +58,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('x', NULL, &no_replay, "append commit name when cherry-picking"),
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+		OPT_BOOLEAN(0, "ff", &ff_ok, "allow fast forward"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
@@ -278,7 +280,7 @@ static struct commit * check_parent(struct commit *commit, int mainline)
 	return commit->parents->item;
 }
 
-static int revert_or_cherry_pick(int argc, const char **argv)
+static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
@@ -318,18 +320,28 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	}
 	discard_cache();
 
-	index_fd = hold_locked_index(&index_lock, 1);
-
 	parent = check_parent(commit, mainline);
 
-	if (!(message = commit->buffer))
-		die ("Cannot get commit message for %s",
-				sha1_to_hex(commit->object.sha1));
-
 	if (parent && parse_commit(parent) < 0)
 		die("%s: cannot parse parent commit %s",
 		    me, sha1_to_hex(parent->object.sha1));
 
+	if (action == CHERRY_PICK && ff_ok &&
+	    parent && !hashcmp(parent->object.sha1, head) &&
+	    !edit && !no_commit && !no_replay && !signoff) {
+		char *hex = sha1_to_hex(commit->object.sha1);
+		int res = reset(hex, prefix, HARD, 0, 0, 0, NULL);
+		if (!res)
+			fprintf(stderr, "Fast-forward to %s\n", hex);
+		return res;
+	}
+
+	if (!(message = commit->buffer))
+		die ("Cannot get commit message for %s",
+		     sha1_to_hex(commit->object.sha1));
+
+	index_fd = hold_locked_index(&index_lock, 1);
+
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -457,12 +469,12 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 		edit = 1;
 	no_replay = 1;
 	action = REVERT;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	no_replay = 0;
 	action = CHERRY_PICK;
-	return revert_or_cherry_pick(argc, argv);
+	return revert_or_cherry_pick(argc, argv, prefix);
 }
-- 
1.7.0.315.gbc198
