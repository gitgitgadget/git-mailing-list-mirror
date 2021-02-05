Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAA8C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20FC64EE4
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBEWQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:16:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:51710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhBEOdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:33:02 -0500
Received: (qmail 18677 invoked by uid 109); 5 Feb 2021 16:10:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 16:10:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24214 invoked by uid 111); 5 Feb 2021 16:10:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 11:10:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 11:10:32 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v7 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <YB1t+FFN+DUVl3G6@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1612493309.git.jonathantanmy@google.com>
 <2d3507536924346637bb138af5a3562ce8f2abc2.1612493309.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d3507536924346637bb138af5a3562ce8f2abc2.1612493309.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 08:58:31PM -0800, Jonathan Tan wrote:

> diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.txt
> new file mode 100644
> index 0000000000..e003856c08
> --- /dev/null
> +++ b/Documentation/config/lsrefs.txt
> @@ -0,0 +1,9 @@
> +lsrefs.unborn::
> +	May be "advertise" (the default), "allow", or "ignore". If "advertise",
> +	the server will respond to the client sending "unborn" (as described in
> +	protocol-v2.txt) and will advertise support for this feature during the
> +	protocol v2 capability advertisement. "allow" is the same as
> +	"advertise" except that the server will not advertise support for this
> +	feature; this is useful for load-balanced servers that cannot be
> +	updated automatically (for example), since the administrator could
> +	configure "allow", then after a delay, configure "advertise".

Minor nit, but did you mean "updated atomically" in the second-to-last
line?

> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 85daeb5d9e..f772d90eaf 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -192,11 +192,20 @@ ls-refs takes in the following arguments:
>  	When specified, only references having a prefix matching one of
>  	the provided prefixes are displayed.
>  
> +If the 'unborn' feature is advertised the following argument can be
> +included in the client's request.
> +
> +    unborn
> +	The server will send information about HEAD even if it is a symref
> +	pointing to an unborn branch in the form "unborn HEAD
> +	symref-target:<target>".

I saw there was some discussion back-and-forth on the wording here.
Reading this, I'm left with the impression that an implementation would
be wrong (i.e., violating the protocol) to send a non-HEAD symref with
the unborn value.

I'd have thought we would describe the protocol in the most liberal
fashion, so that clients would be made ready to handle any future
improvements on the server side.

That kind of sounds like the opposite of what Junio said in [1]. And I'm
not sure it's worth re-opening if it's going to derail or delay this
otherwise useful feature. So I offer it as my 2 cents, but not a real
objection to moving forward.

[1] https://lore.kernel.org/git/xmqq1rdyf71k.fsf@gitster.c.googlers.com/

> diff --git a/ls-refs.c b/ls-refs.c
> index a1e0b473e4..e08fd43e7a 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -7,6 +7,39 @@
>  #include "pkt-line.h"
>  #include "config.h"
>  
> +static int config_read;
> +static int advertise_unborn;
> +static int allow_unborn;

OK, we're back to the three-way config. I'm happy with it, as the
default is now "advertise+accept". :)

> +static void ensure_config_read(void)
> +{
> +	char *str = NULL;
> +
> +	if (config_read)
> +		return;
> +
> +	if (repo_config_get_string(the_repository, "lsrefs.unborn", &str)) {

This function leaks "str". I think you can use repo_config_get_string_tmp()
to avoid the allocation entirely.

(I think the initialization to NULL is also unnecessary, but I don't
mind it).

The rest of the patch looks good to me.

-Peff
