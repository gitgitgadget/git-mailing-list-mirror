Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25C71F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGLToA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:44:00 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44542 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeGLToA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:44:00 -0400
Received: by mail-yb0-f194.google.com with SMTP id a2-v6so11833602ybe.11
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVoEsmv12sawpnG3Cr1Gbzciof7nKmdh5WPYDfM7OVs=;
        b=opQpclNUltaRlOa6ppjjcJche5xG5liCkyX+DlNyQM7sMujUHO+sfJXQykFL6ez7cx
         pC/gf494TbtL7Qec7naMH2lDUVFxASJJL3lGx5po1aAwskvLxpY5mdZx5vxVnHtuoXtP
         DYfPrqc8uc8UD+tp+YGyElWbIz/cN3XA4ABZ3IGrzYnDbGrxfEtLsYpA8HIzym1wyi3o
         a2tu054axCOieVF8vL0Y5f3OSAUAChKSBcdKjWCbSFdPtNGzgy7tsFBfcFzzYmFebNCw
         /u/VgIi6M+xN2T7m/36jVbdIkxNj7qAjF499sDl05DoELD1LhwlpbZDBadg2W1qIg/iA
         4ohg==
X-Gm-Message-State: AOUpUlFYXfIV6IQPYAh5mB6i9xjh0orUI6SRB3D+Ku+0b1OyJCQzAbm7
        eCFGwXqOph52HcYo3JDJQUcHpP4L8l4TJzt5/tg=
X-Google-Smtp-Source: AAOMgpfr68YqFblr7ZzydR/6/FiNAIdtsk46Yzn92guX8AnYTWK+/dT5fwzsetJukFxk/NE8gIpAnmVIPPvqt8LJ4qM=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr1913145ybl.12.1531423981941;
 Thu, 12 Jul 2018 12:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com> <20180711064642.6933-2-sunshine@sunshineco.com>
 <xmqqk1q11mkj.fsf@gitster-ct.c.googlers.com> <CAPig+cS+fFZNZMxc0ARu=cZ2RVjHSP0iiLTsAJ_L7iOarwftgg@mail.gmail.com>
 <20180712165608.GA10515@sigill.intra.peff.net>
In-Reply-To: <20180712165608.GA10515@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 15:32:50 -0400
Message-ID: <CAPig+cRmAkiYqFXwRAkQALDoOo-79r2iAumdEJEZhBnETvL-fw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 12:56 PM Jeff King <peff@peff.net> wrote:
> Like Junio, I'm a little nervous that this is going to end up being a
> maintenance burden. People may hit false positives and then be
> confronted with this horrible mass of sed to try to figure out what went
> wrong [...]

A very valid concern.

> But I came around to thinking:
>   - this found and fixed real problems in the test suite, with minimal
>     false positives across the existing code

The counterargument (and arguing against my own case) is that, while
it found 3 or 4 genuine test bugs hidden by &&-breakage, they were
just that: bugs in the tests; they weren't hiding any bugs in Git
itself, which is pretty measly return for the effort invested in the
linter.

However, existing tests aside, the more important goal is detecting
problems in new or updated tests hiding genuine bugs in changes to Git
itself, so it may have some value.

>   - worst case is that relief is only a "git revert" away

Right. It's just a developer aid, not a user-facing feature which has
to be maintained in perpetuity, so retiring it is easy.
