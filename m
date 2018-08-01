Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A7461F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbeHAVHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 17:07:09 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39781 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeHAVHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 17:07:09 -0400
Received: by mail-yb0-f196.google.com with SMTP id c4-v6so2734731ybl.6
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kEBHXmIdCYA9c88FKFNgOMiHcsmVOOnTfo3ek6qHhDg=;
        b=pKjRC+wYyUSPaiqyxWcoMuDd+LYmd+qM55CPlCPkBiab25clay+3kjcwhpPAoTtp+i
         8+Q+Erk1Zoo77dlIwTbj3ilOFKJZDqY7m0V/rwgFf8uyyW5NS6godNbwux7tSjXiq/YP
         nEicvT10qRVflzVt7krAoxx7oHmfHKRZ9qHlDMt5IFHYUC53mO7qmPtjHXDUHMdTZ7Kg
         qojD7hW+QBdjiUq3YcqQhD5t5e3NOZeXkdw3xOCP730ttSMnoprd/MyTs5J6o/malbVW
         LZKqQdt21XUN+MtJwQpV9l5h5ulhjpJfHl31SZLH9NgDgcQk8k0x5cVHE/y0VaFL7KZm
         LlIw==
X-Gm-Message-State: AOUpUlHnHyp0iAmE0x6SrdhpttYIjqOx27uJwv7MqjVDKYKRnDMCC4eS
        Fr6ZEo0CDF0S5oznyMuLV/nQTkoLYXMtJ5JBPStbn9we
X-Google-Smtp-Source: AAOMgpfVMeRrEn2xfYCsnGM8QrEOWzY27O4zuj79B4y8zD9viPZeqrDtFZ+uWkgHgDYdmurJ2GPa1bkVS+/yUeStZ+E=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr14334924ybq.295.1533151192895;
 Wed, 01 Aug 2018 12:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net> <20180731111532.9358-3-phillip.wood@talktalk.net>
 <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com> <1f9a9062-445d-0c37-9b21-941d8fef659b@talktalk.net>
In-Reply-To: <1f9a9062-445d-0c37-9b21-941d8fef659b@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Aug 2018 15:19:41 -0400
Message-ID: <CAPig+cTttbV2FjnoS_SZtwh2J4wwzsbK+48BAbt1cV0utynYzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 1, 2018 at 11:50 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 31/07/18 22:39, Eric Sunshine wrote:
> > On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> >> +       /*
> >> +        * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE
> >> +        * line with a "'" and also escaped "'" incorrectly as "'\\\\''" rather
> >> +        * than "'\\''". We check for the terminating "'" on the last line to
> >> +        * see how "'" has been escaped in case git was upgraded while rebase
> >> +        * was stopped.
> >> +        */
> >> +       sq_bug = script.len && script.buf[script.len - 2] != '\'';
> >
> > This is a very "delicate" check, assuming that a hand-edited file
> > won't end with, say, an extra newline. I wonder if this level of
> > backward-compatibility is overkill for such an unlikely case.
>
> I think I'll get rid of the check and instead use a version number
> written to .git/rebase-merge/interactive to indicate if we need to fix
> the quoting (if there's no number then it needs fixing). We can
> increment the version number in the future if we ever need to implement
> other fallbacks to handle the case where git got upgraded while rebase
> was stopped. I'll send a patch tomorrow

Hmm, that approach is pretty heavyweight and would add a fair bit of
new code and complexity which itself could harbor bugs. When I
commented that the check was "delicate", I was (especially) referring
to the rigid "script[len-2]", not necessarily to the basic idea of the
check. So, you could keep the check (in spirit) but make it more
robust. Like this, for instance:

/* big comment explaining old buggy stuff */
static int broken_quoting(const char *s, size_t n)
{
    const char *t = s + n;
    while (t > s && *--t == '\n')
        /* empty */;
    if (t > s && *--t != '\'')
        return 1;
    return 0;
}

static int read_env_script(...)
{
    ...
    sq_bug = broken_quoting(script.buf, script.len);
    ...
}

I would feel much more comfortable with a simple solution like this
than with one introducing new complexity associated with adding a
version number.
