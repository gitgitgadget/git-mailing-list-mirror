Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242A46551
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363176; cv=none; b=C3LV59InVc85VaX3ZzUsqtYAgan2djoRshg27HMaJOjNUBzNuRkHO25BqVlVQ21I60pxihUqUcDWjcHaD49UaMYJMJ/RfKJ0dstKc9n7r9wZ49Zla0magvPqTfvOtb2jzpkcxdBsaBW6cDGg2eOJJnhicsyMeLJ/qQwCDfJSSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363176; c=relaxed/simple;
	bh=jAjGMK07G4euA7Zi/aBBLvTtxcwb4ZOoaDp2B63xQHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgzqQVLFXcusuymZseGBrEe8+Lb/N68bhvGfH57eZzwwNa381JXVikOBIcJSk46t6SbUDGtqsHXNpnewC+q3MN0Nwb52oS/Sbxbp37VC5Idr3Bip9sOT5+6x3wIUN11yc+xibP5cOdquHYaah2FvADnmFYaYaJA6WdryfPaHlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KcPAbooN; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KcPAbooN"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E82D11D0E02;
	Mon, 19 Feb 2024 12:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jAjGMK07G4euA7Zi/aBBLvTtxcwb4ZOoaDp2B6
	3xQHA=; b=KcPAbooNNakEmOmyiIJ+QdBEEh/FQcpMdSx9HkI+FmrZMtRZAQ9Tfn
	Wklvq/jDvd+Zid042QCZ9tQ80PDPKITcD4VpilKMD/Irw4fYqWIhECnYvzDbbfGf
	7oFpQ+O4kjuva4Z4ALBTKlCmZ1KxGkr/JLJQN+Lrmsn+RyXLvDJ0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFF7A1D0E01;
	Mon, 19 Feb 2024 12:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C2901D0E00;
	Mon, 19 Feb 2024 12:19:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Beat Bolli <dev+git@drbeat.li>,  git@vger.kernel.org,  Philippe Blain
 <levraiphilippeblain@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] completion: use awk for filtering the config entries
In-Reply-To: <aa3e36a1-52d3-0c15-b70b-83c6664757f5@gmx.de> (Johannes
	Schindelin's message of "Sun, 18 Feb 2024 22:58:20 +0100 (CET)")
References: <20240216171046.927552-1-dev+git@drbeat.li>
	<xmqqr0hcjorg.fsf@gitster.g>
	<4a1d3618-cebe-4c20-89ce-c5dab51af21a@drbeat.li>
	<aa3e36a1-52d3-0c15-b70b-83c6664757f5@gmx.de>
Date: Mon, 19 Feb 2024 09:19:26 -0800
Message-ID: <xmqq4je4e5i9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08DD7666-CF4B-11EE-9E3F-25B3960A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Makes sense.  I wonder if we can have some simple script sanity
>> > checker that catches things like this, e.g., catting a single file
>> > into pipe, grep appearing upstream of awk or sed, etc.
>>
>> Yes, there are quite a few cases of these in t/. I'm not sure if it's worth
>> the churn, though. At least it would make the tests faster on Windows...
>
> Thank you for caring about the speed on Windows!

Yup, that is why I asked ;-)
