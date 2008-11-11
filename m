From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 9/9 v4] bisect: add "--no-replace" option to bisect without
 using replace branches
Date: Tue, 11 Nov 2008 06:46:07 +0100
Message-ID: <20081111064607.e5632ed9.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 06:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzm3t-0005aj-8y
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 06:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYKKFny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 00:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYKKFny
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 00:43:54 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:37203 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbYKKFnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 00:43:53 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id EA7201972E;
	Tue, 11 Nov 2008 06:43:51 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id A58FA19713;
	Tue, 11 Nov 2008 06:43:51 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100624>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    6 +++++-
 git-bisect.sh                |   26 ++++++++++++++++++++------
 t/t6035-bisect-replace.sh    |   10 ++++++++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 3834a34..ce8d7c1 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,7 +16,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect help
- git bisect start [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--no-replace] [<bad> [<good>...]] [--] [<paths>...]
  git bisect bad [<rev>]
  git bisect good [<rev>...]
  git bisect skip [<rev>...]
@@ -247,6 +247,10 @@ As the branches created by "git bisect replace" can be shared between
 developers, this feature might be especially usefull on big projects
 where many people often bisect the same code base.
 
+If you give the `--no-replace` to "git bisect start", then the
+"bisect-replace-*" branches will not be used for the bisection you
+start.
+
 Bisect run
 ~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index be37b64..5a65ab5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|replace|run]'
 LONG_USAGE='git bisect help
         print this long help message.
-git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--no-replace] [<bad> [<good>...]] [--] [<pathspec>...]
         reset bisect state and start bisection.
 git bisect bad [<rev>]
         mark <rev> a known-bad revision.
@@ -119,6 +119,10 @@ bisect_start() {
 		shift
 		break
 		;;
+	    --no-replace)
+		shift
+		touch "$GIT_DIR/BISECT_NO_REPLACE"
+		;;
 	    *)
 		rev=$(git rev-parse -q --verify "$arg^{commit}") || {
 		    test $has_double_dash -eq 1 &&
@@ -386,6 +390,16 @@ We continue anyway.
 EOF
 }
 
+replace_option() {
+	test -f "$GIT_DIR/BISECT_NO_REPLACE" ||
+		echo "--bisect-replace"
+}
+
+no_replace_option() {
+	test ! -f "$GIT_DIR/BISECT_NO_REPLACE" ||
+		echo "--no-bisect-replace"
+}
+
 #
 # "check_merge_bases" checks that merge bases are not "bad".
 #
@@ -401,7 +415,7 @@ check_merge_bases() {
 	_bad="$1"
 	_good="$2"
 	_skip="$3"
-	for _mb in $(git merge-base --all --bisect-replace $_bad $_good)
+	for _mb in $(git merge-base --all $(replace_option) $_bad $_good)
 	do
 		if is_among "$_mb" "$_good"; then
 			continue
@@ -436,7 +450,7 @@ check_good_are_ancestors_of_bad() {
 	# Bisecting with no good rev is ok
 	test -z "$_good" && return
 
-	_side=$(git rev-list --bisect-replace $_good ^$_bad)
+	_side=$(git rev-list $(replace_option) $_good ^$_bad)
 	if test -n "$_side"; then
 		# Return if a checkout was done
 		check_merge_bases "$_bad" "$_good" "$_skip" || return
@@ -465,9 +479,8 @@ bisect_next() {
 	test "$?" -eq "1" && return
 
 	# Get bisection information
-	BISECT_OPT=''
-	test -n "$skip" && BISECT_OPT='--bisect-all'
-	eval="git rev-list --bisect-vars $BISECT_OPT $good $bad --" &&
+	BISECT_OPTS="$(no_replace_option) --bisect-vars ${skip:+--bisect-all}"
+	eval="git rev-list $BISECT_OPTS $good $bad --" &&
 	eval="$eval $(cat "$GIT_DIR/BISECT_NAMES")" &&
 	eval=$(filter_skipped "$eval" "$skip") &&
 	eval "$eval" || exit
@@ -534,6 +547,7 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash || exit
 	done
+	rm -f "$GIT_DIR/BISECT_NO_REPLACE" &&
 	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
 	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
 	rm -f "$GIT_DIR/BISECT_LOG" &&
diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
index f22a2e5..b9cc739 100755
--- a/t/t6035-bisect-replace.sh
+++ b/t/t6035-bisect-replace.sh
@@ -164,6 +164,16 @@ test_expect_success '"git rev-list --no-bisect-replace" works' '
      grep $HASH4 rev_list.txt
 '
 
+test_expect_success 'git bisect works with --no-replace' '
+     git bisect start --no-replace $HASH5 $HASH1 &&
+     test "$(git rev-parse --verify HEAD)" = "$HASH3" &&
+     git bisect good &&
+     test "$(git rev-parse --verify HEAD)" = "$HASH4" &&
+     git bisect bad > my_bisect_log.txt &&
+     grep "$HASH4 is first bad commit" my_bisect_log.txt &&
+     git bisect reset
+'
+
 #
 #
 test_done
-- 
1.6.0.3.614.g0f3b9
