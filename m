From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC] git-clone: add --copy-remotes option
Date: Fri, 9 Feb 2007 03:07:20 -0500
Message-ID: <20070209080720.GA19750@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFQn0-0004T5-Pz
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946195AbXBIIHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 03:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946197AbXBIIHX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:07:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3441 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946195AbXBIIHX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:07:23 -0500
Received: (qmail 10657 invoked from network); 9 Feb 2007 03:07:25 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Feb 2007 03:07:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2007 03:07:20 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39158>

When invoked as

  git clone --copy-remotes origin:grandparent parent child

the repo 'child' will clone and track all branches of the parent's
refs/remotes/origin/*, storing them as refs/remotes/grandparent/*.

---

Since the move to separate remotes, I occasionally have the desire to
"fully" clone a repository, including its remotes. For example, I
sometimes want to work on a topic branch in a fresh working directory,
so I use "git clone -s git topic". However, later on in topic I want to
compare my work against upstream branches, but they may not have been
cloned into 'topic' (e.g., I want to look at Junio's 'next', but there
was no 'next' branch in my 'git' repository, only 'remotes/origin/next',
so it didn't get cloned).

Using this patch, I can do
  git clone -s --copy-remotes origin:junio git topic
and access the resulting branches as 'junio/next'.

Some thoughts:
  - the implementation is a little ugly, but making key/value pairs in
    shell variables is inherently ugly. Suggestions are welcome.
  - The child tracks the remote tracking branches of the parent, which
    is very simple. To solve my problem, I could instead automagically
    copy the remotes config from the parent, and the child could then
    track upstream itself. That seems a bit ugly to me (I end up with
    two repos tracking the same data, potentially downloading it twice).
  - making a mapping of names (origin -> junio) is more complex than I
    would like, but otherwise you run a high risk of collision (remote's
    origin/master becoming your origin/master conflicts with remote's
    master becoming your origin/master).

Are people interested in this?

 git-clone.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 1bd54de..1f3530b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -128,6 +128,14 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	1,--copy-remotes) usage ;;
+	*,--copy-remotes)
+		shift
+		from=`echo $1 | cut -d: -f1`
+		to=`echo $1 | cut -d: -f2`
+		eval "copy_remotes_$from=\"$to\""
+		copy_remotes="$copy_remotes $from"
+		;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -321,6 +329,17 @@ then
 			destname="refs/$branch_top/${name#refs/heads/}" ;;
 		refs/tags/*)
 			destname="refs/$tag_top/${name#refs/tags/}" ;;
+		refs/remotes/*)
+			for i in $copy_remotes; do
+			  case "$name" in
+			    refs/remotes/$i/*)
+			      eval "destremote=\$copy_remotes_$i"
+			      destname="refs/remotes/$destremote/${name#refs/remotes/$i/}"
+			      break
+			      ;;
+			  esac
+			done
+			;;
 		*)
 			continue ;;
 		esac
@@ -383,6 +402,11 @@ then
 		# Set up the mappings to track the remote branches.
 		git-config remote."$origin".fetch \
 			"+refs/heads/*:$remote_top/*" '^$' &&
+		for i in $copy_remotes; do
+			eval "destremote=\$copy_remotes_$i"
+			git-config --add remote."$origin".fetch \
+				"+refs/remotes/$i/*:refs/remotes/$destremote/*"
+		done
 		rm -f "refs/remotes/$origin/HEAD"
 		git-symbolic-ref "refs/remotes/$origin/HEAD" \
 			"refs/remotes/$origin/$head_points_at" &&
-- 
1.5.0.rc4.502.g6a6e-dirty
