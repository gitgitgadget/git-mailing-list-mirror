From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/4] submodule: fix recursive execution from non root directory
Date: Thu, 24 Mar 2016 16:41:42 -0700
Message-ID: <CA+P7+xqravWtkXQFC2aRg7=-mOdmQgu6Ci9QeFBMYUoy9YejWA@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com> <1458862468-12460-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:42:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEtE-0001X3-7U
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcCXXmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 19:42:04 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33972 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcCXXmC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 19:42:02 -0400
Received: by mail-io0-f176.google.com with SMTP id m184so99676606iof.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Hn6Kbp9T11K4lxihW9B7qUGSisBEFdkfdDT8sv/CdA=;
        b=s68uz5/hBUUx44yxAzz2t771fGYYR3BFeNpnUcWlMebGsq0f4pnGv0jLZ7Gmce4PPk
         gZRN4twEFtq0yLDdqfWTBdJuOen/TM/7a9uUWW789ioooZSUZ5pjUb3pFSXRI6LeAfQp
         R7MPtVbMeehekUCbVWjvLv9xS9XzSDXjSupMg1QtLYZaTrh24F3rUC73UV1oiDhxCPb9
         cAo/Opm0eO1uh43alaokl5HlNVMDlky3T6xPICi1C8kWgDvPZDvCawzAqx57CwDpRMue
         MdLtAygozYyDlvzLcV309kw8T6HjrmX5Nc1K4YNumrBq8LNM0D4+YoFZZajSjjVAF6tZ
         uKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Hn6Kbp9T11K4lxihW9B7qUGSisBEFdkfdDT8sv/CdA=;
        b=i/87ZYjW0EpFR1hAlz8FMZxn2buFAbWjY9pRn+CNZi26oaxYQ5cxuvXRKDDFQMQBQB
         qGf8LAMRpPwhZ+6t8eBNZy0udKbyMHO9f4ARqYPaLIrBcqdXdVTTttvdsPyplXCo+2Rg
         2FkTrPW8Z0O6GQprvgdB0/SPxgpJLMeZljxi+h875zbnnScf8c2mk8JdomakVLn2+kjh
         taOeg5eEgd31jRoz3O7QUeCnvgOGurp9oihBe35cbfgGZjKU0F07FpeAf35WG8aCQiYK
         dMwLgxkSzxg1HqObHCTs9donVw/FQeJeIcLIsYT5aHhuefhBqSzJLRTqpKhiZq+P7C4l
         ev6A==
X-Gm-Message-State: AD7BkJKoVPictwKM3ju/dmUBgzUYU6fWq7h9DtGltwVV2oiU6/jAGlyi1X7EwlTG4Hb1qqmQsPvtTCKTnAxfGA==
X-Received: by 10.107.136.77 with SMTP id k74mr12760959iod.0.1458862921494;
 Thu, 24 Mar 2016 16:42:01 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Thu, 24 Mar 2016 16:41:42 -0700 (PDT)
In-Reply-To: <1458862468-12460-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289829>

On Thu, Mar 24, 2016 at 4:34 PM, Stefan Beller <sbeller@google.com> wrote:
> One of the first things that happens in most submodule sub commands is
>
>     git submodule--helper list --prefix "$wt_prefix"
>
> Currently the passed --prefix is used for doing path calculation
> as if we were in that path relative to the repository root, which is
> why we need to pass "$wt_prefix". The more common way in Git however
> would be to use
>
>     git -C "$wt_prefix" submodule--helper list
>
> which I want to change later. That way however does not just
> pass the prefix into the submodule command, but also changes
> into that directory.
>
> Say you have the following setup
>
> repo/ # a superproject repository
> repo/untracked/ # an untracked dir in repo/
> repo/sub/ # a submodule
> repo/sub/subsub # a submodule of a submodule
>
> When in repo/untracked/ and invoking "git submodule status --recursive",
> the recursed instance of the latter version for listing submodules would
> try to change into the directory repo/sub/untracked, which is a bug.
> This happens as we cd into the submodule in git-submodule.sh without
> clearing wt_prefix, which is the assumed relative path inside the working
> directory.
>
> Most times that directory doesn't exist and we error out. Fix this bug
> by clearing wt_prefix, such that any recursive instances of will assume
> to operate from the respective root of the respective submodule.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 536ba68..6b18a03 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -827,6 +827,7 @@ Maybe you want to use 'update --init'?")"
>                         (
>                                 prefix="$(relative_path $prefix$sm_path)/"
>                                 clear_local_git_env
> +                               wt_prefix=
>                                 cd "$sm_path" &&
>                                 eval cmd_update
>                         )
> @@ -1159,6 +1160,7 @@ cmd_status()
>                         (
>                                 prefix="$displaypath/"
>                                 clear_local_git_env
> +                               wt_prefix=
>                                 cd "$sm_path" &&
>                                 eval cmd_status
>                         ) ||
> @@ -1240,6 +1242,7 @@ cmd_sync()
>
>                                 if test -n "$recursive"
>                                 then
> +                                       wt_prefix=

And here I think I see why we moved the original prefix code up some.
This looks good.

>                                         eval cmd_sync
>                                 fi
>                         )
> --
> 2.8.0.rc4.10.g52f3f33
>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Regards,
Jake
