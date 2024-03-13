Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BC4CB47
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352100; cv=none; b=YklfpZ3IF2y6zJ/ZmiCCs9VvYRJLgzWaRztniXDfKVl/faLTDx2LhUT76la8Z0+6sWKGriJVzcoIQ/QCZvYy9XJnJx7rXxuj8nFfoFWJSLYkTXZvK//RIbNzM/FCmlZ9+xQcTD2LJgOj5wKvPk6quZ1BCm84EXBBamhumrJ9qZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352100; c=relaxed/simple;
	bh=WE6QxMrDzldBDXVvrrnZMlQcO1COzRQNAg+ROTZJuTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCtCgvmqTA5amWesvJzoD6d86iEzfmEAyWELAlE+4Rao8g7D1bJY5DMqzk0pPQGexW28ChHmbAwoWlP76hP1qDwODL98wpxG1EuPNeSto1iVErO4tw76jyc+kDtRTYgYzw01oJSOIU91drDG4PGoxp/eiFzk4/yIwYIlkujek0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xIYDssTX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIYDssTX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AD34919F8E;
	Wed, 13 Mar 2024 13:48:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WE6QxMrDzldBDXVvrrnZMlQcO1COzRQNAg+ROT
	ZJuTI=; b=xIYDssTXzzthNvxZcuEAj4/q0BBVrsxzx/iTE3PVWS6x6rIydx7Tby
	JKeWehxgRltGwWBIFTgibUCT+08592K9CHqorcqpyGUs9FSsIj/+9bDyfovwY0hz
	wM6wU7JlK54PU5mXB03nSuLOe7O0qBkBpNz5KEhIAwV5yh4yO8wR4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A640A19F8D;
	Wed, 13 Mar 2024 13:48:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54F9719F8A;
	Wed, 13 Mar 2024 13:48:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] parse-options: factor out register_abbrev() and
 struct parsed_option
In-Reply-To: <ZfDMhJ4r5g-g-B3n@google.com> (Josh Steadmon's message of "Tue,
	12 Mar 2024 14:43:32 -0700")
References: <20240224212953.44026-1-l.s.r@web.de>
	<20240303121944.20627-1-l.s.r@web.de>
	<20240303121944.20627-4-l.s.r@web.de> <ZfDMhJ4r5g-g-B3n@google.com>
Date: Wed, 13 Mar 2024 10:48:13 -0700
Message-ID: <xmqqil1qc9b6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DE5AB6BE-E161-11EE-A88A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I found this change to be hard to follow, although I'm not sure anything
> actually needs to be changed. Thinking aloud below, apologies for being
> verbose.

Thanks for carefully following the code.  It unfortunately has to
get long, but this is the kind of review that I would appreciate
most if I were the author, pointing out what is easy to understand
and more importantly what is harder to follow.
