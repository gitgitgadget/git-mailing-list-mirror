Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364657263E
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761419760; cv=none; b=A0A9VlOT41/M2BVkQ5PGH9blRHmV+9LrmCJ8xyHeJPL28Pkwt1cbCeyV3U0UaYW4NPWFo0yEk6FOSM+xDZMiSA0UetAcpVyrYQbWEnDNysSXb1i9TOKeiEeDqpNkX5ojlGqpFgjl45CvvqvX8F/+h6vmbYatF+xx+lqKuuyuc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761419760; c=relaxed/simple;
	bh=opr6/GG21TvgV/DIoL5tDp2UNKaVoon1Gvtpkt1UoqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9HwQIOi1W7cBEx5wJjmeKY7YN29cWKbqpCkEpUVCBsaSNeeKHIMq6eUS/SzBEg4h3CnVcEdLx7fQ3daylxD14lplbQaTa5GHEadFA2vRCmsQhnu7i3OQ0VD5DTqREIIVudbCOdnpSOXrmjt1NjgODHW6M+3L/bb6ct9ciwuDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZkO8Mrsf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZkO8Mrsf"
Received: (qmail 338346 invoked by uid 109); 25 Oct 2025 19:15:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=opr6/GG21TvgV/DIoL5tDp2UNKaVoon1Gvtpkt1UoqU=; b=ZkO8MrsfsrCq3qGucpzPftzcveGE08wEAX+YEZum9MrenXLzRqqifSTKVCfdLQ8KUM/CUeCnmNqCVOVQdZRvuYAa1C1EPDZellfHdpqofVu0HAGzKgdDvq1p8GHc6DlJmPyFxyp3orA4l3otC0WU+iiQi/pOb2Rv3i3HVTfxPzjXJcjAg/JkucWdn0oDy0YxyA0MIA6wewPKjaBnppRDKjS//efKg48g5O4eOENYVehIRY7aKccQ5lQX2pQvJMhedkTWO+KpgCTb57lGfGjzIuxUoI2Zy0EggUciNLLF3phOv/GATZsxCAhltytj8dOId2bWqqJjqeqYDX3vF7+aNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Oct 2025 19:15:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 530824 invoked by uid 111); 25 Oct 2025 19:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Oct 2025 15:15:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Oct 2025 15:15:50 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] builtin/maintenance: introduce
 "geometric-repack" task
Message-ID: <20251025191550.GA279793@coredump.intra.peff.net>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
 <20251024-pks-maintenance-geometric-strategy-v3-3-9b5b3bdb4387@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-3-9b5b3bdb4387@pks.im>

On Fri, Oct 24, 2025 at 08:57:16AM +0200, Patrick Steinhardt wrote:

> +		# Repacking should now cause a no-op geometric repack because
> +		# no packfiles need to be combined.
> +		ls -l .git/objects/pack >before &&
> +		run_and_verify_geometric_pack 1 &&
> +		ls -l .git/objects/pack >after &&
> +		test_cmp before after &&

I got a CI failure from this test like this:

   + diff -u before after
   --- before 2025-10-25 17:51:59.985025237 +0000
   +++ after  2025-10-25 17:52:00.304026445 +0000
   @@ -1,5 +1,5 @@
    total 16
   --rw-rw-r-- 1 builder builder 1252 Oct 25 17:51 multi-pack-index
   +-rw-rw-r-- 1 builder builder 1252 Oct 25 17:52 multi-pack-index
    -r--r--r-- 1 builder builder 1156 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.idx
    -r--r--r-- 1 builder builder  226 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.pack
    -r--r--r-- 1 builder builder   64 Oct 25 17:51 pack-68c20c4590a622a21395b4480621d55494112a83.rev

I'm not sure if this is a bug or a race condition in the test. If
"no-op" means "do not generate a new pack, but do generate a new midx"
then it's a race condition (the regenerated midx might move across the
minute boundary).  If it means "do not even generate a new midx", then
there is a bug. ;)

You can generate the race at will like this:

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 0d76693fee..2b5141196f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -501,6 +501,7 @@ test_expect_success 'geometric repacking task' '
 		# Repacking should now cause a no-op geometric repack because
 		# no packfiles need to be combined.
 		ls -l .git/objects/pack >before &&
+		sleep 60 &&
 		run_and_verify_geometric_pack 1 &&
 		ls -l .git/objects/pack >after &&
 		test_cmp before after &&

though if we are going to be picky about timestamps, it probably makes
sense to use a higher resolution. Sadly I don't think there's a portable
way to do that with "ls", and "stat" is probably likewise something we
can't assume. I'd turn to perl, but I know you've been trying to avoid
depending on it. You can hack around it with:

  test-tool chmtime -v +0 .git/objects/pack/*

for this case, I'd think.

-Peff
