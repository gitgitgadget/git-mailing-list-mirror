Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11A4C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 07:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiBOHdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:33:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiBOHdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 02:33:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC8119434
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:33:09 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qk11so21923392ejb.2
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WNrQoaWqxm358SubvdvwD+XdO65ANZ/052xcDwTbkk=;
        b=bH7bIqjpvBQzM2Q7j+6EldS0BYnbArNansaZx2ccS2Cd9/HLLCYOrjKWvICjCPXn/p
         7wb7H/7EnO4y6ED+Q+ZOoKbDHsyZfnNQzWH5xo4/QJAsxzr4cmYHCwWrRfUwYh+2EEQS
         7AJ7t1iW44vGjJBwIFTo6JQwHXj/WM39gZVOyxMs016htbrXjn1yOOf0Ft8B6XFTmhO2
         SCm5kMqBAiimu6uWMo6tDQBjPPNf8s4CTUd7sN+BbYnosoKZjTfiKh0MdOjaFR1PYD/A
         Z38EiCqc04cLMR44aDd6mvtBcX6y1dhVhGmsArHpp3a1ileUHXPIcM/x0PTlMWqEuuQS
         4UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WNrQoaWqxm358SubvdvwD+XdO65ANZ/052xcDwTbkk=;
        b=DRMFE2ixWNU5E/VdkA83Ok9KGyIKMqTMcrGZTw9EPOCRVeJFbNiKJWBvPBe2lY0jz5
         iaMv1OhcO6vOfO65fvfLowR4tHTIoKWP8NivoYMCaDamBxUWprNM+G2nFq8Z6YxGnFw5
         SL9uwTcquusJ2ypx0M/Sem+unXKLmOZPF8YsXX5yoAYo9HUpj5m6NCrq0hu3uIMx8DQO
         6StRI/Zu0Xw08eLE9WutVl3hhUYBOdhNK+q23Ahi6xPtYfoIVmwVy/riFyUAXcvIJS/4
         r3GER9cR2eC9veADkrvsNWnnyBIygoGK9yCWSMNswR+L5aZh4/WDq7KhL+fTp0fxXwal
         GOjA==
X-Gm-Message-State: AOAM532POxxsUXpGC8qEfB5bcOWGhlLC/9zm8WAslUY7orVo3//a9pg9
        AIyW+Px22lwnLcvoNhMSmUQwwER+/4xTuoQchozjBchzAvo=
X-Google-Smtp-Source: ABdhPJxNgv0mw7A23EMDW4yg/Dn4f5IvL1Rm4X6SUOjmlK6N71aUJ/aNXuTaQajLDtcZ86N7LzaiS/5T3kRgLFjwCKA=
X-Received: by 2002:a17:907:868a:: with SMTP id qa10mr2019029ejc.540.1644910387867;
 Mon, 14 Feb 2022 23:33:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <4059d5034bd9137ffca4929ed5bd8b7ce75ea09c.1644565025.git.ps@pks.im>
In-Reply-To: <4059d5034bd9137ffca4929ed5bd8b7ce75ea09c.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 08:32:56 +0100
Message-ID: <CAP8UFD32MQSVQ2uUhmO29jFz=LfqvN8U7e-a=sDgQAxUh+Gadw@mail.gmail.com>
Subject: Re: [PATCH 3/6] fetch: control lifecycle of FETCH_HEAD in a single place
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 12, 2022 at 5:49 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> There are two different locations where we're appending to FETCH_HEAD:
> first when storing updated references, and second when backfilling tags.
> Both times we open the file, append to it and then commit it into place,
> which is essentially duplicate work.
>
> Improve the lifecycle of updating FETCH_HEAD by opening and committing
> it once in `do_fetch()`, where we pass the structure down to code which

s/down to code/down to the code/

> wants to append to it.

> @@ -1601,6 +1596,10 @@ static int do_fetch(struct transport *transport,
>         if (!update_head_ok)
>                 check_not_current_branch(ref_map, worktrees);
>
> +       retcode = open_fetch_head(&fetch_head);
> +       if (retcode)
> +               goto cleanup;
> +
>         if (tags == TAGS_DEFAULT && autotags)
>                 transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
>         if (prune) {
> @@ -1617,7 +1616,8 @@ static int do_fetch(struct transport *transport,
>                                    transport->url);
>                 }
>         }
> -       if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
> +
> +       if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)) {
>                 retcode = 1;
>                 goto cleanup;
>         }

I think the following (if it works) would be more consistent with
what's done for open_fetch_head() above:

retcode = fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)
if (retcode)
      goto cleanup;
