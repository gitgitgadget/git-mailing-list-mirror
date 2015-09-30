From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: configure gpg at startup
Date: Wed, 30 Sep 2015 12:25:36 -0700
Message-ID: <xmqqtwqb7lqn.fsf@gitster.mtv.corp.google.com>
References: <560c2efb.894f320a.d43ae.4338@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Renee Margaret McConahy <nepella@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhN0Z-0000uw-3x
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbbI3TZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:25:39 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33204 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbbI3TZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:25:38 -0400
Received: by pacex6 with SMTP id ex6so49192235pac.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7myvhAVvlGX8OXb3fa83dOcMv1Ls0QS1lntE256ZaJc=;
        b=bmnf605V0Ug+/2A832O0klNYwAHYIQQSxKyUW04gLnQINPG09zhGuUnld7nuGqLwR4
         IkpYLk0ZgVR9cd0dI+IxX90JNcGf6WYT5njcyDfJgZZfOSZwVw75Y8f/wuYYVWjoRbnt
         ARsc6ODGSz2zMxGkCOiF2BLFHwt4P1IDLQznHx5K/riVupKJQTT54ujpnGsGrJfImR4R
         6TiJ4jJ74by6fCgtL+DbVJb7ckvRPeWOP/dfcRNiyUnioYkJo3fyaKgp7J7TXPPXH1d1
         c8hYt3I9SrsaoSgfvlveCMPurQVfvFmJnNRks3IE6AnhKrMNrQCDtTa1GyKaRJOyZU0a
         RitQ==
X-Received: by 10.66.186.39 with SMTP id fh7mr6927617pac.48.1443641137689;
        Wed, 30 Sep 2015 12:25:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id tp6sm2129626pbc.81.2015.09.30.12.25.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 12:25:37 -0700 (PDT)
In-Reply-To: <560c2efb.894f320a.d43ae.4338@mx.google.com> (Renee Margaret
	McConahy's message of "Wed, 30 Sep 2015 13:49:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278858>

Renee Margaret McConahy <nepella@gmail.com> writes:

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

Thanks.

I'd remove the unused "flags" (already pointed out by somebody, I
think), but otherwise the change looks sensible.


>  builtin/am.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 4f77e07..f0b0ffd 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2208,6 +2208,18 @@ enum resume_mode {
>  	RESUME_ABORT
>  };
>  
> +static int git_am_config(const char *k, const char *v, void *cb)
> +{
> +	int *flags = cb;
> +	int status;
> +
> +	status = git_gpg_config(k, v, NULL);
> +	if (status)
> +		return status;
> +
> +	return git_default_config(k, v, NULL);
> +}
> +
>  int cmd_am(int argc, const char **argv, const char *prefix)
>  {
>  	struct am_state state;
> @@ -2308,7 +2320,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	git_config(git_default_config, NULL);
> +	git_config(git_am_config, NULL);
>  
>  	am_state_init(&state, git_path("rebase-apply"));
