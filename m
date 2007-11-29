From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add a show-externals command.
Date: Thu, 29 Nov 2007 00:04:41 -0800
Message-ID: <20071129080441.GE32277@soma>
References: <1195512975-3647-1-git-send-email-vineet@doorstop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vineet Kumar <vineet@doorstop.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 09:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxeOM-00061Y-C9
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 09:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbXK2IEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 03:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbXK2IEn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 03:04:43 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42634 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755399AbXK2IEm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 03:04:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DE7E37DC10A;
	Thu, 29 Nov 2007 00:04:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195512975-3647-1-git-send-email-vineet@doorstop.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66515>

Vineet Kumar <vineet@doorstop.net> wrote:
> show-externals can be used by scripts to provide svn:externals-like
> functionality.  For example, a script can list all of the externals and then
> use check out the listed URLs at the appropriate paths, similar to what the svn
> client does.  Said script (or perhaps git-svn itself, in the future) could
> simply invoke svn export on the paths, or it could go one further, using
> git-svn clone and even git-submodule together to better integrate externals
> checkouts.
> 
> The implementation is shamelessly copied from show-ignores.  A more general
> command to list user-specified properties is probably a better idea.
> 
> Signed-off-by: Vineet Kumar <vineet@doorstop.net>

Thanks.

Acked-by: Eric Wong <normalperson@yhbt.net>

I'm close to having svn:externals supported in git-svn, too.  But
previously cloned repositories probably won't support them
out-of-the-box, so this can still be useful.

> ---
>  git-svn.perl |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 5b1deea..74966ed 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -141,6 +141,9 @@ my %cmd = (
>  	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
>  			{ 'revision|r=i' => \$_revision
>  			} ],
> +	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",
> +			{ 'revision|r=i' => \$_revision
> +			} ],
>  	'multi-fetch' => [ \&cmd_multi_fetch,
>  	                   "Deprecated alias for $0 fetch --all",
>  			   { 'revision|r=s' => \$_revision, %fc_opts } ],
> @@ -560,6 +563,21 @@ sub cmd_show_ignore {
>  	});
>  }
>  
> +sub cmd_show_externals {
> +	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
> +	$gs ||= Git::SVN->new;
> +	my $r = (defined $_revision ? $_revision : $gs->ra->get_latest_revnum);
> +	$gs->prop_walk($gs->{path}, $r, sub {
> +		my ($gs, $path, $props) = @_;
> +		print STDOUT "\n# $path\n";
> +		my $s = $props->{'svn:externals'} or return;
> +		$s =~ s/[\r\n]+/\n/g;
> +		chomp $s;
> +		$s =~ s#^#$path#gm;
> +		print STDOUT "$s\n";
> +	});
> +}
> +
>  sub cmd_create_ignore {
>  	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
>  	$gs ||= Git::SVN->new;
> -- 
> 1.5.3.4
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eric Wong
