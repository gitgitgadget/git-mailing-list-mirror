From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/4] submodule: fix recursive path printing from non root directory
Date: Thu, 24 Mar 2016 16:38:31 -0700
Message-ID: <CA+P7+xqbkK7GKf5=eFVYkBzmrjy9hOsWGTn0W31qWiT-0ZhuPQ@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com> <1458862468-12460-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:38:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEqA-0008AU-N8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcCXXiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:38:54 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33496 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcCXXix (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:38:53 -0400
Received: by mail-io0-f170.google.com with SMTP id c63so102540484iof.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EDUBuP06uUXlJH+D5WSVXL7m/JREZGLDeSevyuvxKGQ=;
        b=nVVIMz25DkWn1+hA77tNfLbkDuys1u5XUPvQjcaFEirw4mRjtQufvCWosGRpe/Fl8t
         vRxBtRYaDtGMkCJBhlMCoNWczTgkmJNLKEqihbnwCTT4lNrfyU8P9J2lFokfYoeTr5UR
         L1Ec2ijS2qo8WbwmdJPdwO8OnyjFbzScRJk9kYT4u6sxSPWw0aE3zrd7HNxqeAoqhQxi
         MEYgclsui6AE9hYkNwrYlD4EMMGvuAlsfzEVQCDSqoEhbL4wU2KMNveOUD8agElxYUCB
         FqlrwM1YPLqPOO2nEsHUtG+5jguWe7L9f4/aDeRvs5Md1LlppiFRscTM1R6+1500BSzM
         tmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EDUBuP06uUXlJH+D5WSVXL7m/JREZGLDeSevyuvxKGQ=;
        b=IfxADvqYsqa/mop8Lfjr4TYnoEU7PzFSvhDNSf860jB4Cz1R9JZ47D7VkfScr1016o
         IPTnMazepBBFtKUqRH7zt8fVlOsvGgm8QYFWqDB7kcZUOtxE2lP7vBdqbG9PNoQ1nUJH
         UJs2VnQhe6sp1q++W3ymr2ErWhi6mDUuANLjYYCwBwQDh1tJ0nyh1KBgpguqncMJIzwF
         EeW2ac7LHhdoIgjKxq5u1UEQcrqb+A1LKFHjcomVEuvjvjHEc0lbmDZ0IonzT/s7VMFE
         ja43Vdae5r8Gge7JvjngQKaENzikAwOhpFhzuEsCLnvXgjZvpLSGXz4HFlyutGiPz0NC
         OFqw==
X-Gm-Message-State: AD7BkJIcZL1eIyV1ClmEMkWyQ2QrwSPyz/wRmrsvLgGXyQxnERxE+UAVmKMM+R5DFqiqMJCp3pPmEmaCXgqSNg==
X-Received: by 10.107.136.77 with SMTP id k74mr12750503iod.0.1458862730986;
 Thu, 24 Mar 2016 16:38:50 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Thu, 24 Mar 2016 16:38:31 -0700 (PDT)
In-Reply-To: <1458862468-12460-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289828>

On Thu, Mar 24, 2016 at 4:34 PM, Stefan Beller <sbeller@google.com> wrote:
> Recursing into submodules currently works by just calling
> (cd $submodule && eval <command>) for update, sync and status
> command.
>
> Say you have the following setup
>
> repo/ # a superproject repository
> repo/untracked/ # an untracked dir in repo/
> repo/sub/ # a submodule
> repo/sub/subsub # a submodule of a submodule
>
> When being in repo/untracked/ and invoking "git submodule status"
> you would expect output like:
>
>     repo/untracked/$ git submodule status --recursive
>      <sha1> ../sub (version)
>      <sha1> ../sub/subsub (<version>)
>
> We need to take into account that we are in the untracked/ dir,
> so we need to prepend ../ to the paths. By using relative_path
> to compute the prefix, we'll have that output.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 43c68de..536ba68 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -825,7 +825,7 @@ Maybe you want to use 'update --init'?")"
>                 if test -n "$recursive"
>                 then
>                         (
> -                               prefix="$prefix$sm_path/"
> +                               prefix="$(relative_path $prefix$sm_path)/"
>                                 clear_local_git_env
>                                 cd "$sm_path" &&
>                                 eval cmd_update
> @@ -1233,13 +1233,13 @@ cmd_sync()
>                         then
>                         (
>                                 clear_local_git_env
> +                               prefix=$(relative_path "$prefix$sm_path/")

Not really sure why this got moved, but I don't think it hurts
anything, though we will have prefix defined now regardless of if
we're recursive or not. But I think that's correct.

>                                 cd "$sm_path"
>                                 remote=$(get_default_remote)
>                                 git config remote."$remote".url "$sub_origin_url"
>
>                                 if test -n "$recursive"
>                                 then
> -                                       prefix="$prefix$sm_path/"
>                                         eval cmd_sync
>                                 fi
>                         )
> --
> 2.8.0.rc4.10.g52f3f33
>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake
