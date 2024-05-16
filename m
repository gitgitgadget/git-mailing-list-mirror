Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF215CB
	for <git@vger.kernel.org>; Thu, 16 May 2024 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892947; cv=none; b=Y8WvIbD8s0Qs5wy6cscQZRWBSIeq3Jfb6+9TnarTOIk5lwJ88hJcyqWL7N31M4c/Kzm3M4fkECxvsfrnTRJ0gwXQRdDz3a88c521mwIR5nST4M6RrJ4+ynxLaXiqW15pf3wR9WtGuLVrxWRfvdJzIM0PsNpSk80FigQqtOvA1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892947; c=relaxed/simple;
	bh=6yG2bOzu9QZzn1ddfONhF5olv0aD2+P3l/w9sFXnODo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXXGe2Gg8Y5q6osjlhkvCwnjTTS7XDawMLcGaOoORu+qfD9QacdLPUWgwp1NaD5xe9uY0TcnrTzBY/QGxbOmnzBvaFN/CXKBatANU3CLOmCG0kRXgZPIye/LgaBZB1iSev0L1IZKmNVs3D13dJXx9Sc5MJgYUN5xd6etgtws4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vl8B5qJS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vl8B5qJS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A1F2E22213;
	Thu, 16 May 2024 16:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6yG2bOzu9QZzn1ddfONhF5olv0aD2+P3l/w9sF
	XnODo=; b=vl8B5qJS2e/MGXVUKMCx3RLyMlf4Y9ketNcicfsZ47fhbB/W6M+4b8
	ZLtz8cqpgukdep1ICbmm6p1S/4WoWYea9rQ19XsrhYsH7Uv1Ro6dyRVsKibb1Kf7
	7jXqK29Q8S4K2XSwSgdLsmYRqvW5ShPGZOsWnP0/T21eGMYd/3Csc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A4D822210;
	Thu, 16 May 2024 16:55:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D45F22205;
	Thu, 16 May 2024 16:55:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/16] refs: move object peeling into "object.c"
In-Reply-To: <f03626ac0025050e49cad4057e6f3b3e7c7c141c.1715836916.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 10:04:58 +0200")
References: <cover.1715836916.git.ps@pks.im>
	<f03626ac0025050e49cad4057e6f3b3e7c7c141c.1715836916.git.ps@pks.im>
Date: Thu, 16 May 2024 13:55:42 -0700
Message-ID: <xmqqttixo4s1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A98B00BE-13C6-11EF-9624-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Peeling an object has nothing to do with refs, but we still have the
> code in "refs.c". Move it over into "object.c", which is a more natural
> place to put it.

Yay!  Very nice.

> Ideally, we'd also move `peel_iterated_oid()` over into "object.c". But
> this function is tied to the refs interfaces because it uses a global
> ref iterator variable to optimize peeling when the iterator already has
> the peeled object ID readily available.

Sure.
