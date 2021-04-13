Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53228C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3628A61019
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhDMHda (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:33:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:50824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238142AbhDMHd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:33:29 -0400
Received: (qmail 28657 invoked by uid 109); 13 Apr 2021 07:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:33:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23187 invoked by uid 111); 13 Apr 2021 07:33:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:33:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:33:08 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] config: allow overriding of global and system
 configuration
Message-ID: <YHVJNOjJhysn7LBy@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <d27efc0aa847f3fb179307b3a265b3759b7d9570.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d27efc0aa847f3fb179307b3a265b3759b7d9570.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 09:11:52AM +0200, Patrick Steinhardt wrote:

> +test_expect_success 'override global and system config with missing file' '
> +	sane_unset GIT_CONFIG_NOSYSTEM &&
> +	test_must_fail env GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=/dev/null git config --global --list >actual &&
> +	test_must_fail env GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=does-not-exist git config --system --list >actual &&
> +	GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=does-not-exist git version
> +'

I was slightly surprised to see these still marked as test_must_fail.
But it's because git-config, when given a _specific_ file to read, will
complain if the file doesn't exist. And that is true independent of your
patch.

There is one interesting implication there. Running:

  GIT_CONFIG_SYSTEM=/dev/null git config --system --list

does _not_ complain, even though:

  GIT_CONFIG_NOSYSTEM=1 git config --system --list

does. IMHO that is quite sensible, but I wanted to point it out, as
using /dev/null is not an exact replacement for GIT_CONFIG_NOSYSTEM (in
my opinion it is even better ;) ).

-Peff
