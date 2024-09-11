Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239F2EAE5
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090332; cv=none; b=fXHpcGyTUboSkrzslh6Tx6N9AsclYlsusSvSSc2NlPUXNfOlCPMzkAsLZF7CCdhBERHTRwz6ZLWCgK3X96cFfaradD5zHbD1fUq64BjQ53AHh04ziuf8hCOSBPHH8bLuFBRmdNqv1VyiQnrveKuittUM1M+ZkD8jxuXfgs4zE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090332; c=relaxed/simple;
	bh=BACwT3UqvviUSr07qeaoalJp2ousQUhRumE6anPZAMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrTbkGOpvTi5zdMo1TQFEc2ixWc1iNzlSclJ/fCVPwkBzgwo/cHlS10nKi3/Rc8A26kehVX+3nbvKfVoQXru3m9VgjF6jQriNqRDwk3pvTOyLFAk4lT5mHVLShVbtnoc7qRAY90FEiDGiZ2bmodCaPri2u4CrYoCdTMYjKWmsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aVkCPocu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVkCPocu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 923EA25674;
	Wed, 11 Sep 2024 17:32:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BACwT3UqvviU
	Sr07qeaoalJp2ousQUhRumE6anPZAMU=; b=aVkCPocu4Q6RlLyyWijzAdp3xpI3
	MlCov7Pyw2RLUkRyTUhet2iN4wvTqiCDcbAl/yFL7bNjzxe0Ax5EsJzou8hQ66Qx
	CPg8tuFmAE9aeXasihArUl5haaQQLtYRQQvLGk3yPk3xA2D3rPokpNzyl7jkjNoU
	b7gIQkMFDKQf528=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 89C8525672;
	Wed, 11 Sep 2024 17:32:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DD1E25671;
	Wed, 11 Sep 2024 17:32:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com> (Derrick Stolee
	via GitGitGadget's message of "Tue, 10 Sep 2024 02:28:25 +0000")
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 14:32:05 -0700
Message-ID: <xmqq8qvx6fmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4BD9C56A-7085-11EF-981F-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> One obvious issue with this current implementation is that it inlines m=
uch
> of the delta calculation into the "Enumerate objects" phase, and thus m=
akes
> it single-threaded.

Na=C3=AFvely, traversal of history partitioned by paths smells
embarrassingly parallelizable; it may need some post processing to
make sure that the same object only appears once, though, and the
devil probably is in the details ;-).

Thanks for an enjoyable cover letter that pulls readers in.
