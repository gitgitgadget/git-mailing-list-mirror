From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 25 Jun 2012 04:16:59 +0000
Message-ID: <20120625041659.GA5785@dcvr.yhbt.net>
References: <20120624220835.GA4762@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Mon Jun 25 06:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj0k3-000860-PE
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 06:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab2FYERB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 00:17:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40790 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab2FYERA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 00:17:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71189331E8;
	Mon, 25 Jun 2012 04:16:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120624220835.GA4762@beczulka>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200542>

Marcin Owsiany <marcin@owsiany.pl> wrote:
> git-svn insists on creating the "master" head (unless it exists) on every
> "fetch". While it is useful that it gets created initially (users expect this
> git convention), some users find it annoying that it gets recreated, especially
> when they would like the git branch names to follow SVN repository branch
> names. More background in
> http://thread.gmane.org/gmane.comp.version-control.git/115030
> 
> Make git-svn skip the "master" creation if there is another head ref pointing
> to the same place. This means "master" does get created on initial "clone" but
> does not get recreated once a user deletes it.

Sounds reasonable to me.  Thanks for following up on this after all this
time :)

> Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
> ---
>  git-svn.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 0b074c4..90f3d06 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
>  	}
>  
>  	my $valid_head = verify_ref('HEAD^0');
> +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;

I (and I believe most git hackers) prefer C-style "&&" for boolean
expressions:

	return if $valid_head && grep { $_ eq $valid_head } @heads_commits;

"and" is lower precedence and best reserved for control flow:

	-f $file and print "File: $file exists!\n";

There's no logical difference in this case, but "&&" is probably easier for
C programmers to read.

I'll just swap "and" for "&&" and push unless there's any objection from
you.
