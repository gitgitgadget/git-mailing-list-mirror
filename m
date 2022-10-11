Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFDC433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 13:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiJKNW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 09:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJKNWS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 09:22:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FAC23BE3
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 06:21:38 -0700 (PDT)
Received: (qmail 32319 invoked by uid 109); 11 Oct 2022 13:21:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 13:21:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22341 invoked by uid 111); 11 Oct 2022 13:21:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Oct 2022 09:21:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Oct 2022 09:21:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] bisect--helper: plug strvec leak
Message-ID: <Y0Vt4eAfUET1GEIp@coredump.intra.peff.net>
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
 <xmqqy1tunjgp.fsf@gitster.g>
 <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
 <xmqqk05cipq8.fsf@gitster.g>
 <1965b54b-122a-c965-f886-1a7dd6afbfb4@web.de>
 <Y0TXTl0gSBOFQa9B@coredump.intra.peff.net>
 <xmqq35buykz1.fsf@gitster.g>
 <221011.86k056q0l4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221011.86k056q0l4.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2022 at 09:29:01AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > But the code before this patch is safe only for strvec_pushl() call,
> > not run_command_v_opt() call, so we are not losing anything, I would
> > think.
> 
> Yes, and if we suppose a bug like this sneaking in one way or the other:
> 	
> 	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> 	index 28ef7ec2a48..a7f9d43a6f1 100644
> 	--- a/builtin/bisect--helper.c
> 	+++ b/builtin/bisect--helper.c
> 	@@ -766,7 +766,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
> 	                strbuf_trim(&start_head);
> 	                if (!no_checkout) {
> 	                        const char *argv[] = { "checkout", start_head.buf,
> 	-                                              "--", NULL };
> 	+                                              "--" };
> 	 
> 	                        if (run_command_v_opt(argv, RUN_GIT_CMD)) {
> 	                                res = error(_("checking out '%s' failed."
> 
> I don't know a way to statically flag that, but we'll catch it with
> SANITIZE=address:

I'd expect we'd even catch it in a non-sanitizing build, since we'd
likely feed garbage to exec (unless we get lucky and there's a NULL on
the stack). I like catching bugs as early as possible, but I agree this
kind is not likely to get very far (assuming there's test coverage).

-Peff
