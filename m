Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9B148FE1
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057419; cv=none; b=ULRPvGqH8vHfg1qxn+aEN+/Ob3NoBfLcwdOvLpUJEtJF23eAveQmMNNLGH1kmA089njbbAwE/qZnYsEZu8QpPcTXujuVkpVW+DGjUi8FOeiXWqDVQYtt7rk73wqgVjJEUe/mOJ80sPpRxtYMoZ0LDgFTkEYudHVnuP/GMWx3cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057419; c=relaxed/simple;
	bh=+O/XqtfcbQgzbKVwqWXR28+j6c4rCjR+Iz3HXNl03O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBSUoIOkPHHdSe7nTLvhIDGoOW/EG2Gc+QuVeudf0Sh2yDU2Zsp5MNzRB6hRIEju4Gicsxa2GBK4yMCpl9jxgCFyClm5t76wUKPKARAxqg3TLcbYbFLtev9eEasJJMcxCZdgntDE/SVeC8JiQpgsxsJDDzOVnxZkda0KZYVvFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a/tZ8KNc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a/tZ8KNc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AD6AF2480E;
	Tue, 27 Feb 2024 13:10:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+O/XqtfcbQgzbKVwqWXR28+j6c4rCjR+Iz3HXN
	l03O8=; b=a/tZ8KNcNSjfLr4TS+f6IuKX18w5K7mLm0mxoWelN02RAc2QQDA2sK
	aS3Ab8IMwQcCAKZATdnFkPI+7dHXjRV0oN8sXP5lzhZql0/bZIKjvsqlZqxOac+J
	MUdTdb+NvP7pAylq4fgazD3pgoqpF6g8SIFVQg2QMGbXX9SFk25eg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A5AF72480D;
	Tue, 27 Feb 2024 13:10:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3FFC2480C;
	Tue, 27 Feb 2024 13:10:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Dirk Gouders <dirk@gouders.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
In-Reply-To: <xmqqcyshu6es.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 Feb 2024 10:08:11 -0800")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
	<gha5nmnex4.fsf@gouders.net>
	<79914d16-f58d-7ab0-5c25-f29870a73402@gmx.de>
	<xmqqcyshu6es.fsf@gitster.g>
Date: Tue, 27 Feb 2024 10:10:12 -0800
Message-ID: <xmqq8r35u6bf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 740EA68E-D59B-11EE-888C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that what made it harder to follow in the original
> construct is that we called the behaviour "incorrect" upfront and
> then come back with "that incorrectness is what we want".

Oh, I forgot to say that lack of "<area>: " on the title of the
earlier parts of the series were a bit uncomfortable to read.


