Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCD41F45F
	for <e@80x24.org>; Fri, 10 May 2019 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfEJVUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 17:20:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727835AbfEJVUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 17:20:42 -0400
Received: (qmail 1421 invoked by uid 109); 10 May 2019 21:20:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 May 2019 21:20:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15950 invoked by uid 111); 10 May 2019 21:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 May 2019 17:21:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2019 17:20:39 -0400
Date:   Fri, 10 May 2019 17:20:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] archive-tar: mark RECORDSIZE/BLOCKSIZE as unsigned
Message-ID: <20190510212039.GA20767@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <pull.145.v2.git.gitgitgadget@gmail.com>
 <ac2b2488a1b42b3caf8a84594c48eca796748e59.1556321244.git.gitgitgadget@gmail.com>
 <d960966d-a7d4-dc3e-ca0a-70e9e5d1abf3@web.de>
 <nycvar.QRO.7.76.6.1905081334260.44@tvgsbejvaqbjf.bet>
 <20190508230420.GC19990@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905091605070.44@tvgsbejvaqbjf.bet>
 <20190509183855.GA28107@sigill.intra.peff.net>
 <f380b182-633f-f347-ed2e-f90548d7f3c9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f380b182-633f-f347-ed2e-f90548d7f3c9@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 07:18:44PM +0200, René Scharfe wrote:

> Am 09.05.19 um 20:38 schrieb Jeff King:
> > I do dream of a world where we do not have a bunch of implicit
> > conversions (both signedness but also truncation) in our code base, and
> > can compile cleanly with -Wconversion We know that this case is
> > perfectly fine, but I am sure there are many that are not. However, I'm
> > not sure if we'll ever get there, and in the meantime I don't think it's
> > worth worrying too much about individual cases like this.
> 
> Here's a rough take on how to silence that warning for archive-tar.c using
> GCC 8.3.  Some of the changes are worth polishing and submitting.  Some
> are silly.  The one for regexec_buf() is scary; I don't see a clean way of
> dealing with that size_t to int conversion.

This is actually slightly less tedious than I had imagined it to be, but
still pretty bad. I dunno. If somebody wants to tackle it, I do think it
would make the world a better place. But I'm not sure if it is worth the
effort involved.

>  static void write_trailer(void)
>  {
> -	int tail = BLOCKSIZE - offset;
> +	size_t tail = BLOCKSIZE - offset;

These kinds of int/size_t conversions are the ones I think are the most
valuable (because the size_t's are often used to allocate or access
arrays, and truncated or negative values there can cause other security
problems). _Most_ of them are harmless, of course, but it's hard to
separate the important ones from the mundane.

> @@ -414,7 +432,7 @@ static int git_tar_config(const char *var, const char *value, void *cb)
>  			tar_umask = umask(0);
>  			umask(tar_umask);
>  		} else {
> -			tar_umask = git_config_int(var, value);
> +			tar_umask = (mode_t)git_config_ulong(var, value);
>  		}

It's nice that the cast here shuts up the compiler, and I agree it is
not likely to be a problem in this instance. But we'd probably want some
kind of "safe cast" helper. To some degree, if you put 2^64-1 in your
"umask" value you get what you deserve, but it would be nice if we could
detect such nonsense (less for this case, but more for others where we
do cast).

> @@ -1119,7 +1119,22 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  {
>  	assert(nmatch > 0 && pmatch);
>  	pmatch[0].rm_so = 0;
> -	pmatch[0].rm_eo = size;
> +	pmatch[0].rm_eo = (regoff_t)size;
> +	if (pmatch[0].rm_eo != size) {
> +		if (((regoff_t)-1) < 0) {
> +			if (sizeof(regoff_t) == sizeof(int))
> +				pmatch[0].rm_eo = (regoff_t)INT_MAX;
> +			else if (sizeof(regoff_t) == sizeof(long))
> +				pmatch[0].rm_eo = (regoff_t)LONG_MAX;
> +			else
> +				die("unable to determine maximum value of regoff_t");
> +		} else {
> +			pmatch[0].rm_eo = (regoff_t)-1;
> +		}
> +		warning("buffer too big (%"PRIuMAX"), "
> +			"will search only the first %"PRIuMAX" bytes",
> +			(uintmax_t)size, (uintmax_t)pmatch[0].rm_eo);
> +	}
>  	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
>  }

I think a helper could make things less awful here, too. Our xsize_t()
is sort of like this, but of course it dies. But I think it would be
possible to write a macro to let you do:

  if (ASSIGN_CAST(pmatch[0].rm_eo, size))
	warning(...);

This is definitely a rabbit-hole that I've been afraid to go down. :)

-Peff
