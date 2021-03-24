Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAC4C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA95461A19
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbhCXTM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:12:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:47814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237748AbhCXTMt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:12:49 -0400
Received: (qmail 14454 invoked by uid 109); 24 Mar 2021 19:12:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 19:12:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20938 invoked by uid 111); 24 Mar 2021 19:12:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 15:12:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 15:12:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Message-ID: <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 02:48:47AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Refactor the userdiff_find_by_namelen() function so that a new
> for_each_userdiff_driver() API function does most of the work.
> 
> This will be useful for the same reason we've got other for_each_*()
> API functions as part of various APIs, and will be used in a follow-up
> commit.

The refactorings up to here all made sense, but TBH this one makes the
code more confusing to follow to me.

Perhaps part of it is just that the diff is messy, but I had to read it
several times to understand what's going on. Here's what I think were
the tricky parts:

> -static struct userdiff_driver *userdiff_find_by_namelen(const char *k, size_t len)
> +struct for_each_userdiff_driver_cb {
> +	const char *k;
> +	size_t len;
> +	struct userdiff_driver *driver;
> +};

Our callback function does _one_ type of selection (based on a "type"
parameter), but not another (based on the name). That feels
inconsistent, but is also the reason we have this awkward struct.  Part
of my confusion is the name: this is not something to be generically
used with for_each_userdiff_driver(), but rather a type unique to
find_by_namelen() to be passed through the opaque void pointer.

So "struct find_by_namelen_data" would have been a lot more
enlightening.

The fact that callbacks are awkward in general in C might not be
solvable, at least not without duplicating some iteration code.

> +static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
> +				       enum userdiff_driver_type type, void *priv)
>  {
> [...]
> +	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
> +	    !driver->name[cb_data->len]) {
> +		cb_data->driver = driver;
> +		return -1; /* found it! */
>  	}

This "return -1" took me a while to grok, and the comment didn't help
all that much. The point is to stop traversing the list, but "-1" to me
signals error. I think returning "1" might be a bit more idiomatic, but
also a comment that says "tell the caller to stop iterating" would have
been more clear.

> +int for_each_userdiff_driver(each_userdiff_driver_fn fn,
> +			     enum userdiff_driver_type type, void *cb_data)
> +{
> +	int i, ret;
> +	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_CUSTOM)) {
> +
> +		for (i = 0; i < ndrivers; i++) {
> +			struct userdiff_driver *drv = drivers + i;
> +			ret = fn(drv, USERDIFF_DRIVER_TYPE_CUSTOM, cb_data);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_BUILTIN)) {
> +
> +		for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
> +			struct userdiff_driver *drv = builtin_drivers + i;
> +			ret = fn(drv, USERDIFF_DRIVER_TYPE_BUILTIN, cb_data);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
> +}

I spent a while scratching my head at these types, and what they would
be used for, since this caller doesn't introduce any. Looking at patch 7
helped, though it's unclear to me why we need to distinguish between
custom and builtin drivers there. As you note there, nobody calls
list-custom-drivers nor list-drivers. And if we haven't configured
anything, then wouldn't list-drivers be the same as list-builtin-drivers?
Or for the purposes of that test, if we _did_ configure something,

  As an aside, it feels like this is something we ought to be able to
  ask git-config about, rather than having a test-helper. This is
  basically "baked-in" config, and if we represented it as such, and
  parsed it into a struct just like regular config, then probably "git
  config --list --source" could be used to find it (and differentiate it
  from user-provided config). Possible downsides:

    1. Would people find it confusing that "git config --list" suddenly
       gets way bigger? Maybe we'd want an "--include-baked-in" option
       or something.

    2. Is the cost of parsing the config measurably bad? Obviously a
       user could provide the same content and we'd have to parse it,
       but there's a lot more rules here than most users would probably
       provide.

> +enum userdiff_driver_type {
> +	USERDIFF_DRIVER_TYPE_UNSPECIFIED = 1<<0,
> +	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<1,
> +	USERDIFF_DRIVER_TYPE_CUSTOM = 1<<2,
> +};

I was confused by these being bits, because some of them seem mutually
exclusive (e.g., UNSPECIFIED and anything else).

Perhaps it would make more sense as:

  USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
  USERDIFF_DRIVER_TYPE_CUSTOM = 1<<0,
  USERDIFF_DRIVER_TYPE_ALL = USERDIFF_DRIVER_TYPE_BUILTIN | USERDIFF_DRIVER_TYPE_CUSTOM

Or the one caller who wants "ALL" could even do the OR themselves.

I do kind of wonder if there's much value in having a single function
with a type field at all, though, given that there's no overlap in the
implementation. Would separate "for_each_custom" and "for_each_builtin"
functions make sense? And then the existing caller would just call them
sequentially.

I dunno. I know a lot of this is nit-picking, and I don't think there's
anything incorrect in this patch. I just found it surprisingly hard to
read for something that purports to be refactoring / cleaning the code.

-Peff
