From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: read the dcommit url from the config file on
	a per remote basis
Date: Mon, 23 Feb 2009 14:45:16 -0800
Message-ID: <20090223224516.GB32193@dcvr.yhbt.net>
References: <200902191930.10139.kumbayo84@arcor.de> <200902222241.56223.kumbayo84@arcor.de> <20090223020545.GE26706@dcvr.yhbt.net> <200902231202.54054.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 23:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbjZd-00029I-OI
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 23:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbZBWWpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbZBWWpT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 17:45:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:59909 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982AbZBWWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 17:45:18 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F651F5FC;
	Mon, 23 Feb 2009 22:45:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902231202.54054.kumbayo84@arcor.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111177>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> The commit url for dcommit is determined in the following order:
> commandline option --commit-url
> svn.commiturl
> svn-remote.<name>.commiturl
> svn-remote.<name>.url
> 
> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>

> ---
> Now with a short documentation for svn.commiturl.
> I hope the wording is OK.

Thanks Peter, the wording is fine.

Acked and pushed out to git://git.bogomips.org/git-svn

>  Documentation/git-svn.txt |    4 ++++
>  git-svn.perl              |   12 +++++++++++-
>  2 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 3d45654..cda3389 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -169,6 +169,10 @@ and have no uncommitted changes.
>  	reused if a user is later given access to an alternate transport
>  	method (e.g. `svn+ssh://` or `https://`) for commit.
>  
> +config key: svn-remote.<name>.commiturl
> +
> +config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
> +
>  	Using this option for any other purpose (don't ask)
>  	is very strongly discouraged.
>  --
> diff --git a/git-svn.perl b/git-svn.perl
> index cbc5211..be4d011 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -438,7 +438,17 @@ sub cmd_dcommit {
>  		die "Unable to determine upstream SVN information from ",
>  		    "$head history.\nPerhaps the repository is empty.";
>  	}
> -	$url = defined $_commit_url ? $_commit_url : $gs->full_url;
> +
> +	if (defined $_commit_url) {
> +		$url = $_commit_url;
> +	} else {
> +		$url = eval { command_oneline('config', '--get',
> +			      "svn-remote.$gs->{repo_id}.commiturl") };
> +		if (!$url) {
> +			$url = $gs->full_url
> +		}
> +	}
> +
>  	my $last_rev = $_revision if defined $_revision;
>  	if ($url) {
>  		print "Committing to $url ...\n";
> -- 
> 1.6.1.3
