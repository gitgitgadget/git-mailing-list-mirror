Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9647D1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeHIIV3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 04:21:29 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:40889 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeHIIV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 04:21:28 -0400
Received: by mail-yw1-f49.google.com with SMTP id z143-v6so3429411ywa.7
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 22:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWZ4khMjJmP2TV9WbrJpYu1dwYqgQnA0FfiEctkbO80=;
        b=eD3bRmejuyjFSWq7ViKvOVuCwH8sml4eNvU3R4zmqtJKtmBr/QCuM49Z5Og3z+eMsN
         SuAd77Fc93dVfCZUDNf9YjE4dHqmUX+L57/DU1NP3wvRo9dMxnZa23ZJTQjVWnRzO5Lf
         ju/3d0/tIcrCouLWBaewFyo+EjZU7SX+mhQdRk/nOsUqY5vBai8RIXQr2gKA+9JiTawV
         I/zzSHMZ6GSZgqvtcuXC0pzvWRytW4uEy90PUlsuEt0SDIWVr+qvcncvL1MjMP1FI6x8
         5nMSr2iG+5IVycB9yZURNzyq9Q2tgpJepSnBMETznryI1ffOMwvwsg8nvy+cI9raho3B
         ZnaA==
X-Gm-Message-State: AOUpUlFwSxKcpq+8hI1ueUBFHhybpageXFG8KulX2TRHnejX6kfsq0FC
        s7k1vpHIGBuPK/iJvJPxG07l2J2WtaBbiacqyEs=
X-Google-Smtp-Source: AA+uWPwDr+LR5tBrW0M28QqX2G1POQejEooFfNV1kOkEvr0/m08/F8B1MmhSS2cwY0GjKZH/Wr1NkTSX2eR17cZNj9s=
X-Received: by 2002:a81:ae61:: with SMTP id g33-v6mr343443ywk.74.1533794296252;
 Wed, 08 Aug 2018 22:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com> <20180807082135.60913-2-sunshine@sunshineco.com>
 <20180808225011.GC3902@sigill.intra.peff.net>
In-Reply-To: <20180808225011.GC3902@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Aug 2018 01:58:05 -0400
Message-ID: <CAPig+cR6=HjSo4HW8jPCDBQ0SsVqCw8o=cekVEPnSZZzsh2Tkw@mail.gmail.com>
Subject: Re: [PATCH 1/5] chainlint: match arbitrary here-docs tags rather than
 hard-coded names
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 6:50 PM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 07, 2018 at 04:21:31AM -0400, Eric Sunshine wrote:
> > +# Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
> > +# line such as "cat <<EOF >out" is seen, the here-doc tag is moved to the front
> > +# of the line enclosed in angle brackets as a sentinel, giving "<EOF>cat >out".
>
> Gross, but OK, as long as we would not get confused by a line that
> actually started with <EOF> at the start.

It can't get confused by such a line. There here-doc swallower
prepends that when it starts the swallowing process and removes it add
the end. Even if a line actually started with that, it would become
"<EOF><EOF>cmd" while swallowing the here-doc, and be restored to
"<EOF>cmd" at the end. Stripping the "<EOF>" is done non-greedily, so
it wouldn't remove both of them. Likewise, non-greedy matching is used
for pulling the "EOF" out of the "<...>" when trying to match against
the terminating "EOF" line, so there can be no confusion.

> > +/<<[         ]*[-\\]*[A-Z0-9_][A-Z0-9_]*/ {
> > +     s/^\(.*\)<<[    ]*[-\\]*\([A-Z0-9_][A-Z0-9_]*\)/<\2>\1<</
> > +     s/[     ]*<<//
>
> Here-docs can use lowercase, too, though I'd personally frown on that
> from a style perspective.

Yeah, I was going with the tighter uppercase-only which Jonathan
suggested[1], but I guess it wouldn't hurt to re-roll to allow
lowercase too.

[1]: https://public-inbox.org/git/20180730205914.GE156463@aiede.svl.corp.google.com/

> It looks like this doesn't catch:
>
>   cat <<'EOF'
>   EOF
>
> either. I think we prefer the backslash style, but there are quite a few
> <<-'EOF' hits. Is it covered somewhere else?

No. I've gotten so used to \EOF in this codebase that it didn't occur
to me to even think about 'EOF', but a re-roll could add that, as
well.
