From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn fix for systems without strftime %z
Date: Mon, 23 Feb 2009 14:44:00 -0800
Message-ID: <20090223224400.GA32193@dcvr.yhbt.net>
References: <1235399583-6043-1-git-send-email-bwalton@artsci.utoronto.ca> <1235399583-6043-2-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Feb 23 23:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbjYL-0001bW-TR
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbZBWWoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 17:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755244AbZBWWoF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 17:44:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59896 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757559AbZBWWoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 17:44:03 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5563C1F43E;
	Mon, 23 Feb 2009 22:44:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1235399583-6043-2-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111176>

Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> %z isn't available on all platforms in the date formatting
> routines.  Detect when %z is ignored and insert the
> the proper value if necessary.
> 
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>

Hi Ben,

Thanks for the patch.  What about just removing strftime() entirely and
making the %z workaround the standard code path so it gets used/tested
more?  I don't think there'd be a discernable overhead on a modern
system and the ancient ones tend to stay around forever...  I'd like
to avoid rarely executed code paths if possible.

> ---
>  git-svn.perl |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index cbc5211..66f49b4 100755
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
> @@ -4721,7 +4722,18 @@ sub run_pager {
>  }
>  
>  sub format_svn_date {
> -	return strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
> +	my $timestr = strftime("%Y-%m-%d %H:%M:%S %z (%a, %d %b %Y)", localtime(shift));
> +
> +	# for systems without %z (solaris 8, 9, etc)
> +	if ($timestr =~ /%z/) {
> +		my $lt = time;
> +		my $gm = timelocal(gmtime($lt));
> +		my $sign = qw( + + - )[ $lt <=> $gm ];
> +		my $gmoff = sprintf("%s%02d%02d", $sign, (gmtime(abs($lt - $gm)))[2,1]);
> +		$timestr =~ s/%z/$gmoff/;
> +	}
> +
> +	return $timestr;
>  }
