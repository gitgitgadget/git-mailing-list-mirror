Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1078821
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245030; cv=none; b=PvUEa+/8ymRuyc/sOJiVPGcRjSyg8L9EX+HUFx4WwagGeHJtp8c6KmmlevxffbenZM3j+dn/C80U6dPw3caxbpDlNIsAvi9N252FSNFoWhsc/HYNBg7FHNEk7iuorKCGS9Fzl6EmZDHU9dNN1hjAYHbgbcy8dTOVWPgthmNPEkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245030; c=relaxed/simple;
	bh=9kOXlDSsb7gf1JM3LYhy/qngVs4DoAu4XOKRUz198JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0B1PLa4RorN3ohe2Kh5QululC4/LN1QbjOhm2Goj+xq+v/xZQmiuNXmUWatt2OPIaH0mQ/s6qEE9ocPx8xX9fd+xoOjlXODj3fPyePnWCIAUaY+wollT4cOZsoYie2P2Jn78Sh8FCAgxi4cgh9Pbu7EVeZVPIn79/uuD+ZoKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=E2ef0eYN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="E2ef0eYN"
Date: Sun, 29 Jun 2025 20:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751245022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJIx0QaRncIddECK3rnCHvyPGOMILUBvZLY9cwY7Bqg=;
	b=E2ef0eYNPz/8OqsH5ofxc1RJvFGxt7+Kw4fC4zj1jpOZhlZALwFJdkGouqJJqeJHlSZy3k
	XsVD1XBDo924R/fF4B8rWrYmxrRq73gRHrbkmebTmp0t1jze0YFvRXuTT7hijJo8NOpNrd
	9oj5BdVy3gDeFO0nTnU9p5x8GQMXQFw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, aclopte@gmail.com, gitster@pobox.com, 
	jason11choca@proton.me, kristofferhaugsbakk@fastmail.com, rhodges@cisco.com
Subject: Re: [PATCH 0/5] fix apply --intent-to-add
Message-ID: <tjoz7imj4yx7gvyyew5tk6eytfq2ipq4ip4nbgbkxekp6ellcb@4ri4ehz5cwtp>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <16943C7D-C331-482E-BFDD-236E8E79552A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16943C7D-C331-482E-BFDD-236E8E79552A@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 25/06/29 11:10AM, Lidong Yan wrote:
> I think [PATCH 2/5] actually solve the problem. [PATCH 3/5] makes 'git apply'
> consistent with 'git add', which means
>   git add —intent-to-add exist-in-index-file.c
> and
>   git apply —intent-to-add patch-contains-exist-in-index-file
> 
> will ignore intent-to-add and do nothing.

This behavior is correct and expected (even if you don't register an
intent to add) because the file is there in the worktree, so you can't
create a new file in the worktree with that name.

But the real reason for that test in create_file is that we're in a mode
that shouldn't be touching the index at all, so we shouldn't touch the
index (except in the special case where intents to add live in the
index). If there's a patch that updates existing file A, and creates new
file B, then without that test apply will touch the index for both A and
B, which is wrong. It must only touch it for B.
