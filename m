From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/2] difftool: don't assume that default sh is sane
Date: Sat, 19 Jul 2014 18:21:32 +0100
Message-ID: <20140719172132.GB26927@serenity.lan>
References: <1405787717-30476-1-git-send-email-charles@hashpling.org>
 <1405787717-30476-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8YKS-00068u-QI
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 19:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbaGSRVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 13:21:44 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34191 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbaGSRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 13:21:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9843B866001;
	Sat, 19 Jul 2014 18:21:43 +0100 (BST)
X-Quarantine-ID: <o-XkIZ77e691>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o-XkIZ77e691; Sat, 19 Jul 2014 18:21:42 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 0AED3CDA563;
	Sat, 19 Jul 2014 18:21:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1405787717-30476-2-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253899>

On Sat, Jul 19, 2014 at 05:35:17PM +0100, Charles Bailey wrote:
> From: Charles Bailey <cbailey32@bloomberg.net>
> 
> git-difftool used to create a command list script containing $( ... )
> and explicitly call "sh -c" with this list.
> 
> Instead, allow mergetool --tool-help to take a mode parameter and call
> mergetool directly to invoke the show_tool_help function. This mode
> parameter is intented for use solely by difftool.
> 
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> ---
> Another issue for Solaris. Originally I had a fix for this that
> substituted "@SHELL_PATH@" even inside perl scripts but I felt that
> having an interface for show_tool_help was a little neater all round but
> I welcome alternative views.
> 
>  git-difftool.perl |  6 +-----
>  git-mergetool.sh  | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 18ca61e..598fcc2 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -47,13 +47,9 @@ sub find_worktree
>  
>  sub print_tool_help
>  {
> -	my $cmd = 'TOOL_MODE=diff';
> -	$cmd .= ' && . "$(git --exec-path)/git-mergetool--lib"';
> -	$cmd .= ' && show_tool_help';
> -
>  	# See the comment at the bottom of file_diff() for the reason behind
>  	# using system() followed by exit() instead of exec().
> -	my $rc = system('sh', '-c', $cmd);
> +	my $rc = system(qw(git mergetool --tool-help=diff));
>  	exit($rc | ($rc >> 8));
>  }
>  
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e969dd0..d32b663 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -320,7 +320,17 @@ guessed_merge_tool=false
>  while test $# != 0
>  do
>  	case "$1" in
> -	--tool-help)
> +	--tool-help*)
> +		case "$#,$1" in
> +		1,*=*)

What's the reason for forcing `--tool-help` to be the last option?
Wouldn't it be simpler to just change the top-level case statement to:

	--tool-help=*)
		TOOL_MODE=${1#--tool-help=}
		show_tool_help
		;;
	--tool-help)
		show_tool_help
		;;

> +			TOOL_MODE=$(expr "z$1" : 'z-[^=]*=\(.*\)')
> +			;;
> +		1,--tool-help)
> +			;;
> +		*)
> +			usage
> +			;;
> +		esac
>  		show_tool_help
>  		;;
>  	-t|--tool*)
> -- 
> 2.0.2.611.g8c85416
