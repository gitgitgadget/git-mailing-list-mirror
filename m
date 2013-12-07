From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 1/4] subtree: support split --rejoin --squash
Date: Sat,  7 Dec 2013 11:21:22 -0700
Message-ID: <1386440485-3092-1-git-send-email-mmogilvi_git@miniinfo.net>
References: <1B2468D5-F0B7-4D11-8710-A3A7C8D66215@gmail.com>
Cc: greened@obbligato.org, amdmi3@amdmi3.ru, john@keeping.me.uk,
	techlivezheng@gmail.com, apenwarr@gmail.com,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 19:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpMYP-0006F9-9P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 19:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab3LGSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 13:24:19 -0500
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:44013 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754624Ab3LGSYR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 13:24:17 -0500
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id yiD81m0081wfjNsA1iQHaP; Sat, 07 Dec 2013 18:24:17 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id yiQE1m00d1UYGSS8jiQFKz; Sat, 07 Dec 2013 18:24:16 +0000
Received: from rand.mmogilvi.local (rand.mmogilvi.local [192.168.30.68])
	by mmogilvi.dynu.net (Postfix) with ESMTP id 9F95C1E9601A;
	Sat,  7 Dec 2013 11:24:14 -0700 (MST)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1B2468D5-F0B7-4D11-8710-A3A7C8D66215@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1386440657;
	bh=RT7CY0FbrBruvtuZ9CmLmhcOFYR56zeam8CqLxD/IRY=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=tbeAcdcmtgVbkyMwb9G+K4w4nw1pyQt3b3+ec4SS8gsLuGrCYyh1R9l4YjUTPFg/H
	 9laY3+oMngsGnk403419IBcRmzegHPWs12R91/VMOO/HQcMAhVAdIw8+Fya53GMHRv
	 +0zfw5bsJIMpA7hiKBLvhtGVGY9gAw/RKABu9+imSqDARB4G70+R8LWwY9AOgp0qvB
	 GqXT6EQI0D7cSnyFm4vi66ZwGz2xfyT/7HJqoOrkS//KClpLiF4l9bgDLph9mtB/2o
	 waZHKURZGfFa9NvNhLsLFHzzaf+9dKq5O//LACgrJaZ6gOX+lIl9d2xaT8OYlYzKQl
	 EluekjgVziREw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239009>

Allow using --squash with "git subtree split --rejoin".  It
will still split off (and save to --branch) the complete
subtree history, but the merge done for the "--rejoin" will
be merging a squashed representation of the new subtree
commits, instead of the commits themselves (similar to
how "git subtree merge --squash" works).

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I can think of a couple of possible objections to this patch.
Are these (or any others) worth fixing?

1. Perhaps someone want the saved subtree (--branch) to have
   a squashed representation as well, as an option?  Maybe we
   need two different --squash options?  Something
   like "--rejoin-squash"?
2. It could definitely use some automated tests.  In fact,
   pre-existing --squash functionality is hardly tested at
   all, either.
      See patch 4 comments for a script I use to help with
   mostly-manual testing.



 contrib/subtree/git-subtree.sh  | 60 +++++++++++++++++++++++++++++++----------
 contrib/subtree/git-subtree.txt | 27 ++++++++++++-------
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d7af03..998a9c5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -20,14 +20,13 @@ q             quiet
 d             show debug messages
 P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
+squash        merge subtree changes as a single commit
  options for 'split'
 annotate=     add a prefix to commit message of new commits
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
- options for 'add', 'merge', 'pull' and 'push'
-squash        merge subtree changes as a single commit
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
@@ -229,13 +228,19 @@ find_latest_squash()
 	sq=
 	main=
 	sub=
+	par1=
+	par2=
 	git log --grep="^git-subtree-dir: $dir/*\$" \
-		--pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
-	while read a b junk; do
-		debug "$a $b $junk"
+		--pretty=format:'START %H %P%n%s%n%n%b%nEND%n' HEAD |
+	while read a b c d junk; do
+		debug "$a $b $c $d $junk"
 		debug "{{$sq/$main/$sub}}"
 		case "$a" in
-			START) sq="$b" ;;
+			START)
+				sq="$b"
+				par1="$c"
+				par2="$d"
+				;;
 			git-subtree-mainline:) main="$b" ;;
 			git-subtree-split:) sub="$b" ;;
 			END)
