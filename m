From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-push segfault
Date: Wed, 24 Feb 2010 13:05:44 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002241218390.14365@iabervon.org>
References: <20100224.082728.16634.0@webmail17.dca.untd.com> <20100224170853.GA4756@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "ddrowley3@juno.com" <ddrowley3@juno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 19:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkLcM-0002iQ-Vf
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 19:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab0BXSFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 13:05:46 -0500
Received: from iabervon.org ([66.92.72.58]:44447 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630Ab0BXSFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 13:05:45 -0500
Received: (qmail 1038 invoked by uid 1000); 24 Feb 2010 18:05:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Feb 2010 18:05:44 -0000
In-Reply-To: <20100224170853.GA4756@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140963>

On Wed, 24 Feb 2010, Jeff King wrote:

> On Wed, Feb 24, 2010 at 04:27:28PM +0000, ddrowley3@juno.com wrote:
> 
> > ./test.sh: line 12:  3686 Segmentation fault      (core dumped) git
> > push
> > 
> > I reproduced this consistently on 2 different machines with 2
> > different versions of git, so it must have something to do with my
> > ~/.gitconfig. Yep - if I remove the following from my .gitconfig, then
> > the seg fault goes away:
> > 
> > [push]
> >     default = tracking
> 
> Thanks, I can see it now. The patch below should fix it.
> 
> Note, however, that you will still get a failure for "git push remote",
> as your config is set up to push tracking branches by default, and you
> don't have one here.
> 
> I'm a little unsure of the patch. Arguably branch_get should not be
> setting branch->merge_nr to 1, as there is nothing in branch->merge. On
> the other hand, branch->merge_name _does_ have one element, so perhaps
> it is an error in the caller to assume that branch->merge_nr and
> branch->merge necessarily correspond. Daniel, this looks like your code.
> Comments?

I think it would be worthwhile to have branch->merge, branch->merge_nr, 
and branch->merge_name all match, even if branch->remote is NULL, by 
discarding the merge_name if the remote isn't specified.

It might also be wise to check branch_has_merge_config() instead of the 
test below, in any case, to match how the other code paths determine 
whether there is tracking configured.

> -- >8 --
> Subject: [PATCH] push: fix segfault for odd config
> 
> If you have a branch.$X.merge config option, but no
> branch.$X.remote, and your configuration tries to push
> tracking branches, git will segfault.
> 
> The problem is that even though branch->merge_nr is 1, you
> don't actually have an upstream since there is no remote.
> Other callsites generally check explicitly that
> branch->merge is not NULL, so let's do that here, too.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin-push.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-push.c b/builtin-push.c
> index 5633f0a..f7bc2b2 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -68,7 +68,7 @@ static void setup_push_tracking(void)
>  	struct branch *branch = branch_get(NULL);
>  	if (!branch)
>  		die("You are not currently on a branch.");
> -	if (!branch->merge_nr)
> +	if (!branch->merge_nr || !branch->merge)
>  		die("The current branch %s is not tracking anything.",
>  		    branch->name);
>  	if (branch->merge_nr != 1)
> -- 
> 1.7.0.215.g2da3b.dirty
> 
> 
