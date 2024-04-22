Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BCF1F922
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824841; cv=none; b=FKf9oHq8rSsPjdkHY3CNDL4OSEi5udZxl/XS1+lVOBV9G5Ehq82Cix3/jUKgCH1ifG2RAoi9mlfYXSLvCPylF24KJshLnMlrNZpdu+uO333UXECkDipJqjdjBI/3Ijl0X6P+eKxcErekPaRZ/lWf4F2l4RErH7cDmC7IybjaS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824841; c=relaxed/simple;
	bh=G25d4jrmE8tpq2nQCUlgE8JK6vKv/8x1cVCOMzBLzeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CydD9jlhro12fNOyGczJKFidgd3/28hmbicWoO17zLUtP2KjPQyFvwuZfjud58Fs5XziINGlyiZjYhXSwcVs5juAP4KitxhMCr7RGBhi7HLA+lH2cy99/YkMRInzWndK9qNfN8ZgWaAuqFGGyTYgdOkrAteYvPS/d6oNZGg+5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dAj4zZoN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dAj4zZoN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 974792BDB2;
	Mon, 22 Apr 2024 18:27:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G25d4jrmE8tp
	q2nQCUlgE8JK6vKv/8x1cVCOMzBLzeY=; b=dAj4zZoNt6Zo9ZMD6xzgxB/kCUf0
	qc48/yEBf/kTEFuRl0FNP63C7ycXbsfz8z+o64bck4pZZvki1c1VWSqq+CkTXhLP
	rYc7ZD2oQ8xa1w3alOThY/fiJ3M4TU/XUa8MxenprXmmPUvI27IzU9KiYnRUpi33
	uNOvb1+1gbCrVQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C84F2BDB1;
	Mon, 22 Apr 2024 18:27:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D237B2BDB0;
	Mon, 22 Apr 2024 18:27:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] apply: plug a leak in apply_data
In-Reply-To: <78f38e0f-7456-42d7-b0d1-887944bb01c9@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Tue, 23 Apr 2024 00:04:16 +0200")
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
	<8e6ab088-2026-43e7-a869-b1c7185ee765@gmail.com>
	<74a6465c-01b6-4a65-8491-751244d37c82@gmail.com>
	<78f38e0f-7456-42d7-b0d1-887944bb01c9@gmail.com>
Date: Mon, 22 Apr 2024 15:27:13 -0700
Message-ID: <xmqqjzkpt4n2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7867BB62-00F7-11EF-B72E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> So the leak existed before that commit. Indeed it looks
>> like the leak predates the introduction of struct image in b94f2eda99
>> (builtin-apply.c: make it more line oriented, 2008-01-26) and when
>> the patch does not apply we have been leaking the buffer passed to
>> apply_fragments() since the beginning of the builtin apply added in
>> ac6245e31a3 (Builtin git-apply., 2006-05-23)
>
> You are very right.
>
> I saw that commit.  I reviewed again my notes and I recorded the hash o=
f
> the previous hop;  the one that my message, incorrectly, refers to.
> I'll reroll to fix it.

FWIW, the very first version of apply_one_fragment() in 3cca928d
(git-apply: first cut at actually checking fragment data,
2005-06-05) already had leak; it "returns -1" upon an error without
freeing old/new buffers.  Over the years, the shape of the code
changed, but the leak survived.

