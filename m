Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584617BA4
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 19:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717873591; cv=none; b=hOspC0kcnl+lfaX4UuuFHjwiDFqgnYZoRFcx4AzLqbtaoFcdqHQZTbq2P7lyKKuhv4gJTTPlAy6JoDp90xwFemXorCw4V44gozJXvyLPO8+1RpDE501iGxAFoUlhPjo2NgdqkeEZK7nLmjxXah3N4BhyDEewdBqbgw4ZT+96kFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717873591; c=relaxed/simple;
	bh=BWvbvsdnFFMFAZajfWiROiwDMx2zvHmiGljKhgG9NZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJvg94D3TdKTXGl3M0VL469VhbrbG65rnwx2s0Kmoy6K9LknZtaBBP3ajTde9r7P2jo5bp1wf62W94W6xqubAyf8LL+4n+4Ta3iuiC2QlvwSWl1UBD+rWmtBxq4dxwrKovQ2ptSHB2RQ6+crqyrQaCsuc0J1oO9WhhZPKhEP5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rBe4hmFK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBe4hmFK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7941B38F2D;
	Sat,  8 Jun 2024 15:06:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=BWvbvsdnFFMFAZajfWiROiwDMx2zvHmiGljKhg
	G9NZY=; b=rBe4hmFKPN8lPDUxntI14L7QwxPutanujXeL5+mH5sY0vI/8N4qBP7
	G2THZMnxiXDKw7rPg4BGSnjWYPps47Whz8Vq+qfabvyirncyXoSHqPJY+20e9mur
	OmGLWrM8yY0dlNY950fdXBTFBkJmh7K6yu+LU4HbtlFIat95ZZuac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E64D38F2C;
	Sat,  8 Jun 2024 15:06:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9D7E38F2B;
	Sat,  8 Jun 2024 15:06:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
In-Reply-To: <20240608113621.GE2966571@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 8 Jun 2024 07:36:21 -0400")
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im>
	<1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
	<20240605100318.GA3436391@coredump.intra.peff.net>
	<xmqq1q5buxzx.fsf@gitster.g> <ZmFAQ1UT6ePxHtzq@tanuki>
	<20240606070109.GC646308@coredump.intra.peff.net>
	<xmqqwmn2nko9.fsf@gitster.g>
	<20240608113621.GE2966571@coredump.intra.peff.net>
Date: Sat, 08 Jun 2024 12:06:27 -0700
Message-ID: <xmqqzfrvb6fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 35DD325C-25CA-11EF-B3BD-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Possibly I should base my daily driver branch on "jch". Like you, there
> are many parts of the code I won't exercise day to day. But it would
> mean I'd do more testing (and CI) on those topics. The big question is
> whether that would introduce a bunch of noise from not-quite-ready
> topics being merged to jch. It depends how careful / conservative you
> are. :)

I am not all that conservative.  Especially with the parts of the
system that I do not exercise myself.