@@ -243,7 +248,8 @@ find_latest_squash()
 					if [ -n "$main" ]; then
 						# a rejoin commit?
 						# Pretend its sub was a squash.
-						sq="$sub"
+						assert [ "$main" = "$par1" ]
+						sq="$par2"
 					fi
 					debug "Squash found: $sq $sub"
 					echo "$sq" "$sub"
@@ -252,6 +258,8 @@ find_latest_squash()
 				sq=
 				main=
 				sub=
+				par1=
+				par2=
 				;;
 		esac
 	done
@@ -565,6 +573,13 @@ cmd_split()
 	debug "Splitting $dir..."
 	cache_setup || exit $?
 	
+	if [ -n "$rejoin" ]; then
+		ensure_clean
+		if [ -n "$squash" ]; then
+			first_split="$(find_latest_squash "$dir")"
+		fi
+	fi
+
 	if [ -n "$onto" ]; then
 		debug "Reading history for --onto=$onto..."
 		git rev-list $onto |
@@ -630,13 +645,6 @@ cmd_split()
 		die "No new revisions were found"
 	fi
 	
-	if [ -n "$rejoin" ]; then
-		debug "Merging split branch into HEAD..."
-		latest_old=$(cache_get latest_old)
-		git merge -s ours \
-			-m "$(rejoin_msg $dir $latest_old $latest_new)" \
-			$latest_new >&2 || exit $?
-	fi
 	if [ -n "$branch" ]; then
 		if rev_exists "refs/heads/$branch"; then
 			if ! rev_is_descendant_of_branch $latest_new $branch; then
@@ -649,6 +657,30 @@ cmd_split()
 		git update-ref -m 'subtree split' "refs/heads/$branch" $latest_new || exit $?
 		say "$action branch '$branch'"
 	fi
+	if [ -n "$rejoin" ]; then
+		debug "Merging split branch into HEAD..."
+		latest_old=$(cache_get latest_old)
+		new=$latest_new
+
+		if [ -n "$squash" ]; then
+			debug "Squashing split branch."
+
+			set $first_split
+			old=$1
+			sub=$2
+			if [ "$sub" = "$latest_new" ]; then
+				say "Subtree is already at commit $latest_new."
+				exit 0
+			fi
+			new=$(new_squash_commit "$old" "$sub" "$latest_new") \
+				|| exit $?
+			debug "New squash commit: $new"
+		fi
+
+		git merge -s ours -m \
+			"$(rejoin_msg $dir $latest_old $latest_new)" \
+			$new >&2 || exit $?
+	fi
 	echo $latest_new
 	exit 0
 }
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index e0957ee..92e7a4d 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -140,18 +140,20 @@ OPTIONS
 	want to manipulate.  This option is mandatory
 	for all commands.
 
+
+OPTIONS FOR add, merge, pull, rejoin
+----------------------------------
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge and pull (unsure).
-	Specify <message> as the commit message for the merge commit.
+	This option is only valid for add, merge, pull, and
+	split '--rejoin'.
 
+	Specify <message> as the commit message for the merge commit.
 
-OPTIONS FOR add, merge, push, pull
-----------------------------------
 --squash::
-	This option is only valid for add, merge, push and pull
-	commands.
-
+	This option is only valid for add, merge, pull, and
+	split '--rejoin'.
+
 	Instead of merging the entire history from the subtree
 	project, produce only a single commit that contains all
 	the differences you want to merge, and then merge that
@@ -180,6 +182,10 @@ OPTIONS FOR add, merge, push, pull
 	local repository remain intact and can be later split
 	and send upstream to the subproject.
 
+	Using '--squash' with split '--rejoin' only squashes
+	the merge back to the mainline, not the synthetic subtree
+	history.
+
 
 OPTIONS FOR split
 -----------------
@@ -251,9 +257,10 @@ OPTIONS FOR split
 	showing an extra copy of every new commit that was
 	created (the original, and the synthetic one).
 	
-	If you do all your merges with '--squash', don't use
-	'--rejoin' when you split, because you don't want the
-	subproject's history to be part of your project anyway.
+	Fortunately, you can use '--squash' with '--rejoin'
+	to simplify a sequence of synthetic commits as a
+	single squashed commit in the mainline.  The subtree
+	will still have full history.
 
 
 EXAMPLE 1. Add command
-- 
1.8.3.2
