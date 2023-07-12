Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7941EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 16:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGLQ4t convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 Jul 2023 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGLQ4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 12:56:48 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50912E
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:56:47 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-635dd1b52a2so43975566d6.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 09:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181006; x=1691773006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rQaWrhS0A4BSTee3Hig/WOgjNDCoAqoqhWn871g4GA=;
        b=ZsAkllxZ9pUHJm4B8KwnBYA/h/J+SfglzFK0rpGgjGCFBynUsnkVMKG8kQ2FjRDDUw
         2z3DwdGBJOPSCb0pP0PCDsiZN0dBdaBckCmmutz9O+AuI80h4+dyecniyrYed7/5j3ka
         UJ3YHMs8MUWk6EsTpPt976kyzgUWDwiRHGSUSm/2YkUCDASxESpeIIDfxSqC3oz46rYN
         7It+cD3vz4WQo3RVJWRMh5XrLwnHH4V3UHAFolxGoXtFuHtizvTa2AOnN9x9aCSOAN9x
         +gGkN6ctv6e2J8ZNV/M/aI+SnmK7px/UDKvDsJoGS0K79GA7BsklEwNXcoDL5o62ntod
         bHTg==
X-Gm-Message-State: ABy/qLZYGT+cvzZfkeVOSlNyiCvMJ9JGKDQ9iFwgJ6obX4sWCS2o9db1
        iShRbZUr6SC5TNO4QQn183j5oPzmBX9d+lDZ5OLR/i7L
X-Google-Smtp-Source: APBJJlFV05r4De2o2IhdV9Cvt37P935SirHO6e7Wj8sL7/WlXUWMxJn6OiR+Dqb/PJqZG0ReGFUO+YWHEnnU2kjiSBI=
X-Received: by 2002:a0c:b3ce:0:b0:636:fda0:a23 with SMTP id
 b14-20020a0cb3ce000000b00636fda00a23mr14910582qvf.27.1689181006456; Wed, 12
 Jul 2023 09:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230712110732.8274-1-andy.koppe@gmail.com>
In-Reply-To: <20230712110732.8274-1-andy.koppe@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jul 2023 12:56:35 -0400
Message-ID: <CAPig+cT3tWnSfk+ZoRWU=JTGctMiE38fH5V1ebpP7L1bGsfU4Q@mail.gmail.com>
Subject: Re: [PATCH] pretty: add %r format specifier for showing refs
To:     Andy Koppe <andy.koppe@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not a proper review... just running my eye quickly over the patch...

On Wed, Jul 12, 2023 at 7:17 AM Andy Koppe <andy.koppe@gmail.com> wrote:
> This lists refs similarly to the %D decoration format, but separates
> the refs with spaces only and omits "tag:" annotations. It's intended
> primarily for color output, where tags are already distinguished by
> color.
>
> Refactor format_decorations() to take an enum decoration_format argument
> that determines the prefix, separator and suffix as well as the tag
> annotation.
>
> For %d and %D, wrap the "tag:" annotation and the actual tag in separate
> color controls, because otherwise the tag ends up uncolored when %w
> width formatting breaks a line between the annotation and tag.
>
> Amend t4207-log-decoration-colors.sh to reflect the added color
> controls, and t4202-log.sh to test the %r format.
> ---

Missing sign-off.

> diff --git a/log-tree.h b/log-tree.h
> @@ -13,17 +13,18 @@ struct decoration_filter {
> +enum decoration_format {
> +  DECO_FMT_BARE = 0,
> +  DECO_FMT_UNWRAPPED,
> +  DECO_FMT_WRAPPED,
> +};

Indent with TAB, not spaces.

Is this enum name a bit too generic for a public header? A quick scan
of other enums in the project shows that they usually incorporate the
"subsystem" into their names somehow (often as a prefix); for
instance, "enum apply_ws_ignore", "enum bisect_error".
