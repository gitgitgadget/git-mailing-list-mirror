From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 3/8] submodule config: remove name_and_item_from_var
Date: Thu, 29 Oct 2015 21:23:49 -0400
Message-ID: <CAPig+cSpnGE5Acgvd+b0arcFx8oStuRRKR4fcSwZG2fbEZ6wSQ@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-4-git-send-email-sbeller@google.com>
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
X-From: git-owner@vger.kernel.org Fri Oct 30 02:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZryQ7-0006zz-9J
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbbJ3BXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:23:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33499 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975AbbJ3BXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:23:50 -0400
Received: by vkgy127 with SMTP id y127so2932825vkg.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=q+QnRZAmG6LbjFQC/XL6ZMOV2FPeQwo/SAz0eFCShbA=;
        b=vy4+sKRBsPQrBbkLDihE9RpQUTqndayW4AFyfyeuzwRNGl406BrTq7rb6dH4CcKGUB
         IAa3hKR6a6YISY1r636gu2vq2kghojw7LLjLhiV+bLqISIGaHvNJYmEE+8+O6vt49Kpw
         bRaP+isVkll7bBz3CcM0eiskR4YeVxG3H5aHIXoBPPgwPcu4u7wh7DVlNZn92Yu1rHg1
         4TE44z3AeMXlUvhKDBntkt6BGtQ5qp7wt109D1mGWHrKFc6wLlqg++nDQI09h9yhjW21
         i4WX8nw1LTwpTp4F9jWyycmn3tZcZDpWpBtEY4GbeVkGY4sLSmsyJmf7ZQ0c7rkQdKSk
         HRcQ==
X-Received: by 10.31.151.16 with SMTP id z16mr3689180vkd.14.1446168229567;
 Thu, 29 Oct 2015 18:23:49 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Thu, 29 Oct 2015 18:23:49 -0700 (PDT)
In-Reply-To: <1446074504-6014-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280472>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> submodule config: remove name_and_item_from_var
>
> By inlining `name_and_item_from_var` it is easy to add later options
> which are not required to have a submodule name.

I guess you're trying to say that name_and_item_from_var() didn't
provide a proper abstraction, thus wasn't as useful as expected.
Perhaps that commit message could make this shortcoming clearer.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/submodule-config.c b/submodule-config.c
> index 8b8c7d1..4d0563c 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -251,18 +235,25 @@ static int parse_config(const char *var, const char *value, void *data)
>  {
>         struct parse_config_parameter *me = data;
>         struct submodule *submodule;
> -       struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
> -       int ret = 0;
> +       int subsection_len, ret = 0;
> +       const char *subsection, *key;
> +       char *name;
>
> -       /* this also ensures that we only parse submodule entries */
> -       if (!name_and_item_from_var(var, &name, &item))
> +       if (parse_config_key(var, "submodule", &subsection,
> +                            &subsection_len, &key) < 0)
>                 return 0;
>
> +       if (!subsection_len)
> +               return 0;

Alternately:

    if (parse_config_key(var, "submodule", &subsection,
            &subsection_len, &key) < 0 || !subsection_len)
        return 0;

> +
> +       /* subsection is not null terminated */
> +       name = xmemdupz(subsection, subsection_len);
>         submodule = lookup_or_create_by_name(me->cache,
>                                              me->gitmodules_sha1,
> -                                            name.buf);
> +                                            name);
> +       free(name);

Since this is all private to submodule-config.c, I wonder if it would
be cleaner to change lookup_or_create_by_name() to accept a
name_length argument?

> -       if (!strcmp(item.buf, "path")) {
> +       if (!strcmp(key, "path")) {
>                 if (!value)
>                         ret = config_error_nonbool(var);
>                 else if (!me->overwrite && submodule->path != NULL)
