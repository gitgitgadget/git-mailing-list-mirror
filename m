From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCHv2] completion: make compatible with zsh
Date: Mon, 30 Aug 2010 16:19:27 +0200
Message-ID: <20100830141927.GA16495@neumann>
References: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	avarab@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:19:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5D7-0002y1-9q
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab0H3OTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:19:32 -0400
Received: from francis.fzi.de ([141.21.7.5]:22696 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755652Ab0H3OTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:19:31 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 Aug 2010 16:19:28 +0200
Content-Disposition: inline
In-Reply-To: <1282877156-16149-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2010 14:19:28.0338 (UTC) FILETIME=[5B1BAB20:01CB484E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154811>

Hi,


On Thu, Aug 26, 2010 at 10:45:56PM -0400, Mark Lodato wrote:
> Modify git-completion.bash so that it also works with zsh when using
> bashcompinit.  In particular:
> 
> declare -F
>     Zsh doesn't have the same 'declare -F' as bash, but 'declare -f'
>     is the same, and it works just as well for our purposes.

> @@ -2372,17 +2383,22 @@ _git ()
>  	fi
>  
>  	local completion_func="_git_${command//-/_}"
> -	declare -F $completion_func >/dev/null && $completion_func && return
> +	declare -f $completion_func >/dev/null && $completion_func && return
>  
>  	local expansion=$(__git_aliased_command "$command")
>  	if [ -n "$expansion" ]; then
>  		completion_func="_git_${expansion//-/_}"
> -		declare -F $completion_func >/dev/null && $completion_func
> +		declare -f $completion_func >/dev/null && $completion_func
>  	fi
>  }

I chose -F back then because it does not print the definition of the
completion function, so there is less stuff to throw away immediately.
However, the run-time difference seems to be barely measureable (i.e.
'time declare -f _git_config >/dev/null' vs. 'declare -F _git_config
 >/dev/null' sometimes shows 0.001s difference), so I'm fine with this
change.


> @@ -2417,3 +2433,29 @@ if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
>  complete -o bashdefault -o default -o nospace -F _git git.exe 2>/dev/null \
>  	|| complete -o default -o nospace -F _git git.exe
>  fi
> +
> +if [[ -z $ZSH_VERSION ]]; then

-z?  I think you wanted to use -n here, like at the other places.

Nit: why "if [[ ... ]]"?  FWIW "if [ ... ]" would be enough.

> +	shopt () {
> +		local option
> +		if [ $# -ne 2 ]; then
> +			echo "USAGE: $0 (-q|-s|-u) <option>" >&2
> +			return 1
> +		fi
> +		case "$2" in
> +		nullglob)
> +			option="$2"
> +			;;
> +		*)
> +			echo "$0: invalid option: $2" >&2
> +			return 1
> +		esac
> +		case "$1" in
> +		-q)	setopt | grep -q "$option" ;;
> +		-u)	unsetopt "$option" ;;
> +		-s)	setopt "$option" ;;
> +		*)
> +			echo "$0: invalid flag: $1" >&2
> +			return 1
> +		esac
> +	}
> +fi
> -- 
> 1.7.2.2
> 
