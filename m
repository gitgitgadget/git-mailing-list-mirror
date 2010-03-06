From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 6/7] cherry-pick: add a no-op --no-ff option to future
	proof scripts
Date: Sat, 06 Mar 2010 21:34:45 +0100
Message-ID: <20100306203447.2960.5046.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6EB-0003Eu-MU
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495Ab0CGC2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:28:06 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45509 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab0CGC1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:51 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 77D81818052;
	Sun,  7 Mar 2010 03:27:40 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4F2AB818082;
	Sun,  7 Mar 2010 03:27:37 +0100 (CET)
X-git-sha1: 317ad7685603fef14597d8d78e8e9dda87b10aae 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141640>

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
 builtin/revert.c                  |    6 +++++-
 t/t3506-cherry-pick-ff.sh         |    8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

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
index 476f41e..0651e34 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -36,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
+static int edit, no_replay, no_commit, mainline, signoff, allow_ff, no_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static const char *commit_name;
@@ -63,11 +63,13 @@ static void parse_args(int argc, const char **argv)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (action == CHERRY_PICK) {
 		struct option cp_extra[] = {
 			OPT_BOOLEAN(0, "ff", &allow_ff, "allow fast-forward"),
+			OPT_BOOLEAN(0, "no-ff", &no_ff, "disallow fast forward"),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
@@ -297,6 +299,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die("cherry-pick --ff cannot be used with -x");
 		if (edit)
 			die("cherry-pick --ff cannot be used with --edit");
+		if (no_ff)
+			die("cherry-pick --ff cannot be used with --no-ff");
 	}
 
 	if (read_cache() < 0)
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
1.7.0.1.307.g861f4
