From: Jeff King <peff@peff.net>
Subject: Re: Odd problems trying to build an orphaned branch
Date: Thu, 5 Nov 2015 19:20:48 -0500
Message-ID: <20151106002048.GC9963@sigill.intra.peff.net>
References: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
 <20151106001832.GB9963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: alan@clueserver.org
X-From: git-owner@vger.kernel.org Fri Nov 06 01:20:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuUm0-0003MA-2M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 01:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965627AbbKFAUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 19:20:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:53773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965414AbbKFAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 19:20:51 -0500
Received: (qmail 14339 invoked by uid 102); 6 Nov 2015 00:20:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 18:20:51 -0600
Received: (qmail 20601 invoked by uid 107); 6 Nov 2015 00:21:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 19:21:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 19:20:48 -0500
Content-Disposition: inline
In-Reply-To: <20151106001832.GB9963@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280950>

On Thu, Nov 05, 2015 at 07:18:32PM -0500, Jeff King wrote:

> Of course that leaves only the problem that filter-branch is
> horrendously slow (for the kernel, most of the time goes to populating
> the index for each commit; I think filter-branch could probably learn to
> skip this step if there is no index or tree filter at work).

Here's a totally untested patch that seems to make a filter-branch like
this on the kernel orders of magnitude faster:

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 27c9c54..9df5185 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -306,6 +306,13 @@ then
 	start_timestamp=$(date '+%s')
 fi
 
+if test -n "$filter_index" || test -n "$filter_tree"
+then
+	need_index=t
+else
+	need_index=
+fi
+
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
 
@@ -313,7 +320,10 @@ while read commit parents; do
 
 	case "$filter_subdir" in
 	"")
-		GIT_ALLOW_NULL_SHA1=1 git read-tree -i -m $commit
+		if test -n "$need_index"
+		then
+			GIT_ALLOW_NULL_SHA1=1 git read-tree -i -m $commit
+		fi
 		;;
 	*)
 		# The commit may not have the subdirectory at all
@@ -387,8 +397,15 @@ while read commit parents; do
 	} <../commit |
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
+
+	if test -n "$need_index"
+	then
+		tree=$(git write-tree)
+	else
+		tree="$commit^{tree}"
+	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+		"$tree" $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
 done <../revs
 
