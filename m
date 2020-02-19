Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA2C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88173208E4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSTe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:34:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSTe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:34:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so1982380wrm.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI4tBeGAefCD0aBKh0ElKb9OxJM+x0OMXRW/GSUHYI0=;
        b=Puzw0NOTYfCs/KFKe5BvHEYT9tCk3dskol/QdAwOBfN3Cd9PquzT8ugnDYZLVUXpdY
         vvXU4KcpTlVZvyvMfKM6T6Y3LyQpzavFMltVLwsOGJGssRSyOxZiasra9jSHXvdij54F
         1R8RpqSMMkbmqQoaZrF2JBvPF31D8o0Jr/Fq6keBpsHLG/GzOZqc16BdKAdRpEbVM9qp
         fhkvH0rLvF1MUR/Qu6ZSMa1dH5sGNqtdC/HzRyA324+JxDcXg2r6AXSQ7mDRx5W3LODd
         6LJZynFOakO97DDycsFKuVnoDVOJ+gAYKR3NOhhIwkZRh3/SHA6Clh4ClGMzgqia/pBe
         pFog==
X-Gm-Message-State: APjAAAVms3GYk2GREuOspqXGJ/5r9nTPmBhpUsy4qhFiwLdciDabOIyn
        NId92OC4W0sud3drAYpJbs7ogPO0QRDLO2V+jH9dNg==
X-Google-Smtp-Source: APXvYqwPYvMgGY4vV/VGL2M8Bsh3WjlM5OSn9SUydK4mlV58LsOK0E4V6jKzq9f7N6sjDL7hWMY76tqAiplKGg3vTy4=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr39452779wrr.226.1582140894955;
 Wed, 19 Feb 2020 11:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20200219161352.13562-1-pbonzini@redhat.com> <20200219161352.13562-4-pbonzini@redhat.com>
In-Reply-To: <20200219161352.13562-4-pbonzini@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 14:34:43 -0500
Message-ID: <CAPig+cQOZwA3aAzBko-RL8UnW77DuBY-s_-J2D+35Ofn=fFfsg@mail.gmail.com>
Subject: Re: [PATCH 3/4] am: support --show-current-patch=raw as a synonym for--show-current-patch
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Git List <git@vger.kernel.org>, bfields@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 11:15 AM <pbonzini@redhat.com> wrote:
> [...]
> We would like therefore to add a new mode to "git am" that copies
> .git/rebase-merge/patch to stdout.  In order to preserve backwards
> compatibility, "git am --show-current-patch"'s behavior as to stay as

s/as to/has to/

> is, and the new functionality will be added as an optional
> argument to --show-current-patch.  As a start, add the code to parse
> submodes.  For now "raw" is the only valid submode, and it prints
> the full e-mail message just like "git am --show-current-patch".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -2078,7 +2082,14 @@ static int show_patch(struct am_state *state)
> -       patch_path = am_path(state, msgnum(state));
> +       switch (sub_mode) {
> +       case SHOW_PATCH_RAW:
> +               patch_path = am_path(state, msgnum(state));
> +               break;
> +       default:
> +               abort();
> +       }

I expect that this abort() is likely to go away in the next patch, so
it's not such a big deal, but the usual way to indicate that this is
an impossible condition is with BUG() rather than abort(). So, if you
happen to re-roll for some reason, perhaps consider using BUG()
instead.

> @@ -2130,8 +2141,42 @@ enum resume_type {
> +static int parse_opt_show_current_patch(const struct option *opt, const char *arg, int unset)
> +{
> +       int new_value = SHOW_PATCH_RAW;
> +
> +       if (arg) {
> +               for (new_value = 0; new_value < ARRAY_SIZE(valid_modes); new_value++) {
> +                       if (!strcmp(arg, valid_modes[new_value]))
> +                               break;
> +               }
> +               if (new_value >= ARRAY_SIZE(valid_modes))
> +                       return error(_("Invalid value for --show-current-patch: %s"), arg);
> +       }

I think the more typical way of coding this in this project is to
initialize 'new_value' to -1. Doing so will make it easier to some day
add a configuration value as fallback for when the sub-mode is not
specified on the command line. So, it would look something like this:

    int submode = -1;
    if (arg) {
        int i;
        for (i = 0; i < ARRAY_SIZE(valid_modes); i++)
            if (!strcmp(arg, valid_modes[i]))
                break;
        if (i >= ARRAY_SIZE(valid_modes))
            return error(_("invalid value for --show-current-patch: %s"), arg);
        submode = i;
    }

    /* fall back to config value */
    if (submode < 0) {
        /* check if config value available and assign 'sudmode' */
    }

> +       if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
> +               return error(_("--show-current-patch=%s is incompatible with "
> +                              "--show-current-patch=%s"),
> +                            arg, valid_modes[resume->sub_mode]);

So, this allows --show-current-patch=<foo> to be specified multiple
times but only as long as <foo> is the same each time, and errors out
otherwise. That's rather harsh and makes it difficult for someone to
override a value specified earlier on the command line (say, coming
from a Git alias). The typical way this is handled is "last wins"
rather than making it an error.

> +       resume->mode = RESUME_SHOW_PATCH;
> +       resume->sub_mode = new_value;
> +       return 0;
> +}
