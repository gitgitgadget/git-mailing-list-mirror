From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: improve repository URL matching when following parents
Date: Tue, 5 Feb 2008 00:53:42 -0800
Message-ID: <20080205085342.GD15141@hand.yhbt.net>
References: <20080129091858.GA4569@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 09:54:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMJZK-0004Ps-TE
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 09:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbYBEIxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 03:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755452AbYBEIxp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 03:53:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37562 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755324AbYBEIxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 03:53:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id CA69C2DC08B;
	Tue,  5 Feb 2008 00:53:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080129091858.GA4569@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72633>

Eric Wong <normalperson@yhbt.net> wrote:
> Warning!  This patch isn't heavily-tested against remote
> servers, it only helped me limp by on a server I was having
> trouble with tonight.  I was barely awake when working on this
> and have been living in a different timezone for more than a
> week, so don't trust it too much unless you're already having
> difficulty with some servers.

Warning lifted, please apply to master.

> This way we can avoid the spawning of a new SVN::Ra session by
> reusing the existing one.
> 
> The most problematic issue is that some svn servers disallow
> too many connections from a single IP, so this will allow
> git-svn to fetch from those repositories with a higher success
> rate by using fewer connections.
> 
> This sometimes showed up as a new (and redundant)
> [svn-remote "$parent_refname"] entry in $GIT_DIR/svn/.metadata.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> 
>  Note: there are still cases where git-svn can open more than
>  one connection to the SVN server, which can make some SVN
>  setups/administrators unhappy.  Unfortunately, I'm pretty sure
>  I won't have time to properly fix all of these in the next few
>  days.

It may be a while before I have time to fix this.  If anybody else is
willing to step up, please do.

Some notes:

Most of this is related to svn:// (and possibly svn+ssh://) sessions,
and definitely doesn't apply to file:// servers.

I couldn't find an explicit way to close the socket using the SVN API.
However, the socket does seem to get closed when the refcount of the
SVN::Ra object hits zero.

It seems only one SVN::Ra can be active at a time.  Even though it's
possible to hold multiple sockets open to an SVN server within the same
process (with svn://), the SVN library code doesn't work well with
multiple sessions active.

>  For now, if you get "connection closed unexpectedly" messages
>  while fetching (and following parents), just restart git-svn
>  and it'll pick up where it left off.
> 
>  git-svn.perl |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 75e97cc..7ba8c8f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2226,7 +2226,12 @@ sub find_parent_branch {
>  		# just grow a tail if we're not unique enough :x
>  		$ref_id .= '-' while find_ref($ref_id);
>  		print STDERR "Initializing parent: $ref_id\n";
> -		$gs = Git::SVN->init($new_url, '', $ref_id, $ref_id, 1);
> +		my ($u, $p) = ($new_url, '');
> +		if ($u =~ s#^\Q$url\E(/|$)##) {
> +			$p = $u;
> +			$u = $url;
> +		}
> +		$gs = Git::SVN->init($u, $p, $self->{repo_id}, $ref_id, 1);
>  	}
>  	my ($r0, $parent) = $gs->find_rev_before($r, 1);
>  	if (!defined $r0 || !defined $parent) {

-- 
Eric Wong
