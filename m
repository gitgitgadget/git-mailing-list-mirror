Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D052C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAC26108B
	for <git@archiver.kernel.org>; Thu, 20 May 2021 13:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhETNOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 09:14:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:60384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237915AbhETNOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 09:14:35 -0400
Received: (qmail 27364 invoked by uid 109); 20 May 2021 13:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 May 2021 13:13:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31392 invoked by uid 111); 20 May 2021 13:13:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 May 2021 09:13:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 May 2021 09:13:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] trace2: refactor to avoid gcc warning under -O3
Message-ID: <YKZgZZrZdKyUk9d9@coredump.intra.peff.net>
References: <xmqqim3ew905.fsf@gitster.g>
 <patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-2e41e3e4cb-20210520T110357Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 01:05:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> I also wondered briefly why we needed the out-parameter at all, and not
> >> just letting the caller look at errno. The answer is that we need to
> >> preserve it across the close() call. The more usual thing in our code
> >> base would be to use saved_errno, but not have it as an out-parameter.
> >> [...]
> > I think this alternative is more readable as well.
> >
> > I'll mark the topic to be "Expecting a reroll" in the what's cooking
> > report.
> >
> > Thanks.
> 
> Here's that re-roll, thanks both.

Thanks, this looks OK to me. There is one minor nit (introduced by me!)
below, but I'm not sure if we should care or not.

> The patch is entirely Jeff's at this point (from
> <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>), with my amended commit
> message. So I added his SOB per his recent-ish ML "every patch of mine
> can be assumed to have my SOB" message.

So I have definitely said that, and I stand by it. But as a matter of
project policy, I think we probably shouldn't consider that "enough".
The point of the DSO is to make an affirmative statement about a
particular patch. So probably my blanket statement should be taken more
as "I will almost definitely add my signoff if you ask me". :)

And of course in the case of this particular patch, it is very much:

  Signed-off-by: Jeff King <peff@peff.net>

> @@ -271,15 +271,13 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>  	}
>  
>  	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
> -		e = tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd))
>  			goto connected;
> -		if (e != EPROTOTYPE)
> +		if (errno != EPROTOTYPE)
>  			goto error;
>  	}
>  	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
> -		e = tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd))
>  			goto connected;
>  	}
>  
> @@ -287,7 +285,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_dst *dst,
>  	if (tr2_dst_want_warning())
>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
>  			path, tr2_sysenv_display_name(dst->sysenv_var),
> -			strerror(e));
> +			strerror(errno));

We expect the value of errno to persist across tr2_dst_want_warning()
and tr2_sysenv_display_name() here. The former may call getenv() and
atoi(). I think that's probably fine, but if we wanted to be really
paranoid, we'd have to preserve errno manually here, too.

-Peff
