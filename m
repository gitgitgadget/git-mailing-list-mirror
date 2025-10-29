Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491A2505AA
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742937; cv=none; b=SMMbKz0TJE2XZimjC0XWPSSqbBBb3i7kLmzKJARLsg7WD/eDqagX+O9JtQw+BQFEj3emBX0/HJQLD/49L8cLZmARKIY1Fb+ECFDlQMoOziv1hwvv5PbXqONI1M9FmnN9SjXs1uHxggOt33EMCQkTNADUfo19cYqf+0oKZ5IYTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742937; c=relaxed/simple;
	bh=Rq3PfsM7N2Blqjgbr4CMWeWnXtaU05SsoVZLCUIm66I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKMd5lRMoC7r1V7AxrhyHRIyXF2f9T83mPV/V06ThCsMYiBMVRL4JVlvtygYZIv4cbKPn4MKyaUB1ZnmPrhaLDOJyWH/0AKssbRhnCIPncRS+wBX1ioa8aTG1mUl683sG5bmrxIH5tTyM0TzAikapmTL0qVmCAzOyPVTMqzWGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hNBWlXPr; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hNBWlXPr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761742926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vHZAAYAsf0mN/nVEUMSS35SSlmMyImlCf6DRQDzCaE=;
	b=hNBWlXPrz8BWX3Pv+mHuwNrdH6PGADMpLYDqHXGoXW2dUa+qVsd+/BK3QPOqMKqqlagAm4
	LPYWjlkFDntwE3kUg9c96y20R8NUMaf79kHnMxgJAraD4h6oOBu5iBls69gXvWyv1W3IAW
	9Q4pivsSy8AY+Wh9eLKWFeThnMIejxE=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
In-Reply-To: <aP/Gdl0kGJWklZdO@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g> <aPgkwnq87UeusC6v@nand.local>
 <xmqqecqv1trk.fsf@gitster.g> <aPrByfpOkQ7biyEI@nand.local>
 <xmqqtszpqgmy.fsf@gitster.g> <aP/Gdl0kGJWklZdO@nand.local>
Date: Wed, 29 Oct 2025 14:01:42 +0100
Message-ID: <87ldktrhe1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> I am not saying that we should continue to write "if (0 <= k)", since we
> will clearly never take the else branch. I am trying to say that
> path_idx() *could* return (size_t)-1, and callers would be able to write
> "if (k == (size_t)-1)" to check for that error condition.
>
> My observation was that there are unlikely to be so many active paths at
> any one time such that we'd ever want to return (size_t)-1 as a valid
> index, and could always use it as an error sentinel.

Yes, I agree. If the list grows to (size_t)-1 entries, I think we also
run into other issues.

Anyhow, in the v3 I've submitted, I resolved it differently so no
awkward type cast is needed.

-- 
Cheers,
Toon
