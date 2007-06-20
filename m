From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] Accept root <tree-ish> in 'git-svn commit-diff'
Date: Tue, 19 Jun 2007 23:25:48 -0700
Message-ID: <20070620062548.GA25840@muzzle>
References: <11821688443683-git-send-email-ynvich@gmail.com> <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, J.Sixt@eudaptics.com, masterdriverz@gmail.com
To: Sergey Yanovich <ynvich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0tdZ-0001MD-SG
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 08:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbXFTGZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 02:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757888AbXFTGZv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 02:25:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38059 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754AbXFTGZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 02:25:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0BF4C8D4027;
	Tue, 19 Jun 2007 23:25:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 19 Jun 2007 23:25:48 -0700
Content-Disposition: inline
In-Reply-To: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50537>

Sergey Yanovich <ynvich@gmail.com> wrote:
> Experiments with Subversion (my version is 1.4.2) show that it is
> not necessary to call 'svn import' before the first commit. Contrarily
> to the Subversion documentation, first commit may be done even when
> Subversion repository is at revision 0.
> 
> This allow export the whole git branch to a Subversion repo using only
> 'git-svn commit-diff'. Before this patch, however, 'git-svn' had
> no means to operate on root commits.

Cool.

> Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
> ---
>  git-svn.perl |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 50128d7..8ad291b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2572,7 +2572,12 @@ sub generate_diff {
>  	}
>  	push @diff_tree, '--find-copies-harder' if $_find_copies_harder;
>  	push @diff_tree, "-l$_rename_limit" if defined $_rename_limit;
> -	push @diff_tree, $tree_a, $tree_b;
> +	if ($tree_a eq '0000000000000000000000000000000000000000') {

You can make this more legible by using '0' x40 instead of repeating
40 '0' characters.  Also, it might be a good idea to support --root
directly for git-svn so the user won't have to type 40 zeroes in the
command-line :)

> +		push @diff_tree, '--root';
> +	} else {
> +		push @diff_tree, $tree_a;
> +	}
> +	push @diff_tree, $tree_b;
>  	my ($diff_fh, $ctx) = command_output_pipe(@diff_tree);
>  	local $/ = "\0";
>  	my $state = 'meta';
> @@ -2606,6 +2611,8 @@ sub generate_diff {
>  			}
>  			$x->{file_b} = $_;
>  			$state = 'meta';
> +		} elsif ($state eq 'meta' && $_ eq $tree_b &&
> +			$tree_a eq '0000000000000000000000000000000000000000') {

Same here with '0' x40

>  		} else {
>  			croak "Error parsing $_\n";
>  		}
> -- 
> 1.5.2.1
> 

-- 
Eric Wong
