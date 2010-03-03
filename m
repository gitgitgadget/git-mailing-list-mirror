From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 8/9] cherry-pick: add a no-op --no-ff option to future
	proof scripts
Date: Wed, 03 Mar 2010 21:11:43 +0100
Message-ID: <20100303201146.23506.11793.chriscool@tuxfamily.org>
References: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:05:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0Rp-0008HT-De
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab0CDCFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:41 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40591 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab0CDCFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:23 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F2A5B818096;
	Thu,  4 Mar 2010 03:05:10 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B500681807F;
	Thu,  4 Mar 2010 03:05:07 +0100 (CET)
X-git-sha1: cc36842550973b37eb45309e9f7bb5fc490c9d8c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141499>

A --ff option to allow "git cherry-pick" to fast forward if
possible was added in a previous patch, and this behavior may
become the default one in the future.

So to future proof scripts that may rely on the current behavior
it is safer to add a --no-ff option to make sure that the current
behavior will be used.

Requested-by: Paolo Bonzini <bonzini@gnu.org>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-cherry-pick.txt |    6 +++++-
 builtin/revert.c                  |    5 +++--
 t/t3506-cherry-pick-ff.sh         |    8 ++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d71607a..dfc8243 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -7,7 +7,7 @@ git-cherry-pick - Apply the change introduced by an existing commit
 
 SYNOPSIS
 --------
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>
+'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--[no-]ff] <commit>
 
 DESCRIPTION
 -----------
@@ -75,6 +75,10 @@ effect to your index in a row.
 	cherry-pick'ed commit, then a fast forward to this commit will
 	be performed.
 
+--no-ff::
+	Does nothing right now, but in the future this may disallow
+	fast forward if it becomes the default behavior.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>
diff --git a/builtin/revert.c b/builtin/revert.c
index 4799073..111853b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -36,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, ff_ok;
+static int edit, no_replay, no_commit, mainline, signoff, ff_ok, no_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static const char *commit_name;
@@ -59,6 +59,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_BOOLEAN(0, "ff", &ff_ok, "allow fast forward"),
+		OPT_BOOLEAN(0, "no-ff", &no_ff, "disallow fast forward"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
@@ -326,7 +327,7 @@ static int revert_or_cherry_pick(int argc, const char **argv, const char *prefix
 		die("%s: cannot parse parent commit %s",
 		    me, sha1_to_hex(parent->object.sha1));
 
-	if (action == CHERRY_PICK && ff_ok &&
+	if (action == CHERRY_PICK && ff_ok && !no_ff &&
 	    parent && !hashcmp(parent->object.sha1, head) &&
 	    !edit && !no_commit && !no_replay && !signoff) {
 		char *hex = sha1_to_hex(commit->object.sha1);
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index e17ae71..2d7e532 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -35,6 +35,14 @@ test_expect_success 'cherry-pick not using --ff does not fast forwards' '
 	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify second)"
 '
 
+test_expect_success 'cherry-pick using --no-ff does not fast forwards' '
+	git checkout master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick --no-ff second &&
+	test "$(git rev-parse --verify HEAD)" != "$(git rev-parse --verify second)"
+'
+
 #
 # We setup the following graph:
 #
-- 
1.7.0.315.gbc198
