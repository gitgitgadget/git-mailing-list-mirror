Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A7C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD26D207FB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbgGAQK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:10:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbgGAQKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:10:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id h5so24613515wrc.7
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 09:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YPP/VS2wjPG599Qpy84tZH52/PV2lmp7Mo4TUr1V+Y=;
        b=JOCvvQAPSWZfknGorMLbOz8fAH/sZ8n1UTewN9voj20ZEDcwZX8VWO3lavPeTnez2A
         kW3YX32QCOKOqHfNjaIdhTT2JEryiFU8RGE0rRiCCymzpit6ufZfZUT3IWlNpijln+Dz
         ijBpvyBkoGlRDCbLK87G62F/uJLbhci5JtQwXWVCTjZ7+Uq84zV0/XY3R4RHYqoIbjvn
         QeppWY3OteVQKJjy4ViLXA6ElcEWtko30iVecgPgYYtMS3YEYjrPlgm9TXKqpXWRfh3t
         A6Ukz9+mVjesZQKWHN7+27DpIbAq0tgwuCuTiLx12L6/KP1ANnOQoyayZqjmzjUUKvUO
         01kQ==
X-Gm-Message-State: AOAM531lpid1ZtGtakPiZy1+oRMlR/D/zxRD+9+zjRclMhhK8ArMrNLi
        JBqVR7lrdRK/Ml/NEwM+wmfynXLF95VTayxx1R3oOA==
X-Google-Smtp-Source: ABdhPJz8m6Trl9dKJddVPgK9oRcLrlUjnjSD/Pt331xCVFRqYxEF5oN4MRyP/A3a3J8XGisNvTl5/zYYOTvrfFgw8C4=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr29014979wrd.277.1593619823167;
 Wed, 01 Jul 2020 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200701093653.3706-1-ben@wijen.net> <20200701093653.3706-3-ben@wijen.net>
In-Reply-To: <20200701093653.3706-3-ben@wijen.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jul 2020 12:10:11 -0400
Message-ID: <CAPig+cTEpajuD98RH5xepJ+rK2f75SROrTvgjzKnyfjxbuA1AQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git clone: don't clone into non-empty directory
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 5:46 AM Ben Wijen <ben@wijen.net> wrote:
> When using git clone with --separate-git-dir realgitdir and
> realgitdir already exists, it's content is destroyed.
>
> Make sure we don't clone into an existing non-empty directory.
>
> Signed-off-by: Ben Wijen <ben@wijen.net>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> @@ -1021,6 +1021,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>                 die(_("destination path '%s' already exists and is not "
>                         "an empty directory."), dir);
>
> +       if (real_git_dir) {
> +               real_dest_exists = path_exists(real_git_dir);
> +               if (real_dest_exists && !is_empty_dir(real_git_dir))

"git init --separate-git-dir=" checks only whether the path exists,
and errors out if it does; it doesn't care whether the directory is
empty or not. I'm wondering, therefore, if this check should be
tightened to more closely align the behavior of the two commands.
(Using the tighter semantic now doesn't prohibit loosening it in the
future, whereas it's harder to tighten behavior which started out
loose.)

> +                       die(_("destination path '%s' already exists and is not "
> +                               "an empty directory."), real_git_dir);

This message might be a bit clearer if "destination" is changed to
"repository". (And drop the bit about not being empty -- if we go that
route.)
