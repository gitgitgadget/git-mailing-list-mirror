From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sat, 12 Sep 2009 17:11:19 -0400
Message-ID: <20090912211119.GA30966@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 23:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmZsZ-000299-TL
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 23:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbZILVLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 17:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZILVLW
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 17:11:22 -0400
Received: from peff.net ([208.65.91.99]:41724 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198AbZILVLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 17:11:21 -0400
Received: (qmail 14321 invoked by uid 107); 12 Sep 2009 21:11:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Sep 2009 17:11:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Sep 2009 17:11:19 -0400
Content-Disposition: inline
In-Reply-To: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128298>

On Sat, Sep 12, 2009 at 11:01:45PM +0300, John Tapsell wrote:

>   So anyway, I tried to do a "git pull" and it gives me the misleading error:
> 
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.master.merge' in
> your configuration file does not tell me either.  Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details on the refspec.
>
> [...]
>
> But the actual problem is that "master" doesn't exist on origin.  So
> basically I _have_ told it what branch.master.remote and
> branch.master.merge etc is, it's just that they don't appear to exist.

Ugh. That is horrible. It's an artifact of the (IMHO) brain-dead way
that pull and fetch interact.

Pull doesn't actually look at the configuration at all. It just calls
fetch, and then fetch writes out a file containing the refs it pulled,
some of which may be marked with a magic "not-for-merge" flag. So we see
that nothing is available for merging and guess that it must not have
been configured. Which is of course wrong in your case; it just didn't
exist.

I think it is enough for git-pull to just check whether the config
exists, and if so, guess that the ref was simply not fetched. IOW,
this:

-- >8 --
Subject: [PATCH] pull: make "nothing to merge" error message more accurate

When pull sees that no branches are available for merge and
that we have a current branch, it assumes the problem is
that we had no branch.*.merge configuration. But it may also
be the case that we simply didn't pull the configured ref
(probably because it doesn't exist). Let's distinguish those
two cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-pull.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0bbd5bf..4ddd537 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -89,6 +89,9 @@ error_on_no_merge_candidates () {
 	done
 
 	curr_branch=${curr_branch#refs/heads/}
+	upstream=`git config "branch.$curr_branch.merge" ||
+		  git config "branch.$curr_branch.rebase"`
+	upstream_short=`echo "$upstream" | sed "s|refs/heads/||"`
 
 	if [ -z "$curr_branch" ]; then
 		echo "You are not currently on a branch, so I cannot use any"
@@ -96,7 +99,7 @@ error_on_no_merge_candidates () {
 		echo "Please specify which branch you want to merge on the command"
 		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
-	else
+	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
 		echo "your configuration file does not tell me either.	Please"
@@ -114,6 +117,10 @@ error_on_no_merge_candidates () {
 		echo "    remote.<nickname>.fetch = <refspec>"
 		echo
 		echo "See git-config(1) for details."
+	else
+		echo "Your configuration specified for us to pull the ref"
+		echo "'$upstream_short', but we were unable to fetch it from"
+		echo "the remote."
 	fi
 	exit 1
 }
-- 
1.6.5.rc0.201.g76b4d.dirty
