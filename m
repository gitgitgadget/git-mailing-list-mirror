Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194142EEAD
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981491; cv=none; b=CZFfxGEAsbTaUyvmWnUM23tcKS793KKZrGRGvcdR2UR7qGOnIiBRg5EZwyHFpaz0K7fSa3TAXaiAot59g1GQgYiHOHgPmCso6BxFiD9o48TohvLdNroGo3460Nx2eAwn5+PzgPJOhWTQIph4QgGLRIoQKcq6oUtYRC8TViI481k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981491; c=relaxed/simple;
	bh=jzT/u1IjiLbwrM9v84chtV50uQZ5l1R8dxAxVgJwHuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AseVSuqizp661u+fdATNpNzwEec/HQiVdtzZuiYnzwqyALvqzB6Do7TAiwnsnfnJamBjEgVruzKfd9RZkn/5dvY9paqydFZvXKJ7NOrEZW6pZGQoG5yz7ApIeL+xH9aCliw/fi2sz0bnqv29/7Asujhht5snq1xjlVuGtKUdmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bt38edyc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bt38edyc"
Received: (qmail 85893 invoked by uid 106); 2 Jul 2026 08:38:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jzT/u1IjiLbwrM9v84chtV50uQZ5l1R8dxAxVgJwHuw=; b=bt38edyckclFx+UUcZxBLVMeHMv5lwMEU9eBB8gE8LnKOVqaRSzeCBc0CDpp5X4HgiNNfqsHz6LmfaZEi8iRPSlSV5yRPEkMGPylrUCJEaHd6VbJjrd4T6qe65x11szlbyavpfVO/WQZFFVKS+EZiP5hSvGsB7RWSIFcYZj4qn73YEdp8i/vfonRBJw718llJuUQdpmHObfU3EPQbBWpNdid/I80in3gCTX0vh3FyZA/DXEKs7CK32twAk0jh8YMXIaDgGzU4b4N3PQV4pr2bEIFtfnEroCdmTdTdst8XJgROqQgZ7xVaNQ4l4qWFjVzvut/7rLyoxJ2KVBniwTw0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178613 invoked by uid 111); 2 Jul 2026 08:38:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:38:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:38:06 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] parse-options: add a separate case for help
 output on error
Message-ID: <20260702083806.GA481298@coredump.intra.peff.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-3-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701212442.1430084-3-sandals@crustytoothpaste.net>

On Wed, Jul 01, 2026 at 09:24:40PM +0000, brian m. carlson wrote:

> However, there are some cases where we print help output because the
> user has provided ambiguous or invalid input, such as an ambiguous
> option, and we'll want to exit unsuccessfully there.  Make this easier
> by defining a new return code, PARSE_OPT_HELP_ERROR, that can be used in
> this case, while reserving PARSE_OPT_HELP for those cases where the user
> has requested help directly.

Makes sense. We'd want to audit every spot that generates PARSE_OPT_HELP
and see if it should be PARSE_OPT_HELP_ERROR. I only see one spot
touched here:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -583,7 +583,7 @@ static enum parse_opt_result parse_long_opt(
>  			ambiguous.option->long_name,
>  			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
>  			abbrev.option->long_name);
> -		return PARSE_OPT_HELP;
> +		return PARSE_OPT_HELP_ERROR;
>  	}

That one makes sense. The other site that generates it is within
usage_with_options_internal(), which handles both asked-for "-h" and
unexpected errors, but still always returns PARSE_OPT_HELP.

Ah...it looks like you _do_ switch it in patch 4 (when the distinction
between the two starts to make a difference). I think it should be done
in this patch, though, since the point is generating the correct
HELP/HELP_ERROR here (even though it does not yet matter).

I wonder if we'd also want:

diff --git a/parse-options.c b/parse-options.c
index 742444eead..08c21d9fc0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1373,7 +1373,7 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 	parse_options_check_harder(opts);
 
 	if (!usagestr)
-		return PARSE_OPT_HELP;
+		return err ? PARSE_OPT_HELP_ERROR : PARSE_OPT_HELP;
 
 	if (!err && ctx && ctx->flags & PARSE_OPT_SHELL_EVAL)
 		fprintf(outfile, "cat <<\\EOF\n");

I can't figure out when we wouldn't have a usagestr, though. Perhaps not
ever from parse-options itself, but only when called via
usage_with_options() or something? That function does not look at our
return value so it would not matter, but it feels like we should keep
things consistent.

-Peff
