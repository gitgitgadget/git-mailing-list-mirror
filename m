Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14ACC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D35610D1
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbhIMTfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:35:09 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:35343 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhIMTfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:35:08 -0400
Received: by mail-ej1-f43.google.com with SMTP id i21so23474485ejd.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DewcHWhytEuPurg080dehUwgcjSQJZ8A39df2iQcBLo=;
        b=jOMVUzZbGnTSFQn8GFesLWhLv2wllA0mXK0iMrT7VS3wp/wvHWT5PsVjCTZQr+9wrC
         Oe70aafufa2nC8LiO57bhXRivLG5w8kmtMkUGZ8wjWbuh1Ncz8RCRJK8RXivPqYTcHPl
         1U1N4V0K/YQxzf7Of7rxmsXLurvpe1vy4qLx2P5VZT1sL6EzC+XePFwynwpov7/smXpo
         42fEVRY9pIudXsd0DFcaW3y8GApaOf8KGogJ62+2z7m8+LYRP8/HPymjCv2Cdxq3kUGg
         0im21WSRQk6eXoXWrs5Uoe2np6ccXD2bOfIjRmpma5nYE8fcNtLely/Ud5f4/eMxI+wO
         V98w==
X-Gm-Message-State: AOAM530/3ZfTavFxQQOfqQuo3jEkK1rYjFnYf1yoyBYx3uefIqJCy95J
        zHxouTHPUnRYK+/MgaBbqOdQDh7rFAXj8ptBrB7OHzvx
X-Google-Smtp-Source: ABdhPJwIgtPeF+cOhfusIG65C43UcapL3C8ZjoOteM0UHaBpQqjhfJHIxONEH/V2KajqPFyWYX734oaNtR5yuxa1dBs=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr14363268ejd.568.1631561631687;
 Mon, 13 Sep 2021 12:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210913181221.42635-2-chooglen@google.com>
 <YT+mlW851sRyt842@nand.local>
In-Reply-To: <YT+mlW851sRyt842@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 15:33:40 -0400
Message-ID: <CAPig+cRbSUaahdRr9pj9==_7g0Om-Zax93zBRBiJg0-X7zXnOA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Glen Choo <chooglen@google.com>, Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 3:29 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Mon, Sep 13, 2021 at 11:12:19AM -0700, Glen Choo wrote:
> > +test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
> > +     cd "$TRASH_DIRECTORY/full" &&
> > +     git fsck &&
> > +     corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> > +             "incorrect checksum" &&
> > +     cp commit-graph-pre-write-test $objdir/info/commit-graph &&
> > +     git -c core.commitGraph=false fsck
>
> Nit; I recommend replacing the `-c` style configuration with
> `test_config`, which modifies `$GIT_DIR/config` but only for the
> duration of the sub-shell.

Small correction: There is no subshell here, so it would be more
accurate to say "... for the duration of the test".

Aside: In fact, test_config() can't be used in subshells due to
implementation limitations which I won't go into.
