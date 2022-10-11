Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE7C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 02:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJKCjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 22:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKCjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 22:39:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983583F3F
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 19:39:11 -0700 (PDT)
Received: (qmail 30146 invoked by uid 109); 11 Oct 2022 02:39:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 02:39:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16781 invoked by uid 111); 11 Oct 2022 02:39:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 22:39:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 22:39:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Message-ID: <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
 <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
 <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 05:08:42PM +0200, René Scharfe wrote:

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 501245fac9..28ef7ec2a4 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -765,11 +765,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>  		strbuf_trim(&start_head);
>  		if (!no_checkout) {
> -			struct strvec argv = STRVEC_INIT;
> +			const char *argv[] = { "checkout", start_head.buf,
> +					       "--", NULL };
> 
> -			strvec_pushl(&argv, "checkout", start_head.buf,
> -				     "--", NULL);
> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> +			if (run_command_v_opt(argv, RUN_GIT_CMD)) {

This is OK with me, but note that one thing we lose is compiler
protection that we remembered the trailing NULL pointer in the argv
array (whereas strvec_pushl() has an attribute that makes sure the last
argument is a NULL).

Probably not that big a deal in practice. It would be nice if there was
a way to annotate this for the compiler, but I don't think there's any
attribute for "this pointer-to-pointer parameter should have a NULL at
the end".

-Peff
