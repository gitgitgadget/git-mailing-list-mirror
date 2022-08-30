Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3262BECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiH3UH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiH3UHX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 16:07:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAFE75484
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 13:07:19 -0700 (PDT)
Received: (qmail 7593 invoked by uid 109); 30 Aug 2022 20:07:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Aug 2022 20:07:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29066 invoked by uid 111); 30 Aug 2022 20:07:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Aug 2022 16:07:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Aug 2022 16:07:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] format-patch: allow forcing the use of in-body
 From: header
Message-ID: <Yw5t9mfaIi647Qbl@coredump.intra.peff.net>
References: <20220826213203.3258022-1-gitster@pobox.com>
 <20220829213837.13849-1-gitster@pobox.com>
 <20220829213837.13849-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829213837.13849-3-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2022 at 02:38:36PM -0700, Junio C Hamano wrote:

> +--[no-]force-in-body-from::
> +	With the e-mail sender specified via the `--from` option, by
> +	default, an in-body "From:" to identify the real author of
> +	the commit is added at the top of the commit log message if
> +	the sender is different from the author.  With this option,
> +	the in-body "From:" is added even when the sender and the
> +	author have the same name and address, which may help if the
> +	mailing list software mangles the sender's identity.

I find it a little curious that this option can only be used with
"--from". That makes sense in a way, because this is a special case of
that feature, overriding the "are they the same" check.

But given that the use case is not to send somebody else's patch, but to
duplicate your _own_ ident in both spots, it feels funny that you must
also say "by the way, I am the sender of the email". I.e., you have to
say:

  git format-patch --from='Me <me@example.com>' --force-in-body-from

I guess it is not too bad because just "--from" will do the equivalent
thing (picking "me" from your committer ident). It just feels kind of
clunky that:

  git format-patch --force-in-body-from

will silently ignore the option.

All that said, I don't care _too_ strongly about it. I do suspect the
feature might be better placed in send-email (or possibly in addition).
If you are using send-email, then I think you're not supposed to use
"--from" with format-patch at all, and you have no way of accessing this
feature.

-Peff
