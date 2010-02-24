From: Jeff King <peff@peff.net>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 12:08:53 -0500
Message-ID: <20100224170853.GA4756@coredump.intra.peff.net>
References: <20100224.082728.16634.0@webmail17.dca.untd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "ddrowley3@juno.com" <ddrowley3@juno.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 18:09:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkKjO-0000pA-6k
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 18:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0BXRI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 12:08:57 -0500
Received: from peff.net ([208.65.91.99]:52136 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757327Ab0BXRI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 12:08:56 -0500
Received: (qmail 4558 invoked by uid 107); 24 Feb 2010 17:09:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 24 Feb 2010 12:09:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2010 12:08:53 -0500
Content-Disposition: inline
In-Reply-To: <20100224.082728.16634.0@webmail17.dca.untd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140955>

On Wed, Feb 24, 2010 at 04:27:28PM +0000, ddrowley3@juno.com wrote:

> ./test.sh: line 12:  3686 Segmentation fault      (core dumped) git
> push
> 
> I reproduced this consistently on 2 different machines with 2
> different versions of git, so it must have something to do with my
> ~/.gitconfig. Yep - if I remove the following from my .gitconfig, then
> the seg fault goes away:
> 
> [push]
>     default = tracking

Thanks, I can see it now. The patch below should fix it.

Note, however, that you will still get a failure for "git push remote",
as your config is set up to push tracking branches by default, and you
don't have one here.

I'm a little unsure of the patch. Arguably branch_get should not be
setting branch->merge_nr to 1, as there is nothing in branch->merge. On
the other hand, branch->merge_name _does_ have one element, so perhaps
it is an error in the caller to assume that branch->merge_nr and
branch->merge necessarily correspond. Daniel, this looks like your code.
Comments?

-- >8 --
Subject: [PATCH] push: fix segfault for odd config

If you have a branch.$X.merge config option, but no
branch.$X.remote, and your configuration tries to push
tracking branches, git will segfault.

The problem is that even though branch->merge_nr is 1, you
don't actually have an upstream since there is no remote.
Other callsites generally check explicitly that
branch->merge is not NULL, so let's do that here, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5633f0a..f7bc2b2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -68,7 +68,7 @@ static void setup_push_tracking(void)
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
 		die("You are not currently on a branch.");
-	if (!branch->merge_nr)
+	if (!branch->merge_nr || !branch->merge)
 		die("The current branch %s is not tracking anything.",
 		    branch->name);
 	if (branch->merge_nr != 1)
-- 
1.7.0.215.g2da3b.dirty
