From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Wed, 16 Oct 2013 20:44:44 +0100
Message-ID: <20131016194444.GQ27238@serenity.lan>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
 <20131016192412.GK9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 21:45:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWX1i-0002ga-V2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 21:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761600Ab3JPToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 15:44:54 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33071 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761596Ab3JPTow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 15:44:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D18CC6064FC;
	Wed, 16 Oct 2013 20:44:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvVBP9jG6NYD; Wed, 16 Oct 2013 20:44:51 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 0FEC16064FF;
	Wed, 16 Oct 2013 20:44:46 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131016192412.GK9464@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236256>

On Wed, Oct 16, 2013 at 12:24:13PM -0700, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> >                                    Since commit d44e712 (pull: support
> > rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> > chosen the most recent reflog entry which is an ancestor of the current
> > branch if it can find one.
> >
> > Change rebase so that it uses the same logic.
> 
> Nice idea.
> 
> Could pull be made to rely on rebase for this as a follow-up?

It's not an obvious change to do that (at least to me) - pull does the
different steps of figuring out the base and then rebasing at different
points in the script.

> [...]
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -437,6 +437,14 @@ then
> >  			error_on_missing_default_upstream "rebase" "rebase" \
> >  				"against" "git rebase <branch>"
> >  		fi
> > +		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
> > +		do
> > +			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
> 
> "git merge-base --is-ancestor" is faster.

We should probably change git-pull to use that as well.

> What should happen if HEAD is not a valid commit?  (Tested with:
> 
> 	$ git checkout --orphan foo
> 	$ cat >>.git/config <<EOF
> 	[branch "foo"]
> 		remote = origin
> 		merge = refs/heads/master
> 	EOF
> 	$ bin-wrappers/git rebase 2>&1 | wc -l
> 	83
> 
> ).

Adding "2>/dev/null" to the merge-base line silences most of that, all
we're left with is "fatal: Needed a single revision" which is the same
as I get from master's git-rebase.  I think silencing stderr is the
right thing to do here - in the worst case we just use the merge-base of
the two branches instead of the appropriate reflog entry.

> diff --git i/git-rebase.sh w/git-rebase.sh
> index fd36cf7..d2e2c2e 100755
> --- i/git-rebase.sh
> +++ w/git-rebase.sh
> @@ -439,7 +439,7 @@ then
>  		fi
>  		for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
>  		do
> -			if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
> +			if git merge-base --is-ancestor "$reflog" HEAD
>  			then
>  				upstream_name=$reflog
>  				break
