Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38981DEFDC
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463489; cv=none; b=tOdBdHBvhabO/EX3OBPvJieVLQ5Gbcb2ErUIbAFqZ+0o/udwPQJknl2Kim0+680oWGGKLEIdi2x6bcXvwJzdL2cUpdntfEQgDqyucQH1d5Xa6+JfFIVuMlIy2jg26RSIEj5M8gt7PhthiNkXAviK/Qs8Y1FSnMC0qCUa53VINfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463489; c=relaxed/simple;
	bh=VGqcWddS5SaEziv6Ew26XTH2MAZ/aPxSusC8A7QuFh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jP8T4FdVvaoM3TGg8kk9tsmrVtzUMOS9bbo62YTDEAX/+u5rJN08XufTeOFHKa9FAzdz34jPs55YyX0Vu9Iqs5STyEGYV3+WJI7uBXWNDPImsCcybIgohLgYpqTMkn8/VEPH46UwnFh76YWlJXermrrAs9kH5cYUAQz3H70TzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XByrS4yq; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XByrS4yq"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A36C135488;
	Wed,  4 Sep 2024 11:24:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VGqcWddS5SaEziv6Ew26XTH2MAZ/aPxSusC8A7
	QuFh4=; b=XByrS4yqoIM14Dcbz8Jb0yvkJ8DqBpTwGE5GnrTqYcvzqDScO0kBe5
	8d8Noiu/DggyuXe5HQq1/Mwym1AL4J3wI27PjnLYgzelp7Gx5fhjsWYIBlKgMOcP
	zzBIYDimoIofPkuOPA2gtSllRp26wrD+erHLis5uW8tHgqSwQAfzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BD1335487;
	Wed,  4 Sep 2024 11:24:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFAC635486;
	Wed,  4 Sep 2024 11:24:45 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/3] refs/files: use heuristic to decide whether to
 repack with `--auto`
In-Reply-To: <49f953142b1b20a63102b87a1d96f5bc1f79da82.1725439407.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 4 Sep 2024 10:53:08 +0200")
References: <cover.1725280479.git.ps@pks.im> <cover.1725439407.git.ps@pks.im>
	<49f953142b1b20a63102b87a1d96f5bc1f79da82.1725439407.git.ps@pks.im>
Date: Wed, 04 Sep 2024 08:24:44 -0700
Message-ID: <xmqqmskncugz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D1103DAE-6AD1-11EF-B4B0-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a heuristic that decides whether or not it is worth to pack
> loose references. The important factors to decide here are the number of
> loose references in comparison to the overall size of the "packed-refs"
> file. The bigger the "packed-refs" file, the longer it takes to rewrite
> it and thus we scale up the limit of allowed loose references before we
> repack.
>
> As is the nature of heuristics, this mechansim isn't obviously
> "correct", but should rather be seen as a tradeoff between how much
> resources we spend packing refs and how inefficient the ref store
> becomes. For all I can say, we have successfully been using the exact
> same heuristic in Gitaly for several years by now.

This seems to hit the balance between the thoroughness of repack
(leaving fewer loose refs is good) and the frequencey (doing repack
less often is good) in a quite sensible way.

I also have to wonder if it adds a good component to the heuristics
to leave younger loose refs (wrt mtime) out of packed-refs, with the
expectation that they are more likely to be updated again soon than
refs that were written long time ago and stayed the same value.

Thanks.
