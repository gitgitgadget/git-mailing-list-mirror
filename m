Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA16F2EF
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167909; cv=none; b=oqn3WlLluEQ75/77wSt1lYeMPVXlBHZuQcFInc6iNJkxULRc2PJTnUJe2YmbouUaLk+Cj2HlPFNKcSTEQ601UChBtjldZ1I7YsO3KQjBN2QC94KbElXvTajTUmjgpzm62yQ0N48YhwqbVgFMCZB6u1qFFWfXQ1Nv9S55vQlJoMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167909; c=relaxed/simple;
	bh=RXjvElIceM33y4V9fSkaj+WP7i3z7NSfFGO6MV3nvp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kWBK7+BpPyArv0aq36P5fb8ByQUWJeXs29nXRuPUyk7PknIUVqvKqj+yu9p+xcDKqX3IFHOjJ56mE/wTH7n2a0oyMskrngl+5vb+92FWAI6HQ1TH6nusaIRbG4pLbiSHXK16Dbbzo96qhJdBNQHqqtFYNJl6rECHd9SGabhP12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C/to6+UB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C/to6+UB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B248F33F26;
	Fri, 31 May 2024 11:05:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RXjvElIceM33y4V9fSkaj+WP7i3z7NSfFGO6MV
	3nvp0=; b=C/to6+UBY+b6qDTg+6svMOG8lL4i9WiwJlOvFeT2CswL2nB9onu7uZ
	xrby53BHgrnaUgilbN/YyDsIvTL3RAPmQRXoaq6TdFleuBkXG0cQGvtd/mJgyAfb
	1M+YQh4KWLsY8o4FG+ZJbWmkYxqsEAFRrRA7PrsogUWy+aeZVUr+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F5D233F24;
	Fri, 31 May 2024 11:05:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 92AD333F23;
	Fri, 31 May 2024 11:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
In-Reply-To: <20240531120034.GA442032@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 08:00:34 -0400")
References: <20240531120034.GA442032@coredump.intra.peff.net>
Date: Fri, 31 May 2024 08:05:03 -0700
Message-ID: <xmqqh6eehvj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 29D9042A-1F5F-11EF-ACCA-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> The "int" in question is in add_patterns_from_buffer(), so we could
> catch it there. But by putting the checks in its two callers, we can
> produce more useful error messages.

Nice trick.  I wondered if we want INT_MAX/2 or something even
lower, but because once these things are read, we only parse the
contents so allowing up to INT_MAX is fine.  It is not like we read
this and that and concatenate them into a larger buffer.
