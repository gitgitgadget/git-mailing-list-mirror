Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48758383
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718149; cv=none; b=KgdUXgx2iVv1Est+urc8NyxW1ZlJnqolUypLq2fXJMMNgWE2VXKS6J/gDpch0qxKmscQla6qLzR1Lv1qjOuVP6I/+oDr/pr+2GkdPJTT7g1rIdnBHzoWpxOOoMVBzgdvKJldVi7ydKnf+SGEWYy3nJZF+IJB9wTzVGA0O6ZjkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718149; c=relaxed/simple;
	bh=2XwOJDeVyEraZhaUVtzojKoPOTqLlvj3PBdCDubgfH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzeyVZsnldC2UcMXN7DZBP5nDUgS906GMnIEmavQ5c+4guQdSEi0nWGWpan08bzoGHJq5L34gFXTPscHsGeZwm4wDa+a0oGwgxSnlQaQOZFhZ5uCl4AtLy0IdSat42ZS0jmESSvJSzn0IgYfSgmUBo7rdVU7ghrXfZr9biNlbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JV19J/rM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JV19J/rM"
Received: (qmail 9179 invoked by uid 109); 17 Jul 2025 02:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2XwOJDeVyEraZhaUVtzojKoPOTqLlvj3PBdCDubgfH4=; b=JV19J/rML4KP61b3j+gtfgl/n0Dl6dOS5w8R7C94cvkDYEgq+cDC69kfd6wErmDA9pD2lqpJDpXUviUF7jul3fOsTKYR/loDrBZ4et9RpHNDVkpLZb1i1jtC9NBrIvZ8woU7n4QcakMK/bPZ1Q7KxwLoYHSln5C1hgOEcCwEEY8AWsvoQONMw3rYp/CrF3NVQn2BNReDJLIxIjzG8fdPkZn860sm1IdADhkSv05tSnqIqsVd3JSsrCUsVA/RFHJFvllG8RNx1R3u9ATGmrE21loaB12ngOHg2SyAWxl/IYSKbEEUoIFKPAYSJyUcV2PzZLRpstLSNEr4qMaJahlo3Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Jul 2025 02:09:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28700 invoked by uid 111); 17 Jul 2025 02:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 22:09:08 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 22:09:05 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/5] refs: selectively set prefix in the seek functions
Message-ID: <20250717020905.GA2193264@coredump.intra.peff.net>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-3-852d5a2f56e1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-3-852d5a2f56e1@gmail.com>

On Tue, Jul 15, 2025 at 01:28:28PM +0200, Karthik Nayak wrote:

> +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				   const char *refname, unsigned int flags)
> [...]
> +		do {
> +			int len, idx;
> +			int cmp = 0;
> +
> +			sort_ref_dir(dir);
> +
> +			slash = strchr(slash, '/');
> +			len = slash ? slash - refname : (int)strlen(refname);

I was looking at this code due to a nearby thread and noticed this funny
cast to int. I guess you added it to silence -Wsign-compare, but Why are
we not using a size_t in the first place?

This kind of conversion can sometimes have security implications because
a very large "refname" would cause "len" to become negative (i.e., if
it's between 2GB and 4GB).

In this particular case it ends up cast back to a size_t via strncmp:

> +			for (idx = 0; idx < dir->nr; idx++) {
> +				cmp = strncmp(refname, dir->entries[idx]->name, len);
> +				if (cmp <= 0)
> +					break;
> +			}

so we get the original value back. We'd still get truncation for a
refname value over 4GB, which would presumably give us a slightly wrong
answer. But I don't think we'd ever look outside the array.

Such sizes are probably unlikely if we are feeding filesystem paths. But
we probably should not set a bad example, and just do;

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..3949d145e8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 		 * indexing to each level as needed.
 		 */
 		do {
-			int len, idx;
+			size_t len;
+			int idx;
 			int cmp = 0;
 
 			sort_ref_dir(dir);
 
 			slash = strchr(slash, '/');
-			len = slash ? slash - refname : (int)strlen(refname);
+			len = slash ? slash - refname : strlen(refname);
 
 			for (idx = 0; idx < dir->nr; idx++) {
 				cmp = strncmp(refname, dir->entries[idx]->name, len);

-Peff
