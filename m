Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE4C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0E4206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFKAQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:16:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39475 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgFKAQx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:16:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id t18so4273364wru.6
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jt3uAEXTc7b/m4+RyeYTp7XQ/hJMbDSbM8AeKbO+sl0=;
        b=NX0iVo1Qd2tUtMIqlt+gzuQAZIRpqtol0MnDSzNgczWyrPtaZbCWBie4Vmt1ho2m7j
         3ekgNOrLnfO93gFrGg5p0Qt9RKz3hPVmNKusPFsxNJyGBWn24azvaI3/D3IRuq1Ni+bc
         Fa4ZXExJi4C093/84FjXCWlxuKqAZ2cul/DZlt4/k3XWfRFLTtd+ENxwc+kXDq7eaXAp
         +fWJtIKxhgDuDNP37QuSmPIDDWe8uTTGrbnVlpgg8Sir0AeC+RDwsT0zBD02Mh09CCYU
         tS7QKcRSgby3YKb0AcOadjSwrmEAF0Bowf1JwGxMWQrWv07VtsAiTPSyjP/msPWx3SAN
         mEXw==
X-Gm-Message-State: AOAM530L+cvqB/gKl3zKtMf6MbHj+TsHPNeeZ91GwzKqiS0VFOKfJkiw
        3ZjVnetqpfX5jbkELDPbQTN2CcOoCcGddYsQtjlgx7swKMo=
X-Google-Smtp-Source: ABdhPJycDTV2Im2O9EFTvH7DJTRLr53hNcnD2CVSYiMMFcU2lPEhmkliE8ZkXO41watVSlEOBbnYyjet7iR0XyNj8+w=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr6786642wrw.277.1591834610392;
 Wed, 10 Jun 2020 17:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Jun 2020 20:16:38 -0400
Message-ID: <CAPig+cSnEvVB5vsffFXidG1-XNxDX10u2XhD9NqV3pwh8zyxxw@mail.gmail.com>
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
To:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 5:19 PM Don Goodman-Wilson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> To make this process much less cumbersome, let's introduce support for
> `core.defaultBranchName`. That way, users won't need to keep their
> copied template files up to date, and won't interfere with default hooks
> installed by their administrators.
> [...]
> Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
> ---
> diff --git a/refs.c b/refs.c
> @@ -560,6 +560,40 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
> +                       die(_("Could not retrieve `core.defaultBranchName`"));

Nit: here the error message is capitalized...

> +               if (from_config)
> +                       branch_name = from_config;
> +               else
> +                       branch_name = "master";

Non-actionable nit: could be written:

    branch_name = from_config ? from_config : "master";

> +       }
> +
> +       if (short_name)
> +               return from_config ? from_config : xstrdup(branch_name);

The logic overall is a bit difficult to follow when trying to
understand when and when not to duplicate the string and when and when
not to free(), but seems to be correct.

> +       /* prepend "refs/heads/" to the branch name */
> +       prefixed = xstrfmt("refs/heads/%s", branch_name);
> +       if (check_refname_format(prefixed, 0))
> +               die(_("invalid default branch name: '%s'"), branch_name);

Here, the error message is not capitalized. It would be nice for both
messages to share a common capitalization scheme. These days, we tend
to favor _not_ capitalizing error messages, so perhaps remove
capitalization from the earlier one.

> +/*
> + * Retrieves the name of the default branch. If `short_name` is non-zero, the
> + * branch name will be prefixed with "refs/heads/".
> + */
> +char *git_default_branch_name(int short_name);

Overall, the internal logic regarding duplicating/freeing strings
would probably be easier to grok if there were two separate functions:

    char *git_default_branch_name(void);
    char *git_default_ref_name(void);

but that's subjective.
