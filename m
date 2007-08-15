From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Make git-cvsexportcommit "status" each file in turn
Date: Wed, 15 Aug 2007 16:04:31 +0200
Message-ID: <20070815140431.GC4550@xp.machine.xx>
References: <1187184448.13096.54.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 16:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILJUK-0005j8-J4
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 16:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbXHOOEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756509AbXHOOEi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 10:04:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:34398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755339AbXHOOEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 10:04:37 -0400
Received: (qmail invoked by alias); 15 Aug 2007 14:04:35 -0000
Received: from unknown (EHLO localhost) [84.170.188.156]
  by mail.gmx.net (mp037) with SMTP; 15 Aug 2007 16:04:35 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19moolmrjpmSrO1rfKm024Gbjpe/9Ly5UM0lFzyfk
	uFaIc3Sn+b2ZNS
Mail-Followup-To: Alex Bennee <kernel-hacker@bennee.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1187184448.13096.54.camel@murta.transitives.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55905>

On Wed, Aug 15, 2007 at 02:27:28PM +0100, Alex Bennee wrote:
> Hi,
> 
> It turns out CVS doesn't always give the status output in the order
> requested. According to my local CVS gurus this is a known CVS issue.
> 
> The attached patch just makes the script check each file in turn. It's
> slower but correct.
> 
> I also slightly formatted the warn output when it detects problems as
> multiple line wraps with long file paths where making my eyes bleed :-)
> 

I inlined the patch for easier commenting. Please inline further
patches.

> ---
>  git-cvsexportcommit.perl |   30 ++++++++++++++++++++----------
>  1 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index e9832d2..ee02c56 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -182,15 +182,21 @@ if (@canstatusfiles) {
>        my @updated = safe_pipe_capture(@cvs, 'update', @canstatusfiles);
>        print @updated;
>      }
> -    my @cvsoutput;
> -    @cvsoutput= safe_pipe_capture(@cvs, 'status', @canstatusfiles);
> -    my $matchcount = 0;
> -    foreach my $l (@cvsoutput) {
> -        chomp $l;
> -        if ( $l =~ /^File:/ and  $l =~ /Status: (.*)$/ ) {
> -            $cvsstat{$canstatusfiles[$matchcount]} = $1;
> -            $matchcount++;
> -        }
> +
> +    # We can't status all the files at once as CVS doesn't gaurentee
> +    # that it will output the status bits in the order requested.
> +
> +    foreach my $f (@canstatusfiles)
> +    {
> +	my $cvscmd = join(' ', @cvs)." status $f";
> +	my $cvsoutput = `$cvscmd`;
> +
> +	# slurp out the status out of the result
> +	my ($status) = $cvsoutput =~ m/.*Status: (\S*)/;
> +
> +	$opt_v && print "Status of $f is $status\n";
> +
> +	$cvsstat{$f} = $status;
>      }
>  }
> 

This is extremly wastefull, because it will spawn a CVS process for each file.
A better fix would be to parse the filename from the output of
'cvs status' and use that as input for $cvsstat.

(And/or you could use an hash instead of an array for 'cvsoutput', so
you could double check that you only get the status for those files you
asked for.)

> 
>  
> @@ -198,10 +204,14 @@ if (@canstatusfiles) {
>  foreach my $f (@afiles) {
>      if (defined ($cvsstat{$f}) and $cvsstat{$f} ne "Unknown") {
>  	$dirty = 1;
> -	warn "File $f is already known in your CVS checkout -- perhaps it has been added by another user. Or this may indicate that it exists on a different branch. If this is the case, use -f to force the merge.\n";
> +	warn "File $f is already known in your CVS checkout.\n"
> +	warn "  Perhaps it has been added by another user.\n"
> +	warn "  Or this may indicate that it exists on a different branch.\n"
> +	warn "  If this is the case, use -f to force the merge.\n";
>  	warn "Status was: $cvsstat{$f}\n";
>      }
>  }
> +
>  # ... validate known files.
>  foreach my $f (@files) {
>      next if grep { $_ eq $f } @afiles;
> -- 
> 1.5.2.3
> 

-Peter
