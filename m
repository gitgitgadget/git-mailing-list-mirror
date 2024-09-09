Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8116D9AF
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901151; cv=none; b=noSx1h2rDVoWkOCx8uNMm+yi2XZkDJFLQyzV7H7NUOT3u7Chlgo+ciAtYHfdSCORF7Upx1EsdMjS8EhGeMJ330lmFkvD3aNK9Vmkp+y9UeOYZAF0ZIdaGuE6TK4o9VVYsTGKXH57uiirkuAOHNl8bWVLKnVyV1o8qGYNyjyKtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901151; c=relaxed/simple;
	bh=CrAGS0mc6fKDjZeGQqplCnubcCGm6bqYh57al+9Tq8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KgqdluNlmd3ko1MdT1Z2eqpDa5p0M12ePU5uLPWukvWIwRqyc5yrBFiW7YSbwujxDpYDPrE45PJ2/RUHpRQxs4LvNHPMVNg6vG6jwy50JptwReLBvbLhY+bBIFoJ7DFE52MfK4i02k1osiMmAiBlnkR566x3cxeRF7AEmu61ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uFN7v0XX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uFN7v0XX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 610031FBFB;
	Mon,  9 Sep 2024 12:59:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CrAGS0mc6fKDjZeGQqplCnubcCGm6bqYh57al+
	9Tq8w=; b=uFN7v0XXfrvIeBGawYQg/RyNQLfK44jZ38M1VzFzj9m/73W2stDw1p
	4r1KijtkU0zF4VFM1Xr5kvSwpZLPrNszQ2i9fk3D+zh8tYfwDGh6csC11M3mYbNU
	RK3HweWVEUho9SZZjFW8Xt5HUqP+4z21we5uoNMBH6bQMTG2ToU+Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 55F3B1FBFA;
	Mon,  9 Sep 2024 12:59:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76FB81FBF6;
	Mon,  9 Sep 2024 12:59:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Jorge
 Luis Martinez Gomez <jol@jol.dev>,  David Hull <david.hull@friendbuy.com>
Subject: Re: [PATCH 1/2] diff: report copies and renames as changes in
 run_diff_cmd()
In-Reply-To: <b4ce7873-3dfa-443c-847c-64200fd065cc@gmail.com> (Phillip Wood's
	message of "Mon, 9 Sep 2024 16:16:06 +0100")
References: <130d4803-2818-4611-9258-951a18dd5717@web.de>
	<b4ce7873-3dfa-443c-847c-64200fd065cc@gmail.com>
Date: Mon, 09 Sep 2024 09:59:05 -0700
Message-ID: <xmqqseu8sqzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D440943E-6ECC-11EF-991A-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> which is inconsistent with the quicker one.  Fix it.  Even if we ignore
>> the file contents (because it's empty or contains only ignored lines),
>> there's still the meta data change of adding or changing a filename, so
>> we need to report it in the exit code.
>> d7b97b7185 (diff: let external diffs report that changes are
>> uninteresting, 2024-06-09) set diff_from_contents if external diff
>> programs are allowed.  This is the default e.g. for git diff, and so
>> that change exposed the inconsistency much more widely.
>
> Thanks for fixing this - both patches looks good to me.

Yup, thanks, both.
