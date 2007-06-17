From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sun, 17 Jun 2007 10:19:59 +0200
Message-ID: <20070617081959.GD1828@planck.djpig.de>
References: <11820198064114-git-send-email-djk@tobit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dirk Koopman <djk@tobit.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 17 10:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzpzY-0000KG-Jo
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 10:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459AbXFQIUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 04:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbXFQIUI
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 04:20:08 -0400
Received: from planck.djpig.de ([85.10.192.180]:2875 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459AbXFQIUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 04:20:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 07C2A88102;
	Sun, 17 Jun 2007 10:20:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncwWbA1AHBdp; Sun, 17 Jun 2007 10:20:00 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E6DD988105; Sun, 17 Jun 2007 10:19:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11820198064114-git-send-email-djk@tobit.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50340>

Hi.

On Sat, Jun 16, 2007 at 07:50:06PM +0100, Dirk Koopman wrote:
> Early cvs clients don't cause state->{args} to be initialised,
> so force this to occur.
> Some revision checking code assumes that revisions will be
> recognisably numeric to perl, Branches are not, because they
> have more decimal points (eg 1.2.3.4 instead of just 1.2). 
> ---
>  git-cvsserver.perl |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 5cbf27e..0a4b75e 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1813,11 +1813,14 @@ sub req_annotate
>  # the second is $state->{files} which is everything after it.
>  sub argsplit
>  {
> +    $state->{args} = [];        # need this here because later code depends on it
> +                                # and for some reason earlier versions of CVS don't
> +                                # satisfy the next condition on plain 'cvs update'
> +
>      return unless( defined($state->{arguments}) and ref $state->{arguments} eq "ARRAY" );
>  
>      my $type = shift;
>  
> -    $state->{args} = [];
>      $state->{files} = [];
>      $state->{opt} = {};
>  

I just would move all the initializations up there. And I think the
comment is really unnecessary. Will prepare a replacement patch.

> @@ -1906,11 +1909,13 @@ sub argsfromdir
>  
>      # push added files
>      foreach my $file (keys %{$state->{entries}}) {
> -	if ( exists $state->{entries}{$file}{revision} &&
> -		$state->{entries}{$file}{revision} == 0 )
> -	{
> -	    push @gethead, { name => $file, filehash => 'added' };
> -	}
> +        # remember that revisions could be on branches 1.2.3.4[.5.6..]
> +        # not just a recogisable "numeric" 1.2
> +        if ( exists $state->{entries}{$file}{revision} &&
> +             !$state->{entries}{$file}{revision} )
> +        {
> +            push @gethead, { name => $file, filehash => 'added' };
> +        }
>      }
>  
>      if ( scalar(@{$state->{args}}) == 1 )

Hmm, I don't see how you could have a problem with that since cvsserver
doesn't support branches and never generates any revision numbers in
that format?

There is probably much more code out there in cvsserver that does assume
that revision is always a simple integer.

And again that comment is a but much IMHO.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
