Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F09149C53
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867734; cv=none; b=Rdu6LNbvujvuANtQwMQsASRy59tMMB+nFh4h01OPoeknJ2e2nxYBk8o0UNnUdOPjf1HqChU3cc6W0O/mQQF1y2z3jnWYig8+EmQsEpHZNARuCDEn/iPIDohEgbDCqd95P+OGTM1Mj4Islh6IAzfRX+QLbCeLefvLHDZydyiwkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867734; c=relaxed/simple;
	bh=usNdq8N3zS0XE82Dk7Be/W3o6qHrmTV/YBwlL92Fctc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9+dGXGmJvUhLALeKYF6Dr/UGD0E7fqxmbrPJHLXNTxjwoZYOdfKKzTeD2yWDhjef3qhxEomPPwEkq2Bkbx8oSv410ffSQrVDzx7IvXMdvNyKVOn8LdQ7cWQjulOtebVSgzITAYmLKPX84lHpHLxxWWq/iPNXNdENmJiGO/lD/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fXoP1zGs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fXoP1zGs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B671F3C353;
	Wed, 28 Aug 2024 13:55:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=usNdq8N3zS0XE82Dk7Be/W3o6qHrmTV/YBwlL9
	2Fctc=; b=fXoP1zGs+7VJFWQymCIPoCn/xpFns8BIq9C5FWW2XRMbHGTbT+2jQD
	3qkljMzNDJywdQppudRR8SodpIko+8QqlsafgASLo15i+HLmwYbfgThqMsBAS5JN
	HI/EA56r5BXP9wwzS3GtRd1YpSPhbWq9wriR55NHLE8Yov1ojDRkA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AE1213C352;
	Wed, 28 Aug 2024 13:55:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41A303C351;
	Wed, 28 Aug 2024 13:55:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: [PATCH] fixup! midx: implement writing incremental MIDX bitmaps
In-Reply-To: <afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 15 Aug 2024 18:29:28 -0400")
References: <cover.1723755667.git.me@ttaylorr.com>
	<cover.1723760847.git.me@ttaylorr.com>
	<afefb4555750661ffd2c573a33d92f8fcb9f435a.1723760847.git.me@ttaylorr.com>
Date: Wed, 28 Aug 2024 10:55:20 -0700
Message-ID: <xmqqseuozg53.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B237BC24-6566-11EF-856D-BF444491E1BC-77302942!pb-smtp20.pobox.com

With -Wunused, the compiler notices that the midx_name parameter is
unused.  In this case, it is truly unused, the function signature is
not constrained externally, so we can simply drop the parameter from
the definition of the function and its sole caller.

This comes from 01a2cbab (midx: implement writing incremental MIDX
bitmaps, 2024-08-15), so I'll squash the following to that commit.

 midx-write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/midx-write.c w/midx-write.c
index bac3b0589a..0ad9139fdb 100644
--- c/midx-write.c
+++ w/midx-write.c
@@ -827,7 +827,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 }
 
 static int write_midx_bitmap(struct write_midx_context *ctx,
-			     const char *object_dir, const char *midx_name,
+			     const char *object_dir,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
@@ -1415,7 +1415,7 @@ static int write_midx_internal(const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(&ctx, object_dir, midx_name.buf,
+		if (write_midx_bitmap(&ctx, object_dir,
 				      midx_hash, &pdata, commits, commits_nr,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));

