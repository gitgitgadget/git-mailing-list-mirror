Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2465C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB25208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGaUyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:54:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:44372 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgGaUyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:54:35 -0400
Received: (qmail 24710 invoked by uid 109); 31 Jul 2020 20:54:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 20:54:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31735 invoked by uid 111); 31 Jul 2020 20:54:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 16:54:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 16:54:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 2/4] upload-pack.c: allow banning certain object
 filter(s)
Message-ID: <20200731205434.GB1440890@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <a0a04277578333daa0b38a8e06e1738b920f5ac3.1596227003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a04277578333daa0b38a8e06e1738b920f5ac3.1596227003.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 04:26:31PM -0400, Taylor Blau wrote:

> Git clients may ask the server for a partial set of objects, where the
> set of objects being requested is refined by one or more object filters.
> Server administrators can configure 'git upload-pack' to allow or ban
> these filters by setting the 'uploadpack.allowFilter' variable to
> 'true' or 'false', respectively.
> 
> However, administrators using bitmaps may wish to allow certain kinds of
> object filters, but ban others. Specifically, they may wish to allow
> object filters that can be optimized by the use of bitmaps, while
> rejecting other object filters which aren't and represent a perceived
> performance degradation (as well as an increased load factor on the
> server).
> 
> Allow configuring 'git upload-pack' to support object filters on a
> case-by-case basis by introducing two new configuration variables:
> 
>   - 'uploadpackfilter.allow'
>   - 'uploadpackfilter.<kind>.allow'
> 
> where '<kind>' may be one of 'blobNone', 'blobLimit', 'tree', and so on.

Minor nit, but <kind> is "blob:none", "blob:limit", etc. The code and
documentation gets this right; it's just the commit message.

I'm pretty sure this is a casualty of updating the syntax as the series
was developed. One trick I use is to avoid repeating explanations that
are in the documentation from the patch already. I.e., explain "why"
here, but it's OK to let "what" come from the patch itself. That's not
only one less thing to remember to update, but it's less for reviewers
to read through, too.

</meta-patch-advice>

> +test_expect_success 'upload-pack fails banned object filters' '
> +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
> +	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
> +		"file://$(pwd)/srv.bare" pc3 2>err &&
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
> +'

These messages aren't translated now, so we can just use grep, I think.

Ditto in the other tests below.

> +static void die_if_using_banned_filter(struct upload_pack_data *data)
> +{
> +	struct list_objects_filter_options *banned = banned_filter(data,
> +								   &data->filter_options);
> +	struct strbuf buf = STRBUF_INIT;
> +	if (!banned)
> +		return;
> +
> +	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
> +		    list_object_filter_config_name(banned->choice));
> +
> +	packet_writer_error(&data->writer, "%s\n", buf.buf);
> +	die("%s", buf.buf);
> +}

Hmm, the strbuf was unexpected. I'd have just written it out twice.
After all, the messages don't have to be the same. And perhaps we don't
want them to be the same? A user receiving the ERR packet would see:

  remote error: git upload-pack: filter 'foo' not supported

do we need the "git upload-pack" part there? Other errors say just
"upload-pack". IMHO even that is unnecessarily verbose, and I wouldn't
mind a separate patch to reduce it. But definitely going even longer
doesn't seem like the right direction. :)

I also wondered about the trailing newline. Other callers of
packet_writer_error() don't seem to use it. I think in practice it
doesn't matter much because readers will generally be using
CHOMP_NEWLINE, but it probably makes sense to be consistent.

> [...]

Aside from this nits, this patch looks good to me.

-Peff
