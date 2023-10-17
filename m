Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201F4439
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9206792
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 17:00:20 -0700 (PDT)
Received: (qmail 3686 invoked by uid 109); 17 Oct 2023 00:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Oct 2023 00:00:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17927 invoked by uid 111); 17 Oct 2023 00:00:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Oct 2023 20:00:22 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Oct 2023 20:00:19 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Jason Hatton <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Message-ID: <20231017000019.GB551672@coredump.intra.peff.net>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
 <20231012160930.330618-3-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012160930.330618-3-sandals@crustytoothpaste.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:09:30PM +0000, brian m. carlson wrote:

> +static unsigned int munge_st_size(off_t st_size) {
> +	unsigned int sd_size = st_size;
> +
> +	/*
> +	 * If the file is an exact multiple of 4 GiB, modify the value so it
> +	 * doesn't get marked as racily clean (zero).
> +	 */
> +	if (!sd_size && st_size)
> +		return 0x80000000;
> +	else
> +		return sd_size;
> +}

Coverity complained that the "true" side of this conditional is
unreachable, since sd_size is assigned from st_size, so the two values
cannot be both true and false. But obviously we are depending here on
the truncation of off_t to "unsigned int". I'm not sure if Coverity is
just dumb, or if it somehow has a different size for off_t.

I don't _think_ this would ever cause confusion in a real compiler, as
assignment from a larger type to a smaller has well-defined truncation,
as far as I know.

But I do wonder if an explicit "& 0xFFFFFFFF" would make it more obvious
what is happening (which would also do the right thing if in some
hypothetical platform "unsigned int" ended up larger than 32 bits).

-Peff
