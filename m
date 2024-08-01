Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAE13699A
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475729; cv=none; b=CM2u02s+b7j2LNxtLALn9JreaPa5KXrAYMila5jkaoBSjY/CyI7D//2bIcgHooowRTHUyYFhYefZHDmjDP5a/pJ7pjhK0MEFSpkiRnSAim385axUP6IEaIFXXg5ITu19KVQeuG+PwZCPKv+doyNAEddE9MszDL497BBxwqgrR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475729; c=relaxed/simple;
	bh=AmU+8jPtfy+bgfvciCopNvativYS0+I3VCdCYzpLvAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S1SSBcZmywxox/CsSPWvU/q2kFh9VkPGhxmvhCcsEgpKFPpyDOjnGpISnqJxxpJvksi8H+MiTGjdI5mTn2pohQnooS5s+2Y4BqYIF2cojzugtxRg18IWywTmyE/LmnbL8lrqp0QAJbNtotSO0r33hAnSGoWIUMpxa7dgaE/ZFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FmswluUj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FmswluUj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64E263DBC5;
	Wed, 31 Jul 2024 21:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AmU+8jPtfy+bgfvciCopNvativYS0+I3VCdCYz
	pLvAU=; b=FmswluUjAoIgKhU4osDblOikDKwAC2/E9VRKUSb8FhVu5KPZAcXRHZ
	Pg+11FZebtuVIHlXTKUk1rEkkLAQLnAkOAG2v/rVBVTiL8qV246ny146sF65FdN6
	ykxJcv/YBdPV3SwlJS6G5gC4BprFEo53R+UKV0GR2SMp30XZSQnLc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A3603DBC4;
	Wed, 31 Jul 2024 21:28:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C77DF3DBC3;
	Wed, 31 Jul 2024 21:28:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: git config set --file, key-value pair without '= value', gives
 Segmentation fault
In-Reply-To: <ZqrKeG+alFldB7OY@nand.local> (Taylor Blau's message of "Wed, 31
	Jul 2024 19:36:34 -0400")
References: <CANrWfmTek1xErBLrnoyhHN+gWU+rw14y6SQ+abZyzGoaBjmiKA@mail.gmail.com>
	<ZqqucpNgqSgZDPtA@nand.local> <xmqq5xslyyaf.fsf@gitster.g>
	<ZqrKeG+alFldB7OY@nand.local>
Date: Wed, 31 Jul 2024 18:28:45 -0700
Message-ID: <xmqq1q39yqsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65D38A9C-4FA5-11EF-AE72-BAC1940A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I tried to match the behavior a few lines down in that function, where
> we only call regexec() if value is non-NULL.

Yes, that is exactly what made me question the code.  With the
current code, valueless true cannot be updated with "--value"
restriction, ever, because it will never match anything.

In any case, the patch is a strict improvement over the current code
that segfaults.  Making it aware of "--type=bool" and have it treat
synonymous values of true/false properly would be better left as a
follow-up topic.

Thanks.
