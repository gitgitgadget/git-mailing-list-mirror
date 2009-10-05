From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Mon, 5 Oct 2009 15:35:16 -0400
Message-ID: <20091005193516.GB20078@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <4AC9D952.3050108@viscovery.net>
 <20091005115308.GA2122@coredump.intra.peff.net>
 <7vljjpacax.fsf@alter.siamese.dyndns.org>
 <20091005191257.GA24305@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MutNC-0003iR-FW
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 21:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbZJETgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbZJETgD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 15:36:03 -0400
Received: from peff.net ([208.65.91.99]:43714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbZJETgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 15:36:02 -0400
Received: (qmail 19696 invoked by uid 107); 5 Oct 2009 19:38:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 15:38:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 15:35:16 -0400
Content-Disposition: inline
In-Reply-To: <20091005191257.GA24305@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129582>

On Mon, Oct 05, 2009 at 03:12:57PM -0400, Jeff King wrote:

> > I think you are right.
> 
> Nope, I'm not. I figured out one more case that it needs to handle.
> Revised patch coming up in a few minutes.

OK, here it is, which I think covers all of the cases. I also re-wrapped
the text, as I agree with JSixt that it was pretty ugly. I also
re-wrapped some of the existing text, as it gave the very choppy:

  Your configuration specifies to merge the ref
  'foo' from the remote, but no such ref
  was fetched.

It would be really nice to just pipe it through 'fmt', but I suspect
that will create portability problems.

-- >8 --
Subject: [PATCH] pull: improve advice for unconfigured error case

There are several reasons a git-pull invocation might not
have anything marked for merge:

  1. We're not on a branch, so there is no branch
     configuration.

  2. We're on a branch, but there is no configuration for
     this branch.

  3. We fetched from the configured remote, but the
     configured branch to merge didn't get fetched (either
     it doesn't exist, or wasn't part of the fetch refspec).

  4. We fetched from the non-default remote, but didn't
     specify a branch to merge. We can't use the configured
     one because it applies to the default remote.

  5. We fetched from a specified remote, and a refspec was
     given, but it ended up not fetching anything (this is
     actually hard to do; if the refspec points to a remote
     branch and it doesn't exist, then fetch will fail and
     we never make it to this code path. But if you provide
     a wildcard refspec like

       refs/bogus/*:refs/remotes/origin/*

     then you can see this failure).

We have handled (1) and (2) for some time. Recently, commit
a6dbf88 added code to handle case (3).

This patch handles cases (4) and (5), which previously just
fell under other cases, producing a confusing message.

While we're at it, let's rewrap the text for case (3), which
looks terribly ugly as it is.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-pull.sh |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index edf3ce3..8b0b6f6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -90,8 +90,17 @@ error_on_no_merge_candidates () {
 
 	curr_branch=${curr_branch#refs/heads/}
 	upstream=$(git config "branch.$curr_branch.merge")
+	remote=$(git config "branch.$curr_branch.remote")
 
-	if [ -z "$curr_branch" ]; then
+	if [ $# -gt 1 ]; then
+		echo "There are no candidates for merging in the refs that you just fetched."
+		echo "Generally this means that you provided a wildcard refspec which had no"
+		echo "matches on the remote end."
+	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
+		echo "You asked to pull from the remote '$1', but did not specify"
+		echo "a branch to merge. Because this is not the default configured remote"
+		echo "for your current branch, you must specify a branch on the command line."
+	elif [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
 		echo "'branch.<branchname>.merge' in your configuration file."
 		echo "Please specify which branch you want to merge on the command"
@@ -116,9 +125,8 @@ error_on_no_merge_candidates () {
 		echo
 		echo "See git-config(1) for details."
 	else
-		echo "Your configuration specifies to merge the ref"
-		echo "'${upstream#refs/heads/}' from the remote, but no such ref"
-		echo "was fetched."
+		echo "Your configuration specifies to merge the ref '${upstream#refs/heads/}' from the"
+		echo "remote, but no such ref was fetched."
 	fi
 	exit 1
 }
-- 
1.6.5.rc2.219.g00ca
