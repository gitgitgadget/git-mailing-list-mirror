Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA964DDA1
	for <git@vger.kernel.org>; Wed, 29 May 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012925; cv=none; b=mGG97mD71YF2cTsKqLIr7lCpqPY5CtWdCtYLpMcbKutLXKQWpyOtDZdBgjYV3xLwfeqcxLyibYmiJDM0w2rSJ6f2lI0PFn4kkY02mJQF+bi8r+0OhTagfzvJmHWMxVg4oKrIbgXoBiD8jrOiBNcmT+0bTXXGg+VQ9/gaMy4UZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012925; c=relaxed/simple;
	bh=+DY8XsI/cB8HQZ2QexT3pA3IMoNY105eg0dnRI4uStA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dxUl1Y4ejgEV9kkPbVfw7XEZlxppHw6UMWhGMauT1kPyR6iMziLSA8KHL58lc+h2+qTKwlli6wJbHFCcXuMDQsnVIKB83m4o2I1KbRBfJfGqLPmvustuRYtRoqmrmBlgKkfCS02e25JLQw5kAvKxhAPStjdGCFrY/vVxaxU7V/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aWgLnynG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aWgLnynG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 595542BC4E;
	Wed, 29 May 2024 16:02:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+DY8XsI/cB8HQZ2QexT3pA3IMoNY105eg0dnRI
	4uStA=; b=aWgLnynGnhGp3Pr1DBoqYnRq3PwNxjEtmSJaZc2Aj/5cawx7NFcKz+
	tK3RfSQraYnh0b/sUmARl7R9JtDKxIzFpWx8fnUXz/vayvQsW3JnkiV4TXU47wKY
	8+aLHRulIIrSUdwplJB6r2UHiPcOcHBUd46gJ+Wf1BvEJLxizaHyU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 50E352BC4D;
	Wed, 29 May 2024 16:02:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5296D2BC4B;
	Wed, 29 May 2024 16:01:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/19] object-file: make `buf` parameter of
 `index_mem()` a constant
In-Reply-To: <6cbb8444a6dabb883ac3b0e450c0bfbd17b58bea.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:44 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<6cbb8444a6dabb883ac3b0e450c0bfbd17b58bea.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 13:01:57 -0700
Message-ID: <xmqqmso8wfnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4ED5469A-1DF6-11EF-9EE4-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `buf` parameter of `index_mem()` is a non-constant string. This will
> break once we enable `-Wwrite-strings` because we also pass constants
> from at least one callsite.
>
> Adapt the parameter to be a constant. As we cannot free the buffer
> without casting now, this also requires us to move the lifetime of the
> nested buffer around.

Makes sense.
