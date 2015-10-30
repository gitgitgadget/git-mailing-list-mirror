From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 4/8] submodule-config: parse_config
Date: Thu, 29 Oct 2015 21:53:44 -0400
Message-ID: <CAPig+cRHy5iT940scnKyMNDx8zgXt50ZsFqF0tALVRpueKdo-A@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-5-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 02:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrytG-0002m9-Im
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209AbbJ3Bxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:53:48 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35324 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbJ3Bxp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:53:45 -0400
Received: by vkfw189 with SMTP id w189so38929391vkf.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tPCg3ZcGg0ce9uX1ptaZ0niLqji/FV0oq80Kbmi0AhM=;
        b=U0lAt7CrM2EXIKtvrtZLxpyQiH1QF8nPLaZS1l80E34q1tyWN8MivuyFCTBynxNNX0
         vv8yqvQflbBMZKUkvrXeKLNjnYx8CAx+tybRe0JuayNvzHsm58ihOuMGZvs6jvSjQuu9
         TrCemfIbxv+mGN7hnaPJgZ7l8A/o3Ed1mcA3ANFatSBiHlN4ACCndHZREWxDitszT8k2
         zjnffCrWj5bYlSv4+RsTjB07mF4Sq9H5rgb79a+9vONaE3sqHLFKoOfu+NpgjgJm9ObG
         XRAxnbHPIwkR17a6smowIqrTO7u2klUsBqLWPVKFOBhRWGtX/kqbHIDDqkclFHPwP628
         w3aQ==
X-Received: by 10.31.131.141 with SMTP id f135mr3731180vkd.37.1446170024286;
 Thu, 29 Oct 2015 18:53:44 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Thu, 29 Oct 2015 18:53:44 -0700 (PDT)
In-Reply-To: <1446074504-6014-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280473>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> submodule-config: parse_config

Um, what?

> This rewrites parse_config to distinguish between configs specific to
> one submodule and configs which apply generically to all submodules.
> We do not have generic submodule configs yet, but the next patch will
> introduce "submodule.jobs".
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> # Conflicts:
> #       submodule-config.c

Interesting.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/submodule-config.c b/submodule-config.c
> index 4d0563c..1cea404 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -231,27 +231,23 @@ struct parse_config_parameter {
>         int overwrite;
>  };
>
> -static int parse_config(const char *var, const char *value, void *data)
> +static int parse_generic_submodule_config(const char *var,
> +                                         const char *key,
> +                                         const char *value)
>  {
> -       struct parse_config_parameter *me = data;
> -       struct submodule *submodule;
> -       int subsection_len, ret = 0;
> -       const char *subsection, *key;
> -       char *name;
> -
> -       if (parse_config_key(var, "submodule", &subsection,
> -                            &subsection_len, &key) < 0)
> -               return 0;
> -
> -       if (!subsection_len)
> -               return 0;
> +       return 0;
> +}
>
> -       /* subsection is not null terminated */
> -       name = xmemdupz(subsection, subsection_len);
> -       submodule = lookup_or_create_by_name(me->cache,
> -                                            me->gitmodules_sha1,
> -                                            name);
> -       free(name);
> +static int parse_specific_submodule_config(struct parse_config_parameter *me,
> +                                          const char *name,
> +                                          const char *key,
> +                                          const char *value,
> +                                          const char *var)

Minor: Are these 'key', 'value', 'var' arguments analogous to the
like-named arguments of parse_generic_submodule_config()? If so, why
is the order of arguments different?

> +{
> +       int ret = 0;
> +       struct submodule *submodule = lookup_or_create_by_name(me->cache,
> +                                                              me->gitmodules_sha1,
> +                                                              name);
>
>         if (!strcmp(key, "path")) {
>                 if (!value)
> @@ -318,6 +314,30 @@ static int parse_config(const char *var, const char *value, void *data)
>         return ret;
>  }
>
> +static int parse_config(const char *var, const char *value, void *data)
> +{
> +       struct parse_config_parameter *me = data;
> +
> +       int subsection_len;
> +       const char *subsection, *key;
> +       char *name;
> +
> +       if (parse_config_key(var, "submodule", &subsection,
> +                            &subsection_len, &key) < 0)
> +               return 0;
> +
> +       if (!subsection_len)
> +               return parse_generic_submodule_config(var, key, value);
> +       else {
> +               int ret;
> +               /* subsection is not null terminated */
> +               name = xmemdupz(subsection, subsection_len);
> +               ret = parse_specific_submodule_config(me, name, key, value, var);
> +               free(name);
> +               return ret;
> +       }
> +}

Minor: You could drop the 'else' and outdent its body, thus losing one
indentation level.

    if (!subsection_len)
        return parse_generic_submodule_config(...);

    int ret;
    ...
    return ret;

This might give you a less noisy diff and would be a bit more
consistent with the early part of the function where you don't bother
giving the if (parse_config_key(...)) an 'else' body.
