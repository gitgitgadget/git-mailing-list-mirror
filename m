From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: add fetch --parent option
Date: Tue, 7 Apr 2009 19:14:08 -0700
Message-ID: <20090408021408.GC20161@dcvr.yhbt.net>
References: <49DA6827.9020204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNKL-0004w6-4p
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336AbZDHCOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755566AbZDHCOK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:14:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35397 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758336AbZDHCOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:14:09 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B90113057;
	Wed,  8 Apr 2009 02:14:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49DA6827.9020204@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116018>

Jason Merrill <jason@redhat.com> wrote:
> Signed-off-by: Jason Merrill <jason@redhat.com>
> ---
> rebase fetches only the SVN parent of the current HEAD; it should
> be possible to do that with fetch as well, for instance to support
> rebasing with stg rebase rather than git rebase.

Hi Jason, the above should be in the commit message.

Otherwise, Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks

>  Documentation/git-svn.txt |    3 +++
>  git-svn.perl              |   18 ++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index b7b1af8..85b2c8d 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -97,6 +97,9 @@ COMMANDS
>  	makes 'git-log' (even without --date=local) show the same times
>  	that `svn log` would in the local timezone.
>  
> +--parent;;
> +	Fetch only from the SVN parent of the current HEAD.
> +
>  This doesn't interfere with interoperating with the Subversion
>  repository you cloned from, but if you wish for your local Git
>  repository to be able to interoperate with someone else's local Git
> diff --git a/git-svn.perl b/git-svn.perl
> index d919798..cb718b8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -63,7 +63,7 @@ $sha1_short = qr/[a-f\d]{4,40}/;
>  my ($_stdin, $_help, $_edit,
>  	$_message, $_file,
>  	$_template, $_shared,
> -	$_version, $_fetch_all, $_no_rebase,
> +	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
>  	$_merge, $_strategy, $_dry_run, $_local,
>  	$_prefix, $_no_checkout, $_url, $_verbose,
>  	$_git_format, $_commit_url, $_tag);
> @@ -112,6 +112,7 @@ my %cmd = (
>  	fetch => [ \&cmd_fetch, "Download new revisions from SVN",
>  			{ 'revision|r=s' => \$_revision,
>  			  'fetch-all|all' => \$_fetch_all,
> +			  'parent|p' => \$_fetch_parent,
>  			   %fc_opts } ],
>  	clone => [ \&cmd_clone, "Initialize and fetch revisions",
>  			{ 'revision|r=s' => \$_revision,
> @@ -381,12 +382,21 @@ sub cmd_fetch {
>  	}
>  	my ($remote) = @_;
>  	if (@_ > 1) {
> -		die "Usage: $0 fetch [--all] [svn-remote]\n";
> +		die "Usage: $0 fetch [--all] [--parent] [svn-remote]\n";
>  	}
> -	$remote ||= $Git::SVN::default_repo_id;
> -	if ($_fetch_all) {
> +	if ($_fetch_parent) {
> +		my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
> +		unless ($gs) {
> +			die "Unable to determine upstream SVN information from ",
> +			    "working tree history\n";
> +		}
> +	        # just fetch, don't checkout.
> +		$_no_checkout = 'true';
> +		$_fetch_all ? $gs->fetch_all : $gs->fetch;
> +	} elsif ($_fetch_all) {
>  		cmd_multi_fetch();
>  	} else {
> +		$remote ||= $Git::SVN::default_repo_id;
>  		Git::SVN::fetch_all($remote, Git::SVN::read_all_remotes());
>  	}
>  }
> -- 
