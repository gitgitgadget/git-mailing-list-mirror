From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn dcommit: avoid self-referential mergeinfo
 lines when svn.pushmergeinfo is configured
Date: Thu, 15 Mar 2012 22:02:42 +0000
Message-ID: <20120315220242.GA9348@dcvr.yhbt.net>
References: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bryan Jacobs <bjacobs@woti.com>,
	Sam Vilain <sam@vilain.net>
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Ikz-00017i-P3
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab2COWCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:02:44 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34118 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139Ab2COWCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:02:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE061F4F5;
	Thu, 15 Mar 2012 22:02:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193229>

Avishay Lavie <avishay.lavie@gmail.com> wrote:
> [PATCH] git svn dcommit: avoid self-referential mergeinfo lines when
> svn.pushmergeinfo flag is configured

Subject line is too long, ~50 chars is the limit.
See git-commit(1) / Documentation/SubmittingPatches

> When svn.pushmergeinfo is configured, git svn dcommit tries to
> automatically populate svn:mergeinfo properties by merging the parent
> branch's mergeinfo into the committed one on each merge commit. This
> process can add self-referential mergeinfo lines, i.e. ones that
> reference the same branch being committed into (e.g. when
> reintegrating a branch to trunk after previously having merged trunk
> into it), which are then mishandled by SVN and cause errors in mixed
> SVN/Git environments.
> For more details, see my original report on the issue at [1].
> 
> This commit adds a step to git svn dcommit that filters out any
> mergeinfo lines referencing the target branch from the mergeinfo, thus
> avoiding the problem.
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/191932
> 
> Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
> ---
> This is my first time sending a patch to the group, so if I'm doing
> something wrong, please let me know.

Noted :)

Sam Vilain should be Cc:-ed on mergeinfo-related stuff.  I don't know my
way around mergeinfo stuff at all.

This test breaks t9161-git-svn-mergeinfo-push.sh:

  not ok - 12 check reintegration mergeinfo
  #
  #               mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4)
  #               test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
  #       /branches/svnb2:3,8,16-17
  #       /branches/svnb3:4,9
  #       /branches/svnb4:5-6,10-12
  #       /branches/svnb5:6,11"

Be sure tests run successfully before submitting patches (or ask
for help fixing tests).

Lastly, formatting: some lines are too long (80 columns max) and
there's trailing whitespace.

>  git-svn.perl |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index eeb83d3..1ed409d 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -752,6 +752,19 @@ sub populate_merge_info {
>  	return undef;
>  }
> 
> +sub remove_self_referential_merge_info {
> +	return $_merge_info unless defined $_merge_info;
> +
> +	my ($_merge_info, $branchurl, $gs) = @_;
> +	my $rooturl = $gs->repos_root;
> +	
> +	unless ($branchurl =~ /^\Q$rooturl\E(.*)/) {
> +		fatal "URL to commit to is not under SVN root $rooturl!";
> +	}
> +	my $branchpath = $1;
> +	return join("\n", grep { $_ !~ m/^$branchpath\:/ } split(/\n/, $_merge_info));
> +}
> +
>  sub cmd_dcommit {
>  	my $head = shift;
>  	command_noisy(qw/update-index --refresh/);
> @@ -902,6 +915,8 @@ sub cmd_dcommit {
>  				                             $uuid,
>  				                             $linear_refs,
>  				                             $rewritten_parent);
> +
> +				$_merge_info = remove_self_referential_merge_info($_merge_info, $url, $gs);
>  			}
> 
>  			my %ed_opts = ( r => $last_rev,
> -- 
> 1.7.8.msysgit.0
