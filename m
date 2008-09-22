From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] git abbref-ref: new porcelain for abbreviate_ref()
Date: Mon, 22 Sep 2008 08:32:22 -0700
Message-ID: <20080922153222.GD3669@spearce.org>
References: <1222074591-26548-1-git-send-email-bert.wesarg@googlemail.com> <1222074591-26548-2-git-send-email-bert.wesarg@googlemail.com> <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 17:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhnPm-0002AP-Nb
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 17:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbYIVPcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYIVPcY
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:32:24 -0400
Received: from george.spearce.org ([209.20.77.23]:55203 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbYIVPcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 11:32:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CB04A3835F; Mon, 22 Sep 2008 15:32:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222074591-26548-3-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96482>

Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> This gives direct access to the abbreviate_ref() function. The operation
> mode defaults to the core.warnambiguousrefs value, like the refname:short
> format, but can be explicitly changed with the --{,no}-strict option.
> 
> The bash completion script utilizes this new command.

And it slows down too, doesn't it?  Now we are doing a fork per
branch during completion.  Yikes.  Didn't you just post a series
about making completion faster?
 
> Junio, if this is not a porcelain, tell me.

IMHO its plumbing.  Porcelain is used by a human.  Plumbing is the
bits needed to make human interfaces.
 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 93f0881..7f002c0 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -112,9 +112,9 @@ __git_ps1 ()
>  		fi
>  
>  		if [ -n "$1" ]; then
> -			printf "$1" "${b##refs/heads/}$r"
> +			printf "$1" "$(git abbrev-ref $b)$r"
>  		else
> -			printf " (%s)" "${b##refs/heads/}$r"
> +			printf " (%s)" "$(git abbrev-ref $b)$r"
>  		fi
>  	fi
>  }
> @@ -162,7 +162,7 @@ __git_heads ()
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> -		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
> +		n,refs/heads/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
>  		n,*) is_hash=y; echo "$i" ;;
>  		esac
>  	done
> @@ -180,7 +180,7 @@ __git_tags ()
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> -		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
> +		n,refs/tags/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
>  		n,*) is_hash=y; echo "$i" ;;
>  		esac
>  	done
> @@ -199,9 +199,9 @@ __git_refs ()
>  		case "$is_hash,$i" in
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;
> -		n,refs/tags/*) is_hash=y; echo "${i#refs/tags/}" ;;
> -		n,refs/heads/*) is_hash=y; echo "${i#refs/heads/}" ;;
> -		n,refs/remotes/*) is_hash=y; echo "${i#refs/remotes/}" ;;
> +		n,refs/tags/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
> +		n,refs/heads/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
> +		n,refs/remotes/*) is_hash=y; echo "$(git abbrev-ref $i)" ;;
>  		n,*) is_hash=y; echo "$i" ;;
>  		esac
>  	done
> @@ -222,7 +222,7 @@ __git_refs_remotes ()
>  		case "$is_hash,$i" in
>  		n,refs/heads/*)
>  			is_hash=y
> -			echo "$i:refs/remotes/$1/${i#refs/heads/}"
> +			echo "$i:refs/remotes/$1/$(git abbrev-ref $i)"
>  			;;
>  		y,*) is_hash=n ;;
>  		n,*^{}) is_hash=y ;;

-- 
Shawn.
