From: Bryan Jacobs <bjacobs@woti.com>
Subject: Re: [PATCH] git svn dcommit: avoid self-referential mergeinfo lines
 when svn.pushmergeinfo is configured
Date: Wed, 14 Mar 2012 12:15:56 -0400
Organization: White Oak Technologies
Message-ID: <20120314121556.44e4054a@robyn.woti.com>
References: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Avishay Lavie <avishay.lavie@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:25:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7r1N-0000g4-G6
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165Ab2CNQZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:25:45 -0400
Received: from mail02.woti.us ([66.92.158.6]:39741 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756141Ab2CNQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:25:45 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Mar 2012 12:25:45 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 6A950537CBACA;
	Wed, 14 Mar 2012 12:15:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNtgPnFPEx3d; Wed, 14 Mar 2012 12:15:57 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id ED539516C5FC4;
	Wed, 14 Mar 2012 12:15:56 -0400 (EDT)
In-Reply-To: <CAHkK2bpq1J2SW2P1tkFnjw5dWEr=uQrfrTUaS2J-swuKsP4kig@mail.gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193125>

This patch looks proper to me.

It's arguable that the real bug is SVN removing the
redundant-but-harmless mergeinfo lines, but that's neither here nor
there. git-svn should be as similar to the real SVN client as possible.

At my workplace we have not experienced the interoperability bug
described in the linked thread, and we work with both SVN and git-svn.
But it may be our SVN client does not exhibit the good/bad behavior, or
perhaps nobody has tried the workflow which causes it to be a problem.

Bryan Jacobs

On Wed, 14 Mar 2012 18:09:04 +0200
Avishay Lavie <avishay.lavie@gmail.com> wrote:

> [PATCH] git svn dcommit: avoid self-referential mergeinfo lines when
> svn.pushmergeinfo flag is configured
> 
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
> 
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
> +		fatal "URL to commit to is not under SVN root
> $rooturl!";
> +	}
> +	my $branchpath = $1;
> +	return join("\n", grep { $_ !~ m/^$branchpath\:/ }
> split(/\n/, $_merge_info)); +}
> +
>  sub cmd_dcommit {
>  	my $head = shift;
>  	command_noisy(qw/update-index --refresh/);
> @@ -902,6 +915,8 @@ sub cmd_dcommit {
>  				                             $uuid,
>  				                             $linear_refs,
>  				                             $rewritten_parent);
> +
> +				$_merge_info =
> remove_self_referential_merge_info($_merge_info, $url, $gs); }
> 
>  			my %ed_opts = ( r => $last_rev,
