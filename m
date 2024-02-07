Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8D8289E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326645; cv=none; b=o1Y1Riz5C8KBtzWq34HlGoLAI4qkrQVIUh9HR3FMR0uOCkUyc7CWUvcLRo8TWhowN0PcXISlNalnKSWMTLC1Wp/cURSSr2x75De6gTy/0JjAgluv5i2beKzpdK8b00WPz99ZxDEwKTtgIBpo0OnIOH7BBsCfI9G0kx559LD2IH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326645; c=relaxed/simple;
	bh=0u43xb4qNpVETUQ/Ao83gBHMddEMI4kUqyQ+dai5pHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNBUKyGkO7rhpQ+0Q2qE1y7syDPenhZaQg7Bv0uA2FobzqQYWMkyaLXi7L9vo5RZMwmVdEPujolmFcopdnaYA9qXDYeoCy04kqG+Iazy8VUxJsPbVEjzN8PrJbIRLhL+LHxF12jJOidkS00TuXZ1676ANa2WPQIv9zkEzCQRwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mcYZJaUM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mcYZJaUM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D3682D429;
	Wed,  7 Feb 2024 12:24:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0u43xb4qNpVE
	TUQ/Ao83gBHMddEMI4kUqyQ+dai5pHc=; b=mcYZJaUMDXjZDFznpzpcU8KnY5Ub
	5DwKBDH3seUDWX+YjwcyHP1Sh3ruzW8KqrvEaVR397Uel3fAjEzR8LdjZUdxl2vr
	vOUqlAEIbfVduZ6eGOZM7E8jae8r0iDQH/PdTPUSKiaNvDiOC8L2udJ/v3vT+o8Z
	Tj8XQD1qpXvhe9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8509E2D428;
	Wed,  7 Feb 2024 12:24:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2FAB72D425;
	Wed,  7 Feb 2024 12:24:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] commit.c: ensure find_header_mem() doesn't scan
 beyond given range
In-Reply-To: <e7b269ea-6a10-4f3c-ae97-a58eb7ccc6ef@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 7 Feb 2024 18:09:54 +0100")
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
	<pull.1652.v2.git.1707314246530.gitgitgadget@gmail.com>
	<e7b269ea-6a10-4f3c-ae97-a58eb7ccc6ef@web.de>
Date: Wed, 07 Feb 2024 09:23:58 -0800
Message-ID: <xmqqr0ho9oi9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AE8F1F82-C5DD-11EE-9623-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> -	/*
>> -	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
>> -	 * given by len. However, current callers are safe because they comp=
ute
>> -	 * len by scanning a NUL-terminated block of memory starting at msg.
>> -	 * Nonetheless, it would be better to ensure the function does not l=
ook
>> -	 * at msg beyond the len provided by the caller.
>> -	 */
>>  	while (line && line < msg + len) {
>> -		const char *eol =3D strchrnul(line, '\n');
>> +		char *eol =3D (char *) line;
>> +		for (size_t i =3D 0; i < len && *eol && *eol !=3D '\n'; i++) {
>> +			eol++;
>> +		}
>
> This uses the pointer eol only for reading, so you can keep it const.
>
> The loop starts counting from 0 to len for each line, which cannot be
> right.  find_header_mem("headers\nfoo bar", 9, "foo", &len) would still
> return "bar" instead of NULL.
>
> You could initialize i to the offset of line within msg instead (i.e.
> i =3D line - msg).  Or check eol < msg + len instead of i < len -- then
> you don't even need to introduce that separate counter.
>
> Style nit: We tend to omit curly braces if they contain only a single
> statement.

All true.  As we already use an extra variable 'i' for counting, we
can do without eol and reference line[i] instead, which would make
the whole thing something like

	while (line && line < msg + len) {
		size_t i;
		for (i =3D 0;
                     i < len && line[i] && line[i] !=3D '\n';
		     i++)
			;
		if (key_len < i &&
		    !strncmp(line, key, ken_len) &&
		    linhe[key_len] =3D=3D ' ') {
			*out_len =3D i - key_len - 1;
			return line + key_len + 1;
		}
                line =3D line[i] ? line + i + 1 : NULL;
	}

which is not too bad, simply because the original already needed to
know the length of the current line and due to lack of this "i" you
introduced, it used "eol-line" instead.  Now you have "i", the code
may get even simpler by getting rid of "eol".

