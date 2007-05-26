From: Jeff King <peff@peff.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Sat, 26 May 2007 02:07:48 -0400
Message-ID: <20070526060748.GA20715@coredump.intra.peff.net>
References: <465750FE.9000406@iii.hu> <20070526004028.GA8940@sigill.intra.peff.net> <20070526011036.GA4169@gondor.apana.org.au> <20070526034236.GA18169@coredump.intra.peff.net> <7vps4onps0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 08:08:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrpRj-0005cg-FZ
	for gcvg-git@gmane.org; Sat, 26 May 2007 08:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbXEZGHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 02:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXEZGHv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 02:07:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbXEZGHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 02:07:51 -0400
Received: (qmail 26379 invoked from network); 26 May 2007 06:07:55 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 May 2007 06:07:55 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 May 2007 02:07:48 -0400
Content-Disposition: inline
In-Reply-To: <7vps4onps0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48452>

On Fri, May 25, 2007 at 09:59:43PM -0700, Junio C Hamano wrote:

>  * I suspect we would declare either "war on echo" or "harder push
>    for builtins" triggered by these.

Cry havoc! More fixes below (just a diff -- maybe we want to aggregate
these into a single commit?).

These are the ones I noticed that use commit messages (which are
probably the most likely to use backslash). There are _tons_ of uses for
heads and filenames. I think we either should stop with commit messages,
or go all-out and simply remove all uses of echo (because there are
literally hundreds otherwise).

> -		echo "$commit_only" |
> +		printf "%s\n" "$commit_only" |

Is "\n" portable to all shells (i.e., do you need '\n')? It works with
bash and dash, which are by far the most common, but who knows what evil
lurks in the heart of Sun?

---
diff --git a/git-am.sh b/git-am.sh
index 543efd0..8b57129 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -18,7 +18,7 @@ stop_here () {
 
 stop_here_user_resolve () {
     if [ -n "$resolvemsg" ]; then
-	    echo "$resolvemsg"
+	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
     cmdline=$(basename $0)
@@ -146,7 +146,7 @@ do
 	git_apply_opt="$git_apply_opt $1"; shift ;;
 
 	--resolvemsg=*)
-	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
+	resolvemsg=${1#--resolvemsg=}; shift ;;
 
 	--)
 	shift; break ;;
diff --git a/git-commit.sh b/git-commit.sh
diff --git a/git-merge.sh b/git-merge.sh
index 44e9b70..981d69d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -335,7 +335,7 @@ f,*)
 		then
 			echo "Wonderful."
 			result_commit=$(
-				echo "$merge_msg" |
+				printf '%s\n' "$merge_msg" |
 				git-commit-tree $result_tree -p HEAD -p "$1"
 			) || exit
 			finish "$result_commit" "In-index merge"
@@ -440,7 +440,7 @@ done
 if test '' != "$result_tree"
 then
     parents=$(git-show-branch --independent "$head" "$@" | sed -e 's/^/-p /')
-    result_commit=$(echo "$merge_msg" | git-commit-tree $result_tree $parents) || exit
+    result_commit=$(printf '%s\n' "$merge_msg" | git-commit-tree $result_tree $parents) || exit
     finish "$result_commit" "Merge made by $wt_strategy."
     dropsave
     exit 0
@@ -479,7 +479,7 @@ else
 	do
 		echo $remote
 	done >"$GIT_DIR/MERGE_HEAD"
-	echo "$merge_msg" >"$GIT_DIR/MERGE_MSG"
+	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG"
 fi
 
 if test "$merge_was_ok" = t
diff --git a/git-tag.sh b/git-tag.sh
index 4a0a7b6..6f0b7a7 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -126,7 +126,7 @@ if [ "$annotate" ]; then
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
         ${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/TAG_EDITMSG || exit
     else
-        echo "$message" >"$GIT_DIR"/TAG_EDITMSG
+        printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
     fi
 
     grep -v '^#' <"$GIT_DIR"/TAG_EDITMSG |
