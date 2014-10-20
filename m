From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: merge: fix rooturl/branchurl match check
Date: Mon, 20 Oct 2014 06:24:13 +0000
Message-ID: <20141020062413.GB27885@dcvr.yhbt.net>
References: <BLU437-SMTP152A16338E427B250EB601FBAA0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tommaso Colombo <zibo86@hotmail.com>
To: Tommaso Colombo <tommaso.colombo@outlook.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 08:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg6OI-00081V-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 08:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaJTGYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 02:24:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35271 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbaJTGYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 02:24:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF031F8B3;
	Mon, 20 Oct 2014 06:24:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP152A16338E427B250EB601FBAA0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tommaso Colombo <tommaso.colombo@outlook.com> wrote:
> When populating svn:mergeinfo, git-svn merge checks if the merge parent
> of the merged branch is under the same root as the git-svn repository.
> This was implemented comparing $gs->repos_root with the return value of
> of cmt_metadata for the merge parent. However, the first may contain a
> username, whereas the second does not. In this case the comparison
> fails.
> 
> Remove the username from $gs->repos_root before performing the
> comparison.

Thanks.  Commit makes sense, but one of the test cases fails for me,
can you check it out?
$ make && make t9161-git-svn-mergeinfo-push.sh -C t GIT_TEST_OPTS='-i -v'
<snip successes>
ok 11 - reintegration merge

expecting success: 
	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4)
	test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
/branches/svnb2:3,8,16-17
/branches/svnb3:4,9
/branches/svnb5:6,11"
	
not ok 12 - check reintegration mergeinfo
#	
#		mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4)
#		test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
#	/branches/svnb2:3,8,16-17
#	/branches/svnb3:4,9
#	/branches/svnb5:6,11"
#		
make: *** [t9161-git-svn-mergeinfo-push.sh] Error 1
make: Leaving directory `/home/ew/git-core/t'


You'll also need to sign-off (see Documentation/SubmittingPatches)
It is required (project policy, not mine)

> @@ -729,7 +730,7 @@ sub populate_merge_info {
>  			}
>  			my $branchpath = $1;
>  
> -			my $ra = Git::SVN::Ra->new($branchurl);
> +			my $ra = Git::SVN::Ra->new(add_path_to_url($gs->repos_root, $branchpath));

Also, please keep long lines wrapped to <= 80 columns.
Thanks again.
