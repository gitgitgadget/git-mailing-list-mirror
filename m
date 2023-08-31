Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE8C83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 17:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346854AbjHaRE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345932AbjHaRE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 13:04:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E8A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 10:04:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BFBF1DE48;
        Thu, 31 Aug 2023 13:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=032VbQaHrS4Z9MD1fV2SF2nBUzzJxaDpfTgr47
        w8sQQ=; b=Eb91kS9QICAt7Bw6p8n1YTDg88Lv/FFOC6JL8rz7VV//t0ORgdiK0U
        O0KMTTZOgySdXkpC0SpZWLzUttWPdpD2C5GmWMYLqqCEoVZPKbMJhywFpNk+N0DF
        3YE8M/7VlUWk0jpE4r6Y1LsoTYIzp0gxfdcZnoWJuWrtmSmESZCug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53F871DE47;
        Thu, 31 Aug 2023 13:04:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBE5F1DE46;
        Thu, 31 Aug 2023 13:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 7/8] interpret-trailers: mark unused "unset" parameters
 in option callbacks
In-Reply-To: <20230831071945.GE3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:19:45 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071945.GE3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 10:04:09 -0700
Message-ID: <xmqq4jkfxhx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67A129D4-4820-11EE-AEFF-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are a few parse-option callbacks that do not look at their "unset"
> parameters, but also do not set PARSE_OPT_NONEG. At first glance this
> seems like a bug, as we'd ignore "--no-if-exists", etc.
>
> But they do work fine, because when "unset" is true, then "arg" is NULL.
> And all three functions pass "arg" on to helper functions which do the
> right thing with the NULL.

Yuck.  That is ugly.

> Note that this shortcut would not be correct if any callback used
> PARSE_OPT_NOARG (in which case "arg" would be NULL but "unset" would be
> false). But none of these do.

That is even uglier.  Unlike the BUG_ON_OPT_NEG() and BUG_ON_OPT_ARG()
that catch discrepancies between options[] flags and the expectation
by the callback function, there is no way for us to protect against
such mistakes?

> So the code is fine as-is. But we'll want to mark the unused "unset"
> parameters to quiet -Wunused-parameter.

OK.  Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/interpret-trailers.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 6aadce6a1e..a5f9adf6b9 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -24,19 +24,19 @@ static enum trailer_if_exists if_exists;
>  static enum trailer_if_missing if_missing;
>  
>  static int option_parse_where(const struct option *opt,
> -			      const char *arg, int unset)
> +			      const char *arg, int unset UNUSED)
>  {
>  	return trailer_set_where(opt->value, arg);
>  }
>  
>  static int option_parse_if_exists(const struct option *opt,
> -				  const char *arg, int unset)
> +				  const char *arg, int unset UNUSED)
>  {
>  	return trailer_set_if_exists(opt->value, arg);
>  }
>  
>  static int option_parse_if_missing(const struct option *opt,
> -				   const char *arg, int unset)
> +				   const char *arg, int unset UNUSED)
>  {
>  	return trailer_set_if_missing(opt->value, arg);
>  }
