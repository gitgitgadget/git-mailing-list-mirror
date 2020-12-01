Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A2EC83016
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DC920706
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgLAAcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:32:42 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45922 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLAAcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:32:41 -0500
Received: by mail-ej1-f68.google.com with SMTP id qw4so182362ejb.12
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6LyUzWvsYeWKPDCsK1pzrqg4umFylW7dqGuRXkjzRE=;
        b=qLMeCGTekqXRwq8S9yIs2y0xmHBD3tKGVQw/n6cbYbr0jg4TXvpSn0Z1hHYGitxkof
         cvudMSCcmB1bDQEfd6ge9sWE5UL07VRwVoHFviHxoRqKpKVrikWW2hHrIJqqiOvr6cuU
         FrB2EQGY+Jid3vF+IrI8HMXWEty4eP5Vbh8v9w6YFOImp0GWSzZXUmszHIh+63j+BhQd
         FcPUxsI5dJlt+ejzhqZ7g4vtIdeI+kKDadx1ZEPQ1UQYgZem4kDT1UqoB0VEqpR1b9Uo
         k9Zs5IGMWMkbGVuEVkeH0+qiN/CqAcffCbH5hpbt4EejuppSdZ+8pqSKOZcZSlyYpdIc
         8TAg==
X-Gm-Message-State: AOAM533r/gZNArhDl+ti7GnuoGFChvFjN17cAbhQXRZS4j4p5rNQ3lMp
        rmaul6IfhTcWomQEJi0ugrek4fU2EHbXypTM5mY=
X-Google-Smtp-Source: ABdhPJwIk57GvgGCqSGCwKH7SVaAQ0kKJX3T0wBCXqxzrodjb9XdbAFYhOyp9pygh5qT65POGUXyFSwIsc5TNmxL47A=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr468424ejb.168.1606782720427;
 Mon, 30 Nov 2020 16:32:00 -0800 (PST)
MIME-Version: 1.0
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
In-Reply-To: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Nov 2020 19:31:49 -0500
Message-ID: <CAPig+cRx03potus-ea-4J8mCuG3vVeQBJ8NcEh_Hs2yJqaoXcw@mail.gmail.com>
Subject: Re: [PATCH] builtin/bugreport.c: use thread-safe localtime_r()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 6:10 PM Taylor Blau <me@ttaylorr.com> wrote:
> To generate its filename, the 'git bugreport' builtin asks the system
> for the current time with 'localtime()'. Since this uses a shared
> buffer, it is not thread-safe.
>
> Even though 'git bugreport' is not multi-threaded, using localtime() can
> trigger some static analysis tools to complain, and a quick
>
>     $ git grep -oh 'localtime\(_.\)\?' -- **/*.c | sort | uniq -c
>
> shows that the only usage of the thread-unsafe 'localtime' is in a piece
> of documentation.
>
> So, convert this instance to use the thread-safe version for
> consistency, and to appease some analysis tools.
> ---

Missing sign-off.

> This is purely academic, since this clearly isn't a thread-unsafe usage
> of that function, but it should appease any other static analysis tools
> that folks might run.

It's not only multi-threaded cases for which it could be a problem,
but also cases in which the caller holds onto the pointer to the
returned shared buffer assuming it will remain valid until use. If the
caller invokes some other code which itself calls localtime(), then
the buffer might be overwritten before the original caller uses the
value. But, you're right that in this particular case it's academic
since strbuf_addftime() doesn't do anything which should clobber the
shared buffer.

The patch itself looks fine.
