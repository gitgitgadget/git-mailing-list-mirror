Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B8D20988
	for <e@80x24.org>; Thu, 20 Oct 2016 06:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbcJTGbX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:31:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:59877 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbcJTGbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:31:23 -0400
Received: (qmail 19465 invoked by uid 109); 20 Oct 2016 06:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:31:22 +0000
Received: (qmail 21185 invoked by uid 111); 20 Oct 2016 06:31:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:31:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:31:20 -0400
Date:   Thu, 20 Oct 2016 02:31:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 6/7] diff: handle sha1 abbreviations outside of repository
Message-ID: <20161020063120.auxwjybljo4hz3p5@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062125.3iqej3bpdoitr3fz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161020062125.3iqej3bpdoitr3fz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 02:21:25AM -0400, Jeff King wrote:

> diff --git a/diff.c b/diff.c
> index 8f0f309..ef11001 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3049,6 +3049,19 @@ static int similarity_index(struct diff_filepair *p)
>  	return p->score * 100 / MAX_SCORE;
>  }
>  
> +static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
> +{
> +	if (startup_info->have_repository)
> +		return find_unique_abbrev(oid->hash, abbrev);
> +	else {
> +		char *hex = oid_to_hex(oid);
> +		if (abbrev < 0 || abbrev > GIT_SHA1_HEXSZ)
> +			die("BUG: oid abbreviation out of range: %d", abbrev);
> +		hex[abbrev] = '\0';
> +		return hex;
> +	}
> +}

Note that this function has a semantic (but not textual) conflict with
lt/auto-abbrev in 'next', as it sets DEFAULT_ABBREV to -1.

The resolution is:

diff --git a/diff.c b/diff.c
index cab811e..4c09314 100644
--- a/diff.c
+++ b/diff.c
@@ -3102,7 +3102,9 @@ static const char *diff_abbrev_oid(const struct object_id *oid, int abbrev)
 		return find_unique_abbrev(oid->hash, abbrev);
 	else {
 		char *hex = oid_to_hex(oid);
-		if (abbrev < 0 || abbrev > GIT_SHA1_HEXSZ)
+		if (abbrev < 0)
+			abbrev = FALLBACK_DEFAULT_ABBREV;
+		if (abbrev > GIT_SHA1_HEXSZ)
 			die("BUG: oid abbreviation out of range: %d", abbrev);
 		hex[abbrev] = '\0';
 		return hex;

This logic could be pushed down into the find_unique_abbrev() code
(where it _would_ just cause a textual conflict). I preferred to keep it
up here because other callers could conceivably want to handle the
non-repo case in some different way (e.g., by not abbreviating at all).

-Peff
