From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH, next version] git bisect: introduce 'fixed' and 'unfixed'
Date: Fri, 27 Jun 2008 14:48:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271446180.9925@racer>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <20080624174157.GB9500@sigill.intra.peff.net>
 <7vej6mbh3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCEMO-00079a-6X
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbYF0Nue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYF0Nue
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:50:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:41829 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751611AbYF0Nud (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:50:33 -0400
Received: (qmail invoked by alias); 27 Jun 2008 13:50:29 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp063) with SMTP; 27 Jun 2008 15:50:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OiDxcCB7OuIpsjgbwOIcMG+PeSaE7QaWtY5kbax
	8JyOnTsnfdgc90
X-X-Sender: gene099@racer
In-Reply-To: <7vej6mbh3w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86563>


When you look for a fix instead of a regression, it can be quite hard
to twist your brain into choosing the correct bisect command between
'git bisect bad' and 'git bisect good'.

So introduce the commands 'git bisect fixed' and 'git bisect unfixed'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 24 Jun 2008, Junio C Hamano wrote:

	> Jeff King <peff@peff.net> writes:
	> 
	> > On Tue, Jun 24, 2008 at 06:09:28PM +0100, Johannes Schindelin 
	> > wrote:
	> >
	> >> 	And this is my first attempt at a proper patch for it.
	> >> 
	> >> 	Now with documentation, and hopefully all places where the
	> >> 	user is being told about a "bad" commit.
	> >
	> > This looks reasonably sane to me. The only thing I can think 
	> > of that we're missing is that "git bisect visualize" will still
	> > show the refs as "bisect/bad" and "bisect/good".
	> >
	> > To fix that, you'd have to ask people to start the bisect by 
	> > saying "I am bisecting to find a fix, not a breakage." And then
	> > you could change the refnames and all of the messages as
	> > appropriate.
	> 
	> It probably is not just a good idea, but is a necessary fix, to 
	> remove confusion like this example that appears everywhere:
	> 
	> >  		echo >&2 'You '$THEN'need to give me at least one good' \
	> > -			'and one bad revisions.'
	> > +			'and one bad (or fixed) revision.'
	> >  		echo >&2 '(You can use "git bisect bad" and' \
	> >  			'"git bisect good" for that.)'
	> 
	> People who are reading the change Dscho did in the "patch" form 
	> may not notice it, but imagine how the above looks to the end user
	> who was told that "new bisect can now look for fixes", who does
	> not need to nor even want to know that the new feature is
	> implemented by making bad and fixed synonyms.
	> 
	> They need to mentally reword "good" into "unfixed" and "bisect 
	> bad" into "bisect fixed" while reading the output from the above 
	> pieces, but the point of this new "look for fixes" feature is they do 
	> not have to do the rewording anymore!

	How about autodetecting from the user's last input what she meant?

 Documentation/git-bisect.txt |   16 ++++++++++++++++
 git-bisect.sh                |   42 ++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 12 deletions(-)

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
index 8b11107..197489b 100755
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
@@ -32,6 +39,8 @@ require_work_tree
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+GOOD="good"
+BAD="bad"
 
 sq() {
 	@@PERL@@ -e '
@@ -216,7 +225,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		echo >&2 'Warning: bisecting only with a $BAD commit.'
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -230,10 +239,10 @@ bisect_next_check() {
 			echo >&2 'You need to start by "git bisect start".'
 			THEN='then '
 		}
-		echo >&2 'You '$THEN'need to give me at least one good' \
-			'and one bad revisions.'
-		echo >&2 '(You can use "git bisect bad" and' \
-			'"git bisect good" for that.)'
+		echo >&2 'You '$THEN'need to give me at least one $GOOD' \
+			'and one $BAD revision.'
+		echo >&2 '(You can use "git bisect $BAD" and' \
+			'"git bisect $GOOD" for that.)'
 		exit 1 ;;
 	esac
 }
@@ -250,7 +259,7 @@ eval_rev_list() {
 
 	if [ $res -ne 0 ]; then
 		echo >&2 "'git rev-list --bisect-vars' failed:"
-		echo >&2 "maybe you mistake good and bad revs?"
+		echo >&2 "maybe you mistake $GOOD and $BAD revs?"
 		exit $res
 	fi
 
@@ -324,7 +333,7 @@ exit_if_skipped_commits () {
 	_tried=$1
 	if expr "$_tried" : ".*[|].*" > /dev/null ; then
 		echo "There are only 'skip'ped commit left to test."
-		echo "The first bad commit could be any of:"
+		echo "The first $BAD commit could be any of:"
 		echo "$_tried" | tr '[|]' '[\012]'
 		echo "We cannot bisect more!"
 		exit 2
@@ -351,12 +360,12 @@ bisect_next() {
 	eval "$eval" || exit
 
 	if [ -z "$bisect_rev" ]; then
-		echo "$bad was both good and bad"
+		echo "$bad was both $GOOD and $BAD"
 		exit 1
 	fi
 	if [ "$bisect_rev" = "$bad" ]; then
 		exit_if_skipped_commits "$bisect_tried"
-		echo "$bisect_rev is first bad commit"
+		echo "$bisect_rev is first $BAD commit"
 		git diff-tree --pretty $bisect_rev
 		exit 0
 	fi
@@ -474,7 +483,8 @@ bisect_run () {
 
       cat "$GIT_DIR/BISECT_RUN"
 
-      if grep "first bad commit could be any of" "$GIT_DIR/BISECT_RUN" \
+      if grep "first $BAD commit could be any of" \
+			"$GIT_DIR/BISECT_RUN" \
 		> /dev/null; then
 	  echo >&2 "bisect run cannot continue any more"
 	  exit $res
@@ -486,7 +496,8 @@ bisect_run () {
 	  exit $res
       fi
 
-      if grep "is first bad commit" "$GIT_DIR/BISECT_RUN" > /dev/null; then
+      if grep "is first $BAD commit" \
+		"$GIT_DIR/BISECT_RUN" > /dev/null; then
 	  echo "bisect run success"
 	  exit 0;
       fi
@@ -502,6 +513,13 @@ case "$#" in
     cmd="$1"
     shift
     case "$cmd" in
+    fixed|unfixed)
+	BAD="fixed"
+	GOOD="unfixed"
+	test "$cmd" = fixed && cmd=bad
+	test "$cmd" = unfixed && cmd=good
+    esac
+    case "$cmd" in
     help)
         git bisect -h ;;
     start)
-- 
1.5.6.173.gde14c
