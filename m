From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Don't rely on $_ after making a function call
Date: Wed, 25 Apr 2007 13:59:48 -0700
Message-ID: <20070425205948.GA12375@untitled>
References: <11775270321427-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 23:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgobF-00010X-Ii
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 23:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423380AbXDYU7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbXDYU7y
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:59:54 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33218 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbXDYU7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:59:53 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B79247DC0A0;
	Wed, 25 Apr 2007 13:59:51 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 25 Apr 2007 13:59:48 -0700
Content-Disposition: inline
In-Reply-To: <11775270321427-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45574>

Adam Roben <aroben@apple.com> wrote:
> Many functions and operators in perl set $_, so its value cannot be relied upon
> after calling arbitrary functions. The solution is simply to copy the value of
> $_ into a local variable that will not get overwritten.

Does this fix any particular bug?  It looks right to me
and makes the code easier to follow, so;

Acked-by: Eric Wong <normalperson@yhbt.net>

> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  git-svn.perl |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 077d6b3..90f3bc1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -771,19 +771,19 @@ sub cmt_metadata {
>  sub working_head_info {
>  	my ($head, $refs) = @_;
>  	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
> -	while (<$fh>) {
> -		chomp;
> -		my ($url, $rev, $uuid) = cmt_metadata($_);
> +	while (my $hash = <$fh>) {
> +		chomp($hash);
> +		my ($url, $rev, $uuid) = cmt_metadata($hash);
>  		if (defined $url && defined $rev) {
>  			if (my $gs = Git::SVN->find_by_url($url)) {
>  				my $c = $gs->rev_db_get($rev);
> -				if ($c && $c eq $_) {
> +				if ($c && $c eq $hash) {
>  					close $fh; # break the pipe
>  					return ($url, $rev, $uuid, $gs);
>  				}
>  			}
>  		}
> -		unshift @$refs, $_ if $refs;
> +		unshift @$refs, $hash if $refs;
>  	}
>  	command_close_pipe($fh, $ctx);
>  	(undef, undef, undef, undef);
> -- 
> 1.5.2.rc0.14.g520d-dirty
> 

-- 
Eric Wong
