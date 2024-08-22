Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75411DDF4
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343436; cv=none; b=ehyVsVqvwdNtLr5gU34thgxVj2++0vZzxR0blK4AT6kZhHt61tJ8LMCrVp1s/s97mU2WQP9VOK1pZinBg9JmuXcniLJ0y5to6e2ubMX6MOoh592LY2KvS/D2u4WPtEj4vehyFXx4seKeakoYyLs9Tha7VeJeTNY8x1Ep4uIzb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343436; c=relaxed/simple;
	bh=OU3NaEGYgH+iy8C+K0r567iyCrPajjNQovSUKtazVpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gwaKNaUf3P4ae+XYVo30rIduWJklwRBHNax40CkTsg4N0KGqr7Mz3Q89pdJiekzKAvfHrtelp32MAgHtNal3MMSAU9OjRhhaQmfCB2rdgBPEYcWTxdNECN4CofFOOzln9/CH3VsIApq9RPuLIM793HV/1sNTEG8aQpWMfT9RKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SsjBr14s; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SsjBr14s"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 359EF1F610;
	Thu, 22 Aug 2024 12:17:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OU3NaEGYgH+iy8C+K0r567iyCrPajjNQovSUKt
	azVpc=; b=SsjBr14sLVKXt7Cw1x418J7ooVG3msR652DrDGvn0HZUp9xkXLm+5T
	Lmb+pm6pR5p3/XFGIyzEaueft/dEXVIzAOLMaHloO1UnONgswT7tbA2Az6bsl5wN
	eKZHXbZUicsqGO7aSobXTdo6lcxKHGbPQmGpYeFWhSb+nTD1LmIus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DE1A1F60F;
	Thu, 22 Aug 2024 12:17:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B8701F60B;
	Thu, 22 Aug 2024 12:17:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <xmqq1q2gtu19.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Aug 2024 09:13:38 -0700")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <ZsIM2DRDbJsvNjAM@ArchLinux>
	<xmqqed6j9m24.fsf@gitster.g> <Zsb64NTyqc_oHNFO@tanuki>
	<xmqq1q2gtu19.fsf@gitster.g>
Date: Thu, 22 Aug 2024 09:17:08 -0700
Message-ID: <xmqqwmk8sfaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBE578BC-60A1-11EF-8346-BF444491E1BC-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> So any reference that contains additional data is not a proper ref and
>> thus should be warned about from my point of view. No Git tooling should
>> write them, so if something does it's a red flag to me.
>
> If you find such a file in $GIT_DIR/refs/ hierarchy, because our
> consumer side has been looser than necessary forever, and we never
> have written such a file ourselves, it is a sign that a third-party
> tool wrote it, and that the third-party tool used our reader
> implementation as the specification.  That is why I am hesitant to
> retroactively tighten the rules like this patch does.

I forgot to add my recommended course of action, without which a
review is worth much less X-<.

I am OK if we tightened the rules retroactively, as long as it
starts as a probing check (i.e. "info: we found an unusual thing
in the wild. Please report this to us so that we can ask you for
more details like how such a ref that would violate a rule that was
retroactively tightened got there", not "error: malformed ref").

Thanks.
