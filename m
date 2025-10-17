Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D230F818
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683026; cv=none; b=GsPNA5EDHqpIBfPeF5fbS2ElUigDxFaHymmv0xtsqchE9gJB2s8U9yn0wym7IglaNBsAlIecDmMPluuntI+X16jq47W1IreJwr7Bw4agFA5b7+f8zU5b2Gxp6nHCFWht+7dkvcbz6PVLQtSh+AZHrGtrli2yiihpkgknnd4taE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683026; c=relaxed/simple;
	bh=WYaxTX4rJaU87RiGwGNwaAuYc0jZLtmPx76GqagJ49o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEQp/s2SNKaMAt8QBifpzmOaXdbuY29uN4VFzMg26NOdvtx4Hlr1jQC+UqB/s+gCdw1G5J47qw7XpTRamBoGvA9G/jjI64Urrfnu5cU3q2KuDfmzETlDG+mdSdfFbVU47F7gnpdQBIFfyrgKpzrH8iSKKqkRdpoOm6eVg6Oya4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qv8wgOTp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qv8wgOTp"
Received: (qmail 251500 invoked by uid 109); 17 Oct 2025 06:37:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WYaxTX4rJaU87RiGwGNwaAuYc0jZLtmPx76GqagJ49o=; b=Qv8wgOTppNMIxdTe8/aaV6TZiQKUnpe/4+rw1cJnEkDiTzEII63KlfGG8091UDE122BGleFR3i+DaRw3Csu0hVM+UqbDVpkzhkdzd1fLulFQ8gpKR1EmosjuaNhHkFgtPqb7cTXG9iKrUW6e/TeeQb7iX/NGWN4Id4LxtBbmU8n5uEMGcago7GZjNxh1wUpJ7MsvIaUu83FHDKh9zsRG2YyRW0FaCnmL3jCicxROPws0eg9VPHKNkkZrBQYw3COr2EKxHF+inocvzDK2L+pQs9aNB3lvt52MinkCvYpDLfjM9b3CUkYSvY8apk3bY9duZG/r43cJZcPvHSK8ABS3eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 06:37:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 392314 invoked by uid 111); 17 Oct 2025 06:37:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 02:37:01 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 02:37:01 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
Message-ID: <20251017063701.GA3091356@coredump.intra.peff.net>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>

On Thu, Oct 16, 2025 at 10:39:25AM +0200, Toon Claes wrote:

> +	for (i = 0; i < diff_queued_diff.nr; i++) {
> +		struct diff_filepair *fp = diff_queued_diff.queue[i];
> +		size_t k = path_idx(lm, fp->two->path);
> +		if (0 <= k && bitmap_get(active_c, k))
> +			bitmap_set(lm->scratch, k);
> +		diff_free_filepair(fp);
> +	}

Just one little oddity while looking at this versus the old patches from
Taylor. Here you call diff_free_filepair(). But later...

> +	diff_queued_diff.nr = 0;
> +	diff_queue_clear(&diff_queued_diff);

...you call diff_queue_clear(), which frees the filepairs itself. It
does the right thing, because you truncate the queue explicitly. But
would it be simpler to just leave them in place and let the _clear()
function clean up? I.e., this:

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 40e520ba18..47f2b0ed44 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -315,7 +315,6 @@ static void process_parent(struct last_modified *lm,
 		size_t k = path_idx(lm, fp->two->path);
 		if (0 <= k && bitmap_get(active_c, k))
 			bitmap_set(lm->scratch, k);
-		diff_free_filepair(fp);
 	}
 	for (i = 0; i < lm->all_paths_nr; i++) {
 		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
@@ -331,7 +330,6 @@ static void process_parent(struct last_modified *lm,
 	}
 
 	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
-	diff_queued_diff.nr = 0;
 	diff_queue_clear(&diff_queued_diff);
 }
 

which feels a lot more idiomatic to me.

-Peff
