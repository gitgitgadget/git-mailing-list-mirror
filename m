Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83F1339A9
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208973; cv=none; b=QmEGryd6a9/8v4ii90lFtLGOWRWZYaVC1+XYixx129S4+NsDSOigcSNBMBnAVXdvC6WHyVY8vE6aHChMzaI9Re3rOV7KKB+BMxTiXQk08nOTv1x0L9VeRpg5Fu2r7N/0tjQA9guKIY/EoYCpUsYeWJVa3s7cvJlbWXDqIpQy2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208973; c=relaxed/simple;
	bh=mwaccdeL3cqPrmXcsNPOW1b9HvLUfW3SqeEl9QCgPp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/Iq7eJRvkBPwoAFfIeHqJl7ubYicxgQHGIyglK60H2vjbyw4rYqcOWOTJRd5EDxfL1613kN1dv8FiQcIyoPYi+Q1MWINTz2PXfl5wrudpQbMLw01S7OgCzz7tXvVwqUjiy/hBbxVitKLybzh8LCGt1EU1k8GIHc8CZbIBZrseg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OUjygqFp; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OUjygqFp"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC4891BF269;
	Thu, 25 Jan 2024 13:56:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mwaccdeL3cqP
	rmXcsNPOW1b9HvLUfW3SqeEl9QCgPp4=; b=OUjygqFpmbTJfOfGyu62i5BSmQVT
	zQAyMMWDtLJ7EGl5SBqDCR4VG3J+m597OKkj+KwpLi35Oxkbjqe5Y9yKe2tp1zZ0
	nuQeixxbugB8HhIHLo/1c+li2/MSzZaK+utlTnygujV9a0lJ6c8UChRFATrS0LPr
	wnlo5o3+cUx7uXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D496A1BF268;
	Thu, 25 Jan 2024 13:56:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D06E1BF267;
	Thu, 25 Jan 2024 13:56:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,  Zach FettersMoore
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees
 present
In-Reply-To: <CAP8UFD2Oo8v8Qn0JPYURZA_s7ynZmk6v30b9zR==MxWBTXk9Ng@mail.gmail.com>
	(Christian Couder's message of "Thu, 25 Jan 2024 19:52:22 +0100")
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
	<pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>
	<CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
	<CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com>
	<CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
	<CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
	<CAP8UFD0M_KeUTHthQ6n_a1KbEvuA1gAsE2jKkAqd-4twjbpNWw@mail.gmail.com>
	<xmqq5xzhxta3.fsf@gitster.g>
	<CAP8UFD2Oo8v8Qn0JPYURZA_s7ynZmk6v30b9zR==MxWBTXk9Ng@mail.gmail.com>
Date: Thu, 25 Jan 2024 10:56:09 -0800
Message-ID: <xmqqbk99w8c6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 675BCF9A-BBB3-11EE-991C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Jan 25, 2024 at 5:38=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > It seems that this topic has fallen into the cracks or something,
>> > while the associated pch looks good to me.
>>
>> Yeah, it wasn't clear to me that your message you are responding to
>> was your Reviewed-by:.  If I recall my impression correctly from the
>> time I skimmed its proposed log message the last time, it focused on
>> describing a single failure case the author encountered in the real
>> world and said that the patch changed the behaviour to correct that
>> single case, and was not very clear if it was meant as a general
>> fix.  Is the patch text, including its proposed patch description,
>> satisfactory to you?  In other words, is the above your Reviewed-by:?
>
> Yes, it's satisfactory for me, and I am Ok to give my Reviewed-by:, tha=
nks!

Thanks.  Will queue.
