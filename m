Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00C47A7D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053843; cv=none; b=FjvRhl6SuczpU/JhjPxrby97M4xD4CE4Sq7JNw4MEGgSy+DDc47y9CApYXhl+tkrTlT6oJqFetZijHlCF27cwISMm441hT5589KSyybv5y1eI59X6iOq7O77xYM838E4bokKW7Hep43YDxMRRZL1ljvyF6Vz1kcHtuB5NuWFvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053843; c=relaxed/simple;
	bh=+GRaIFcuCBJv/1sNoSLJ0fO546W+Ude7nGWj+MpLkLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eTEEq0sHpzGGUWfFTjqNcleMsOjulSUZVZ9Z6hydfEWG73T8ZkKLHp7GnAtXS8cEKRRLEf65QCAVNF0tw9bvUXdRHkRon2J0tsc1dkqcJjaYT2D2+tAVbc5CMrn+bsYFc5AYpUhyWlNKp0D10cF1UUW19goXKQ7bIeL9FgqRq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=haeOspWa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="haeOspWa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 94C5F241B8;
	Tue, 27 Feb 2024 12:10:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+GRaIFcuCBJv/1sNoSLJ0fO546W+Ude7nGWj+M
	pLkLU=; b=haeOspWaEJ0wGra2FeFD6fLz2IUGmKRly31VpUowIsGXKPtAzyePlV
	UbvnWWcz0228zf0R0y/tHI5/ALTS6/Dp5NFUoFdNowmR2lCbmsnLk5cdmmLdFUcX
	ZUyv8+PE0KU06RPpur52JnzU1FWVll0o05K+jzRSMw2nZhfYaGoxg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CF40241B7;
	Tue, 27 Feb 2024 12:10:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB0B1241B6;
	Tue, 27 Feb 2024 12:10:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
In-Reply-To: <Zd2eLxPelxvP8FDk@localhost> (Josh Triplett's message of "Tue, 27
	Feb 2024 00:32:47 -0800")
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
	<xmqqbk83nlw5.fsf@gitster.g> <Zd2eLxPelxvP8FDk@localhost>
Date: Tue, 27 Feb 2024 09:10:35 -0800
Message-ID: <xmqqedcxvnn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2088E6C6-D593-11EE-82DE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> I could add statefulness to wt_status_add_cut_line instead, on the
> assumption that it's the only thing that should be adding a cut line,
> and having it not add the line if previously added. For instance, it
> could accept a pointer to the full wt_status rather than just the fp,
> and keep a boolean state there.

Yeah, that approach also has to assume that wt_status structure is
used only once to create a single message buffer without being
reused, but I think that is a safe assumption, too.  The function
being the only thing that adds the scissors line should also be a
safe assumption in code hygiene standpoint---if somebody else tries
to manually write such a line, we'll shoot such a patch down and
tell them to call this function anyway ;-).

> I did run the testsuite, and it passed. I can add a simple test easily
> enough.

It would be prudent to do so.

Thanks.

