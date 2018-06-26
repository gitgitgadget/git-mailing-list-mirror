Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9751F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeFZVNR (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:13:17 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44005 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeFZVNR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:13:17 -0400
Received: by mail-yb0-f194.google.com with SMTP id g3-v6so5168496ybf.10
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/4ZuW7kUy1gRT8SXxdXILWehxHKxHOiJCnyTzyUOOE=;
        b=WQJAKSJYVj7TQKMMkCRWHwls8PF0qYYYy7eRAvovZcqtYMChmuj2aFTVNG6H0U2XgT
         MqC7F3YxebkRQ6/SYVPL4WiX1gn8MJlfa4BobM7IJt4fPGjZbmkILWU23eaZZONM2Tc2
         t56UKdkKmbrpmX3ty0F1xbe1B6VNYRXXN0hH1GswBbRfTV2KFMHlV4AgCGbJvCBjkdzD
         9+FitqUqcIvpRDJw9xptoTkl9NfyBq5YMRdCNcxUp4C7ksecBKNxn1t1T44v0K4QgvHj
         qNMDmrHeqQGszmQ9OZ9CXpkCHOXZp7EbMcwzA4tNZRIA92UlgY8cb9dsnt4g9LnwqYJz
         2r4w==
X-Gm-Message-State: APt69E1sv1hghE/0sMrWSlrCPy7y9rp0winJXx/OgJkqc3n6aNfFhiuH
        BE4sJfqGxuplDoN8FIzvbI9Mtn9k0mpVaFQ9wvg=
X-Google-Smtp-Source: ADUXVKK0jiSdzQQnmeu1oTycSsObkHSATPusBIgthRz/roNLr50N9UGfq+TJ5wpzawDM6p2wQgA98qJprViuyaUw45E=
X-Received: by 2002:a25:ac5b:: with SMTP id r27-v6mr1692035ybd.497.1530047596565;
 Tue, 26 Jun 2018 14:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <CAPig+cRvgsu-6f+mzjGVDWTVhFrhLY5MsNxEQBJYckKDpeaMAg@mail.gmail.com>
 <20180626210100.GA3682@sigill.intra.peff.net>
In-Reply-To: <20180626210100.GA3682@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 17:13:05 -0400
Message-ID: <CAPig+cRzZ-Nd2b-M8v0NUsLX_gkKwLqyakgcRhwGf3CzsWwxBA@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 5:01 PM Jeff King <peff@peff.net> wrote:
> On Tue, Jun 26, 2018 at 04:46:18PM -0400, Eric Sunshine wrote:
> > Some of these dangers can be de-thoothed during the linting phase by
> > defining do-nothing shell functions:
> >
> >     cp () { :; }
> >     mv () { :; }
> >     ln () { :; }
> >
> > That, at least, makes the scariest case ("rm") much less so.
>
> Now that's an interesting idea. We can't catch every dangerous action
> (notably ">" would be hard to override), but it should be pretty cheap
> to cover some obvious ones.

Taking the idea a bit further, the 'sed' script could also throw away
strings of "../" inside subshells, which would help defang the more
difficult cases, like "echo x >../git.c". There are pathological
cases, of course, which it wouldn't catch:

    P=../git.c
    test_expect_success 'foo' '
        (
            cd dir &&
            echo x >$P
        )
    '

but it does help mitigate the issue for the most typical cases.
