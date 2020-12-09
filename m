Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324BC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0D123B51
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgLIQKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:10:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:55564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730549AbgLIQKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:10:48 -0500
Received: (qmail 18141 invoked by uid 109); 9 Dec 2020 16:10:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:10:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16352 invoked by uid 111); 9 Dec 2020 16:10:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:10:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:10:04 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 12:52:26PM +0100, Patrick Steinhardt wrote:

> Co-authored-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

In case we want it, this is also:

  Signed-off-by: Jeff King <peff@peff.net>

> +--config-env=<name>=<envvar>::
> +	Pass a configuration parameter to the command. The <envvar>
> +	given will be replaced with the contents of the environment
> +	variable of that name. In contrast to `-c`, an envvar must
> +	always be given and exist in the environment. Passing an
> +	environment variable with empty value will set <name> to the
> +	empty string which `git config --type=bool` will convert to
> +	`false`.

I agree with Ævar that we probably should keep an empty variable as the
empty string. I think some options use an empty string to clear a list
(e.g., push.pushOption), and I'm not sure how they'd react to a bool
instead. It would be nice to also have a way to do the implicit-bool
thing, but I don't think it's strictly necessary (it's always correct to
put the string "true" into the variable instead).

I think we should also document that <envvar> can't contain an "=" sign.
Of course using strrchr() here doesn't help much with just this patch,
because we flatten the string before stuffing it into
$GIT_CONFIG_PARAMETERS, so the reading side would mis-parse it.

But here's a fix for that. I built it on top of your whole series, since
you touched some of the related functions, but it could easily be
rebased onto just this part.

  [1/3]: quote: make sq_dequote_step() a public function
  [2/3]: config: parse more robust format in GIT_CONFIG_PARAMETERS
  [3/3]: config: store "git -c" variables using more robust format

 config.c          | 118 +++++++++++++++++++++++++++++++++++++---------
 quote.c           |  15 ++++--
 quote.h           |  18 ++++++-
 t/t1300-config.sh |  60 +++++++++++++++++++++++
 4 files changed, 183 insertions(+), 28 deletions(-)

-Peff
