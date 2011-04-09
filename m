From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git rebase --continue automatic --skip?
Date: Sat, 9 Apr 2011 15:03:09 +0200
Message-ID: <20110409130309.GC30820@m62s10.vlinux.de>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
 <20110409000351.GA7445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skillzero@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 15:03:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Xov-0004Sx-0w
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 15:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab1DINDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 09:03:15 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:46562 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752048Ab1DINDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 09:03:14 -0400
Received: (qmail invoked by alias); 09 Apr 2011 13:03:11 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp014) with SMTP; 09 Apr 2011 15:03:11 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18dxyYQeiMdR9YXsn2jhcDn2KBPKHdRZ1Tt3qlXZA
	OQO8ZG8uPnXRJJ
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 44116D400C; Sat,  9 Apr 2011 15:03:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110409000351.GA7445@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171192>

On Fri, Apr 08, 2011 at 08:03:51PM -0400, Jeff King wrote:
> On Fri, Apr 08, 2011 at 01:30:01PM -0700, skillzero@gmail.com wrote:
> 
> > Is there a way to make git rebase --continue automatically do a --skip
> > if a conflict resolution ends up not needing the patch? Normally, git
> > rebase will just silently skip a patch if it's not needed, but if a
> > patch results in a conflict and I use git mergetool and end up
> > deleting all the changes, git rebase --continue stops and makes me
> > explicitly use --skip.
> 
> This is something I have often wanted, too. The patch would look
> something like this:
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 7a54bfc..cec15ae 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -319,6 +319,11 @@ continue)
>  		echo "mark them as resolved using git add"
>  		exit 1
>  	}
> +	if git diff-index --quiet HEAD --; then
> +		test -z "$GIT_QUIET" &&
> +			echo >&2 "Commit has no changes -- skipping"
> +		action=skip
> +	fi
>  	read_basic_state
>  	run_specific_rebase
>  	;;
> 
> that is based on what is in "next", as there has been a lot of cleanup
> in git-rebase recently[1].
> 
> I put it in rebase and not straight into "git am", as I'm not sure that
> "am" would want to share the same behavior. I'm not sure why we haven't
> done this up until now. Maybe there is some corner case I'm not thinking
> of where the user would want to do something besides skip when we hit
> this situation. I dunno.
> 

This was mentioned before on the list (sorry, don't have a reference, 
but it was a long time ago). AFAIR the reason it wasn't implemented yet is that
you will lose the commit message, which might contain precious information.
But with reflogs this shouldn't be a problem anymore.

-Peter



> Potentially this should also go into the rebase--am specific script. I
> haven't really thought it through.
> 
> -Peff
> 
> [1] I hadn't really been following Martin's rebase cleanup, but it is
>     _way_ nicer to look at these days.
