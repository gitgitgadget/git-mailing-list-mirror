From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat, 8 Mar 2008 14:22:23 -0800
Message-ID: <20080308222223.GA1950@hand.yhbt.net>
References: <1205013845-22286-1-git-send-email-jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7RY-0004LL-On
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbYCHWW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYCHWW0
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:22:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58822 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYCHWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:22:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 689257F4153;
	Sat,  8 Mar 2008 14:22:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1205013845-22286-1-git-send-email-jgoerzen@complete.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76594>

John Goerzen <jgoerzen@complete.org> wrote:
> When the rewriteRoot setting is used with git-svn, it causes the svn
> IDs added to commit messages to bear a different URL than is actually
> used to retrieve Subversion data.
> 
> It is common for Subversion repositories to be available multiple
> ways: for instance, HTTP to the public, and svn+ssh to people with
> commit access.  The need to switch URLs for access is fairly common as
> well -- perhaps someone was just given commit access.  To switch URLs
> without having to rewrite history, one can use the old url as a
> rewriteRoot, and use the new one in the svn-remote url setting.
> 
> This works well for svn fetching and general git commands.
> 
> However, git-svn dcommit, rebase, and perhaps other commands do not
> work in this scenario.  They scan the svn ID lines in commit messages
> and attempt to match them up with url lines in [svn-remote] sections
> in the git config.
> 
> This patch allows them to match rewriteRoot options, if such options
> are present.
> 
> Signed-off-by: John Goerzen <jgoerzen@complete.org>

Thanks again, patch + commit message
Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 9e2faf9..1195569 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1540,9 +1540,14 @@ sub find_by_url { # repos_root and, path are optional
>  			                    $remotes->{$repo_id}->{$_});
>  		}
>  		my $p = $path;
> +		my $rwr = rewrite_root({repo_id => $repo_id});
>  		unless (defined $p) {
>  			$p = $full_url;
> -			$p =~ s#^\Q$u\E(?:/|$)## or next;
> +			my $z = $u;
> +			if ($rwr) {
> +				$z = $rwr;
> +			}
> +			$p =~ s#^\Q$z\E(?:/|$)## or next;
>  		}
>  		foreach my $f (keys %$fetch) {
>  			next if $f ne $p;
> -- 
> 1.5.4.2
> 

-- 
Eric Wong
