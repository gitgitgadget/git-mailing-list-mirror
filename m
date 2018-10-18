Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F1A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJROcg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:32:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:44388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727378AbeJROcg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:32:36 -0400
Received: (qmail 15061 invoked by uid 109); 18 Oct 2018 06:33:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 06:33:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27433 invoked by uid 111); 18 Oct 2018 06:32:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 02:32:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 02:33:06 -0400
Date:   Thu, 18 Oct 2018 02:33:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] ref-filter: free memory from used_atom
Message-ID: <20181018063306.GA23497@sigill.intra.peff.net>
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
 <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
 <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com>
 <xmqqa7njevu2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7njevu2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 11:35:01AM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:
> 
> These three patches seem to cause t6300 to fail with an attempt to
> free an invalid pointer in "git for-each-ref --format='%(push)'"
> (6300.25)

I dug into this a bit. I think it's actually a misapplication of the
patches on your side. Applying them locally works, but your
ot/ref-filter-plug-leaks branch does not.

The patch below on top of your branch helps. :)

diff --git a/ref-filter.c b/ref-filter.c
index f4ff80eca0..4255de1d75 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1567,7 +1567,6 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 					continue;
 			}
 			free((char *)v->s); /* we will definitely re-init it on the next line */
-			free((char *)v->s);
 			fill_remote_ref_details(atom, refname, branch, &v->s);
 			continue;
 		} else if (starts_with(name, "color:")) {

Presumably it came from the manual comment-style fixup.

With that fix, the tests run fine for me under ASan/UBSan (with the
exception of t5310, but that's fixed already in a parallel topic).

-Peff
