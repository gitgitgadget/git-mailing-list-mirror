From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: try to read the dcommit url from the config
	file
Date: Sat, 21 Feb 2009 04:08:15 -0800
Message-ID: <20090221120815.GA8145@dcvr.yhbt.net>
References: <200902191930.10139.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sat Feb 21 13:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaqhO-0007HV-Fv
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 13:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbZBUMIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 07:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbZBUMIR
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 07:08:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48229 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbZBUMIR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 07:08:17 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A92A1F5FD;
	Sat, 21 Feb 2009 12:08:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200902191930.10139.kumbayo84@arcor.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110943>

Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> The commit url is determined in the following order
> --commit-url commandline

actually, it should look in the .git/config for this, too:

  svn.commiturl

> svn-remote.<name>.dcommiturl

Of course, having a per-svn-remote commiturl can be useful, too.

Though I'd call it "commiturl" instead of "dcommiturl" to match the
existing config setting.  The not-often-used "set-tree" command could
probably be updated to use these config options, too...

I'll ack this patch with "dcommiturl" replaced with "commiturl".

> svn-remote.<name>.url
> 
> Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
> ---
> 
> I find it really boring to always specify --commit-url on the git svn dcommit command line.
> And it tends to fall out of my bash_history since i do not commit often.
> Setting up the commit url 1 time should be enough.
> 
> I feel that the config key: part im the documentation should get more exposure or explanation.
> Maybe somebody can suggest some wording?
> 
> Also the dcommiturl name is still a suggestion
> 
> My kdelibs git-svn config file no looks like this:
> 
> [svn-remote "svn"]
> 	url = svn://anonsvn.kde.org/home/kde/trunk/KDE/kdelibs
> 	fetch = :refs/remotes/git-svn
> 	dcommiturl = svn+ssh://username@svn.kde.org/home/kde/trunk/KDE/kdelibs
> 
> 
>  Documentation/git-svn.txt |    2 ++
>  git-svn.perl              |   12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 3d45654..0d11428 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -169,6 +169,8 @@ and have no uncommitted changes.
>  	reused if a user is later given access to an alternate transport
>  	method (e.g. `svn+ssh://` or `https://`) for commit.
>  
> +config key: svn-remote.<name>.dcommiturl
> +
>  	Using this option for any other purpose (don't ask)
>  	is very strongly discouraged.
>  --
> diff --git a/git-svn.perl b/git-svn.perl
> index 83cb36f..2ad3603 100755
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
> +			      "svn-remote.$gs->{repo_id}.dcommiturl") };
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
