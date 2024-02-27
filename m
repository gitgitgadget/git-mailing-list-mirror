Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE2557F
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055805; cv=none; b=B7mPhVndJ9vxXn71wwJ01oinPtDM6JEuO6rPGmSPot9v2BvAws4AF/y2iPeigHiTcqdDmatYDBDmdDXvYUhyV81uhU5ZVBdqcssB0+Qbu48PGMqnbDMB5/QtH6oetlJwydh+47EXW7pXfbTFQ5tRu7A24TdWUPsN1GKf1RO1hzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055805; c=relaxed/simple;
	bh=ryVsnWgSqF1XP1K9W2f5FaWXG9wtrodl8BB82E1HAng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A09hWdYeA1F6TpZ/rG+z9fYOvggNUpSCotv80C3J65RS5Fvhyk3vRwQO10jByCygote+GFVKs/5yAYMkTxVmMvcbuuaa4XltIkITSNzzDly0TmFFNgPLAloAnbG9HMIRfSPTA/rA4GovGdetTMj44lwYx6YNf2cKjinQK4dOIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ur/vs6nL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ur/vs6nL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8AF91DCC16;
	Tue, 27 Feb 2024 12:43:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ryVsnWgSqF1XP1K9W2f5FaWXG9wtrodl8BB82E
	1HAng=; b=ur/vs6nLWrbxrj8GQC+2NJjBPwjHs/+QgRlSUJ3dZQiRsc3X+AzDsf
	BbexhWrCVXDR0NCQ7fn8ekaZJsVT6mhP8VIUTpXbTdNLL8E5lrxmk53v1WwZLLIM
	4HRNrcTQfGgRps4owxFhi4zv6kQZ3g/rBjp07qfGKMH1XJlasIUlg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B16951DCC13;
	Tue, 27 Feb 2024 12:43:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 290571DCC12;
	Tue, 27 Feb 2024 12:43:22 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
In-Reply-To: <4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
	(Josh Triplett's message of "Tue, 27 Feb 2024 01:16:09 -0800")
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
	<xmqqbk83nlw5.fsf@gitster.g> <Zd2eLxPelxvP8FDk@localhost>
	<4f97933f173220544a5be2bf05c2bee2b044d2b1.1709024540.git.josh@joshtriplett.org>
Date: Tue, 27 Feb 2024 09:43:21 -0800
Message-ID: <xmqqjzmpu7k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3698B7C-D597-11EE-825A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> diff --git a/wt-status.c b/wt-status.c
> index ea13f5d8db..2d576f7a44 100644

I do not seem to have the preimage ea13f5d8db; as a bugfix patch, it
would be preferrable to make the patches not to depend on anything
in flight.  If feasible, it may even be nicer to base them on one of
the maintenance tracks.

I managed to wiggle the patch in (somehow a context line was
misindented), so there hopefully is no need to resend.

Thanks.
