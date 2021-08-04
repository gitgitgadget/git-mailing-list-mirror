Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF6C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0523060FC3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhHDW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:29:12 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44873 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhHDW3L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:29:11 -0400
Received: by mail-ed1-f44.google.com with SMTP id z11so5506815edb.11
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70w2qkTk/hja6neR6gO+S6TbAcjKYg/4I19UsJZAz9o=;
        b=dbmYXziTgawZsv4VRn6RS2XvHhkuQAq1Mazio4JBvUtHgt7B8LbLIHfemrZ5eafzPr
         4MOc1CGH1tEeFVskUOAcDGc1vVniCNX2bJtRBCtDWBdTUnxf2GeX0NtwNeMUFBrzYDnp
         ERtLGeFMwledf8p8bSiE1K6YjmppxMVA2z6HGrwacejGcYhJbNPGeJFnNlqlF4nxW7Pn
         jKe6T38yGDqGmORUQ0f70IjWpU1AV7jJzfvYDvPZTCS2KU+V+qEVtp00yEO//bVq5NRy
         Q0ayx+2KJthO5H6WxxaoGSo74TXypuVC8ifdqWgwSw/OtNZ9m07agHnKfwK2yCn6h08M
         iS0A==
X-Gm-Message-State: AOAM5313qhHWp9zQM+KeZaX2ROHLdmYq1KWhKquOYLJV7g1t+LESj8y3
        KaiHY3bE+UfCy6nfch2RUV8sSIWZzZf5WPCe9pU=
X-Google-Smtp-Source: ABdhPJx12+kb8MrBqV8wmBp9yqnpernEH5/aEhmmj55JvkHIakjOgn/TvIiLgB/yI3ZrHFxkZkvFqsOwSnFG/4G0h1U=
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr2335398edb.89.1628116136562;
 Wed, 04 Aug 2021 15:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628115064.git.steadmon@google.com> <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
In-Reply-To: <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Aug 2021 18:28:45 -0400
Message-ID: <CAPig+cSqm5cUmAVG6f73oZ+mi9pBJrOg2va2a_Op4=wNFyHfZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 4, 2021 at 6:17 PM Josh Steadmon <steadmon@google.com> wrote:
> It is useful for performance monitoring and debugging purposes to know
> the wire protocol used for remote operations. This may differ from the
> version set in local configuration due to differences in version and/or
> configuration between the server and the client. Therefore, log the
> negotiated wire protocol version via trace2, for both clients and
> servers.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
> @@ -73,6 +74,17 @@ do
> +       test_expect_success "client & server log negotiated version (v${PROTO})" '
> +               test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
> +               cp -r "$LOCAL_PRISTINE" local &&
> +               GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
> +               git -c protocol.version=$PROTO -C local fetch \
> +                       --upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
> +                       origin &&
> +               test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events)" &&
> +               test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events)"
> +       '
>  done

What are these `test` commands actually testing? Did you mean `test
-n`? Or, even better, just plain `grep` (not within a
command-substitution)?
