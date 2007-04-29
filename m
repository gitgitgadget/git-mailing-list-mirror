From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Add 'find-rev' command
Date: Sun, 29 Apr 2007 11:35:15 -0700
Message-ID: <20070429183515.GF12375@untitled>
References: <1177835727239-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiEFH-0003W2-VK
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbXD2Sfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbXD2Sfb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:35:31 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35337 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933069AbXD2SfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:35:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 300D97DC0A1;
	Sun, 29 Apr 2007 11:35:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 11:35:15 -0700
Content-Disposition: inline
In-Reply-To: <1177835727239-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45831>

Adam Roben <aroben@apple.com> wrote:
> This patch adds a new 'find-rev' command to git-svn that lets you easily
> translate between SVN revision numbers and git tree-ish.

Acked-by: Eric Wong <normalperson@yhbt.net>

Also, if you have time, can you get this (and 'log') to understand
revision numbers even if they're not from the working HEAD?  Thanks.

> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
> This is an updated version of my previous patch that takes Eric and Junio's
> comments into account.
> 
>  Documentation/git-svn.txt |    6 ++++++
>  git-svn.perl              |   23 +++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index a0d34e0..482c862 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -159,6 +159,12 @@ New features:
>  Any other arguments are passed directly to `git log'
>  
>  --
> +'find-rev'::
> +	When given an SVN revision number of the form 'rN', returns the
> +        corresponding git commit hash (this can optionally be followed by a
> +        tree-ish to specify which branch should be searched).  When given a
> +        tree-ish, returns the corresponding SVN revision number.
> +
>  'set-tree'::
>  	You should consider using 'dcommit' instead of this command.
>  	Commit specified commit or tree objects to SVN.  This relies on
> diff --git a/git-svn.perl b/git-svn.perl
> index 7b5f8ab..30e4a41 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -141,6 +141,8 @@ my %cmd = (
>  			  'color' => \$Git::SVN::Log::color,
>  			  'pager=s' => \$Git::SVN::Log::pager,
>  			} ],
> +	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
> +			{ } ],
>  	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
>  			{ 'merge|m|M' => \$_merge,
>  			  'verbose|v' => \$_verbose,
> @@ -428,6 +430,27 @@ sub cmd_dcommit {
>  	command_noisy(@finish, $gs->refname);
>  }
>  
> +sub cmd_find_rev {
> +	my $revision_or_hash = shift;
> +	my $result;
> +	if ($revision_or_hash =~ /^r\d+$/) {
> +		my $head = shift;
> +		$head ||= 'HEAD';
> +		my @refs;
> +		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
> +		unless ($gs) {
> +			die "Unable to determine upstream SVN information from ",
> +			    "$head history\n";
> +		}
> +		my $desired_revision = substr($revision_or_hash, 1);
> +		$result = $gs->rev_db_get($desired_revision);
> +	} else {
> +		my (undef, $rev, undef) = cmt_metadata($revision_or_hash);
> +		$result = $rev;
> +	}
> +	print "$result\n" if $result;
> +}
> +
>  sub cmd_rebase {
>  	command_noisy(qw/update-index --refresh/);
>  	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');

-- 
Eric Wong
