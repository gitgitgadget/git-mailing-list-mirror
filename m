Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0747E9
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274096; cv=none; b=oWP+aQ2zM3vD+McU5c3KVKg9dVYfUwQOBp2rdfsomQMJG8HPHIY07IrGBkrjwzTPwSFC9MkHe6znl3myPFH0POfSOLwJneTavM9Ggq3BccvOs6hMN2w41hJxo/+GnQS7ztVfa10eN15ClumQzjQMAAKg2d/dVeaHTqvhJMlxMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274096; c=relaxed/simple;
	bh=3ScFIUOFRMisRxVeD2oNxcGDK9LQHMuNGKWjtd91XcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jlYMgIhF38VeZhe2F7IW1D3kQRfg/MuWuSIHM8h34K2nYWojyw0cGSKJjt75UYEPTXCG7e5wRj43YiMXsf9a6EdqroYhEf2/YYapKGCvtwUSbr+ACyriNW6m4ysKI1cqyvjmitN4UaEHpi/YpZVoytBJwR3SSwiPR+OQOJlRP18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=B26VCRGW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B26VCRGW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DD5E326CA;
	Mon, 24 Jun 2024 20:08:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3ScFIUOFRMisRxVeD2oNxcGDK9LQHMuNGKWjtd
	91XcU=; b=B26VCRGW2Hbc73qoO5lEwjQUmXZvM6CW36C02osp9D9aAG1MxCXBIN
	exXY44bJx8/KV+wNvwhx09pqkRoMS5a6ZxiJA9NlrbqSBGhtcNXGS3OG6m1zqTFt
	YKRJ9MEu6kYt9FsIYFkjFdX7gfI8VoXLgQbBBPJ/w6WeE1dWhLXIk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5585D326C9;
	Mon, 24 Jun 2024 20:08:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 587D7326C7;
	Mon, 24 Jun 2024 20:08:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  anh@canva.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] sparse-index: improve lstat caching of sparse paths
In-Reply-To: <CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com>
	(Elijah Newren's message of "Mon, 24 Jun 2024 15:14:40 -0700")
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
	<CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com>
Date: Mon, 24 Jun 2024 17:08:09 -0700
Message-ID: <xmqqtthhanpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0262A80C-3287-11EF-AB4E-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Elijah Newren <newren@gmail.com> writes:

> ...  It'd simplify this particular call to
>
>     strbuf_add(&data->dir, rest, next_slash - rest + 1);
>
> or substitute any other variable name for "rest" there.  Maybe it
> shouldn't be a big deal, but ...

Good observation.  Naming is hard, but it often happens that a
temporary variable that is given an appropriate name improves the
readability of the code a lot.

> Anyway, despite the many small comments I made, well done!  I think
> the method is not only much more performant, but more readable than my
> original.  With a few small tweaks, it should be good to merge.

Yup, and your review was a delight to read.

Thanks, both.



