From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make branch use correct svn-remote
Date: Tue, 2 Dec 2008 13:51:57 -0800
Message-ID: <20081202215157.GB9650@hand.yhbt.net>
References: <1228185780-22938-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Tue Dec 02 22:53:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7dBJ-00034a-JX
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 22:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYLBVwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 16:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbYLBVwA
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 16:52:00 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57700 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbYLBVv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 16:51:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1518A2DC01A;
	Tue,  2 Dec 2008 21:51:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228185780-22938-1-git-send-email-deskinm@umich.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102181>

Deskin Miller <deskinm@umich.edu> wrote:
> The 'branch' subcommand incorrectly had the svn-remote to use hardcoded
> as 'svn', the default remote name.  This meant that branches derived
> from other svn-remotes would try to use the branch and tag configuration
> for the 'svn' remote, potentially copying would-be branches to the wrong
> place in SVN, into the branch namespace for another project.
> 
> Fix this by using the remote name extracted from the svn info for the
> specified git ref.  Add a testcase for this behaviour.
> 
> Signed-off-by: Deskin Miller <deskinm@umich.edu>

Looks alright to me, thanks Deskin.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
> Applies on v1.6.1-rc1.  Apologies for not catching this when first
> writing testcases for the branch subcommand.
> 
> Deskin Miller
> 
>  git-svn.perl                  |    2 +-
>  t/t9128-git-svn-cmd-branch.sh |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 914c707..e64e97b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -558,7 +558,7 @@ sub cmd_branch {
>  
>  	my ($src, $rev, undef, $gs) = working_head_info($head);
>  
> -	my $remote = Git::SVN::read_all_remotes()->{svn};
> +	my $remote = Git::SVN::read_all_remotes()->{$gs->{repo_id}};
>  	my $glob = $remote->{ $_tag ? 'tags' : 'branches' };
>  	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
>  	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
> diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
> index 47c4d4d..e2b6696 100755
> --- a/t/t9128-git-svn-cmd-branch.sh
> +++ b/t/t9128-git-svn-cmd-branch.sh
> @@ -56,4 +56,21 @@ test_expect_success 'git svn branch tests' '
>  	test_must_fail git svn tag tag1
>  '
>  
> +test_expect_success 'branch uses correct svn-remote' '
> +	(svn co "$svnrepo" svn &&
> +	cd svn &&
> +	mkdir mirror &&
> +	svn add mirror &&
> +	svn copy trunk tags branches mirror/ &&
> +	svn ci -m "made mirror" ) &&
> +	rm -rf svn &&
> +	git svn init -s -R mirror --prefix=mirror/ "$svnrepo"/mirror &&
> +	git svn fetch -R mirror &&
> +	git checkout mirror/trunk &&
> +	base=$(git rev-parse HEAD:) &&
> +	git svn branch -m "branch in mirror" d &&
> +	test $base = $(git rev-parse remotes/mirror/d:) &&
> +	test_must_fail git rev-parse remotes/d
> +'
> +
>  test_done
> -- 
> 1.6.1.rc1
