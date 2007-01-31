From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tone down the detached head warning
Date: Wed, 31 Jan 2007 18:19:43 -0500
Message-ID: <20070131231942.GB31145@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cworth@cworth.org, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 00:19:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCOk1-0005ab-W5
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbXAaXTp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbXAaXTp
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:19:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4354 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030446AbXAaXTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:19:45 -0500
Received: (qmail 10187 invoked from network); 31 Jan 2007 18:19:42 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 31 Jan 2007 18:19:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jan 2007 18:19:43 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38305>

On Wed, Jan 31, 2007 at 02:10:37PM -0500, Nicolas Pitre wrote:

> This is not meant to frighten people or even to suggest they might be
> doing something wrong, but rather to notify them of a state change and
> provide a likely option in the case this state was entered by mistake.

I like this much better. Though I wonder in Carl's case if we can do
even better, since the user is checking out a tracking branch. Does it
really make sense to say "you are not on ANY branch"? Maybe instead:

-- >8 --
git-checkout: note use of remote tracking branch when making detached warning

---
Carl, can you comment? Does this require more explanation about why it
matters that you're on a remote tracking branch?

 git-checkout.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index ed04815..68533a1 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -14,6 +14,7 @@ force=
 branch=
 newbranch=
 newbranch_log=
+detached_remote=
 merge=
 LF='
 '
@@ -58,6 +59,9 @@ while [ "$#" != "0" ]; do
 			if git-show-ref --verify --quiet -- "refs/heads/$arg"
 			then
 				branch="$arg"
+			elif git-show-ref --verify --quiet -- "refs/remotes/$arg"
+			then
+				detached_remote="$arg"
 			fi
 		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
 		then
@@ -155,7 +159,11 @@ then
 	detached="$new"
 	if test -n "$oldbranch"
 	then
-		detach_warn="Note: you are not on ANY branch anymore.
+		case "$detached_remote" in
+		  "") detach_warn="Note: you are not on ANY branch anymore." ;;
+		   *) detach_warn="Note: you are on the remote tracking branch '$detached_remote'" ;;
+		esac
+		detach_warn="$detach_warn
 If you want to create a new branch from this checkout, you may do so
 (now or later) by using -b with the checkout command again. Example:
   git checkout -b <new_branch_name>"
-- 
1.5.0.rc2.587.gbedb-dirty
