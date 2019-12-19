Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B8C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EDF227BF
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLSU4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:56:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36080 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSU4v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 15:56:51 -0500
Received: by mail-io1-f65.google.com with SMTP id r13so7214645ioa.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 12:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZI5BlvitawXciakQyNmllcQikEGaN8RouJA7OOpCYg=;
        b=bhAZ1QEVT8ONOLRSmXliTL2jej9fEyUV3ow4ixp9t7JydVULEr6/oQH48BQWClna/h
         L+KfwEEkRmkMcbN52ZHtnX0XuPScdqF0zsRl98CLnt0BTeElwp8T6ofrNFV+MDi+4SZu
         2VFmiee8pDpq/gPJ4yCV/7HeEhnzXGTJx7N+PVhIDqA6nAYYD3RGRa8HWfVFx7oax8fi
         3ekNM5pA6aEZeZx7oY8uD0TYyn40K0aC0vOShf7INvzgQ2SgmsvYQmH1OMQ6X/8Vf41T
         T7d0C6ViFRB08KAuIqFF6ugBbyyhujoeJQt1yPRzRKLTOcg8977xfzazcvbPilGgxmxP
         Ov0A==
X-Gm-Message-State: APjAAAV/fmoAqwlT32DGNM/FGfWbcyErAUO/muiZm72nWNciinWK5QIH
        p/IlIKxG+qYGO7oektHizRcShjc3OUS50ffBNzA=
X-Google-Smtp-Source: APXvYqyUqGEfOfuDwU7FYUneyBS4BNl08bFTh0xvW8+PhTaEZX4SeQktCa3DhK2jRsvYhNGH2TLwPzoiVUSXfdyFbBk=
X-Received: by 2002:a5e:aa12:: with SMTP id s18mr7036871ioe.182.1576789011185;
 Thu, 19 Dec 2019 12:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191219024518.GA3411@dcvr>
 <xmqqpngkb2ye.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpngkb2ye.fsf@gitster-ct.c.googlers.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Thu, 19 Dec 2019 15:56:39 -0500
Message-ID: <CAPyFy2BubWbyq6tQmHYxquikn2+uHz+48VSfQ308BYiuE=SSWQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Dec 2019 at 13:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmph, my honest me is very tempted to say
>
>  (1) don't run your tests as 'root', as that would break many tests
>      with prerequisite SANITY

It looks like this is just Cirrus-CI's default without explicit
configuration or scripting to use an unprivileged user. Certainly
running the build and test as root is generally not a good idea, but
it is a purpose-built throwaway VM and so doesn't matter much. Anyhow,
it certainly needs to be addressed to avoid skipping the SANITY tests.

>  (2) fix your "ls" to behave

Well, given that hidden dot files were ostensibly a bug and BSD ls has
had this behaviour for over 40 years it's far too late to change. I
can see the rationale for showing all files for root, even though I
dislike the behaviour changing between privileged and unprivileged
users.

> but if you want to list paths that match shell glob *, this would do
>
>         (cd "$1" && printf "%s\n *)
>
> without any loop (other than the one printf gives us implicitly for
> free), wouldn't it?

Yes.

> Note that the helper function's name no longer reflects what it does
> with such a change, so it needs to be renamed.  Together with style
> fix, perhaps
>
>         ls_no_dot () {
>                 (cd "$1" && printf "%s\n *)
>         }
>
> is what we want,

I believe the tests should pass or be skipped when run as root, so I
think we should either require (something like) SANITY for these
tests, or make the change above. I'm happy with either option; I'll
send a v2 based on the approach above for consideration.
