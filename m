From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 14:07:26 -0400
Message-ID: <20080903180726.GA16454@coredump.intra.peff.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net> <20080903133446.GA6967@coredump.intra.peff.net> <alpine.LNX.1.00.0809031234560.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KawmY-0000cY-AB
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYICSHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYICSH3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:07:29 -0400
Received: from peff.net ([208.65.91.99]:4051 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbYICSH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:07:28 -0400
Received: (qmail 30117 invoked by uid 111); 3 Sep 2008 18:07:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 14:07:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 14:07:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809031234560.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94829>

On Wed, Sep 03, 2008 at 12:49:43PM -0400, Daniel Barkalow wrote:

> Good point. I think I confused myself with the new branch case. On the 
> other hand, I think the "not starting a new branch" case should go as 
> well. If you've got a detached HEAD, and you do:
> 
> $ git checkout -b foo origin/master
> 
> we probably ought to describe the old state. The reason that starting a 
> new branch usually shouldn't give the message is that new->commit == 
> old.commit (assuming that the defaults have gotten filled in by this 
> point, which they should have).

Right, I was thinking it was necessary for the starting a new branch
case, but a better test is checking whether the commits are the same.

So based on what you said and thinking a bit, I came up with:

    if (!opts->quiet && !old.path && new->commit != old.commit)

and then I had the brilliant idea of checking what git-checkout.sh did.
And sure enough:

    elif test -z "$oldbranch" && test "$new" != "$old"
    then
            describe_detached_head 'Previous HEAD position was' "$old"
    fi

Patch is below.

-- >8 --
checkout: fix message when leaving detached HEAD

The shell version of git checkout would print:

  Previous HEAD position was 1234abcd... commit subject line

when leaving a detached HEAD for another commit. Ths C
version attempted to implement this, but got the condition
wrong such that the behavior never triggered.

This patch simplifies the conditions for showing the message
to the ones used by the shell version: any time we are
leaving a detached HEAD and the new and old commits are not
the same (this suppresses it for the "git checkout -b new"
case recommended when you enter the detached state).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-checkout.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b380ad6..efdb1e0 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -386,13 +386,11 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	}
 
 	/*
-	 * If the new thing isn't a branch and isn't HEAD and we're
-	 * not starting a new branch, and we want messages, and we
-	 * weren't on a branch, and we're moving to a new commit,
-	 * describe the old commit.
+	 * If we were on a detached HEAD, but we are now moving to
+	 * a new commit, we want to mention the old commit once more
+	 * to remind the user that it might be lost.
 	 */
-	if (!new->path && strcmp(new->name, "HEAD") && !opts->new_branch &&
-	    !opts->quiet && !old.path && new->commit != old.commit)
+	if (!opts->quiet && !old.path && new->commit != old.commit)
 		describe_detached_head("Previous HEAD position was", old.commit);
 
 	if (!old.commit) {
-- 
1.6.0.1.208.gcc04.dirty
