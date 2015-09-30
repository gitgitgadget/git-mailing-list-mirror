From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] am: configure gpg at startup
Date: Wed, 30 Sep 2015 14:53:39 -0400
Message-ID: <CAPig+cSqp+o+MNDyprF8SY1on-SZucTEHWc1Zi2QOnr_93k5jA@mail.gmail.com>
References: <560c2efb.894f320a.d43ae.4338@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Renee Margaret McConahy <nepella@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:53:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMVe-0008IJ-EK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933134AbbI3Sxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:53:41 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36287 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbbI3Sxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:53:40 -0400
Received: by vkfp126 with SMTP id p126so27731355vkf.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iVaIRaYez9XZAFrSC6v9V7tT8Ee5cD9Fd+iszIAHC2I=;
        b=0vK9/ip135LHF1vcVDYyQ5Z9KsY+5gYLIjzkJ0CdFrs2Rxa8WjVmA98cYhq4IxMzeU
         8HgnxwaiFhiLW83bOiOui6c0mywBQ/wQu+nHbIDkb/kfYNqdL8ZUteOJLyznPrj6RD9f
         kmVa43QYiemAbzRfLYP2vCBE1/GaKRfhgLQTvNclCYlfTx7/sVby0+dLcZ4VlBtvFiFP
         +tlvphJiPubGZYBz1d9WX0QNKBTLYUQMhCFI2Js00nd9i6WEK6U7pJ2AxJ8hTJ7FSCXj
         R82x8JsuQRKq/ooGLo+fnybrVZXtEBB9/ZlZ1Ky1PRmSVBblRMHZSH1CabBJIiDl7Ss4
         b/Tw==
X-Received: by 10.31.56.193 with SMTP id f184mr4305968vka.115.1443639219310;
 Wed, 30 Sep 2015 11:53:39 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 30 Sep 2015 11:53:39 -0700 (PDT)
In-Reply-To: <560c2efb.894f320a.d43ae.4338@mx.google.com>
X-Google-Sender-Auth: taxc8nMn521RoRzm9uPgQlFi0lo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278854>

On Wed, Sep 30, 2015 at 1:49 PM, Renee Margaret McConahy
<nepella@gmail.com> wrote:
> The new builtin am ignores the user.signingkey variable: gpg is being
> called with the committer details as the key ID, which may not be
> correct. git_gpg_config is responsible for handling that variable and is
> expected to be called on initialization by any modules that use gpg.
>
> Perhaps git_gpg_config's functionality ought to be merged into
> git_default_config, but this is simpler and in keeping with the current
> practice.
>
> Signed-off-by: Renee Margaret McConahy <nepella@gmail.com>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> index 4f77e07..f0b0ffd 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2208,6 +2208,18 @@ enum resume_mode {
>         RESUME_ABORT
>  };
>
> +static int git_am_config(const char *k, const char *v, void *cb)
> +{
> +       int *flags = cb;

'flags' seems to be unused.

> +       int status;
> +
> +       status = git_gpg_config(k, v, NULL);
> +       if (status)
> +               return status;
> +
> +       return git_default_config(k, v, NULL);
> +}
> +
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
>         struct am_state state;
> @@ -2308,7 +2320,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                 OPT_END()
>         };
>
> -       git_config(git_default_config, NULL);
> +       git_config(git_am_config, NULL);
>
>         am_state_init(&state, git_path("rebase-apply"));
>
> --
> 2.6.0
