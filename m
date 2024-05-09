Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594A16F0F9
	for <git@vger.kernel.org>; Thu,  9 May 2024 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269625; cv=none; b=kim8P9CJ9IpwQGm7RJQsG6jBY9lOtVsTVnPRCPk68IpkJWPSChtrvZJ6mHwJaRAgbbufF/Vj1LEDZkJfmswWTF7kJbgI299RH22Iq0UaBqQSyiSQ16wp0XQgIiNlJCpNV9IJyl8kPTpwPFIhIlYC6kKAhm7NKdZKqmpcxj8VWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269625; c=relaxed/simple;
	bh=xT/91AD9g53Va1RqYDtC4ejNvH0yYa9QCa7Vg/UyRUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mEg3mWpWCxqieJ8j9La5ECM4D8XSkwBKplCI6XRHQq2RKH+hIVM+UIZan9GxznKdCkD0jBnJyNwk03f80sMpdXucJRhwUp77+IkvW3ODN0P3AM/3yRhd032LQ2Akj4uGklsudsfs/UMNnaE1aK0PbVnDNfa3rFM/TiQVlxXhMoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YCSsYVu9; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YCSsYVu9"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E0F192C44D;
	Thu,  9 May 2024 11:47:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xT/91AD9g53Va1RqYDtC4ejNvH0yYa9QCa7Vg/
	UyRUA=; b=YCSsYVu9OCooZ3REy9eH/SGTKAVb7lGfYETXgo0/Vav9tBVsEmlw0q
	ODwNET9A3ovbVBOjvsfWL9EKhCSZPIyXbH3g7MM2SpYXRB0LRx/rsO1HoHWfgs5E
	rZ7wyZMfN2M8RYu9R5vVnaYEqcN7y0W0kbjkwjEjnfDyLAbaM1/vU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D9A7C2C44C;
	Thu,  9 May 2024 11:47:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 694BF2C44A;
	Thu,  9 May 2024 11:46:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: fix installing dependencies for fuzz smoke
 tests
In-Reply-To: <5a92a4aa9edd9653df71b284f07461c7906f97e2.1715241343.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 9 May 2024 10:25:27 +0200")
References: <5a92a4aa9edd9653df71b284f07461c7906f97e2.1715241343.git.ps@pks.im>
Date: Thu, 09 May 2024 08:46:56 -0700
Message-ID: <xmqq8r0jvvgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E852D66-0E1B-11EF-BBAD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There was a semantic merge conflict between 9cdeb34b96 (ci: merge
> scripts which install dependencies, 2024-04-12), which has merged
> "ci/install-docker-dependencies.sh" into "ci/install-dependencies.sh"
> and c7b228e000 (gitlab-ci: add smoke test for fuzzers, 2024-04-29),
> which has added a new fuzz smoke test job that makes use of the
> now-removed script.

Ah, I should have been more carefully paying attention to what
happens in ci/ directory (which I have largely been ignoring).

Thanks for fixing it up.
