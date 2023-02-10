Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6636C05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 10:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjBJKpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 05:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBJKpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 05:45:49 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB446BA92
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:45:47 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id z1so6042469plg.6
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 02:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ylDlohEZf1Ap5x+h8djV1dOLrINkBsrUR5+4Q36iiE=;
        b=M29qCnsYNBBZRrBRNweq/Yry/kyuMta/PYmB/nekpHR2sN/k1k6HGqBSSKFHcwgDvC
         AmG63dudQX3qIp0p5+BmYFJJTMCE4EHNXZHt/salaOWIoS+A9euRm6bN0zkYkPbF7P0D
         Ph2Y5JoETjp9i6lV6NbVzrbsdhZraEWVmpcHWQPoHUk7bsdoNses93tMWWjd69v/iZj8
         MlXl7DFuaXqyt18nA3PcYwnOEQpAvWe1G638QdQlWGu+NHr47oIwcNcOfTcQ3zCi4qEZ
         JPufnTwU+g+LO/Qp7hyr0iAoTbsRztZKTmA+bWLudl5qlqyU6LwhvOxSQr7+GuQSF27F
         dC/Q==
X-Gm-Message-State: AO0yUKUp+pZldnsEKfl/gB2bNg0+5lk3xdpequc2vDnfvq+aXVfrmgSB
        6LGhQ261TSewknD7Yo3b22AlwDkO2gJTBDyHsgiRZXWI1tA=
X-Google-Smtp-Source: AK7set8+NvjOoJD+ShXShwgIfohrzV6iPYmY/eSXd0RNV+df6dMfrGp6J0OIIsd2NecJVhmsN0/nUVOyxEhbI+niceE=
X-Received: by 2002:a17:90a:a786:b0:230:7861:1897 with SMTP id
 f6-20020a17090aa78600b0023078611897mr2103935pjq.134.1676025946563; Fri, 10
 Feb 2023 02:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20230209164552.8971-1-vinayakdev.sci@gmail.com>
In-Reply-To: <20230209164552.8971-1-vinayakdev.sci@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Feb 2023 05:45:35 -0500
Message-ID: <CAPig+cT1EtPO2FLvTsw3SjgCgk=ovNwY77hsX6p7ETKiq8aNog@mail.gmail.com>
Subject: Re: [GSoC][PATCH] {apply,alias}: convert pre-processor macros to enums
To:     Vinayak Dev <vinayakdev.sci@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2023 at 12:00 PM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> {apply,alias}: convert pre-processor macros to enums

Thanks for submitting a GSoC microproject. Let's take a look...

> Groups related #define macros into enums in apply.c and alias.c .

s/Groups/Group/

> The changed #define macros are related constants, so it makes sense to group them.

They already have a common prefix and are grouped textually, so it's
obvious to readers that they are related, thus this isn't necessarily
a good selling point for such a change.

> This also makes debugging easier, as modern debuggers can identify enum constants and list them accordingly.

This is a much better selling point for why such a change would be
desirable. Unfortunately, though, the real situation is more
complicated. The stated argument is only true if these enum values are
assigned to variables of the enum type. However, this patch only
defines the new enumeration type but never actually uses it to declare
variables, so the benefit for the debugger is never seen. For
instance, this patch defines:

  enum binary_type_deflated {
    BINARY_DELTA_DEFLATED = 1,
    BINARY_LITERAL_DEFLATED
  };

but then the code only ever assigns the enum value to an 'int' variable:

  int patch_method;
  ...
  patch_method = BINARY_DELTA_DEFLATED;

at which point the enum value's type is lost; it's an `int` and that's
how the debugger sees it, just as an `int`, so the debugger
can't/won't show it as an actual enum value.

To fix this, the patch would need to change the variable declaration, as well:

  enum binary_type_deflated enum binary_type_deflated;

Finally, please wrap the commit message so it fits in 72 columns.

> Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
>
> vinayakdsci (1):
>   Change #define to enum in apply.c and alias.c

There should be a "---" line just below your sign-off to tell git-am
where the patch's commit message ends, but the "---" line is missing
for some reason. If you didn't remove the "---" line manually, then
you may need to adjust your patch-sending tool to not strip it out.

> diff --git a/alias.c b/alias.c
> @@ -44,9 +44,15 @@ void list_aliases(struct string_list *list)
> -#define SPLIT_CMDLINE_BAD_ENDING 1
> -#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
> -#define SPLIT_CMDLINE_ARGC_OVERFLOW 3
> +/* #define SPLIT_CMDLINE_BAD_ENDING 1 */
> +/* #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2 */
> +/* #define SPLIT_CMDLINE_ARGC_OVERFLOW 3 */
> +enum split_cmdline_error {
> +       SPLIT_CMDLINE_BAD_ENDING = 1,
> +       SPLIT_CMDLINE_UNCLOSED_QUOTE,
> +       SPLIT_CMDLINE_ARGC_OVERFLOW
> +};

Retaining the #define lines as comments serves no purpose once you
have introduced the enum. It's confusing for readers, and there is a
good chance that the commented-out #defines and enum values will drift
out of sync over time.

If we look at the code which utilizes these values, we see several
instances like this:

  return -SPLIT_CMDLINE_BAD_ENDING;

which means that the value being returned from the function is not a
valid enum value since it has been negated. Thus, in this case,
converting the #defines to an enum makes the code less valid and less
clear. Moreover, these constants are only used in `return` statements
from the function, are always negated, and are always returned as the
exit code of the program itself; they are never stored in variables.
Thus, the debugger-related benefit mentioned in the commit message can
never materialize.

So, all in all, I'd say that this is one of those unfortunate cases in
which conversion from #define to enum is unwanted since it makes the
code less clear and less valid, and provides no benefit. If you reroll
the patch, I'd suggest dropping these modifications to "alias.c".

> diff --git a/apply.c b/apply.c
> @@ -205,8 +205,13 @@ struct fragment {
> -#define BINARY_DELTA_DEFLATED  1
> -#define BINARY_LITERAL_DEFLATED 2
> +/* #define BINARY_DELTA_DEFLATED   1 */
> +/* #define BINARY_LITERAL_DEFLATED 2 */
> +
> +enum binary_type_deflated {
> +       BINARY_DELTA_DEFLATED = 1,
> +       BINARY_LITERAL_DEFLATED
> +};

As above, omit the commented-out #define lines. They serve no purpose.

> @@ -918,8 +923,14 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
> -#define DIFF_OLD_NAME 0
> -#define DIFF_NEW_NAME 1
> +
> +/* #define DIFF_OLD_NAME 0 */
> +/* #define DIFF_NEW_NAME 1 */
> +
> +enum diff_name {
> +       DIFF_OLD_NAME = 0,
> +       DIFF_NEW_NAME
> +};

Unlike the change to "alias.c", these changes don't seem to be
harmful, thus they may make sense. However, as mentioned above, they
are not helpful to the debugger as-is. You would also have to change
the variable declarations from `int` to `binary_type_deflated` and
`diff_name`, respectively, for the debugger to benefit from the
change.
