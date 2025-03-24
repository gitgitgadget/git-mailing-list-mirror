Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C511953A9
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812642; cv=none; b=DoBuYyDPCMz2rzJYRMH8hCGrVF4Qfl60fBD7r2CVQ7t+3hRTeFnwgzjxWCPJU+b7EkJUNQPOURPJ9aZykQVpcjf8TJs+nAuyP8XeWfi1qqq3wNKarxRJZv3dNKiuELrFcyFGqCsvAjGIySnY2Zn/oIoYRyKl6v7jFrfMXQJ0lbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812642; c=relaxed/simple;
	bh=0MdmLRm/isFnx/ExUnfZTqFLBzkuFMPLxOXYQzq440s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lVfoDUd9ZdeiwhAMywsTWhvcYWVf9vtT2qhEGs7GXoTsV0A9CdximQ15roGxl8jD/2TxZVtfPfOmigXw5LPkQDz0HgceeaA59dG2eoe/JMAb2JExYJMVYYOEtQEw8M/s3FnK+NpUInGtxPhghpjP5ToR57tmzIKyLH7riD4SNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pMRLzwBp; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pMRLzwBp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1742812636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lzeld8VPUXbKWpIRcEB5f3x1b3McAdlEeGTiZ4gYk3U=;
	b=pMRLzwBpnbF2b4OVFs4Ma+MYCk9V/iYbHOvka95lqR25+mycflbsFeSLNEZ6MQT3rooV4Z
	VwKX5RR9TWcPWUfLezHje0kjM10WfmoSF23iKEvhFUjZWzuEnkdj+ZOLSJmhbtonuxihHs
	LijM3kCbV+Dt34sYHlAWlt4ylByXDf0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
In-Reply-To: <Z-Ew_12NWX_5qATN@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im>
Date: Mon, 24 Mar 2025 11:37:00 +0100
Message-ID: <87a59aww8j.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> I think the porcelain mode is already built so that it can be extended
> with arbitrary new information, no? In `emit_one_suspect_detail()` we
> end up printing one line per info we want to display. I would have
> expected that we can extend that function to also print information
> around unblamable or ignored commits, like we already do for boundary
> commits. E.g. something like the patch further down.

Yeah, I think the porcelain format exists to be easy to machine-parse.
Having an optional prefix symbol on the commit OID would complicate
process that.

And I've been thinking about a similar solution as you've been
suggesting below. I was only wondering whether we only do this when
using `--line-porcelain`. When using `--porcelain` the function
`emit_one_suspect_detail()` doesn't print most of the commit info when
it was already printed. But the "unblamable" and "ignored" info might be
different for each line, even if they blame down to the same commit.

-- 
Toon
