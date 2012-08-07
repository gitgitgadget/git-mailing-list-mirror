From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 2/2] git-svn.perl: keep processing all commits in
 parents_exclude
Date: Tue, 7 Aug 2012 00:48:35 +0000
Message-ID: <20120807004835.GB25929@dcvr.yhbt.net>
References: <1344257176-17116-1-git-send-email-stevenrwalter@gmail.com>
 <1344257176-17116-2-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: avarab@gmail.com, git@vger.kernel.org,
	Steven Walter <stevenrwalter@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 02:48:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyXyT-00029a-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 02:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab2HGAsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 20:48:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42296 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab2HGAsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 20:48:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDBA32BF5;
	Tue,  7 Aug 2012 00:48:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1344257176-17116-2-git-send-email-stevenrwalter@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203004>

Steven Walter <stevenrwalter@gmail.com> wrote:
> This fixes a bug where git finds the incorrect merge parent.  Consider a
> repository with trunk, branch1 of trunk, and branch2 of branch1.
> Without this change, git interprets a merge of branch2 into trunk as a
> merge of branch1 into trunk.

Sam: your eyes would be much appreciated for this series, thanks :)

> ---
>  git-svn.perl                                     |    1 -
>  t/t9164-git-svn-fetch-merge-branch-of-branch2.sh |   53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100755 t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index abcec11..c4678c1 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3623,7 +3623,6 @@ sub parents_exclude {
>  				if ( $commit eq $excluded ) {
>  					push @excluded, $commit;
>  					$found++;
> -					last;
>  				}
>  				else {
>  					push @new, $commit;
> diff --git a/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh b/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
> new file mode 100755
> index 0000000..3493de1
> --- /dev/null
> +++ b/t/t9164-git-svn-fetch-merge-branch-of-branch2.sh
> @@ -0,0 +1,53 @@
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
