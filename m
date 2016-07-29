Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4531C1F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbcG2A3H (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:29:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:50700 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752172AbcG2A3G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:29:06 -0400
Received: (qmail 12933 invoked by uid 102); 29 Jul 2016 00:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:29:06 -0400
Received: (qmail 29969 invoked by uid 107); 29 Jul 2016 00:29:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:29:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 20:29:03 -0400
Date:	Thu, 28 Jul 2016 20:29:03 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
Message-ID: <20160729002902.GD9646@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 04:47:17PM -0700, Junio C Hamano wrote:

> Also makes me wonder if "git cherry-pick A..B" shares the same
> breakage.

Probably.

I guess we want something like:

diff --git a/ident.c b/ident.c
index 139c528..e20a772 100644
--- a/ident.c
+++ b/ident.c
@@ -184,6 +184,11 @@ static const char *ident_default_date(void)
 	return git_default_date.buf;
 }
 
+void reset_ident_date(void)
+{
+	strbuf_reset(&git_default_date);
+}
+
 static int crud(unsigned char c)
 {
 	return  c <= 32  ||

and then to sprinkle calls liberally through builtin-ified programs when
they move from one unit of work to the next.

We could also support resetting the whole ident string, but I don't
think there's any reason to (and unlike the datestamp, it has to do a
bit more looking around to come up with its values).

-Peff
