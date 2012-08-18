From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH v3 1/2] git-svn.perl: consider all ranges for a given
 merge, instead of only tip-by-tip
Date: Sat, 18 Aug 2012 12:49:19 -0700
Message-ID: <502FF1BF.104@vilain.net>
References: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, avarab@gmail.com, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 21:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pBQ-0005KF-57
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 21:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab2HRT7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 15:59:36 -0400
Received: from uk.vilain.net ([92.48.122.123]:44000 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab2HRT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 15:59:32 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 15:59:32 EDT
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 6D0438284; Sat, 18 Aug 2012 20:49:24 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.136] (c-50-136-135-232.hsd1.ca.comcast.net [50.136.135.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id CDF068272;
	Sat, 18 Aug 2012 20:49:21 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <1344705265-10939-1-git-send-email-stevenrwalter@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203691>

On 08/11/2012 10:14 AM, Steven Walter wrote:
> Consider the case where you have trunk, branchA of trunk, and branchB of
> branchA.  trunk is merged back into branchB, and then branchB is
> reintegrated into trunk.  The merge of branchB into trunk will have
> svn:mergeinfo property references to both branchA and branchB.

Nice start, and then...

>    When
> performing the check_cherry_pick check on branchB,

You switch from a user story to an implementation detail.  Perhaps you 
could state the user action which is affected here and mention the 
implementation details in parentheses.

>   it is necessary to
> eliminate the merged contents of branchA as well as branchB, or else the
> merge will be incorrectly ignored as a cherry-pick.
>
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> ---
>   git-svn.perl                                    |    8 ++-
>   t/t9163-git-svn-fetch-merge-branch-of-branch.sh |   60 +++++++++++++++++++++++
>   2 files changed, 63 insertions(+), 5 deletions(-)
>   create mode 100755 t/t9163-git-svn-fetch-merge-branch-of-branch.sh
>
> diff --git a/git-svn.perl b/git-svn.perl
> index ca038ec..abcec11 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3657,14 +3657,14 @@ sub find_extra_svn_parents {
>   	my @merge_tips;
>   	my $url = $self->{url};
>   	my $uuid = $self->ra_uuid;
> -	my %ranges;
> +	my @all_ranges;
>   	for my $merge ( @merges ) {
>   		my ($tip_commit, @ranges) =
>   			lookup_svn_merge( $uuid, $url, $merge );
>   		unless (!$tip_commit or
>   				grep { $_ eq $tip_commit } @$parents ) {
>   			push @merge_tips, $tip_commit;
> -			$ranges{$tip_commit} = \@ranges;
> +			push @all_ranges, @ranges;
>   		} else {
>   			push @merge_tips, undef;
>   		}
> @@ -3679,8 +3679,6 @@ sub find_extra_svn_parents {
>   		my $spec = shift @merges;
>   		next unless $merge_tip and $excluded{$merge_tip};
>   
> -		my $ranges = $ranges{$merge_tip};
> -
>   		# check out 'new' tips
>   		my $merge_base;
>   		eval {
> @@ -3702,7 +3700,7 @@ sub find_extra_svn_parents {
>   		my (@incomplete) = check_cherry_pick(
>   			$merge_base, $merge_tip,
>   			$parents,
> -			@$ranges,
> +			@all_ranges,
>   		       );

This all looks very plausibly correct.

>   		if ( @incomplete ) {
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

You refer to these as "branchA" and "branchB" in your commit message.  
It would be easier to follow if you were consistent.

Otherwise, nice fix.  I'm glad that someone is finding the corner cases 
in this code!  :)

Sam
