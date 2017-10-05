Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A282036B
	for <e@80x24.org>; Thu,  5 Oct 2017 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbdJEL1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 07:27:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:33552 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751744AbdJEL1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 07:27:00 -0400
Received: (qmail 20621 invoked by uid 109); 5 Oct 2017 11:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 11:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27449 invoked by uid 111); 5 Oct 2017 11:27:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 07:27:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 07:26:58 -0400
Date:   Thu, 5 Oct 2017 07:26:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing
 files
Message-ID: <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net>
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
 <20171005104407.65948-2-lars.schneider@autodesk.com>
 <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 08:19:13PM +0900, Junio C Hamano wrote:

> > diff --git a/entry.c b/entry.c
> > index 1c7e3c11d5..5dab656364 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -304,7 +304,7 @@ static int write_entry(struct cache_entry *ce,
> >  					ce->name, new, size, &buf, dco);
> >  				if (ret && string_list_has_string(&dco->paths, ce->name)) {
> >  					free(new);
> > -					goto finish;
> > +					goto delayed;
> >  				}
> >  			} else
> >  				ret = convert_to_working_tree(
> 
> This is unrelated to the main topic of this patch, but we see this
> just before the precontext of this hunk:
> 
> 			if (dco && dco->state != CE_NO_DELAY) {
> 				/* Do not send the blob in case of a retry. */
> 				if (dco->state == CE_RETRY) {
> 					new = NULL;
> 					size = 0;
> 				}
> 				ret = async_convert_to_working_tree(
> 					ce->name, new, size, &buf, dco);
> 
> Aren't we leaking "new" in that CE_RETRY case?

Yes, it certainly looks like it. Wouldn't we want to avoid reading the
file from disk entirely in that case?

I.e., I think free(new) is sufficient to fix the leak you mentioned. But
I think we'd want to protect the read_blob_entry() call at the top of
the case with a check for dco->state == CE_RETRY.

-Peff
