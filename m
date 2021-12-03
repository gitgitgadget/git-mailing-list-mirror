Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A971C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 06:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378562AbhLCGZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 01:25:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:42712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbhLCGZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 01:25:24 -0500
Received: (qmail 22077 invoked by uid 109); 3 Dec 2021 06:22:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 06:22:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29321 invoked by uid 111); 3 Dec 2021 06:22:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 01:22:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 01:22:00 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v3 2/8] test-ref-store: parse symbolic flag constants
Message-ID: <Yam3iHj1a48X+psK@coredump.intra.peff.net>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
 <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
 <3cdebd2dbcad2f6d428d88846569d6563249dad8.1638470403.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cdebd2dbcad2f6d428d88846569d6563249dad8.1638470403.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 06:39:56PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> This lets tests use REF_XXXX constants instead of hardcoded integers. The flag
> names should be separated by a ','.

So much nicer. Thank you for cleaning this up.

One small bug:

> +static unsigned int parse_flags(const char *str, struct flag_definition *defs)
> +{
> +	struct string_list masks = STRING_LIST_INIT_DUP;
> +	int i = 0;
> +	unsigned int result = 0;
> +
> +	if (!strcmp(str, "0"))
> +		return 0;
> +
> +	string_list_split(&masks, str, ',', 64);
> +	for (; i < masks.nr; i++) {
> +		const char *name = masks.items[i].string;
> +		struct flag_definition *def = defs;
> +		int found = 0;
> +		while (def->name) {
> +			if (!strcmp(def->name, name)) {
> +				result |= def->mask;
> +				found = 1;
> +				break;
> +			}
> +			def++;
> +		}

We assume defs ends with a NULL entry here...

> +static struct flag_definition empty_flags[] = {
> +	{ NULL, 0 },
> +};

...and this one does so...

> +static struct flag_definition pack_flags[] = {
> +	FLAG_DEF(PACK_REFS_PRUNE),
> +	FLAG_DEF(PACK_REFS_ALL),
> +};

...but this one does not. So passing an unknown flag will result in us
walking off the end of the list.

> +static struct flag_definition transaction_flags[] = {
> +	FLAG_DEF(REF_NO_DEREF),
> +	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
> +	{ NULL, 0 },
> +};

This one is good. We might want to drop the trailing comma on the NULL
entries, to make it more clear that they have to come last.

The other option would be using ARRAY_SIZE() instead of a NULL
terminator, but of course that has to happen in the caller. Which means
either extra work there, or yet another macro. :)

-Peff
