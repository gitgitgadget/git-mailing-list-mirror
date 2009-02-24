From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn fix to avoid using strftime %z
Date: Tue, 24 Feb 2009 13:46:20 -0800
Message-ID: <20090224214620.GA27411@dcvr.yhbt.net>
References: <1235504689-17420-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc58J-0007Bb-Oq
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759288AbZBXVqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZBXVqW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:46:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58743 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759143AbZBXVqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:46:22 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF1A1F791;
	Tue, 24 Feb 2009 21:46:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1235504689-17420-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111348>

Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> %z isn't available on all platforms in the date formatting
> routines.  Provide a workalike capability that should be
> more portable.
> 
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>

Thanks Ben, acked and pushed out to git://git.bogomips.org/git-svn

> ---
> This is the reworked version that was requested.  It drops %z completely
> from the strftime call in favour of the hand rolled version.  All tests
> still pass on Linux and Solaris.
> 
>  git-svn.perl |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index cbc5211..24180eb 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -4615,6 +4615,7 @@ package Git::SVN::Log;
>  use strict;
>  use warnings;
>  use POSIX qw/strftime/;
> +use Time::Local;
>  use constant commit_log_separator => ('-' x 72) . "\n";
>  use vars qw/$TZ $limit $color $pager $non_recursive $verbose $oneline
>              %rusers $show_commit $incremental/;
> @@ -4721,7 +4722,12 @@ sub run_pager {
>  }
>  
>  sub format_svn_date {
> -	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
> +	# some systmes don't handle or mishandle %z, so be creative.
> +	my $t = shift;
> +	my $gm = timelocal(gmtime($t));
> +	my $sign = qw( + + - )[ $t <=> $gm ];
> +	my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
> +	return strftime("%Y-%m-%d %H:%M:%S $gmoff (%a, %d %b %Y)", localtime($t));
>  }
>  
>  sub parse_git_date {
