Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16571F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJXQK6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:10:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726916AbeJXQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:10:58 -0400
Received: (qmail 7861 invoked by uid 109); 24 Oct 2018 07:44:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 07:44:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2273 invoked by uid 111); 24 Oct 2018 07:43:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 03:43:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 03:44:00 -0400
Date:   Wed, 24 Oct 2018 03:44:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
Message-ID: <20181024074400.GA31239@sigill.intra.peff.net>
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
 <20181023210154.32507-1-avarab@gmail.com>
 <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 02:45:49PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Notes on the implementation:
> >
> >  * The only reason we need a new "git-sh-i18n--helper" and the
> >    corresponding "test-tool gettext-poison" is to expose
> >    git_env_bool() to shellscripts, since git-sh-i18n and friends need
> >    to inspect the $GIT_TEST_GETTEXT_POISON variable.
> >
> >    We only call these if $GIT_TEST_GETTEXT_POISON is set, or in the
> >    test suite, and this code can go away for non-test code once the
> >    last i18n-using shellscript is rewritten in C.
> 
> Makes me wonder if we want to teach "git config" a new "--env-bool"
> option that can be used by third-party scripts.  Or would it be just
> the matter of writing
> 
> 	git config --default=false --type=bool "$GIT_WHATEVER_ENV"
> 
> in these third-party scripts and we do not need to add such a thing?

The config command only takes names, not values. So you'd have to write
something like:

  git -c env.bool="$GIT_WHATEVER_ENV" config --type=bool env.bool

but then you lose the default handling. I think if we added a new
option, it would either be:

  # interpret a value directly; use default on empty, I guess?
  git config --default=false --type=bool --interpret-value "$GIT_WHATEVER_ENV"

or

  # less flexible, but the --default semantics are more obvious
  git config --default=false --type=bool --get-env GIT_WHATEVER_ENV

-Peff
