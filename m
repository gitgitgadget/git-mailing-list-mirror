From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 1/2] git-svn.perl: consider all ranges for a given
 merge, instead of only tip-by-tip
Date: Tue, 7 Aug 2012 00:47:41 +0000
Message-ID: <20120807004741.GA25929@dcvr.yhbt.net>
References: <1344257176-17116-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: avarab@gmail.com, git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:47:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyXxa-0001Tx-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 02:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab2HGArn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 20:47:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42269 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757100Ab2HGArm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 20:47:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656251F43A;
	Tue,  7 Aug 2012 00:47:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1344257176-17116-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203003>

Steven Walter <stevenrwalter@gmail.com> wrote:
> Consider the case where you have trunk, branchA of trunk, and branchB of
> branchA.  trunk is merged back into branchB, and then branchB is
> reintegrated into trunk.  The merge of branchB into trunk will have
> svn:mergeinfo property references to both branchA and branchB.  When
> performing the check_cherry_pick check on branchB, it is necessary to
> eliminate the merged contents of branchA as well as branchB, or else the
> merge will be incorrectly ignored as a cherry-pick.

Thanks Steven, Cc-ing Sam for mergeinfo stuff.

> ---
>  git-svn.perl                                    |    8 ++-
>  t/t9163-git-svn-fetch-merge-branch-of-branch.sh |   60 +++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 5 deletions(-)
>  create mode 100755 t/t9163-git-svn-fetch-merge-branch-of-branch.sh
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index ca038ec..abcec11 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3657,14 +3657,14 @@ sub find_extra_svn_parents {
>  	my @merge_tips;
>  	my $url = $self->{url};
>  	my $uuid = $self->ra_uuid;
> -	my %ranges;
> +	my @all_ranges;
>  	for my $merge ( @merges ) {
>  		my ($tip_commit, @ranges) =
>  			lookup_svn_merge( $uuid, $url, $merge );
>  		unless (!$tip_commit or
>  				grep { $_ eq $tip_commit } @$parents ) {
>  			push @merge_tips, $tip_commit;
> -			$ranges{$tip_commit} = \@ranges;
> +			push @all_ranges, @ranges;
>  		} else {
>  			push @merge_tips, undef;
>  		}
> @@ -3679,8 +3679,6 @@ sub find_extra_svn_parents {
>  		my $spec = shift @merges;
>  		next unless $merge_tip and $excluded{$merge_tip};
>  
> -		my $ranges = $ranges{$merge_tip};
> -
>  		# check out 'new' tips
>  		my $merge_base;
>  		eval {
> @@ -3702,7 +3700,7 @@ sub find_extra_svn_parents {
>  		my (@incomplete) = check_cherry_pick(
>  			$merge_base, $merge_tip,
>  			$parents,
> -			@$ranges,
> +			@all_ranges,
>  		       );
>  
>  		if ( @incomplete ) {
> diff --git a/t/t9163-git-svn-fetch-merge-branch-of-branch.sh b/t/t9163-git-svn-fetch-merge-branch-of-branch.sh
> new file mode 100755
> index 0000000..73cdda5
> --- /dev/null
> +++ b/t/t9163-git-svn-fetch-merge-branch-of-branch.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Steven Walter
> +#
> +
> +test_description='git svn merge detection'
> +. ./lib-git-svn.sh
> +
> +svn_ver="$(svn --version --quiet)"
> +case $svn_ver in
> +0.* | 1.[0-4].*)
> +	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
> +	test_done
> +	;;
> +esac
> +
> +test_expect_success 'initialize source svn repo' '
> +	svn_cmd mkdir -m x "$svnrepo"/trunk &&
> +	svn_cmd mkdir -m x "$svnrepo"/branches &&
> +	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
> +	(
> +		cd "$SVN_TREE" &&
> +		touch foo &&
> +		svn add foo &&

svn_cmd here, too

> +		svn commit -m "initial commit" &&
> +		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
> +		svn switch "$svnrepo"/branches/branch1 &&
> +		touch bar &&
> +		svn add bar &&
> +		svn commit -m branch1 &&
> +		svn cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
> +		svn switch "$svnrepo"/branches/branch2 &&
> +		touch baz &&
> +		svn add baz &&
> +		svn commit -m branch2 &&
> +		svn switch "$svnrepo"/trunk &&
> +		touch bar2 &&
> +		svn add bar2 &&
> +		svn commit -m trunk &&
> +		svn switch "$svnrepo"/branches/branch2 &&
> +		svn merge "$svnrepo"/trunk &&
> +		svn commit -m "merge trunk"
> +		svn switch "$svnrepo"/trunk &&
> +		svn merge --reintegrate "$svnrepo"/branches/branch2 &&
> +		svn commit -m "merge branch2"
> +	) &&
> +	rm -rf "$SVN_TREE"
> +'
> +
> +test_expect_success 'clone svn repo' '
> +	git svn init -s "$svnrepo" &&
> +	git svn fetch
> +'
> +
> +test_expect_success 'verify merge commit' 'x=$(git rev-parse HEAD^2) &&
> +	y=$(git rev-parse branch2) &&
> +	test "x$x" = "x$y"
> +'
> +
> +test_done
> -- 
> 1.7.9.5
