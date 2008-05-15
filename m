From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: fix initial checkout
Date: Thu, 15 May 2008 11:17:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805151050240.19665@iabervon.org>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org> <20080515044402.GA3517@sigill.intra.peff.net> <20080515045026.GA26161@sigill.intra.peff.net> <alpine.DEB.1.00.0805151042570.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 17:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwfDz-0005RQ-CK
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 17:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbYEOPRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754679AbYEOPRk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 11:17:40 -0400
Received: from iabervon.org ([66.92.72.58]:46556 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbYEOPRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 11:17:39 -0400
Received: (qmail 11279 invoked by uid 1000); 15 May 2008 15:17:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 May 2008 15:17:34 -0000
In-Reply-To: <alpine.DEB.1.00.0805151042570.30431@racer>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82207>

On Thu, 15 May 2008, Johannes Schindelin wrote:

> Somewhere in the process of finishing up builtin-clone, the update of
> the working tree was lost.  This was due to not using the option "merge"
> for unpack_trees().

I was sure I'd added support for update without merge, but now I can't see 
what became of it. I was pretty sure I'd actually needed it for something, 
too, but I guess that got resolved some other way. I'll have to check 
tonight on my laptop for something of the sort in my reflogs.

I'm pretty sure that just including merge and the necessary other options 
here will work fine (since there's no index to merge into) and I don't 
have a simple fix off the top of my head for that flag combination, so:

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

> Breakage noticed by Kevin Ballard.
> 
> Test by Jeff King.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	> On Thu, May 15, 2008 at 12:44:02AM -0400, Jeff King wrote:
> 	> 
> 	> > Hmm, builtin-clone does seem to be completely broken. It looks 
> 	> > like unpack_trees is not doing its job for some reason, but I
> 	> > haven't looked further. But it surprised me that we aren't 
> 	> > testing anything as simple as "clone works". The test below
> 	> > currently fails (though I am getting other test failures which 
> 	> > are presumably related).
> 
> 	I did not notice the breakage earlier, because I ran with a 
> 	"twoway_merge" version of builtin-clone in my personal tree.
> 
>  builtin-clone.c  |    3 +++
>  t/t5601-clone.sh |    7 +++++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index a7c075d..8713128 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -525,7 +525,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  		memset(&opts, 0, sizeof opts);
>  		opts.update = 1;
> +		opts.merge = 1;
> +		opts.fn = oneway_merge;
>  		opts.verbose_update = !option_quiet;
> +		opts.src_index = &the_index;
>  		opts.dst_index = &the_index;
>  
>  		tree = parse_tree_indirect(remote_head->old_sha1);
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index dc9d63d..593d1a3 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -23,4 +23,11 @@ test_expect_success 'clone with excess parameters' '
>  
>  '
>  
> +test_expect_success 'clone checks out files' '
> +
> +	git clone src dst &&
> +	test -f dst/file
> +
> +'
> +
>  test_done
> -- 
> 1.5.5.1.424.g3256b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
