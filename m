From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Tue, 24 Jun 2008 18:09:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806241808400.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBC4Q-0002LA-Qf
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760858AbYFXRLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760849AbYFXRLc
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:11:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:44497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760820AbYFXRLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:11:30 -0400
Received: (qmail invoked by alias); 24 Jun 2008 17:11:28 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp045) with SMTP; 24 Jun 2008 19:11:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/culNOn2HcDlw99KHIlDNnkYGmrRextsTmyJWhCC
	SmHO+daLtxCBgA
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806241750030.9925@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86089>


When you look for a fix instead of a regression, it can be quite hard
to twist your brain into choosing the correct bisect command between
'git bisect bad' and 'git bisect good'.

So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 24 Jun 2008, Johannes Schindelin wrote:

	> Okay, that's 3 people who I take the courage from to turn this 
	> into a proper patch.

	And this is my first attempt at a proper patch for it.

	Now with documentation, and hopefully all places where the
	user is being told about a "bad" commit.

 Documentation/git-bisect.txt |   16 ++++++++++++++++
 git-bisect.sh                |   25 ++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 3ca0d33..3fb3b11 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,6 +26,9 @@ on the subcommand:
  git bisect log
  git bisect run <cmd>...
 
+ git bisect fixed [<rev>]
+ git bisect unfixed [<rev>...]
+
 This command uses 'git-rev-list --bisect' option to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
@@ -76,6 +79,19 @@ bad", and ask for the next bisection.
 Until you have no more left, and you'll have been left with the first
 bad kernel rev in "refs/bisect/bad".
 
+Searching for fixes instead of regressions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sometimes you need to find a fix, not a regression.  The bisection
+machinery is really the same for this, but it might be tricky to remember
+to mark a commit "bad" when it contains the fix.
+
+So synonyms for "bad" and "good" are available, "fixed" and "unfixed"
+respectively.
+
+To mark a commit that contains the fix, call "git bisect fixed", and
+"git bisect unfixed" if it does not contain the fix.
+
 Bisect reset
 ~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 8b11107..6e71e1a 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|fixed|unfixed|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -24,6 +24,13 @@ git bisect log
 git bisect run <cmd>...
         use <cmd>... to automatically bisect.
 
+When not looking for a regression, but a fix instead, you can use
+
+git bisect fixed [<rev>]
+	mark <rev> as having the fix you are looking for
+git bisect unfixed [<rev>]
+	mark <rev> as not having the fix you are looking for
+
 Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
@@ -216,7 +223,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		echo >&2 'Warning: bisecting only with a bad (or fixed) commit.'
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -231,7 +238,7 @@ bisect_next_check() {
 			THEN='then '
 		}
 		echo >&2 'You '$THEN'need to give me at least one good' \
-			'and one bad revisions.'
+			'and one bad (or fixed) revision.'
 		echo >&2 '(You can use "git bisect bad" and' \
 			'"git bisect good" for that.)'
 		exit 1 ;;
@@ -324,7 +331,7 @@ exit_if_skipped_commits () {
 	_tried=$1
 	if expr "$_tried" : ".*[|].*" > /dev/null ; then
 		echo "There are only 'skip'ped commit left to test."
-		echo "The first bad commit could be any of:"
+		echo "The first bad (or fixed) commit could be any of:"
 		echo "$_tried" | tr '[|]' '[\012]'
 		echo "We cannot bisect more!"
 		exit 2
@@ -356,7 +363,7 @@ bisect_next() {
 	fi
 	if [ "$bisect_rev" = "$bad" ]; then
 		exit_if_skipped_commits "$bisect_tried"
-		echo "$bisect_rev is first bad commit"
+		echo "$bisect_rev is first bad (or fixed) commit"
 		git diff-tree --pretty $bisect_rev
 		exit 0
 	fi
@@ -474,7 +481,8 @@ bisect_run () {
 
       cat "$GIT_DIR/BISECT_RUN"
 
-      if grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+      if grep "first bad (or fixed) commit could be any of" \
+			"$GIT_DIR/BISECT_RUN" \
 		> /dev/null; then
 	  echo >&2 "bisect run cannot continue any more"
 	  exit $res
@@ -486,7 +494,8 @@ bisect_run () {
 	  exit $res
       fi
 
-      if grep "is first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+      if grep "is first bad (or fixed) commit" \
+		"$GIT_DIR/BISECT_RUN" > /dev/null; then
 	  echo "bisect run success"
 	  exit 0;
       fi
@@ -501,6 +510,8 @@ case "$#" in
 *)
     cmd="$1"
     shift
+    test $cmd = fixed && cmd=bad
+    test $cmd = unfixed && cmd=good
     case "$cmd" in
     help)
         git bisect -h ;;
-- 
1.5.6.173.gde14c
