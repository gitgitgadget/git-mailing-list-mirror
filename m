From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 09/10] git submodule update: cmd_update_recursive
Date: Thu, 17 Sep 2015 16:37:58 -0400
Message-ID: <CAPig+cTbgTO_xOZ_c89n+iL6kRtpfwi7_Srcfr7YyV3as5YjZg@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:38:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcfwS-0004sw-SO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 22:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbbIQUh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 16:37:59 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33976 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbIQUh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 16:37:59 -0400
Received: by vkhf67 with SMTP id f67so18420509vkh.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 13:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ONm+yG8MgnTfLS0pzvnjihOCS9IBVp7ceXWNz1gBpN4=;
        b=BoTkl9O2hU7aO/mhgW6SBMDrH2oYhe7R9uLjH4L1lAAPdxG/8K97MkBIQeiWXhKEe1
         kKYenjEALJK6QWqMGxXMCKauC6BN2e4yHI+rvNL7f5FTpN3+71R2PYOfKCFdp+f6wRnO
         fib+POcEb9R1XANFVjHU/Cj6FXnVOwrzHbkkiylxYPP8kwHvCQdFku4tTrnBwInQaRdq
         +aQfvyw2WJFRNYclI7APffi14RrUnoKIaKXGJB59567ODiZ03WtggltuTIyCde0bBw4A
         1KF+jIvNNUbfMpuFnKs4pwIm0PtRW9wv2a5BF5dNtRj5SFB2YULQ/auEJnJRjBsvEoAp
         IH0w==
X-Received: by 10.31.11.202 with SMTP id 193mr1316992vkl.84.1442522278327;
 Thu, 17 Sep 2015 13:37:58 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 17 Sep 2015 13:37:58 -0700 (PDT)
In-Reply-To: <1442453948-9885-10-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: Ij3YMFzowVHB3ug_dCRD-Zv1j9s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278166>

On Wed, Sep 16, 2015 at 9:39 PM, Stefan Beller <sbeller@google.com> wrote:
> git submodule update: cmd_update_recursive

Commit message doesn't seem to match the patch...

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 52c2967..c40d60f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -607,6 +607,24 @@ cmd_update_recursive()
>         fi
>  }
>
> +cmd_update_clone()
> +{
> +       command="git checkout $subforce -q"
> +       die_msg="$(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> +       say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> +
> +       git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> +
> +       if (clear_local_git_env; cd "$sm_path" && $command "$sha1")
> +       then
> +               say "$say_msg"
> +       else
> +               err="${err};$die_msg"
> +               return
> +       fi
> +       cmd_update_recursive
> +}
> +
>  #
>  # Update each submodule path to correct revision, using clone and checkout as needed
>  #
> @@ -680,7 +698,6 @@ cmd_update()
>                 cmd_init "--" "$@" || return
>         fi
>
> -       cloned_modules=
>         git submodule--helper list --prefix "$wt_prefix" "$@" | {
>         err=
>         while read mode sha1 stage sm_path
> @@ -725,9 +742,8 @@ Maybe you want to use 'update --init'?")"
>
>                 if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>                 then
> -                       git submodule--helper clone ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> -                       cloned_modules="$cloned_modules;$name"
> -                       subsha1=
> +                       cmd_update_clone
> +                       continue
>                 else
>                         subsha1=$(clear_local_git_env; cd "$sm_path" &&
>                                 git rev-parse --verify HEAD) ||
> @@ -767,13 +783,6 @@ Maybe you want to use 'update --init'?")"
>                                 die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>                         fi
>
> -                       # Is this something we just cloned?
> -                       case ";$cloned_modules;" in
> -                       *";$name;"*)
> -                               # then there is no local change to integrate
> -                               update_module=checkout ;;
> -                       esac
> -
>                         must_die_on_failure=
>                         case "$update_module" in
>                         checkout)
> --
> 2.6.0.rc0.131.gf624c3d
