Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78014C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 05:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiGJFpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 01:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJFpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 01:45:06 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CE12AB8
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 22:45:05 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-31c8bb90d09so21760347b3.8
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 22:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzVtegjA6lA94mFr9sZz8flj78IB4DLsRbypGCjRXgs=;
        b=gfho1IdrZY/WeQQ6G42qpr3zaR7njJnGWbYjjGXxqekAXPBXq7mCQidMsJjxqWViyZ
         arwT/0QUDKDbMA17Zo84XWaSlZK92h3ScqhcAROJ0NJkZ38AExlWQsDD775b3zaxldEQ
         +SwoK+cqsgPXpn03uqXWJFu9tTNNNZIiNNugnXt0Xo9XuzNwycVjtWR+vILcyV8i1qKh
         fUYhOe/BjB5O1mhmlgOPgHlSq08HW1ZMQEGlsPyzRVVCRQ47eNlofwOLYhiSjnq77Hsg
         xcabbdkKRtW8vxG45ogYLQHP1qWqxdu5QqKvHmM7Mw3LlXlxyJ4q/IeHgTcSPqThJ2aH
         l8jg==
X-Gm-Message-State: AJIora8lbNgBJNUl89O0ox6EffivgQ/4y7TifxdSh6E0UQE5gv7HUNVa
        g0A+9ksoa3R+h6Y7PdH6eovlRrAl6Q1qKR8ySWQKXPyd9dE=
X-Google-Smtp-Source: AGRyM1tOTTdkVbM5wmBUTIro7NZEERMixomDt+EC/RaIHypMC8RMhTZhKqlYSCr6yQGWumEbbRX454i/PsnVY7D5Q48=
X-Received: by 2002:a81:b50:0:b0:31c:cd9a:c875 with SMTP id
 77-20020a810b50000000b0031ccd9ac875mr13638270ywl.411.1657431904479; Sat, 09
 Jul 2022 22:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
 <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com> <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
 <xmqqwncmt3el.fsf@gitster.g>
In-Reply-To: <xmqqwncmt3el.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jul 2022 01:44:53 -0400
Message-ID: <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust level
 to string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 9, 2022 at 4:52 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Fri, Jul 8, 2022 at 7:28 AM Jaydeep Das via GitGitGadget
> >> + * Returns corresponding string in lowercase for a given member of
> >> + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
> >> + * return "ultimate".
> >> +char *gpg_trust_level_to_str(enum signature_trust_level level);
> >
> > It would be a good idea to update the function documentation to
> > mention that the caller is responsible for freeing the returned
> > string.
>
> Given that there are small and fixed number of trust level strings,
> I actually think that it would be more reasonable to return a static
> string to the caller, something along the lines of the attached, so
> that callers do not have to worry about freeing it.

I also am not a fan of making the caller free the result, and thought
of mentioning it but didn't know if the approach implemented by this
patch was suggested by an earlier reviewer.

> Perhaps along the lines of ...
>
> +static struct sigcheck_gpg_trust_level {
>         const char *key;
>         enum signature_trust_level value;
> +       const char *downcased;
>  } sigcheck_gpg_trust_level[] = {
>
> +const char *gpg_trust_level_to_string(enum signature_trust_level level)
> +{
> +       struct sigcheck_gpg_trust_level *trust;
> +
> +       if (level < 0 || ARRAY_SIZE(sigcheck_gpg_trust_level) <= level)
> +               BUG("invalid trust_level requested: %d", level);
> +
> +       trust = &sigcheck_gpg_trust_level[level];
> +       if (trust->value != level)
> +               BUG("sigcheck_gpg_trust_level[] unsorted");
> +
> +       if (!trust->downcased)
> +               trust->downcased = xstrdup_tolower(trust->key);
> +       return trust->downcased;
> +}

Given the small, fixed number of trust levels, and if the list is
unlikely to change much in the future, I might suggest simply
initializing the fields at compile-time rather than on-demand at
run-time:

    static struct {
        const char *key;
        const char *display_key;
        enum signature_trust_level value;
    } sigcheck_gpg_trust_level[] = {
        { "UNDEFINED", "undefined", TRUST_UNDEFINED },
        { "NEVER", "never", TRUST_NEVER },
        { "MARGINAL", "marginal", TRUST_MARGINAL },
        { "FULLY", "fully", TRUST_FULLY },
        { "ULTIMATE", "ultimate", TRUST_ULTIMATE },
    };
