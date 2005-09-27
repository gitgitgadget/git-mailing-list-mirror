From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix default pull not to do an unintended Octopus.
Date: Tue, 27 Sep 2005 00:38:53 -0700
Message-ID: <7vu0g72c4y.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<87psqwzs3x.fsf@ualberta.net>
	<7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
	<1127765852.5735.36.camel@cashmere.sps.mot.com>
	<7vr7bba3lo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 27 09:40:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKA3W-0007n2-Ai
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 09:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVI0Hiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 03:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVI0Hiz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 03:38:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38556 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964849AbVI0Hiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 03:38:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927073853.LFHW29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 03:38:53 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 26 Sep 2005 15:03:47 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9378>

This is what I ended up doing Sunday night before the discussion
started, and what I still have in the proposed updates branch.

It implements the 'when puling using a shorthand without
explicitly telling which refs to pull, only use the first ref
found from Pull: lines for merging -- creating Octopus using all
default refs is not useful 99.99% of the time' behaviour I
outlined yesterday.

I think it could be modified without too much pain to take
"which heads to use for merge by default" information from
separate "Merge: " line as Jon proposed, if enough people like
that idea better.  Personally I do not think it would make much
practical difference from the end users' point of view, but I've
been proven wrong more often than not in the past, so...

As Pasky said in another thread, git-fetch is not the most
elegantly written script on earth, and it is not my favorite
script either -- it needs to do complex things, like interacting
with the later git-pull stage.

------------
The refspecs specified in the .git/remotes/<remote> on the "Pull: "
lines are for fetching multiple heads in one go, but most of the time
making an Octopus out of them is not what is wanted.  Make git-fetch
leave the marker in .git/FETCH_HEAD file so that later stages can
tell which heads are for merging and which are not.

Tom Prince made me realize how stupid the original behaviour was.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fetch.sh           |   32 ++++++++++++++++++++++++++++----
 git-fmt-merge-msg.perl |    4 +++-
 git-parse-remote.sh    |   11 +++++++++--
 git-pull.sh            |    4 +++-
 4 files changed, 43 insertions(+), 8 deletions(-)

44dbc712fe3dd045550123e1cc689c41482c62e5
diff --git a/git-fetch.sh b/git-fetch.sh
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -54,6 +54,10 @@ append_fetch_head () {
     remote_name_="$3"
     remote_nick_="$4"
     local_name_="$5"
+    case "$6" in
+    t) not_for_merge_='not-for-merge' ;;
+    '') not_for_merge_= ;;
+    esac
 
     # remote-nick is the URL given on the command line (or a shorthand)
     # remote-name is the $GIT_DIR relative refs/ path we computed
@@ -78,10 +82,11 @@ append_fetch_head () {
     if git-cat-file commit "$head_" >/dev/null 2>&1
     then
 	headc_=$(git-rev-parse --verify "$head_^0") || exit
-	echo "$headc_	$note_" >>$GIT_DIR/FETCH_HEAD
+	echo "$headc_	$not_for_merge_	$note_" >>$GIT_DIR/FETCH_HEAD
 	echo >&2 "* committish: $head_"
 	echo >&2 "  $note_"
     else
+	echo "$head_	not-for-merge	$note_" >>$GIT_DIR/FETCH_HEAD
 	echo >&2 "* non-commit: $head_"
 	echo >&2 "  $note_"
     fi
@@ -157,6 +162,13 @@ do
 
     # These are relative path from $GIT_DIR, typically starting at refs/
     # but may be HEAD
+    if expr "$ref" : '\.' >/dev/null
+    then
+	not_for_merge=t
+	ref=$(expr "$ref" : '\.\(.*\)')
+    else
+	not_for_merge=
+    fi
     if expr "$ref" : '\+' >/dev/null
     then
 	single_force=t
@@ -216,7 +228,8 @@ do
 	continue ;;
     esac
 
-    append_fetch_head "$head" "$remote" "$remote_name" "$remote_nick" "$local_name"
+    append_fetch_head "$head" "$remote" \
+    	"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
 
 done
 
@@ -241,16 +254,27 @@ http://* | https://* | rsync://* )
 	    case "$ref" in
 	    +$remote_name:*)
 		single_force=t
+		not_for_merge=
+		found="$ref"
+		break ;;
+	    .+$remote_name:*)
+		single_force=t
+		not_for_merge=t
+		found="$ref"
+		break ;;
+	    .$remote_name:*)
+	        not_for_merge=t
 		found="$ref"
 		break ;;
 	    $remote_name:*)
+	    	not_for_merge=
 		found="$ref"
 		break ;;
 	    esac
 	done
-
 	local_name=$(expr "$found" : '[^:]*:\(.*\)')
-	append_fetch_head "$sha1" "$remote" "$remote_name" "$remote_nick" "$local_name"
+	append_fetch_head "$sha1" "$remote" \
+		"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
     done || exit
     ;;
 esac
diff --git a/git-fmt-merge-msg.perl b/git-fmt-merge-msg.perl
--- a/git-fmt-merge-msg.perl
+++ b/git-fmt-merge-msg.perl
@@ -31,6 +31,8 @@ while (<>) {
 	my ($bname, $tname, $gname, $src);
 	chomp;
 	s/^[0-9a-f]*	//;
+	next if (/^not-for-merge/);
+	s/^	//;
 	if (s/ of (.*)$//) {
 		$src = $1;
 	} else {
@@ -86,7 +88,7 @@ for my $src (@src) {
 			    $src{$src}{GENERIC});
 	my $this = join(', ', @this);
 	if ($src ne '.') {
-		$this .= " from $src";
+		$this .= " of $src";
 	}
 	push @msg, $this;
 }
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -65,8 +65,11 @@ get_remote_default_refs_for_push () {
 	esac
 }
 
-# Subroutine to canonicalize remote:local notation
+# Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
+	# Leave only the first one alone; add prefix . to the rest
+	# to prevent the secondary branches to be merged by default.
+	dot_prefix=
 	for ref
 	do
 		force=
@@ -91,7 +94,8 @@ canon_refs_list_for_fetch () {
 		heads/* | tags/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
-		echo "${force}${remote}:${local}"
+		echo "${dot_prefix}${force}${remote}:${local}"
+		dot_prefix=.
 	done
 }
 
@@ -107,6 +111,9 @@ get_remote_default_refs_for_fetch () {
 		echo "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
+		# This prefixes the second and later default refspecs
+		# with a '.', to signal git-fetch to mark them
+		# not-for-merge.
 		canon_refs_list_for_fetch $(sed -ne '/^Pull: */{
 						s///p
 					}' "$GIT_DIR/remotes/$1")
diff --git a/git-pull.sh b/git-pull.sh
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -24,7 +24,9 @@ then
 		die "You need to first update your working tree."
 fi
 
-merge_head=$(sed -e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | tr '\012' ' ')
+merge_head=$(sed -e '/	not-for-merge	/d' \
+	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
+	tr '\012' ' ')
 
 case "$merge_head" in
 '')
