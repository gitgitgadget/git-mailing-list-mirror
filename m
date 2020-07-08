Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3941BC433DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F6C221EE
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 08:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgGHIpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:45:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGHIpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 04:45:44 -0400
Received: (qmail 27951 invoked by uid 109); 8 Jul 2020 08:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 08:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7315 invoked by uid 111); 8 Jul 2020 08:45:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 04:45:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 04:45:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200708084527.GB2324177@coredump.intra.peff.net>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:

> +static void parse_object_filter_config(const char *var, const char *value,
> +				       struct upload_pack_data *data)
> +{
> +	struct strbuf spec = STRBUF_INIT;
> +	const char *sub, *key;
> +	size_t sub_len;
> +
> +	if (parse_config_key(var, "uploadpack", &sub, &sub_len, &key))
> +		return;
> +	if (!sub || !skip_prefix(sub, "filter.", &sub))
> +		return;

Just while I'm thinking about the config name and case-sensitivity (from
the cover letter): if we did want to use this scheme, then
skip_iprefix() would make this behave more like a regular part of the
section name.

But I'd prefer to just do away with it by using a scheme that doesn't
have the extra layer of dots.

> +	if (sub != key)
> +		strbuf_add(&spec, sub, key - sub - 1);
> +	strbuf_tolower(&spec);

On the flip side, I'd actually consider _not_ matching the filter name
case-insensitively. We don't do so elsewhere (e.g., "git rev-list
--filter=BLOB:NONE" will complain).

-Peff
