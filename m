From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] Add --reference option to git submodule.
Date: Tue, 28 Apr 2009 15:21:04 +0200
Message-ID: <49F702C0.8030206@drmicha.warpmail.net>
References: <20090428123033.GA6839@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 15:22:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LynG8-0005kg-46
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 15:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbZD1NVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 09:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbZD1NVO
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 09:21:14 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36635 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755195AbZD1NVN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 09:21:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 1A20E327A2F;
	Tue, 28 Apr 2009 09:21:13 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Apr 2009 09:21:13 -0400
X-Sasl-enc: Si748sPLDHY01xAhZrFjPUvrWPFtxL4vV7+MrhrbxnCB 1240924872
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3098D58CEB;
	Tue, 28 Apr 2009 09:21:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090428123033.GA6839@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117773>

Michael S. Tsirkin venit, vidit, dixit 28.04.2009 14:30:
> This adds --reference option to git submodule add and
> git submodule update commands, which is passed on to git clone.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Here's v2. Ack?

I don't think it's up to me to Ack but you addressed my remarks.
BTW, even dash has "test STRING" so portability doesn't require -n but I
think it's OK either way.

Just be prepared in case someone asks for a test script ;)

Michael

> 
> Changes from v1: fixes in documentation, fix test usage and
> make it portable.
> 
>  Documentation/git-submodule.txt |   14 ++++++++++++--
>  git-submodule.sh                |   31 ++++++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3b8df44..14256c6 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,10 +9,12 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
> +'git submodule' [--quiet] add [-b branch]
> +	      [--reference <repository>] [--] <repository> <path>
>  'git submodule' [--quiet] status [--cached] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
> +'git submodule' [--quiet] update [--init] [-N|--no-fetch]
> +	      [--reference <repository>] [--] [<path>...]
>  'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach <command>
>  'git submodule' [--quiet] sync [--] [<path>...]
> @@ -177,6 +179,14 @@ OPTIONS
>  	This option is only valid for the update command.
>  	Don't fetch new objects from the remote site.
>  
> +--reference <repository>::
> +	This option is only valid for add and update commands.  These
> +	commands sometimes need to clone a remote repository. In this case,
> +	this option will be passed to the linkgit:git-clone[1] command.
> ++
> +*NOTE*: Do *not* use this option unless you have read the note
> +for linkgit:git-clone[1]'s --reference and --shared options carefully.
> +
>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command
>  	to only operate on the submodules found at the specified paths.
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8e234a4..4989d86 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -15,6 +15,7 @@ require_work_tree
>  command=
>  branch=
>  quiet=
> +reference=
>  cached=
>  nofetch=
>  
> @@ -91,6 +92,7 @@ module_clone()
>  {
>  	path=$1
>  	url=$2
> +	reference="$3"
>  
>  	# If there already is a directory at the submodule path,
>  	# expect it to be empty (since that is the default checkout
> @@ -106,7 +108,12 @@ module_clone()
>  	test -e "$path" &&
>  	die "A file already exist at path '$path'"
>  
> -	git-clone -n "$url" "$path" ||
> +	if test -n "$reference"
> +	then
> +		git-clone "$reference" -n "$url" "$path"
> +	else
> +		git-clone -n "$url" "$path"
> +	fi ||
>  	die "Clone of '$url' into submodule path '$path' failed"
>  }
>  
> @@ -131,6 +138,15 @@ cmd_add()
>  		-q|--quiet)
>  			quiet=1
>  			;;
> +		--reference)
> +			case "$2" in '') usage ;; esac
> +			reference="--reference=$2"
> +			shift
> +			;;
> +		--reference=*)
> +			reference="$1"
> +			shift
> +			;;
>  		--)
>  			shift
>  			break
> @@ -203,7 +219,7 @@ cmd_add()
>  		git config submodule."$path".url "$url"
>  	else
>  
> -		module_clone "$path" "$realrepo" || exit
> +		module_clone "$path" "$realrepo" "$reference" || exit
>  		(
>  			unset GIT_DIR
>  			cd "$path" &&
> @@ -321,6 +337,15 @@ cmd_update()
>  			shift
>  			nofetch=1
>  			;;
> +		--reference)
> +			case "$2" in '') usage ;; esac
> +			reference="$2"
> +			shift 2
> +			;;
> +		--reference=*)
> +			reference="$1"
> +			shift
> +			;;
>  		--)
>  			shift
>  			break
> @@ -351,7 +376,7 @@ cmd_update()
>  
>  		if ! test -d "$path"/.git -o -f "$path"/.git
>  		then
> -			module_clone "$path" "$url" || exit
> +			module_clone "$path" "$url" "$reference"|| exit
>  			subsha1=
>  		else
>  			subsha1=$(unset GIT_DIR; cd "$path" &&
