Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D653364D
	for <git@vger.kernel.org>; Thu, 22 May 2025 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747891959; cv=none; b=RIY4x7Pb9PjqdicqSrISOhqyAPr83FqhRKyplNxQJAtd0bYbr5d5DufLr6Nm8t9NHzlYOumGQkNLxDeL2n4KobG0DOpBJZWaw/ldgzQGB9nFWolqfPFyuv86NWclioA1vWzvj1iVtAI8mhL2JqIS/iFykHhb+G5UhanDMCYL1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747891959; c=relaxed/simple;
	bh=c81tnN1IGY41VIGYaJiOF/gbpJsxvjUpRlVSNkYxtjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvlhhquFeMj7KWHUKh5+Lzu6snUvc1HlqWyGASiinuBvikZyHoQyawuoOBQyKRvkXkVm2fseGUD0NkD9Dm/PbVOVhNLmnlOtOIUIQuIqVgT08K1njCVKz4CsompaFMWh7bQukElRtTXAkBDpWOiaufv6qDmP+Jk/HeZSeTg5c8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VV9ZUC36; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VV9ZUC36"
Received: (qmail 31258 invoked by uid 109); 22 May 2025 05:32:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c81tnN1IGY41VIGYaJiOF/gbpJsxvjUpRlVSNkYxtjo=; b=VV9ZUC36Fy/tjAgJJLfeaiUcM5v8NlgBW6gQVR1cSwKktxvpP18XYLLIWSoAE8dcqVJaG8nbshBWFJMdnOd25sGAWSNPdZGGsNb/W2lrInk0woChcszywr5bvhVbZXbPsHYAcq97EU7Tk9785dPIkC0YTk32j6D8xSE8uFe5La6gBB2vNY0X5rS45cRR3hYHE/7xENPNowUqCRstrt/dXc0PQbCSO5YHjj62FHJOs9rHXXpmPXIDY7VnAAq/tfmW7AwJ8jAm3Dv1wucpjWeZvdzQT9nRwLBATn7zOyQ8tMQLvN9StD7gJPKKp3BJqUBDuuxr4e58/j2mb2FzMrS5PA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 05:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12236 invoked by uid 111); 22 May 2025 05:32:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 01:32:40 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 01:32:35 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <20250522053235.GB1134267@coredump.intra.peff.net>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>

On Tue, May 20, 2025 at 11:53:10AM +0200, Patrick Steinhardt wrote:

> @@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  
>  	pack_int_id = midx_for_pack(&m, pack_int_id);
>  
> +	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> +		return 1;
>  	if (m->packs[pack_int_id])
>  		return 0;

I did wonder while writing this if we might be able to hide the magic
number and gross casting inside a constant or macro. I think just:

  #define MIDX_PACK_ERROR ((void *)(intptr_t)-1)

would be enough?

Though...

> @@ -495,6 +499,8 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
>  				   uint32_t pack_int_id)
>  {
>  	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> +	if (m->packs[local_pack_int_id] == (void *)(intptr_t)-1)
> +		return NULL;
>  	return m->packs[local_pack_int_id];

Yuck, yet another spot that needs to be aware of the new tri-state
value. One alternative is using an auxiliary array to cache the errors,
and then only the lookup function needs to care. Like:

diff --git a/midx.c b/midx.c
index c1adff4404..df71ead50b 100644
--- a/midx.c
+++ b/midx.c
@@ -186,6 +186,7 @@ static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 
 	CALLOC_ARRAY(m->pack_names, m->num_packs);
 	CALLOC_ARRAY(m->packs, m->num_packs);
+	CALLOC_ARRAY(m->pack_err, m->num_packs);
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
 	for (i = 0; i < m->num_packs; i++) {
@@ -408,6 +409,7 @@ void close_midx(struct multi_pack_index *m)
 		if (m->packs[i])
 			m->packs[i]->multi_pack_index = 0;
 	}
+	FREE_AND_NULL(m->pack_errs);
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
 	free(m);
@@ -460,6 +462,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 
 	if (m->packs[pack_int_id])
 		return 0;
+	if (m->pack_errs[pack_int_id])
+		return 1;
 
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
 		    m->pack_names[pack_int_id]);
@@ -482,8 +486,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_release(&pack_name);
 	strbuf_release(&key);
 
-	if (!p)
+	if (!p) {
+		m->pack_errs[pack_int_id] = 1;
 		return 1;
+	}
 
 	p->multi_pack_index = 1;
 	m->packs[pack_int_id] = p;

You could even lazy-malloc the extra array if you wanted to optimize the
common no-errors case, but I'm not sure it's a big deal.

-Peff
