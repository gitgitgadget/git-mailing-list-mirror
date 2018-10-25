Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B870D1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 10:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJYTR4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:17:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:54084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726832AbeJYTR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:17:56 -0400
Received: (qmail 7701 invoked by uid 109); 25 Oct 2018 10:45:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Oct 2018 10:45:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16347 invoked by uid 111); 25 Oct 2018 10:44:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 25 Oct 2018 06:44:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2018 06:45:43 -0400
Date:   Thu, 25 Oct 2018 06:45:43 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
Message-ID: <20181025104542.GA14455@sigill.intra.peff.net>
References: <20181023191758.15138-1-agruenba@redhat.com>
 <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU6YLeTBU02k-Md7+H5kJDq2RXZmAXMaq8ZkiuSmZFXbwQ@mail.gmail.com>
 <xmqqr2gfn1cy.fsf@gitster-ct.c.googlers.com>
 <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHc6FU5CpBNpzfPs0hkNm9Hw1iYnALvUY4WL1z=sPVT10fq+zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 11:49:06AM +0200, Andreas Gruenbacher wrote:

> > That is why I asked what "problem" this patch fixes.  Without
> > answering that question, it is unclear if the patch is completing
> > missing coverage for "--all", or it is cargo culting an useless
> > clearing done for "--glob" and friends to code for "--all" that did
> > not do the same useless clearing.
> 
> This is how the --exclude option is described:
> 
>        --exclude=<glob-pattern>
>            Do not include refs matching <glob-pattern> that the next
> --all, --branches,
>            --tags, --remotes, or --glob would otherwise consider.
> Repetitions of this
>            option accumulate exclusion patterns up to the next --all,
> --branches, --tags,
>            --remotes, or --glob option (other options or arguments do not clear
>            accumulated patterns).
> 
> I'm assuming that some thought has gone into making the options behave
> in this particular way. The implementation in revision.c follows this
> pattern, but the implementation in builtin/rev-parse.c only almost
> does.

Yeah. I think this is just a bug in 9dc01bf063 (rev-parse: introduce
--exclude=<glob> to tame wildcards, 2013-11-01), in that it's handling
of --all differed from e7b432c521 (revision: introduce --exclude=<glob>
to tame wildcards, 2013-08-30). The clearing is very much intentional
and documented, and in general rev-parse should behave the same as
rev-list.

An easy test is:

  $ git rev-list --no-walk --exclude='*' --all --all
  3289ca716320457af5d2dd550b716282ad22da11
  ...a bunch of other tip commits...

  $ git rev-parse --exclude='*' --all --all
  [no output, but it should print those same tip commits]

-Peff
