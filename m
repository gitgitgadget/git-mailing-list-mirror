Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED42C19C
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qelVdWKJ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 749572121B;
	Fri, 22 Dec 2023 14:01:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7tUsOcKg7piQ
	MaUY7spAnz9HHx/wreTViJbRQwpacYY=; b=qelVdWKJeb/Er6cBBKKgBbvbjmK4
	UcCAzhqWw5ZPdLNKHxj2MzykbUjdOm9pT1WsD2W37braR17XLtzkgTFnLgvn5SZ5
	Pyk3O1HjacM7zoo13xBGwoj1g32umj32lZ89Nc3x9ic1MjKHpt3+Aqgt2VV76332
	0hZxOkiI8mmlu1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CD052121A;
	Fri, 22 Dec 2023 14:01:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 128CD21219;
	Fri, 22 Dec 2023 14:01:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] sideband.c: replace int with size_t for clarity
In-Reply-To: <20231222175747.GA2880@tb-raspi4> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
	message of "Fri, 22 Dec 2023 18:57:47 +0100")
References: <pull.1625.git.1703264469238.gitgitgadget@gmail.com>
	<20231222175747.GA2880@tb-raspi4>
Date: Fri, 22 Dec 2023 11:01:37 -0800
Message-ID: <xmqqedfejc32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 894F5418-A0FC-11EE-978F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

Just this part.

> Further down, we read
> 	for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
>
> However, a size of an array can never be negative, so that
> an unsigned data type is a better choice than a signed.
> And, arrays can have more elements than an int can address,
> at least in theory.
> For a reader it makes more sense, to replace
> int i;
> with
> size_t i;

It is a very good discipline to use size_t to index into an array
whose size is externally controled (e.g., we slurp what the end user
or the server on the other end of the connection gave us into a
piece of memory we allocate) to avoid integer overflows as "int" is
often narrower than "size_t".  But this particular one is a Meh; the
keywords[] is a small hardcoded array whose size and contents are
totally under our control.
