From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 2/2] Introduce git am --abort
Date: Wed, 16 Jul 2008 22:45:21 +0200
Message-ID: <9915f89fa819f7cd59de9913e08d831a37bbf418.1216233919.git.s-beyer@gmx.net>
References: <5f60ea3acffdb5dfdbe0ea6e81133efadab9f20d.1216233919.git.s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 22:46:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDtS-0004T8-Px
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbYGPUpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756710AbYGPUpd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:45:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:32944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756115AbYGPUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:45:32 -0400
Received: (qmail invoked by alias); 16 Jul 2008 20:45:30 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp058) with SMTP; 16 Jul 2008 22:45:30 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+WDHk2UWaWkOTGtPsdKHADoIvf0opaqx0EAHC5yq
	BnPmTe/B6PUJHc
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KJDsI-0005o2-Gh; Wed, 16 Jul 2008 22:45:22 +0200
X-Mailer: git-send-email 1.5.6.3.390.g7b30
In-Reply-To: <5f60ea3acffdb5dfdbe0ea6e81133efadab9f20d.1216233919.git.s-beyer@gmx.net> 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88751>

Currently, aborting a git-am process during a conflict is done by
resetting to the HEAD before applying the patches and removing the
.git/rebase directory manually.

This patch introduces an --abort option for git-am to make this as
easy as in git-rebase.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/git-am.txt               |    5 ++++-
 Documentation/git-rerere.txt           |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-am.sh                              |   19 ++++++++++++-------
 git-rebase.sh                          |    8 +++-----
 t/t4150-am.sh                          |   21 +++++++++++++++++----
 6 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 2d7f162..df35cee 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,7 @@ SYNOPSIS
          [--3way] [--interactive] [--binary]
          [--whitespace=<option>] [-C<n>] [-p<n>]
 	 [<mbox> | <Maildir>...]
-'git am' (--skip | --resolved)
+'git am' (--abort | --skip | --resolved)
 
 DESCRIPTION
 -----------
@@ -79,6 +79,9 @@ default.   You could use `--no-utf8` to override this.
 --interactive::
 	Run interactively.
 
+--abort::
+	Abort applying and rewind applied patches.
+
 --skip::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 678bfd3..ad81dbc 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -37,7 +37,7 @@ its working state.
 'clear'::
 
 This resets the metadata used by rerere if a merge resolution is to be
-is aborted.  Calling 'git-am --skip' or 'git-rebase [--skip|--abort]'
+is aborted.  Calling 'git-am [--skip|--abort]' or 'git-rebase [--skip|--abort]'
 will automatically invoke this command.
 
 'diff'::
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 29f6cd4..d271ba0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -489,7 +489,7 @@ _git_am ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}" dir="$(__gitdir)"
 	if [ -d "$dir"/rebase ]; then
-		__gitcomp "--skip --resolved"
+		__gitcomp "--skip --resolved --abort"
 		return
 	fi
 	case "$cur" in
diff --git a/git-am.sh b/git-am.sh
index e36f22c..7301314 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -8,6 +8,7 @@ OPTIONS_SPEC="\
 git-am [options] [<mbox>|<Maildir>...]
 git-am [options] --resolved
 git-am [options] --skip
+git-am [options] --abort
 --
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
@@ -22,6 +23,7 @@ p=              pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
+abort           abort patching and reset done patches
 rebasing        (internal use for git-rebase)"
 
 . git-sh-setup
@@ -108,7 +110,7 @@ print_continue_info () {
 }
 
 run_sequencer () {
-	git sequencer $noadvice --caller='git am||--resolved|--skip' "$@"
+	git sequencer $noadvice --caller='git am|--abort|--resolved|--skip' "$@"
 	case "$?" in
 	0)
 		cleanup
@@ -130,7 +132,7 @@ run_sequencer_i () {
 	while true
 	do
 		output=$(git sequencer $noadvice \
-			--caller='git am -i||--resolved|--skip' \
+			--caller='git am -i|--abort|--resolved|--skip' \
 			$command 2>&1 >/dev/null)
 		noadvice=
 		case "$?" in
@@ -170,6 +172,8 @@ do
 	case "$1" in
 	-i|--interactive)
 		interactive=_i ;;
+	--abort)
+		abort=t ;;
 	-b|--binary)
 		binary=t ;;
 	-3|--3way)
@@ -219,17 +223,18 @@ then
 	# unreliable -- stdin could be /dev/null for example
 	# and the caller did not intend to feed us a patch but
 	# wanted to continue unattended.
-	test -z "$resolved$skip" && tty -s
+	test -z "$abort$resolved$skip" && tty -s
 
+	test -n "$abort" && run_sequencer$interactive --abort
 	test -n "$resolved" && run_sequencer$interactive --continue
 	test -n "$skip" && run_sequencer$interactive --skip
 
-	die "$dotest still exists. Use git am --skip/--resolved."
+	die "$dotest still exists. Use git am --abort/--skip/--resolved."
 fi
 
-# Make sure we are not given --skip nor --resolved
-test -z "$resolved$skip" ||
-	die 'git-am is not in progress. You cannot use --skip/--resolved then.'
+# Make sure we are not given --skip nor --resolved nor --abort
+test -z "$abort$resolved$skip" ||
+	die 'git-am is not in progress. You cannot use --abort/--skip/--resolved then.'
 
 # sequencer running?
 git sequencer --status >/dev/null 2>&1 &&
diff --git a/git-rebase.sh b/git-rebase.sh
index 231c486..a83933b 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -216,13 +216,11 @@ do
 		if test -d "$dotest"
 		then
 			move_to_original_branch
+			git reset --hard $(cat "$dotest/orig-head")
+			rm -r "$dotest"
 		else
-			dotest="$GIT_DIR"/rebase
-			move_to_original_branch
+			git am --abort
 		fi
-		rm -rf "$GIT_DIR/sequencer"
-		git reset --hard $(cat "$dotest/orig-head")
-		rm -r "$dotest"
 		exit
 		;;
 	--onto)
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index e771806..152e2d9 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -83,6 +83,10 @@ test_expect_success setup '
 	git commit -m third &&
 	git format-patch --stdout first >patch2	&&
 	git checkout -b lorem &&
+	echo new >another &&
+	git add another &&
+	test_tick &&
+	git commit -m "added another file" &&
 	sed -n -e "11,\$p" msg >file &&
 	head -n 9 msg >>file &&
 	test_tick &&
@@ -181,8 +185,8 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 '
 
 test_expect_success 'am pauses on conflict' '
-	git checkout lorem2^^ &&
-	! git am lorem-move.patch &&
+	git checkout lorem2~3 &&
+	test_must_fail git am lorem-move.patch &&
 	test -d .git/rebase
 '
 
@@ -193,9 +197,18 @@ test_expect_success 'am --skip works' '
 	test goodbye = "$(cat another)"
 '
 
+test_expect_success 'am --abort works' '
+	git checkout lorem2~3 &&
+	test_must_fail git am lorem-move.patch &&
+	test -d .git/rebase &&
+	git am --abort &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse lorem2~3)" &&
+	! test -f another
+'
+
 test_expect_success 'am --resolved works' '
-	git checkout lorem2^^ &&
-	! git am lorem-move.patch &&
+	git checkout lorem2~3 &&
+	test_must_fail git am lorem-move.patch &&
 	test -d .git/rebase &&
 	echo resolved >>file &&
 	git add file &&
-- 
1.5.6.3.391.g7ab7e
