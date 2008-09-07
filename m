From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add git-svn branch to allow branch creation in SVN
	repositories
Date: Sat, 6 Sep 2008 19:33:16 -0700
Message-ID: <20080907023316.GA12392@untitled>
References: <1220614447-3751-1-git-send-email-rafl@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Ragwitz <rafl@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 04:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcA70-0004UJ-Cl
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 04:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbYIGCdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 22:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYIGCdS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 22:33:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42033 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbYIGCdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 22:33:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 7BC122DC01B;
	Sat,  6 Sep 2008 19:33:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1220614447-3751-1-git-send-email-rafl@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95103>

Hi Florian,

Cool.  Some people have been asking for this feature.

I never implemented it myself because I've been unsure if it's
philosophically proper.  Ut's functionally redundant as svn(1) does the
same thing w/o needing a working copy.  But I'll accept your patch with
some minor modifications (comments inline).

Florian Ragwitz <rafl@debian.org> wrote:
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -149,6 +149,18 @@ and have no uncommitted changes.
>  	is very strongly discouraged.
>  --
>  
> +'branch'::
> +    Create a branch in the SVN repository.

Perhaps a "tag" command that is short for "branch -t" would
be helpful, too.

> +-t;;
> +--tag;;
> +    Create a tag by using the tags_subdir instead of the branches_subdir
> +    specified during git svn init.
> +
> diff --git a/git-svn.perl b/git-svn.perl
> index 7a1d26d..55a2052 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -537,6 +541,30 @@ sub cmd_dcommit {
>  	unlink $gs->{index};
>  }

Coding style things:

1. Don't pad declarations with extra whitespace.
2. No lines over 80 characters (assuming tabs are 8 chars wide)

> +sub cmd_branch {
> +	my $branch_name = shift or die "branch name required\n";
> +	my $head        = shift || 'HEAD';
> +
> +	my ($src, $rev, undef, $gs) = working_head_info($head);
> +
> +	my $remote      = Git::SVN::read_all_remotes()->{svn};

> +	my ($lft, $rgt) = @{ $remote->{ $_tag ? 'tags' : 'branches' }->{path} }{qw/left right/};
> +	my $dst         = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());

This doesn't appear to fail gracefully for SVN repositories
that don't follow the standard trunk, branches, tags layout.

Can you please ensure that it does and print an error message?

> +
> +	my $ctx = SVN::Client->new(
> +		auth    => Git::SVN::Ra::_auth_providers(),
> +		log_msg => sub { ${ $_[0] } = $_message || 'Create branch ' . $branch_name },
> +	);
> +
> +	eval {
> +		$ctx->ls($dst, 'HEAD', 0);
> +	} and die "branch ${branch_name} already exists\n";

Can you print the URLs being copied and add a --dry-run/-n
option (like dcommit).

> +	$ctx->copy($src, $rev, $dst);
> +
> +	$gs->fetch_all;
> +}
> +
>  sub cmd_find_rev {
>  	my $revision_or_hash = shift or die "SVN or git revision required ",
>  	                                    "as a command-line argument\n";

Can you also add a simple test case so we don't break it in the future?
Thanks.

-- 
Eric Wong
