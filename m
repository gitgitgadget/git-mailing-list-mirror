From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Thu, 5 Jul 2007 16:38:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051636240.9789@racer.site>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
 <20070705135824.GB5493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 05 17:38:24 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6TPT-0003Xe-B5
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 17:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946AbXGEPiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 11:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbXGEPiU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 11:38:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:57769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757875AbXGEPiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 11:38:19 -0400
Received: (qmail invoked by alias); 05 Jul 2007 15:38:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 05 Jul 2007 17:38:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SIGB0HN4SpAU5AWyPJ6wR7rxKiqnqIQvRIG9lJu
	tS8FmOKmP0uzai
X-X-Sender: gene099@racer.site
In-Reply-To: <20070705135824.GB5493@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51679>

Hi,

On Thu, 5 Jul 2007, Jeff King wrote:

> status=`((cmd1; echo $? >&3) | cmd2) 3>&1`

Cute.

This is the replacement patch, then (I guess there are still some nits to 
be had, so I did not redo the proper patch yet):

 git-filter-branch.sh |   43 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
old mode 100644
new mode 100755
index 6cf67df..f08288d
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -28,6 +28,16 @@ map()
 	fi
 }
 
+# override die(): this version puts in an extra line break, so that
+# the progress is still visible
+
+die()
+{
+	echo \ >&2
+	echo "$*" >&2
+	exit 1
+}
+
 # When piped a commit, output a script to set the ident of either
 # "author" or "committer
 
@@ -181,23 +191,29 @@ while read commit parents; do
 	export GIT_COMMIT=$commit
 	git cat-file commit "$commit" >../commit
 
-	eval "$(set_ident AUTHOR <../commit)"
-	eval "$(set_ident COMMITTER <../commit)"
-	eval "$filter_env" < /dev/null
+	eval "$(set_ident AUTHOR <../commit)" ||
+		die "setting author failed for commit $commit"
+	eval "$(set_ident COMMITTER <../commit)" ||
+		die "setting committer failed for commit $commit"
+	eval "$filter_env" < /dev/null ||
+		die "env filter failed: $filter_env"
 
 	if [ "$filter_tree" ]; then
 		git checkout-index -f -u -a
 		# files that $commit removed are now still in the working tree;
 		# remove them, else they would be added again
 		git ls-files -z --others | xargs -0 rm -f
-		eval "$filter_tree" < /dev/null
+		eval "$filter_tree" < /dev/null ||
+			die "tree filter failed: $filter_tree"
+
 		git diff-index -r $commit | cut -f 2- | tr '\n' '\0' | \
 			xargs -0 git update-index --add --replace --remove
 		git ls-files -z --others | \
 			xargs -0 git update-index --add --replace --remove
 	fi
 
-	eval "$filter_index" < /dev/null
+	eval "$filter_index" < /dev/null ||
+		die "index filter failed: $filter_index"
 
 	parentstr=
 	for parent in $parents; do
@@ -206,13 +222,17 @@ while read commit parents; do
 		done
 	done
 	if [ "$filter_parent" ]; then
-		parentstr="$(echo "$parentstr" | eval "$filter_parent")"
+		parentstr="$(echo "$parentstr" | eval "$filter_parent")" ||
+				die "parent filter failed: $filter_parent"
 	fi
 
-	sed -e '1,/^$/d' <../commit | \
-		eval "$filter_msg" | \
-		sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
-			$parentstr > ../map/$commit
+	(sed -e '1,/^$/d' <../commit |
+		(eval "$filter_msg" ||
+		 die "msg filter failed: $filter_msg" 2>&3) |
+		(sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
+			$parentstr > ../map/$commit ||
+		 die "commit filter failed: $filter_commit" 2>&3)) 3>&1 |
+	 grep . && die
 done <../revs
 
 src_head=$(tail -n 1 ../revs | sed -e 's/ .*//')
@@ -249,7 +269,8 @@ if [ "$filter_tag_name" ]; then
 		[ -f "../map/$sha1" ] || continue
 		new_sha1="$(cat "../map/$sha1")"
 		export GIT_COMMIT="$sha1"
-		new_ref="$(echo "$ref" | eval "$filter_tag_name")"
+		new_ref="$(echo "$ref" | eval "$filter_tag_name")" ||
+			die "tag name filter failed: $filter_tag_name"
 
 		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
 
