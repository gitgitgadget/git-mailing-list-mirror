From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/3] completion: improve shell expansion of items
Date: Thu, 27 Sep 2012 02:37:51 +0200
Message-ID: <20120927003751.GI10144@goldbirke>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 02:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH27O-0004Pz-D1
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 02:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab2I0AiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 20:38:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59380 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab2I0AiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 20:38:07 -0400
Received: from localhost6.localdomain6 (p5B1308E9.dip0.t-ipconnect.de [91.19.8.233])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Lfneo-1TnLj33EN8-00pVRu; Thu, 27 Sep 2012 02:37:52 +0200
Content-Disposition: inline
In-Reply-To: <20120926215119.GC18653@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Jj6vCIuipUUukOJ1vNzU9Q4HcC9SVTVnNSqNTr/6NRv
 NJA7ubNlF7FR1AuCLxj/9LbLyv2C6ZyE2ZEp94Ef4M8VYp5oNI
 uONE2ichPrhAl8oTfMlNnu+qUW3ETXIVoPxZqyNw2S0NulXibp
 7nUjQxcxQjILk3m5Fujxf3r+gwdzPREtXpanDsV7WmgDbvHS9C
 ZXQBsHxQ3ELc+DHXmkzF3plXwQEsCk5d+0BKnBwJR1MTyFK7mM
 akJ07wavM/rJLC4qUF4fDD7Gvsdm0Ju06Fh9IwqdW3OdtgmAUC
 4ZGqPi5KgNlE0gafZdPk/3v1Ru5ahVXJ/IvHl+cxlfiBE99auJ
 HNeNGEmluv0npgDvNlgQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206456>

Hi,

On Wed, Sep 26, 2012 at 05:51:19PM -0400, Jeff King wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index be800e0..b0416ea 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -225,6 +225,18 @@ fi
>  fi
>  fi
>  
> +# Quotes each element of an IFS-delimited list for shell reuse
> +__git_quote()
> +{
> +	local i
> +	local delim
> +	for i in $1; do
> +		local quoted=${i//\'/\'\\\'\'}
> +		printf "${delim:+$IFS}'%s'" "$quoted"
> +		delim=t
> +	done
> +}
> +
>  # Generates completion reply with compgen, appending a space to possible
>  # completion words, if necessary.
>  # It accepts 1 to 4 arguments:
> @@ -261,7 +273,7 @@ __gitcomp_nl ()
>  __gitcomp_nl ()
>  {
>  	local IFS=$'\n'
> -	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> +	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")" -- "${3-$cur}"))

Iterating through all possible completion words undermines the main
reason for __gitcomp_nl()'s existence: to handle potentially large
number of possible completion words faster than the old __gitcomp().
If we really have to iterate in a subshell, then it would perhaps be
better to drop __gitcomp_nl(), go back to using __gitcomp(), and
modify that instead.

After all, anyone could drop a file called git-cmd-${meta} on his
$PATH, and then get cmd- offered, because completion of git commands
still goes through __gitcomp().
