Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF3256E
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890719; cv=none; b=fNkMS+5z42Rk/39MQ19KBn140NQ95gZNM0hE0Sr75YSOvXLOsUMOhKddphSi+j0Qy3/4qDaBNjJVr5K0EVnRY5qE08FR3un+0IM7iqKZJLl7K4+YNg8oXxbTimKMcPbNXf88f5BuF+ILIN0d2yklkDusmBr4z+ZKVDpICZ1XI2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890719; c=relaxed/simple;
	bh=Yt1ZFV/mFI8x3n24Lyglc7g3ZXFlsyUUZoOnKpZT6Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We/uUUsS3n5QtNxpw8WKMTzyYeKjROzW0yvGZD5XohiJo/EpPGkWl7l37aETZfl55V/1zHiS8eXzTzOo09EFqHQCGLV/C3S2n+GTHmb8edEJMcxSoZYSWoVEZ+BD69Aun+G9/yR5RYpvDdgfz3n8XwMOAqzRPjekgZF74YlrfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25888 invoked by uid 109); 17 Aug 2024 10:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 10:31:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28809 invoked by uid 111); 17 Aug 2024 10:32:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 06:32:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 06:31:55 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] pack-bitmap: initialize `bitmap_writer_init()` with
 packing_data
Message-ID: <20240817103155.GA551779@coredump.intra.peff.net>
References: <cover.1723743050.git.me@ttaylorr.com>
 <9d322fc5399c453913d08f35eee907b5c909ad6b.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d322fc5399c453913d08f35eee907b5c909ad6b.1723743050.git.me@ttaylorr.com>

On Thu, Aug 15, 2024 at 01:31:00PM -0400, Taylor Blau wrote:

> In order to determine its object order, the pack-bitmap machinery keeps
> a 'struct packing_data' corresponding to the pack or pseudo-pack (when
> writing a MIDX bitmap) being written.
> 
> The to_pack field is provided to the bitmap machinery by callers of
> bitmap_writer_build() and assigned to the bitmap_writer struct at that
> point.
> 
> But a subsequent commit will want to have access to that data earlier on
> during commit selection. Prepare for that by adding a 'to_pack' argument
> to 'bitmap_writer_init()', and initializing the field during that
> function.
> 
> Subsequent commits will clean up other functions which take
> now-redundant arguments (like nr_objects, which is equivalent to
> pdata->objects_nr, or pdata itself).

This (and the next few follow-on commits) seem like a good change to me.
It simplifies many of the function calls, and I think it expresses the
domain logic in the API: there is a single set of objects being mapped
to bits, and many parts of the process will rely on it.

Even the midx code, which is not generating a pack, uses a "fake"
packing_data as the way to express that (because inherently the bit
ordering is all coming from the pack-index nature). If we likewise ever
wrote code to generate bitmaps from an existing pack, it would probably
use packing_data, too. :)

-Peff
