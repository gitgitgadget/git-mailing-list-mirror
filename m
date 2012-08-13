From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3 1/2] git-svn.perl: consider all ranges for a given
 merge, instead of only tip-by-tip
Date: Mon, 13 Aug 2012 07:08:50 +0000
Message-ID: <20120813070850.GA9190@dcvr.yhbt.net>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: avarab@gmail.com, sam@vilain.net, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 09:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0omN-0001pX-Ca
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 09:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab2HMHJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 03:09:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49815 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2HMHIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 03:08:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882D41F433;
	Mon, 13 Aug 2012 07:08:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203328>

Steven Walter <stevenrwalter@gmail.com> wrote:
> Consider the case where you have trunk, branchA of trunk, and branchB of
> branchA.  trunk is merged back into branchB, and then branchB is
> reintegrated into trunk.  The merge of branchB into trunk will have
> svn:mergeinfo property references to both branchA and branchB.  When
> performing the check_cherry_pick check on branchB, it is necessary to
> eliminate the merged contents of branchA as well as branchB, or else the
> merge will be incorrectly ignored as a cherry-pick.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> ---

I think this series is good, but would feel more comfortable if
I got a second opinion from Sam.

This doesn't apply against Junio's master (nor mine on
git://bogomips.org/git-svn.git), though it works fine on Junio's maint.

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
> index 0000000..13ae7e3
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
> +		svn_cmd add foo &&
> +		svn_cmd commit -m "initial commit" &&
> +		svn_cmd cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
> +		svn_cmd switch "$svnrepo"/branches/branch1 &&
> +		touch bar &&
> +		svn_cmd add bar &&
> +		svn_cmd commit -m branch1 &&
> +		svn_cmd cp -m branch "$svnrepo"/branches/branch1 "$svnrepo"/branches/branch2 &&
> +		svn_cmd switch "$svnrepo"/branches/branch2 &&
> +		touch baz &&
> +		svn_cmd add baz &&
> +		svn_cmd commit -m branch2 &&
> +		svn_cmd switch "$svnrepo"/trunk &&
> +		touch bar2 &&
> +		svn_cmd add bar2 &&
> +		svn_cmd commit -m trunk &&
> +		svn_cmd switch "$svnrepo"/branches/branch2 &&
> +		svn_cmd merge "$svnrepo"/trunk &&
> +		svn_cmd commit -m "merge trunk"
> +		svn_cmd switch "$svnrepo"/trunk &&
> +		svn_cmd merge --reintegrate "$svnrepo"/branches/branch2 &&
> +		svn_cmd commit -m "merge branch2"
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
