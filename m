Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD99C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43998613A9
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhFXUM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 16:12:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:60076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhFXUMr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 16:12:47 -0400
Received: (qmail 13512 invoked by uid 109); 24 Jun 2021 20:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 20:10:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16238 invoked by uid 111); 24 Jun 2021 20:10:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 16:10:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 16:10:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 4/4] midx: report checksum mismatches during 'verify'
Message-ID: <YNTmsoOKMsaC+cYV@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 02:39:15PM -0400, Taylor Blau wrote:

> 'git multi-pack-index verify' inspects the data in an existing MIDX for
> correctness by checking that the recorded object offsets are correct,
> and so on.
> 
> But it does not check that the file's trailing checksum matches the data
> that it records. So, if an on-disk corruption happened to occur in the
> final few bytes (and all other data was recorded correctly), we would:
> 
>   - get a clean result from 'git multi-pack-index verify', but
>   - be unable to reuse the existing MIDX when writing a new one (since
>     we now check for checksum mismatches before reusing a MIDX)
> 
> Teach the 'verify' sub-command to recognize corruption in the checksum
> by calling midx_checksum_valid().

Makes sense. I was a little surprised we didn't do this already, but I
guess it does not do the same "regenerate and make sure hashfile
produces the same checksum" trick that the pack idx verifier does (as an
aside, I think what the midx code is doing here is much _better_,
because it is looking at semantic problems in the file, and is more
robust against irrelevant changes in the format).

> @@ -1228,6 +1228,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>  		return result;
>  	}
>  
> +	if (!midx_checksum_valid(m))
> +		midx_report(_("incorrect checksum"));

This "midx_report()" function doesn't provide much context on stderr. I
get:

  $ echo foo >>.git/objects/pack/multi-pack-index
  $ git multi-pack-index verify
  incorrect checksum
  Verifying OID order in multi-pack-index: 100% (282/282), done.
  Sorting objects by packfile: 100% (283/283), done.
  Verifying object offsets: 100% (283/283), done.

I think we should at least say "error:", but something along the lines
of "midx file at %s does not match its trailing checksum (possibly
corruption?)". Or something like that.

I think all of the existing calls to midx_report() share this issue,
though. We probably want to at least say "error:" here, but maybe even
something like:

diff --git a/midx.c b/midx.c
index 9a35b0255d..e464907a7c 100644
--- a/midx.c
+++ b/midx.c
@@ -1172,10 +1172,12 @@ void clear_midx_file(struct repository *r)
 
 static int verify_midx_error;
 
-static void midx_report(const char *fmt, ...)
+static void midx_report(struct multi_pack_index *m, const char *fmt, ...)
 {
 	va_list ap;
 	verify_midx_error = 1;
+	/* do we need to care about the "next" pointer here? */
+	fprintf(stderr, ("error: %s/multi-pack-index: "), m->object_dir);
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
 	fprintf(stderr, "\n");

Also, a side note: we should use __attribute__((format)) on this
function to get compile-time checks of our format strings.

-Peff
