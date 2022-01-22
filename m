Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C0C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 12:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiAVMEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 07:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiAVMEo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 07:04:44 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607DC06173B
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 04:04:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id me13so7508325ejb.12
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 04:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RjxB7aJl3l3VtIKRFakLA3P5vZVtCvAuhDKPy5rw5jU=;
        b=qORFs9OYZlzz5AfsVl2vfRrMNTyqqISl6/u5lWZ41roL+bKY4V4DOLwWuJLFVdk0Hn
         2eLWtNYbtJhrwVXoiPpBqEH6m24C7FeI7ImjTVfTxtg8CjSpNNYDOfdZ4dYdthHwSGzA
         /Q8Ts6dmvYmLeCfQQEruhOTR8Pp6DeFZWRPCiqGOksOz8lnYvOvW7c3FjpIltCllbLlR
         RN5TMK0au7oG8BJwrDFA91oopdVionqTRbShaiEIKosivrUPuLKHsmsyKUgeq9oz/KxC
         A8nryB937/8NBxk8y5WOQg8xAdWLJRenBpaSviMKftwiEfOgnaqEJ7LgL7vR6jQwRIhS
         bcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RjxB7aJl3l3VtIKRFakLA3P5vZVtCvAuhDKPy5rw5jU=;
        b=Xt0032nQZ/GvlLOAgKP/2t8gETPdFC8byxs8URwE2yHt4aKLNarlEiRu98zEoVTEz+
         4xxHtPXZ3bjcRFfyefAH3XBhnlUeooOI+b1dowhLk9yCvt7Jp0TtvmFH6R+SGmqSIHxM
         vSVqs1MGUhqfZN7Epn/CulbbkHBzXV97GdPbesa0SWgpBI6RmX0ocCUV1LmUeuQPDywJ
         w7OHynATpliNb0LJgm39ISBnWmFeOiIhGQTgRNazMVU0aKSsEB4ls5DrQ44Tx/LNjMgl
         5UAEWJJeTBaTqSEUdUEzMbM7x51KhJGFMMyVGcHi5Frahz97kt1dFVKYorZ3Cc1aEdby
         Yd8g==
X-Gm-Message-State: AOAM533AWiBmobDhHLqnhCF2LWxeWxrlTKkh37CbKNWy94iO7GDC0tGx
        Rx0ZIUBrep6c7mjh+on/BoAVW1Eszdg=
X-Google-Smtp-Source: ABdhPJwbbpPBgMDEXT9G/7q9FwWZrvSUewgmFrMgUe7DljfC5jiupL+nP75xQ2GAM0olPTt7DqYVog==
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr762350ejc.662.1642853081995;
        Sat, 22 Jan 2022 04:04:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u12sm3643821edq.8.2022.01.22.04.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 04:04:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBF8K-002LsJ-6O;
        Sat, 22 Jan 2022 13:04:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: avoid BUG() when hitting a broken repository
Date:   Sat, 22 Jan 2022 12:55:02 +0100
References: <YemTGQZ97vAPUPY0@pobox.com>
 <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 <xmqqlez8d2e6.fsf@gitster.g> <xmqqbl04d1s9.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqbl04d1s9.fsf_-_@gitster.g>
Message-ID: <220122.86y238ht7r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 21 2022, Junio C Hamano wrote:

> So, taking the two earlier comments from me together...
>
> I _think_ I was the one who spotted the funny skip_prefix() whose
> result was not used, and suggested this unrelated check, during the
> review.  Sorry about that.

Where was that? I don't see a comment like that in the original
thread[1], or do you mean the recent one in [2]?

Doesn't matter much now, but whatever it was I can't find it nor recall
it, or I've misread this.

> [...]
> +test_expect_success 'checkout a branch without refs/heads/* prefix' '
> +	git clone --no-tags . repo-odd-prefix &&
> +	(
> +		cd repo-odd-prefix &&
> +
> +		origin=$(git symbolic-ref refs/remotes/origin/HEAD) &&
> +		git symbolic-ref refs/heads/a-branch "$origin" &&
> +
> +		git checkout -f a-branch &&
> +		git checkout -f a-branch
> +	)
> +'
> +
>  test_expect_success 'checkout -b to a new branch, set to HEAD' '
>  	test_when_finished "
>  		git checkout branch1 &&

It's shortly before the release, so whatever fixes the bug is good with
me, and this patch works.

I don't think dropping the parts of the tests that actually check the
resulting repository state is a good change in this re-imagining of my
initial fix[3].

I see that per your [4] you disagree with the current behavior being
"cast in stone". I also think we should change it, I just think testing
exactly what state we're in before and after will make that easier.

Here we're just testing that we don't die, and not even that it's not a
noop. If and when we change the behavior it'll be extra work to check
that we didn't change something we didn't expect (and basically
requiring digging up [3] again).

In this case we didn't have any test coverage (hence missing the
regression), and with this test we still don't have meaningful coverage.

If you're looking to clearly mark things that are desired v.s. expected
behavior wouldn't that be better done in general via something like a
new "test_expect_oddity"?

Again, for the upcoming release I think this is fine. I'd just like to
clarify the above, since this isn't the first time we've had a back and
forth where you wanted a less specific test that (in the "make coverage"
etc. sense) would lose coverage v.s. a more specific check.

1. https://lore.kernel.org/git/patch-1.1-9b17170b794-20211014T000949Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqr190d2xg.fsf@gitster.g/
3. https://lore.kernel.org/git/patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com/
4. https://lore.kernel.org/git/xmqqlez8d2e6.fsf@gitster.g/
