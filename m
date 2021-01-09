Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B8C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5D723A1E
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 10:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAIK63 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 9 Jan 2021 05:58:29 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46900 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAIK63 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 05:58:29 -0500
Received: by mail-ej1-f51.google.com with SMTP id t16so17880767ejf.13
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 02:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZAmQECowDemPVGiGMJHD7wmbVpL1JEvJCwNdS2xcrU=;
        b=S0jUZuqK56VP2hFEHz0++iNWDHfnNYla7kp8kBLwzswWpNYFGpVij5CJiN7MssxBcz
         CxIXXN9Kb32woRG1uu2Go2FA5yyUzJ6ttLiRWQn2U9CKuB1KdxHa7rXEXEt1MrWTDmaS
         xnmOZuzdnhnp2rs0mQGL3IAajeX++QN4Mrpqfu5w5nzdRHmBXFw6JUNG17Ip/eJJKbvb
         pFY+VD2NWwtKR1QvD8OEL58JfYlP/EZVRrZzAUtzrlQDGjiljbZ6U9gt3TTrtDUJw5I9
         88gXSDwnjQMlo6JEb/FL9QtsQHq3KqgCsPpDMqNoKbIGhZpdeHSmF61BIjJqTvXRbKMd
         C/ow==
X-Gm-Message-State: AOAM533iDLsQN7tML4sbU5vOuTiqxaCZ4r43DZQEULrPY+Tl/aaVjphc
        FkHd2wFnvdaelusLH/qEfJYDe4aCxKpr+Ob935E=
X-Google-Smtp-Source: ABdhPJx8+/Lmj3gpRtakG6CFTYr3Y0obz3E0Pd+9vLXHD1JRU9JMsNuIN8yIp/YQpUwRTB3r3wjF1m8PNwXWXEYkouA=
X-Received: by 2002:a17:906:1ed6:: with SMTP id m22mr5562611ejj.231.1610189866961;
 Sat, 09 Jan 2021 02:57:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35zbgd2a.fsf@gitster.c.googlers.com> <CAPig+cQ3U4s0qmzoLL=ZBeSyCZm=QqjWz2P36ZUxMzNAyYn-WQ@mail.gmail.com>
 <X/mGnY3wR1fGoxcf@coredump.intra.peff.net> <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
In-Reply-To: <X/mJ6gHrKVxQqPX4@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Jan 2021 05:57:36 -0500
Message-ID: <CAPig+cSgeciRLJ07busWu-M9CP4DLWfQxZc3jNmVBaGL0Uq=MA@mail.gmail.com>
Subject: Re: Is t5516 somehow flakey only on macOS?
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 9, 2021 at 5:48 AM Jeff King <peff@peff.net> wrote:
> Commit 014ade7484 (upload-pack: send ERR packet for non-tip objects,
> 2019-04-13) added a test that greps the output of a failed fetch to make
> sure that upload-pack sent us the ERR packet we expected. But checking
> this is racy; despite the argument in that commit, the client may still
> be sending a "done" line when the server exits, causing it to die() on a
> failed write() and never see the ERR packet at all.
> [...]
> So let's loosen to test to avoid annoying racy failures. If we

s/to test to/the test to/

> eventually do the read-after-failed-write thing, we can tighten it. And
> if not, v0 will grow increasingly obsolete as servers support v2, so the
> utility of this test will decrease over time anyway.
>
> Note that we can still check stderr to make sure upload-pack bailed for
> the reason we expected. It writes a similar message to stderr, and
> because the server side is just another process connected by pipes,
> we'll reliably see it. This would not be the case for git://, or for
> ssh servers that do not relay stderr (e.g., GitHub's custom endpoint
> does not).
>
> Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
