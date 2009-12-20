From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/5] git-svn: memoize conversion of SVN merge ticket
 info to git commit ranges
Date: Mon, 21 Dec 2009 10:24:06 +1300
Message-ID: <1261344246.20752.24.camel@denix>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
	 <1261240435-8948-2-git-send-email-sam@vilain.net>
	 <1261240435-8948-3-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 22:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMTGW-0002QY-9Z
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 22:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbZLTVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbZLTVYZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 16:24:25 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56182 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756083AbZLTVYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 16:24:23 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D2A8921C41D; Mon, 21 Dec 2009 10:24:11 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.234] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 16B9121C3F6;
	Mon, 21 Dec 2009 10:24:07 +1300 (NZDT)
In-Reply-To: <1261240435-8948-3-git-send-email-sam@vilain.net>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135536>

On Sun, 2009-12-20 at 05:33 +1300, Sam Vilain wrote:
> Each time the svn mergeinfo ticket changes, we look it up in the rev_map;
> when there are a lot of merged branches, this will result in many repeated
> lookups of the same information for subsequent commits.  Arrange the slow
> part of the function so that it may be memoized, and memoize it.  The more
> expensive revision walking operation can be memoized separately.
> 
> Signed-off-by: Sam Vilain <sam@vilain.net>
> ---
>  git-svn.perl |   91 ++++++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index a4b052c..3b17a83 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1634,6 +1634,7 @@ use Carp qw/croak/;
>  use File::Path qw/mkpath/;
>  use File::Copy qw/copy/;
>  use IPC::Open3;
> +use Memoize;  # core since 5.8.0, Jul 2002
>  
>  my ($_gc_nr, $_gc_period);
>  
> @@ -2967,6 +2968,55 @@ sub find_extra_svk_parents {
>  	}
>  }
>  
> +sub lookup_svn_merge {
> +	my $uuid = shift;
> +	my $url = shift;
> +	my $merge = shift;
> +
> +	my ($source, $revs) = split ":", $merge;
> +	my $path = $source;
> +	$path =~ s{^/}{};
> +	my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
> +	if ( !$gs ) {
> +		warn "Couldn't find revmap for $url$source\n";
> +		next;
> +	}

As mentioned in the other thread, that 'next' should now be 'return'.

Sam
