Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0957A2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947682AbcHEVC2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:02:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:55592 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1947672AbcHEVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:02:26 -0400
Received: (qmail 11262 invoked by uid 102); 5 Aug 2016 21:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 17:02:25 -0400
Received: (qmail 30589 invoked by uid 107); 5 Aug 2016 21:02:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 17:02:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 17:02:22 -0400
Date:	Fri, 5 Aug 2016 17:02:22 -0400
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 5/8] status: print per-file porcelain v2 status data
Message-ID: <20160805210222.a2rvlmioim4psbhw@sigill.intra.peff.net>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
 <1470147137-17498-6-git-send-email-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1470147137-17498-6-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 02, 2016 at 10:12:14AM -0400, Jeff Hostetler wrote:

> +static void wt_porcelain_v2_print_unmerged_entry(
> +	struct string_list_item *it,
> +	struct wt_status *s)
> +{
> +	struct wt_status_change_data *d = it->util;
> +	const struct cache_entry *ce;
> +	struct strbuf buf_current = STRBUF_INIT;
> +	const char *path_current = NULL;
> +	int pos, stage, sum;
> +	struct {
> +		int mode;
> +		struct object_id oid;
> +	} stages[3];
> +	char *key;
> [...]
> +	switch (d->stagemask) {
> +	case 1: key = "DD"; break; /* both deleted */
> +	case 2: key = "AU"; break; /* added by us */
> +	case 3: key = "UD"; break; /* deleted by them */
> +	case 4: key = "UA"; break; /* added by them */
> +	case 5: key = "DU"; break; /* deleted by us */
> +	case 6: key = "AA"; break; /* both added */
> +	case 7: key = "UU"; break; /* both modified */
> +	}
> [...]
> +	fprintf(s->fp, "%c %s %s %06o %06o %06o %06o %s %s %s %s%c",
> +			unmerged_prefix, key, submodule_token,

Coverity complains that "key" can be uninitialized here. I think it's
wrong, and just doesn't know that d->stagemask is constrained to 1-7.

But perhaps it is worth adding a:

  default:
	die("BUG: unhandled unmerged status %x", d->stagemask);

to the end of the switch. That would shut up Coverity, and give us a
better indication if our constraint is violated.

-Peff
