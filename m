From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Added 'find-rev' command
Date: Fri, 27 Apr 2007 12:30:04 -0700
Message-ID: <20070427193004.GC12375@untitled>
References: <117770027350-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhW9a-0007Np-R7
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177AbXD0Taa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757167AbXD0Taa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:30:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:34400 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757177AbXD0TaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 15:30:11 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AF7B77DC0A0;
	Fri, 27 Apr 2007 12:30:09 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 27 Apr 2007 12:30:04 -0700
Content-Disposition: inline
In-Reply-To: <117770027350-git-send-email-aroben@apple.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45746>

Adam Roben <aroben@apple.com> wrote:
> This patch adds a new 'find-rev' command to git-svn that lets you easily
> translate between SVN revision numbers and git tree-ish.

Looks useful.

Acked-by: Eric Wong <normalperson@yhbt.net>

> Signed-off-by: Adam Roben <aroben@apple.com>
> ---
>  Documentation/git-svn.txt |    5 +++++
>  git-svn.perl              |   24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index a0d34e0..a35b9de 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -159,6 +159,11 @@ New features:
>  Any other arguments are passed directly to `git log'
>  
>  --
> +'find-rev'::
> +	When given an SVN revision number of the form 'rN', returns the
> +	corresponding git commit hash.  When given a tree-ish, returns the
> +	corresponding SVN revision number.
> +
>  'set-tree'::
>  	You should consider using 'dcommit' instead of this command.
>  	Commit specified commit or tree objects to SVN.  This relies on
> diff --git a/git-svn.perl b/git-svn.perl
> index 7b5f8ab..4be8576 100755
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
> @@ -428,6 +430,28 @@ sub cmd_dcommit {
>  	command_noisy(@finish, $gs->refname);
>  }
>  
> +sub cmd_find_rev {
> +	my $revision_or_hash = shift;
> +	my $result;
> +	if ($revision_or_hash =~ /^r\d+$/) {
> +		my $desired_revision = substr($revision_or_hash, 1);
> +		my ($fh, $ctx) = command_output_pipe('rev-list', 'HEAD');
> +		while (my $hash = <$fh>) {
> +			chomp($hash);
> +			my (undef, $rev, undef) = cmt_metadata($hash);
> +			if ($rev && $rev eq $desired_revision) {
> +				$result = $hash;
> +				last;
> +			}
> +		}
> +		command_close_pipe($fh, $ctx);
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
> -- 
> 1.5.2.rc0.75.g959b-dirty
> 

-- 
Eric Wong
