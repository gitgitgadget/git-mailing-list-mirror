From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 13:11:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281307420.27959@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMhW-0006yx-Uo
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 14:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbXK1NLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 08:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbXK1NLT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 08:11:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:40082 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754408AbXK1NLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 08:11:18 -0500
Received: (qmail invoked by alias); 28 Nov 2007 13:11:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 28 Nov 2007 14:11:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2mIgqY4z2KAIm0qZ8OV+tIvIfvrbIsJvxuw2yC6
	sOmvsllcCHKbyu
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66317>


When calling 'git pull' with the '--rebase' option, it performs a
fetch + rebase instead of a fetch + pull.

This behavior is more desirable than fetch + pull when a topic branch
is ready to be submitted and needs to be update.

fetch + rebase might also be considered a better workflow with shared
repositories in any case, or for contributors to a centrally managed
repository, such as WINE's.

As a convenience, you can set the default behavior for a branch by
defining the config variable branch.<name>.rebase, which is
interpreted as a bool.  This setting can be overridden on the command
line by --rebase and --no-rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 27 Nov 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > ...
	> > I do not want to go into _that_ many details here, since the 
	> > place to look for it is git-rebase.txt.  Probably I should 
	> > have done that in the first place.
	> >
	> > So how about this instead:
	> >
	> > \--rebase::
	> > 	Instead of a merge, perform a rebase after fetching.
	> > 	*NOTE:* This is a potentially _dangerous_ mode of operation.
	> > 	It rewrites history, which does not bode well when you
	> > 	published that history already.  Do _not_ use this option
	> > 	unless you have	read gitlink:git-rebase[1] carefully.
	> >
	> > Hmm?
	> 
	> Okay.

	I also added documentation for the branch.<name>.rebase variable.

 Documentation/config.txt   |    7 +++++++
 Documentation/git-pull.txt |   10 ++++++++++
 git-pull.sh                |   11 ++++++++++-
 t/t5520-pull.sh            |   22 ++++++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 645514d..7bebc9a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -360,6 +360,13 @@ branch.<name>.mergeoptions::
 	option values containing whitespace characters are currently not
 	supported.
 
+branch.<name>.rebase::
+	When true, rebase the branch <name> on top of the fetched branch,
+	instead of merging the default branch from the default remote.
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand the implications (see gitlink:git-rebase[1]
+	for details).
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e1eb2c1..d4d26af 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -33,6 +33,16 @@ include::urls-remotes.txt[]
 
 include::merge-strategies.txt[]
 
+\--rebase::
+	Instead of a merge, perform a rebase after fetching.
+	*NOTE:* This is a potentially _dangerous_ mode of operation.
+	It rewrites history, which does not bode well when you
+	published that history already.  Do *not* use this option
+	unless you have read gitlink:git-rebase[1] carefully.
+
+\--no-rebase::
+	Override earlier \--rebase.
+
 DEFAULT BEHAVIOUR
 -----------------
 
diff --git a/git-pull.sh b/git-pull.sh
index 30fdc57..698e82b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -17,6 +17,9 @@ test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
 strategy_args= no_summary= no_commit= squash= no_ff=
+curr_branch=$(git symbolic-ref -q HEAD)
+curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
+rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
@@ -52,6 +55,12 @@ do
 		esac
 		strategy_args="${strategy_args}-s $strategy "
 		;;
+	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+		rebase=true
+		;;
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+		rebase=false
+		;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -95,7 +104,6 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	curr_branch=$(git symbolic-ref -q HEAD)
 	case $? in
 	  0) ;;
 	  1) echo >&2 "You are not currently on a branch; you must explicitly"
@@ -142,5 +150,6 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+test true = "$rebase" && exec git-rebase $merge_head
 exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 93eaf2c..52b3a0c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -53,4 +53,26 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test `cat file` = modified
 '
 
+test_expect_success '--rebase' '
+	git branch to-rebase &&
+	echo modified again > file &&
+	git commit -m file file &&
+	git checkout to-rebase &&
+	echo new > file2 &&
+	git add file2 &&
+	git commit -m "new file" &&
+	git tag before-rebase &&
+	git pull --rebase . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
+test_expect_success 'branch.to-rebase.rebase' '
+	git reset --hard before-rebase &&
+	git config branch.to-rebase.rebase 1 &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
 test_done
-- 
1.5.3.6.2064.g4e322
