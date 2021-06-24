Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9039C48BC2
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEAE611CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 00:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFXAKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 20:10:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:58958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhFXAKX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 20:10:23 -0400
Received: (qmail 8604 invoked by uid 109); 24 Jun 2021 00:07:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 00:07:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8314 invoked by uid 111); 24 Jun 2021 00:08:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 20:08:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 20:08:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Message-ID: <YNPM4yvk/71oeAPx@coredump.intra.peff.net>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 10:34:00AM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
> index e05d520a867..2f12ae3386d 100644
> --- a/Documentation/config/color.txt
> +++ b/Documentation/config/color.txt
> @@ -126,6 +126,12 @@ color.interactive.<slot>::
>  	or `error`, for four distinct types of normal output from
>  	interactive commands.
>  
> +color.man::
> +	This flag can be used to enable the automatic colorizaton of man
> +	pages when using the less pager, `false` by default. When set to
> +	`true` it's activated only when `color.ui` allows it, and if
> +	`color.pager` enable (which it is by default).

A few typos here:

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 2f12ae3386..fcc12df508 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -127,10 +127,10 @@ color.interactive.<slot>::
 	interactive commands.
 
 color.man::
-	This flag can be used to enable the automatic colorizaton of man
+	This flag can be used to enable the automatic colorization of man
 	pages when using the less pager, `false` by default. When set to
 	`true` it's activated only when `color.ui` allows it, and if
-	`color.pager` enable (which it is by default).
+	`color.pager` is enabled (which it is by default).
 
 color.pager::
 	A boolean to specify whether `auto` color modes should colorize

The interaction with color.ui seems unusual. Normally it is not a
gate-keeper for specific colorizations, but rather a fallback when
more-specific color config is unspecified. E.g.:

  [color]
  ui = false
  branch = true

would colorize branch output, but nothing else. But from your
description (and I think the code matches this), doing:

  [color]
  ui = false
  man = true

would still disable the man-colors. So there's no way to enable this
feature without enabling colors everywhere else. I think it should
simply be independent of color.ui (with the exception that it may
eventually use it as a fallback like all the other color.* booleans,
_if_ we want to move it to default-to-on).

-Peff
