From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Teach dcommit --mergeinfo to handle multiple lines
Date: Wed, 31 Aug 2011 13:21:31 -0700
Message-ID: <20110831202131.GA27307@dcvr.yhbt.net>
References: <20110831124839.69c70486@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 22:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyrI2-0006Hj-5H
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 22:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab1HaUVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 16:21:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53057 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab1HaUVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 16:21:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F5311F869;
	Wed, 31 Aug 2011 20:21:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110831124839.69c70486@robyn.woti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180502>

Subsystem commit subjects should be prefixed with the approriate
subsystem (e.g. "git-svn: Teach dcommit --mergeinfo ..."

Bryan Jacobs <bjacobs@woti.com> wrote:
> "svn dcommit --mergeinfo" replaces the svn:mergeinfo property in an
> upstream SVN repository with the given text. The svn:mergeinfo
> property may contain commits originating on multiple branches,
> separated by newlines.
> 
> Cause space characters in the mergeinfo to be replaced by newlines,
> allowing a user to create history representing multiple branches being
> merged into one.
> 
> Update the corresponding documentation and add a test for the new
> functionality.
> 
> Signed-off-by: Bryan Jacobs <bjacobs@woti.com>

This looks reasonable, Cc:-ing Sam since he handled the mergeinfo stuff.
After all this time, I still have no experience using SVN mergeinfo
anywhere :x

> ---
>  Documentation/git-svn.txt    |    5 +++--
>  git-svn.perl                 |    3 +++
>  t/t9158-git-svn-mergeinfo.sh |   13 +++++++++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index ed5eca1..3ed28df 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -211,8 +211,9 @@ discouraged.
>  	Add the given merge information during the dcommit
>  	(e.g. `--mergeinfo="/branches/foo:1-10"`). All svn server versions can
>  	store this information (as a property), and svn clients starting from
> -	version 1.5 can make use of it. 'git svn' currently does not use it
> -	and does not set it automatically.
> +	version 1.5 can make use of it. To specify merge information from multiple
> +	branches, use a single space character between the branches
> +	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
>  
>  'branch'::
>  	Create a branch in the SVN repository.
> diff --git a/git-svn.perl b/git-svn.perl
> index 89f83fd..3ee26a2 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -548,6 +548,9 @@ sub cmd_dcommit {
>  	}
>  	my $expect_url = $url;
>  	Git::SVN::remove_username($expect_url);
> +	if (defined($_merge_info)) {
> +		$_merge_info =~ tr{ }{\n};
> +	}
>  	while (1) {
>  		my $d = shift @$linear_refs or last;
>  		unless (defined $last_rev) {
> diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
> index 3ab4390..8c9539e 100755
> --- a/t/t9158-git-svn-mergeinfo.sh
> +++ b/t/t9158-git-svn-mergeinfo.sh
> @@ -38,4 +38,17 @@ test_expect_success 'verify svn:mergeinfo' '
>  	test "$mergeinfo" = "/branches/foo:1-10"
>  '
>  
> +test_expect_success 'change svn:mergeinfo multiline' '
> +	touch baz &&
> +	git add baz &&
> +	git commit -m "baz" &&
> +	git svn dcommit --mergeinfo="/branches/bar:1-10 /branches/other:3-5,8,10-11"
> +'
> +
> +test_expect_success 'verify svn:mergeinfo multiline' '
> +	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk)
> +	test "$mergeinfo" = "/branches/bar:1-10
> +/branches/other:3-5,8,10-11"
> +'
> +
>  test_done
> -- 
> 1.7.6
