From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: [DRAFT] Create stash from index state
Date: Sat, 14 Feb 2009 23:39:29 +0100
Message-ID: <20090214223929.GA29472@chistera.yi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 23:41:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYTCG-0002Af-R2
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZBNWjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZBNWjf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:39:35 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1708
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZBNWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:39:33 -0500
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 57BAE801C015
	for <git@vger.kernel.org>; Sat, 14 Feb 2009 23:39:31 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LYTAX-0007hd-Fc
	  for git@vger.kernel.org; Sat, 14 Feb 2009 23:39:29 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109946>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I've always missed a way to do what `bzr shelve` does: interactive
stash, where you just select hunks à-la `add -p`, and then those gets
stashed away.

I've recently realized that git-stash doesn't need to know how to prompt
for changes, and that just a --from-index flag that would stash the
state of the index would be simpler and (at least in my eyes) very git-ish.

Do you think such a flag would be appropriate? I've prepared a
preliminary, but I need help with the part that removes the index
changes from the working tree (a partial git-reset --hard). I know
"checkout stash && checkout -" would do it, but I really don't know how
to do that with low-level plumbing (unless git-checkout is actually okay
for this.) Any suggestions?

Additionally, I have two behaviors I'd like in stash: the ability to
apply/pop on top of a dirty state, perhaps with a -f flag (at the moment
I'm just doing `commit -a -m foo && pop && reset HEAD^`), and the
ability to --amend the last stash state, as in "oh, add this to the last
stash please". Thoughts?

Many thanks in advance,

-- 
Adeodato Simó                                     dato at net.com.org.es
Debian Developer                                  adeodato at debian.org
 
When all is summed up, a man never speaks of himself without loss; his
accusations of himself are always believed; his praises never.
                -- Michel de Montaigne

--nFreZHaLTZJo0R7j
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="git-stash.diff"

diff --git a/git-stash.sh b/git-stash.sh
index b9ace99..0b6f5bd 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -67,26 +67,32 @@ create_stash () {
 		git commit-tree $i_tree -p $b_commit) ||
 		die "Cannot save the current index state"
 
-	# state of the working tree
-	w_tree=$( (
-		rm -f "$TMP-index" &&
-		cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
-		GIT_INDEX_FILE="$TMP-index" &&
-		export GIT_INDEX_FILE &&
-		git read-tree -m $i_tree &&
-		git add -u &&
-		git write-tree &&
-		rm -f "$TMP-index"
-	) ) ||
-		die "Cannot save the current worktree state"
-
-	# create the stash
 	if test -z "$stash_msg"
 	then
 		stash_msg=$(printf 'WIP on %s' "$msg")
 	else
 		stash_msg=$(printf 'On %s: %s' "$branch" "$stash_msg")
 	fi
+
+	if test -z "$from_index"
+	then
+		# state of the working tree
+		w_tree=$( (
+			rm -f "$TMP-index" &&
+			cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
+			GIT_INDEX_FILE="$TMP-index" &&
+			export GIT_INDEX_FILE &&
+			git read-tree -m $i_tree &&
+			git add -u &&
+			git write-tree &&
+			rm -f "$TMP-index"
+		) ) ||
+			die "Cannot save the current worktree state"
+	else
+		w_tree="$i_tree"
+	fi
+
+	# create the stash
 	w_commit=$(printf '%s\n' "$stash_msg" |
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
 		die "Cannot record working tree state"
@@ -94,10 +100,22 @@ create_stash () {
 
 save_stash () {
 	keep_index=
+	from_index=
 	case "$1" in
 	--keep-index)
 		keep_index=t
 		shift
+		if [ "$1" = "--from-index" ]; then
+			die "--keep-index and --from-index are incompatible"
+		fi
+		;;
+	--from-index)
+		from_index=t
+		shift
+		if [ "$1" = "--keep-index" ]; then
+			die "--from-index and --keep-index are incompatible"
+		fi
+		;;
 	esac
 
 	stash_msg="$*"
@@ -120,7 +138,14 @@ save_stash () {
 		die "Cannot save the current status"
 	printf 'Saved working directory and index state "%s"\n' "$stash_msg"
 
-	git reset --hard
+	if test -z "$from_index"
+	then
+		git reset --hard
+	else
+		# XXX Use plumbing. How?
+		git checkout stash
+		git checkout -
+	fi
 
 	if test -n "$keep_index" && test -n $i_tree
 	then

--nFreZHaLTZJo0R7j--
