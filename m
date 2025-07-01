Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BE72601
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347967; cv=none; b=AA24niUq4zvCvvbXdFY50/42kdx3CIUyWkqiFlByqC+bNXxaCsPsEZIORxJIcvDOdyApvcqT6FW9Htel9BjPgDjr43TMCr7m/5kMuVJMDHRCP0wbeW/5DoPsD/GuLsOKzJQsLp0VaUgR9NVZF9ML8id1MAoBPmRVOwKQ09Pvj7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347967; c=relaxed/simple;
	bh=1noLOxrQg5y/PpSfpMKCeCR4xU1O0E6j/h6S/0q9ilw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJowtUclRSP+akFmSFERlZXIu3PWOP4tWe+iNTEYpFGgi3oMMXoOkL+cYY7tcnK2Yldq7B1hZEjYjoDWrBaPoaLpsO8qAIFGmzWGhHwMRNuRfO5KJm04wLMh1S55D+dlKkUjsY3E6tcXF+gxvdxv/a7BtezPgBxkLUSNMS/cnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=fy8iI8FH; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="fy8iI8FH"
Date: Tue, 1 Jul 2025 01:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1751347962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIU2LY29Kgen6eoCvcD8bW2Z7OHfpZXUJUlLc8OniPM=;
	b=fy8iI8FH2aYQb/2FY65BkMO/0hRjFb+aqjhjc9r4dw+5OyyQ7PYwrf/+OJM8ddob2Jn1BS
	/lmY+NRkveKyqvB63qnb/Nd+NV3xHseatDwEA5VG0LnXkEfFoG0Jxn/+i5U3AMmBzNucIN
	DW0jYc2vf3QQcanXqXXwchUTX8bzP+8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Ryan Hodges <rhodges@cisco.com>, 
	Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH 2/5] apply: read in the index in --intent-to-add mode
Message-ID: <i5mft6pima4ft4gyhluoflktnr22dzl6vc2txqfwvhldecdk5b@rkfdkf2ryci7>
References: <20250628225819.1294068-2-ray@ameretat.dev>
 <20250628225819.1294068-4-ray@ameretat.dev>
 <xmqqbjq512y5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjq512y5.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On 25/06/30 11:47AM, Junio C Hamano wrote:
> "Raymond E. Pasco" <ray@ameretat.dev> writes:
> 
> > There are three main modes of operation for apply: applying only to the
> > worktree, applying to the worktree and index (--index), and applying
> > only to the index (--cached).
> >
> > The --intent-to-add flag modifies the first of these modes, applying
> > only to the worktree, in a way which touches the index, because
> > intents to add are special index entries. However, it has not ever
> > worked correctly in any but the most trivial (empty repository)
> > cases, because the index was never read in (in apply, this is done
> > in read_apply_cache()) before writing to it.
> 
> As the inventor of "add -N", I think what "apply -N" does may be
> wrong (only judging from the above description; it's been a while
> since I really read the code in apply.c).  It does not make any
> sense to write a new index that has only the ITA entries.

Yeah, that's the bug; it writes a new index with just ITA entries (iow,
the index thinks every existing file has been deleted); the fix is to
instead write ITA entries to the existing index, not make a new one. And
the root cause is not having read the index, so it's starting from an
empty tree.
