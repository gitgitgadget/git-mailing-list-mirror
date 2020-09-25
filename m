Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1CB207C4
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgIYUdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:15 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:42924 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYUXv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:23:51 -0400
Received: by mail-ej1-f65.google.com with SMTP id q13so353372ejo.9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 13:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0CHeqLjpnqSxJBoZ/MeAt1Cf+HPz+rEgyhsHE6DX3w=;
        b=gXOgfTFSm+vYMwQEhOVVUcJlwL5iDqKu4BkbsoOLFzVZB/U/5xkG2AoLbCGRaSdvLO
         ycboMAC6J9e9BpD9LwLtTg0y1LE/lRkOw+K8+Jbg12wsb6MP1YEIoW23q3wmcshTAOC1
         mXGc1nsjSCCzlo9P0P7oV0zjVMXFUP2VDHMsQWxHFUcadw6Fu0LNu1gnJ4Sj+5qvWkC+
         JtdWFZTMBy8cvceCqqNHoZTijbOHyBWXf1Ci90hxYW/fqZWNGYqMf8N+jhAisNy1agZy
         A1LCVVzHxnjzGssvb0d/U3NHD5CXM5a2K3vR85VLovh3PmEdmufR74Cj4wuAMJciA4MG
         tNLA==
X-Gm-Message-State: AOAM533ScE3G68pUW1Haj43kjfMES17aEU2C+SK3/Swg4nleEhROtgbm
        1m3rmlLXTp5TUUinaXAL/Q+w7eNsHBpJ/n1qgAq9M0uu9Ik=
X-Google-Smtp-Source: ABdhPJzrcDX+b7hm6+KL4M6Z4yx5X1DzzGu2ayLP7Hyqq7GmCVTZecTUyOdnVTed6FBIgzz6OBnrt7r/ji2uxWDKNEY=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr4484374ejq.138.1601065430288;
 Fri, 25 Sep 2020 13:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925070120.GA3669667@coredump.intra.peff.net> <20200925070550.GH62741@coredump.intra.peff.net>
In-Reply-To: <20200925070550.GH62741@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 16:23:39 -0400
Message-ID: <CAPig+cS96Y8nMQgazZE-HP4Un2LpgfPF3-63vt8=WJf0c5EuRg@mail.gmail.com>
Subject: Re: [PATCH 8/8] shortlog: allow multiple groups to be specified
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 3:05 AM Jeff King <peff@peff.net> wrote:
> This patch teaches shortlog to accept multiple --group options on the
> command line, and pull data from all of them. That makes it possible to
> run:
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> @@ -69,6 +69,11 @@ Shortlog will attempt to parse each trailer value as a `name <email>`
>  identity. If successful, the mailmap is applied and the email is omitted
>  unless the `--email` option is specified. If the value cannot be parsed
>  as an identity, it will be taken literally and completely.
> ++
> +If `--group` is specified multiple times, commits are counted under each
> +value (but again, only once per unique value in that commit). For
> +example, `git shortlog --group=author --group=trailer:co-authored-by`
> +counts both authors and co-authors.

Intuitively, I understand (or hope) that the first use of --group
overrides what is otherwise collected by default (authors), however,
would there be value in stating this explicitly?

At this point, the documentation for --committer still says:

    --committer::
        Collect and show committer identities instead of authors.
        This is an alias for `--group=committer`.

which stops feeling accurate now that --group can be specified more
than once. The "instead of authors" bit is particularly jarring. I
wonder if the first sentence can simply be dropped.
