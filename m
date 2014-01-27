From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/4] submodule: Make 'checkout' update_module explicit
Date: Sun, 26 Jan 2014 20:32:04 -0500
Message-ID: <CAPig+cQweMT6g+GLFfAWg=9hcU7EjQ7eMOjYiMDQ4rennJSsXw@mail.gmail.com>
References: <20140117023746.GJ7078@odin.tremily.us>
	<cover.1390768736.git.wking@tremily.us>
	<43e8f3bfdaffefca9edd7a23574816630690e1e5.1390768736.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 27 02:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7b3d-0003sc-VS
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 02:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbaA0BcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 20:32:08 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:43893 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbaA0BcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 20:32:06 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so4092231lab.9
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 17:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8WCXqNFcK1Y9UGNEqK/1a2xyFMRMtiXsC8fd4pRz2bQ=;
        b=d33Buf8qpsWbpw1ERCX1WXFOCRjEN2yzhX7ajh+GSg/IGA45ekJceX5Y1Yy7QLEnLM
         WrnpImOz/0m53PVex+/dMaNGb3okJay83eN6HcAtX5U8veyR6w1g6i91W7NiBCiqeAlk
         z67gVWTl0mS5TR+FIw7Qd4QaoHFrSzyA6Q/aDMEFZLbWLK7bzFDIrQEoor9CJ2LF8S8U
         vYrZAPPONJAf81jz7u5MScYvp9zhB9RUam3r6eQSuwVAwQDTiHf+JFaFLjztjMrxASDQ
         T16AXYI4Q9cWrDxOGCM8jxnKUGMujOWkGZobKdssVY1XtGDx+wzWDa4Pb71IMJU25RdV
         q/sA==
X-Received: by 10.112.173.6 with SMTP id bg6mr2259486lbc.17.1390786324234;
 Sun, 26 Jan 2014 17:32:04 -0800 (PST)
Received: by 10.114.181.228 with HTTP; Sun, 26 Jan 2014 17:32:04 -0800 (PST)
In-Reply-To: <43e8f3bfdaffefca9edd7a23574816630690e1e5.1390768736.git.wking@tremily.us>
X-Google-Sender-Auth: RMot1vbX_uS34RJAAU7Uq615c3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241125>

On Sun, Jan 26, 2014 at 3:45 PM, W. Trevor King <wking@tremily.us> wrote:
> This avoids the current awkwardness of having either '' or 'checkout'
> for checkout-mode updates, which makes testing for checkout-mode
> updates (or non-checkout-mode updates) easier.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  git-submodule.sh | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5247f78..5e8776c 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -803,17 +803,10 @@ cmd_update()
>                         update_module=$update
>                 else
>                         update_module=$(git config submodule."$name".update)
> -                       case "$update_module" in
> -                       '')
> -                               ;; # Unset update mode
> -                       checkout | rebase | merge | none)
> -                               ;; # Known update modes
> -                       !*)
> -                               ;; # Custom update command
> -                       *)
> -                               die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
> -                               ;;
> -                       esac
> +                       if test -z "$update_module"
> +                       then
> +                               update_module="checkout"

Here, you (unnecessarily) quote 'checkout'...

> +                       fi
>                 fi
>
>                 displaypath=$(relative_path "$prefix$sm_path")
> @@ -882,11 +875,16 @@ Maybe you want to use 'update --init'?")"
>                         case ";$cloned_modules;" in
>                         *";$name;"*)
>                                 # then there is no local change to integrate
> -                               update_module= ;;
> +                               update_module=checkout ;;

But here you use bare (unquoted) 'checkout'. Bare is probably more idiomatic.

>                         esac
>
>                         must_die_on_failure=
>                         case "$update_module" in
> +                       checkout)
> +                               command="git checkout $subforce -q"
> +                               die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +                               say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +                               ;;
>                         rebase)
>                                 command="git rebase"
>                                 die_msg="$(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
> @@ -906,10 +904,7 @@ Maybe you want to use 'update --init'?")"
>                                 must_die_on_failure=yes
>                                 ;;
>                         *)
> -                               command="git checkout $subforce -q"
> -                               die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> -                               say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> -                               ;;
> +                               die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
>                         esac
>
>                         if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
> --
> 1.8.5.2.8.g0f6c0d1
