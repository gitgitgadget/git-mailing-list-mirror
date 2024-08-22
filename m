Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C96182DF
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343225; cv=none; b=nkwvEugmz/KzMTLFMk97jJjZqpoTzcrkIttx22eJBOx5qfM8AAiIbFedQKN9lIw18KTnMIQolP0dki3ZoEyLKrHIYw5rCDUDVJMoQcJR8HfPe5+kaFzKPqbFwb2CBym5UW0mqf10nqq8PjxzNF8CUyb5UVnExFkEcvZZSopSylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343225; c=relaxed/simple;
	bh=GcVICZqTAmD74NJeyQTKhsbrGHBcpvp2SsEuqSgj3I8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6agy5F7tcBBBrUge+2z5IsdNILNhIu8wxUl6scZKoxhx7tN2IeYKfy3y8pFPfbyFg4OgNGKIzP3IL3u8f3QIzOADHl1DZ6v/AXrzOCdciYDjQmLf+VOU6qFipmxy9/ZvNhMMeT5fjmaTuh6nXYhP/WhHc8VEssE/ZA55XKxloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bJskxUuY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bJskxUuY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 921051F5B0;
	Thu, 22 Aug 2024 12:13:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GcVICZqTAmD74NJeyQTKhsbrGHBcpvp2SsEuqS
	gj3I8=; b=bJskxUuYL9jLr5CwH0peZgxec6lE5N9wDmD3QddS0Fak/HUwvA/hvJ
	fIKcPiK7qNUqGM+lmpL438uf2J5k3CJD3Oxlfh+yzI+AZslWpbJKOD/DtXaL4RkN
	wXaz8ID74/Z4RSlF5L0g+OGA43D4oKOMThxyHD4BCEtalFBwf618g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A1C31F5AF;
	Thu, 22 Aug 2024 12:13:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 196C91F5AE;
	Thu, 22 Aug 2024 12:13:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v1 2/4] ref: add regular ref content check for files
 backend
In-Reply-To: <Zsb64NTyqc_oHNFO@tanuki> (Patrick Steinhardt's message of "Thu,
	22 Aug 2024 10:46:31 +0200")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <ZsIM2DRDbJsvNjAM@ArchLinux>
	<xmqqed6j9m24.fsf@gitster.g> <Zsb64NTyqc_oHNFO@tanuki>
Date: Thu, 22 Aug 2024 09:13:38 -0700
Message-ID: <xmqq1q2gtu19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E90D6E0-60A1-11EF-855A-BF444491E1BC-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> So any reference that contains additional data is not a proper ref and
> thus should be warned about from my point of view. No Git tooling should
> write them, so if something does it's a red flag to me.

If you find such a file in $GIT_DIR/refs/ hierarchy, because our
consumer side has been looser than necessary forever, and we never
have written such a file ourselves, it is a sign that a third-party
tool wrote it, and that the third-party tool used our reader
implementation as the specification.  That is why I am hesitant to
retroactively tighten the rules like this patch does.

Thanks.

