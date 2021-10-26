Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27DC433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1443361078
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 18:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhJZSpm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Oct 2021 14:45:42 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44869 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbhJZSpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 14:45:36 -0400
Received: by mail-ed1-f45.google.com with SMTP id w12so273419edd.11
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 11:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AiDtPav/K1jyC4vnhK9ZKwwFZfrASnqfImI2MZ7R1WU=;
        b=w+8NdLgMEpp4x728krlW19ji4Axw34NvDuMnuKFXD6vQT/TzUx6s03xZoWQ16HfhY3
         WKTnDpAfgHSpXm87Lftgx3lkneNHbri7sBxucXxTx7Lz8/Rjg4H89QbjxgE0AFtbkJ9y
         rR0p62t2i0Jr+Wh3/D21WVcYEKEp0VIpAO+cCOOxYG6gMo0uT/gIyKBsySWm5CjHs0ga
         7AxdM7+9oK1lujdsOG1dEo0gMEhjmzq4hSnu2nPXUwuJySs0mVWkj477mhWxEWRjO2Gs
         pM9rxNRFv2qNUBfwv9zQYfsovsOawj+uJd2RhHyespD92/J0NSdhv2SlWJ6A3A42RXjF
         BSEQ==
X-Gm-Message-State: AOAM531ddnnOavm7ww+0s9nj1BsugbqnN2Z7yVjz8nHTWVcgp/4EebY3
        ev8oS4x96BKKCobDiT22kK2CSxnl/BzwcUxZAN8=
X-Google-Smtp-Source: ABdhPJwVUKPAi1KTqReIW4dEIYgXkxAIgtr6zd2p4V3D0SrTAxk2PP4rYN6vUBlp7+vQ5O4jWbgj++PTpd6yHV1LSII=
X-Received: by 2002:a17:907:7244:: with SMTP id ds4mr18332685ejc.392.1635273791619;
 Tue, 26 Oct 2021 11:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5ytkzbt7.fsf@gitster.g> <211026.8635oo11jk.gmgdl@evledraar.gmail.com>
 <211026.864k93zteh.gmgdl@evledraar.gmail.com>
In-Reply-To: <211026.864k93zteh.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 14:43:00 -0400
Message-ID: <CAPig+cRMfzHA0vq6YHs4r3BU2UP6eBGvhb8mnEdeW7LB=E4z2w@mail.gmail.com>
Subject: Re: pre-v2.34.0-rc0 regressions: t7900-maintenance.sh broken due to
 'systemd-analyze' (was: What's cooking in git.git (Oct 2021, #06; Mon, 25))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 11:40 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> So "fixing" that is easy, just have the prereq test that thing in
> particular, and why does one thing have a /lib/ prefix, but not the
> other?
>
> But presumably this points to a bigger problem. I.e. we just did a "git
> maintenance start" a few lines earlier.
>
> If I could start something via systemd then presumably it's either up,
> or our "start" is buggy and we didn't actually start something, or are
> using the wrong (non-portable?) invocation to check the running status
> of the thing we just started?

The bit you're missing is that the test script only mocks up starting
and stopping the systemd unit:

    write_script print-args <<-\EOF &&
    printf "%s\n" "$*" >>args
    EOF

    GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" \
        git maintenance start --scheduler=systemd-timer &&

So, it's only running the `print-args` script, not actually invoking
`systemctl`.

On the other hand, the "analyze" check really is invoking a real
systemd command. (Why `systemd-analyze` needs to open /dev/tty0
explicitly rather than just emitting to stdout or stderr is a
different question...)

> Also aside from that shouldn't this be:
>
>     test_when_finished "systemd-something stop-it some-service" &&
>     systemd-something start-it some-service &&
>     [...]
>
> Or are runaway services handled somehow by systemd magic (tied to the
> PID of the test run?).

Answered above: we're just mocking starting/stopping the unit, not
actually launching any background services.
