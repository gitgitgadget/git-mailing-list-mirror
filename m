Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6EC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA64630EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhKPPju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:39:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:60098 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238277AbhKPPjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:39:49 -0500
Received: (qmail 20409 invoked by uid 109); 16 Nov 2021 15:36:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 15:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30067 invoked by uid 111); 16 Nov 2021 15:36:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 10:36:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 10:36:51 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
Message-ID: <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211116033542.3247094-3-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 03:35:42AM +0000, brian m. carlson wrote:

> The current way we generate random file names is by taking the seconds
> and microseconds, plus the PID, and mixing them together, then encoding
> them.  If this fails, we increment the value by 7777, and try again up
> to TMP_MAX times.
> 
> Unfortunately, this is not the best idea from a security perspective.
> If we're writing into TMPDIR, an attacker can guess these values easily
> and prevent us from creating any temporary files at all by creating them
> all first.  POSIX only requires TMP_MAX to be 25, so this is achievable
> in some contexts, even if unlikely to occur in practice.

I think we unconditionally define TMP_MAX as 16384. I don't think that
changes the fundamental issue that somebody could race us and win,
though.

> @@ -485,12 +483,13 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  	 * Replace pattern's XXXXXX characters with randomness.
>  	 * Try TMP_MAX different filenames.
>  	 */
> -	gettimeofday(&tv, NULL);
> -	value = ((uint64_t)tv.tv_usec << 16) ^ tv.tv_sec ^ getpid();
>  	filename_template = &pattern[len - num_x - suffix_len];
>  	for (count = 0; count < TMP_MAX; ++count) {
> -		uint64_t v = value;
>  		int i;
> +		uint64_t v;
> +		if (csprng_bytes(&v, sizeof(v)) < 0)
> +			return -1;

If csprng_bytes() fail, the resulting errno is likely to be confusing.
E.g., if /dev/urandom doesn't exist we'd get ENOENT. But the caller is
likely to say something like:

  error: unable to create temporary file: no such file or directory

which is misleading. It's probably worth doing:

  return error_errno("unable to get random bytes for temporary file");

or similar here. That's verbose on top of the error that the caller will
give, but this is something we don't expect to fail in practice.

I actually wonder if we should simply die() in such a case. That's not
very friendly from a libification stand-point, but we really can't
progress on much without being able to generate random bytes.

-Peff
