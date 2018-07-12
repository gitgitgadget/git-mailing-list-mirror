Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E501D1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 10:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeGLK7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 06:59:33 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35032 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeGLK7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 06:59:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so11227036ybm.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 03:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bB59pVLUgT9ZsI6F3LJgCOZOkV8d2yDDR4KE4vqqqwc=;
        b=l/+0B6uUwghgjzam3dLSarPPYHpPDyVDKD6yo0TJyJzoIGuv2PjtMFZOneqCJkAPo2
         Xio1038wg/+qmMLJdBaa1gIbMFWwoLJ++HZtQsxv60jdqezlYb+y3GdCEWNpW8JsyMw/
         80kuMTCCo2VasG5aJaunkHkPv0JEOPa/op7URAqf5yPCXJLUdZiITjOf/l3PqdsulIJN
         Tgb2yd8SHPZPnjZPrMe3yLMA6hdCFMLdozC8IbRwJC6kMiiLDT27G7+CDFAWKUXA7waH
         czZ7XbyLfIQOHst35rrfOfkd9BfDVx3KEPUgVea5LzwLzv3cTOowk4vvxTUwWANiL+WQ
         PXdQ==
X-Gm-Message-State: AOUpUlE7JrXZj0XpYdkPTtz5ypGgtkO65IMozqpdds1tQUViTCOYjXsp
        f6Av7x1ATLvUmaaVv4O22Fczpt78fDJYq9wnejc=
X-Google-Smtp-Source: AAOMgpdkdBuymdUAaE/Y65Af3n9Q8qet2Oc4FD8ZqJSyBEp7UOmt44X7ClzXM9m2HapT5lM3wuMedHK9xfaHiBVXQRQ=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr732592ybf.287.1531392632255;
 Thu, 12 Jul 2018 03:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 06:50:20 -0400
Message-ID: <CAPig+cS+fFZNZMxc0ARu=cZ2RVjHSP0iiLTsAJ_L7iOarwftgg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 5:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> As with the previous "transform the script and feed the result to
> shell" approach, this risks to force us into writing our tests in a
> subset of valid shell language, which is the primary reason why I
> was not enthused when I saw the previous round.  The worst part of
> it is that the subset is not strictly defined based on the shell
> language syntax or features (e.g. we allow this and that feature but
> not that other feature) but "whatever that does not cause the linter
> script to trigger false positives".

Some observations perhaps worth considering:

The linter is happy (no false positives) with the 13000+ existing
tests (though, of course, not all of them use subshells). Those tests,
written over many years, vary quite wildly in style and implementation
approach, so the "subset" of shell language accepted by the linter is
quite broad.

The original --chain-lint series (jk/test-chain-lint) had to make some
changes, such as wrapping code in a {...} block[1], merely to pacify
the linter. v2 of the subshell linter required no such changes.

The subshell linter was crafted to be on par with the existing
--chain-lint in terms of strictness (and looseness), so the subshell
linter is not more strict than the existing implementation. (For
instance, one can escape the strict &&-chain requirement in the
existing --chain-lint by wrapping code in a {...} block. The subshell
linter intentionally allows that escape, as well.)

And, perhaps most important: We're not tied indefinitely to the
"subset" implemented by the current linter. If it is indeed found to
be too strict or limiting, it can always be loosened or retired
altogether.

Thanks for the feedback.

[1]: bfe998fc9b (t0050: appease --chain-lint, 2015-03-20)
