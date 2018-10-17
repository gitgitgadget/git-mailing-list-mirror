Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7012F1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 12:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJQUAz (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:00:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41538 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQUAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:00:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so24589732edd.8
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqDvBz6uKMSNEGcRcJ+dWRuxPsorHd04dAqkp/qgj+o=;
        b=AbnpbVtoegMhangUSk+b8zYQtWzcMSiAznG1aiyG00bcn3ADRW+Yn1TAxB3eIgoVUY
         HOGokzxSAaXhWa8SixOMypBhG2+iRAqXzrIzUS18f9pw7XTehJWqEirr7s45SWzwiuRE
         xgW1xitIAP2NVggZmSOhHsi/JCcw8NJnSA2r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqDvBz6uKMSNEGcRcJ+dWRuxPsorHd04dAqkp/qgj+o=;
        b=IPo9xd6w1Ot3xV+YvU3HhT4LOk+HzNqrkZHAgQtGUCW+9tlOvWGIb32/4qQqzrjXyJ
         yiAuiNqJsu1E6X1wvtFkKNY+0VwKUHez1yuR95wYrWoHTdSEc9JTwJF4ctVGQT/62/9B
         xR98u4EohwHdFYJwWDQkcpZ/OnKbrCjUO4qPWbItwSR96KFLdxc8Avc2rHWiq3tr8I92
         Qh/sA2s6K4alk+CabrXnG7aRqDnGV4qngNTNSDI7mIwzwxANJWYMFDfZyJc10auAPCzo
         DypSN0xcaUrXVRgx8LKt1zy1famiotkAP4QS0EYcGaeqTdARweZ5JnpNNqO5N97/TPlf
         iWAA==
X-Gm-Message-State: ABuFfoh+Im3WBRkQYwa+rOlMw/x78TH4TQJKwQ4xeeHENUFUiMoT1iP8
        Of2xFn6F6/arqq3TXQjC4Q8XCigUu3tot2A/B/+JWg==
X-Google-Smtp-Source: ACcGV61wcLS05rJYtEO8C3BpzlRQosP5eu+MpNk13Iksk1QvQvDu4qcBSgyrHr6rPpye4RuAgfg1yJ+VZ6OWB7QQIRc=
X-Received: by 2002:a50:b1c4:: with SMTP id n4-v6mr422031edd.128.1539777928926;
 Wed, 17 Oct 2018 05:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181016215850.47821-1-jonathantanmy@google.com>
In-Reply-To: <20181016215850.47821-1-jonathantanmy@google.com>
From:   Arturas Moskvinas <arturas@uber.com>
Date:   Wed, 17 Oct 2018 15:05:17 +0300
Message-ID: <CAGY-PBiH1fKebjgCfrcCTpC9Xue7guqYoE51UpBQJ30zJoxGeQ@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: clear flags before each v2 request
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I can confirm that shallow clones are no longer failing.

--
Arturas Moskvinas

On Wed, Oct 17, 2018 at 12:58 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Suppose a server has the following commit graph:
>
>  A   B
>   \ /
>    O
>
> We create a client by cloning A from the server with depth 1, and add
> many commits to it (so that future fetches span multiple requests due to
> lengthy negotiation). If it then fetches B using protocol v2, the fetch
> spanning multiple requests, the resulting packfile does not contain O
> even though the client did report that A is shallow.
>
> This is because upload_pack_v2() can be called multiple times while
> processing the same session. During the 2nd and all subsequent
> invocations, some object flags remain from the previous invocations. In
> particular, CLIENT_SHALLOW remains, preventing process_shallow() from
> adding client-reported shallows to the "shallows" array, and hence
> pack-objects not knowing about these client-reported shallows.
>
> Therefore, teach upload_pack_v2() to clear object flags at the start of
> each invocation.
>
> (One alternative is to reduce or eliminate usage of object flags in
> protocol v2, but that doesn't seem feasible because almost all 8 flags
> are used pervasively in v2 code.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was noticed by Arturas Moskvinas <arturas@uber.com> in [1]. The
> reproduction steps given were to repeat a shallow fetch twice in
> succession, but I found it easier to write a more understandable test if
> I made the 2nd fetch an ordinary fetch. In any case, I also reran the
> original reproduction steps, and the fetch completes without error.
>
> This patch doesn't cover the negotiation issue that I mentioned in my
> previous reply [2].
>
> [1] https://public-inbox.org/git/CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com/
> [2] https://public-inbox.org/git/20181013004356.257709-1-jonathantanmy@google.com/
> ---
>  t/t5702-protocol-v2.sh | 25 +++++++++++++++++++++++++
>  upload-pack.c          |  5 +++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 88a886975d..70b88385ba 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -429,6 +429,31 @@ test_expect_success 'fetch supports include-tag and tag following' '
>         git -C client cat-file -e $(git -C client rev-parse annotated_tag)
>  '
>
> +test_expect_success 'upload-pack respects client shallows' '
> +       rm -rf server client trace &&
> +
> +       git init server &&
> +       test_commit -C server base &&
> +       test_commit -C server client_has &&
> +
> +       git clone --depth=1 "file://$(pwd)/server" client &&
> +
> +       # Add extra commits to the client so that the whole fetch takes more
> +       # than 1 request (due to negotiation)
> +       for i in $(seq 1 32)
> +       do
> +               test_commit -C client c$i
> +       done &&
> +
> +       git -C server checkout -b newbranch base &&
> +       test_commit -C server client_wants &&
> +
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +               fetch origin newbranch &&
> +       # Ensure that protocol v2 is used
> +       grep "git< version 2" trace
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> diff --git a/upload-pack.c b/upload-pack.c
> index 62a1000f44..de7de1de38 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -37,6 +37,9 @@
>  #define CLIENT_SHALLOW (1u << 18)
>  #define HIDDEN_REF     (1u << 19)
>
> +#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
> +               NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
> +
>  static timestamp_t oldest_have;
>
>  static int deepen_relative;
> @@ -1393,6 +1396,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>         enum fetch_state state = FETCH_PROCESS_ARGS;
>         struct upload_pack_data data;
>
> +       clear_object_flags(ALL_FLAGS);
> +
>         git_config(upload_pack_config, NULL);
>
>         upload_pack_data_init(&data);
> --
> 2.19.0.271.gfe8321ec05.dirty
>
