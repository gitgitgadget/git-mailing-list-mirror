From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 5/5] completion: refactor __gitcomp_1
Date: Sat, 17 Nov 2012 11:58:37 +0100
Message-ID: <20121117105837.GC12052@goldbirke>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
 <1353116298-11798-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 11:59:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZg7D-0008DN-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 11:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2KQK66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 05:58:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50312 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2KQK65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 05:58:57 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LdIov-1SrVXD31Zx-00iNmq; Sat, 17 Nov 2012 11:58:39 +0100
Content-Disposition: inline
In-Reply-To: <1353116298-11798-6-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:e6BP2rR5BpSFzrh40hw9QL3eCthDaSkheGHcBCwz002
 39rnOssqFl5nRTk3jJdXqoxq2ytQiBKHWsNQ0svyu0B3IZCKvN
 XuUNNyLCgVl8Kwl5Y83KcjHJ4ZxWS3cdoLwNoLsWqy7Zvis9nN
 pdDVfCbuZeKbaqNXjeDh6kPlREMBRwkgxMgGcKp9O9czAfRViS
 ghPu+JvAGdChex/7xXGHFqY5K1vKaM/ldxyv9v8OmiSbBp3qgI
 Hiu0tqD5GhTY2n61UTNUyd/CMreziamHbMuIiJ/1FIWNpPvrtv
 OjB9F3yNC8NdTZe8Fsy8ldpAjOkHuxdxAZt0PMCpzNowDSRcS+
 qfXtfCjrlGl3IUsf1BIU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209937>

[Wow, that's quite the Cc-list above.  I wonder why e.g. Robert ended
up there, when all his "sins" were to add a couple of 'git svn'
options back in 2009.]

On Sat, Nov 17, 2012 at 02:38:18AM +0100, Felipe Contreras wrote:
> It's only used by __gitcomp, so move some code there and avoid going
> through the loop again.
> 
> We could get rid of it altogether, but it's useful for zsh's completion
> wrapper.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ad3e1fe..d92d11e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -58,15 +58,12 @@ __gitdir ()
>  
>  __gitcomp_1 ()
>  {
> -	local c IFS=$' \t\n'
> -	for c in $1; do
> -		c="$c$2"
> -		case $c in
> -		--*=*|*.) ;;
> -		*) c="$c " ;;
> -		esac
> -		printf '%s\n' "$c"
> -	done
> +	local c=$1
> +	case $c in
> +	--*=*|*.) ;;
> +	*) c="$c " ;;
> +	esac
> +	printf '%s\n' "$c"
>  }
>  
>  # The following function is based on code from:
> @@ -249,10 +246,16 @@ __gitcomp ()
>  	--*=)
>  		;;
>  	*)
> -		local IFS=$'\n'
> -		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
> +		local c IFS=$' \t\n'
> +		for c in ${1-}; do
> +			c=`__gitcomp_1 "$c${4-}"`

1. Backticks.
2. A subshell for every word in the wordlist?

> +			if [[ "$c" = "$cur_"* ]]; then
> +				COMPREPLY+=("${2-}$c")

This is the first time we use the append operator in the completion
script.  When it came up last time the question was whether the
benefit of using it is large enough for worrying about supported Bash
versions.

  http://article.gmane.org/gmane.comp.version-control.git/206525

> +			fi
> +		done
>  		;;
>  	esac
> +
>  }
>  
>  # Generates completion reply with compgen from newline-separated possible
> -- 
> 1.8.0
> 
