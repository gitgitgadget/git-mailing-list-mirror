From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git config --get-colorbool
Date: Wed, 5 Dec 2007 23:38:59 -0800
Message-ID: <20071206073858.GA23315@soma>
References: <475697BC.2090701@viscovery.net> <1196906706-11170-1-git-send-email-gitster@pobox.com> <1196906706-11170-2-git-send-email-gitster@pobox.com> <20071206053059.GF5499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0BKL-0007fB-FI
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbXLFHjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbXLFHjB
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:39:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47463 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbXLFHjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:39:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D08647DC025;
	Wed,  5 Dec 2007 23:38:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071206053059.GF5499@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67265>

Jeff King <peff@peff.net> wrote:
> [Eric Wong cc'd because of git-svn relevance]
> 
> On Wed, Dec 05, 2007 at 06:05:04PM -0800, Junio C Hamano wrote:
> 
> > This adds an option to help scripts find out color settings from
> > the configuration file.
> > 
> >     git config --get-colorbool color.diff
> > 
> > inspects color.diff variable, and exits with status 0 (i.e. success) if
> > color is to be used.  It exits with status 1 otherwise.
> 
> There is no way to differentiate between "do not use color" and "no
> value found". This makes it impossible to use this to implement the
> required "try color.diff, fallback to diff.color" behavior.
> 
> We could simply make it
> 
>   git config --get-colorbool diff
> 
> which would check both (and when diff.color support is finally dropped,
> just remove it from there).
> 
> git-svn should probably be moved to this interface (it still has the
> color.diff == true means "always" behavior), but it can't be until the
> fallback behavior is implemented.
> 
> Also, your patch doesn't seem to implement the color.pager/pager.color
> behavior, either (which is probably not important for git-add -i, but is
> used by git-svn).
> 
> Anyway, below is a totally untested (I don't even have svn installed,
> but it passes perl -wc!) patch for git-svn to use the new "true means
> auto" behavior for color.diff. It would be nice to replace this with
> a working --get-colorbool, but we should at least unify the behavior
> before v1.5.4.

Hi Jeff,

I completely agree that the color behavior should be consistent across
git-*.  So I'd like to just be able to just use --get-colorbool in
git-svn.

Your patch seems to do what it says it does, though.

> -Peff
> 
> ---
> diff --git a/git-svn.perl b/git-svn.perl
> index 9f884eb..71f6e93 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3979,7 +3979,12 @@ sub log_use_color {
>  		$dc = `git-config --get $dcvar`;
>  	}
>  	chomp($dc);
> -	if ($dc eq 'auto') {
> +	return 0 if $dc eq 'never';
> +	return 1 if $dc eq 'always';
> +	if ($dc ne 'auto') {
> +		chomp($dc = `git-config --bool --get $dcvar`);
> +	}
> +	if ($dc eq 'auto' || $dc eq 'true') {
>  		my $pc;
>  		$pc = `git-config --get color.pager`;
>  		if ($pc eq '') {
> @@ -3998,10 +4003,7 @@ sub log_use_color {
>  		}
>  		return 0;
>  	}
> -	return 0 if $dc eq 'never';
> -	return 1 if $dc eq 'always';
> -	chomp($dc = `git-config --bool --get $dcvar`);
> -	return ($dc eq 'true');
> +	return 0;
>  }
>  
>  sub git_svn_log_cmd {
> -

-- 
Eric Wong
