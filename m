Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934A1CFA9
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361728; cv=none; b=nt1/82f39Rxkxz/D0BTdnRFJVeiOnvLfTwqh8OnFBJ9U7k2pwey+j8olG+/8SdgfsWa9RJg1Rk/BcBxulAxcgLyBP7bCWJS2NHZgAjR40KzVlmoWW7IMPoc2OSYtfL/pWuTGuuA2r0fURSGc8nbuxgJ7KOu6Nx+so63/iassWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361728; c=relaxed/simple;
	bh=Arsatqn15SX23ShrFbccifSdlF5pxSfl3ueKXHHan0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLhI6ktOuFuT0rprzEi6O6AXct5GLHeof3wHdFR1bpt4yuVqVUYNBEhYTI5fMXFSDIciY7Ntq3hH5F849KbcpyVRHiDOgxXNwZwX7ZohPIhtEeYSWf7lCCFsnBklFI20V5W9i0c++uYnQYp2IM7OYAWN/EFCE6iMbzlerRDpOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=adEXK19T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="adEXK19T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93BBE1DC187;
	Wed,  7 Feb 2024 22:08:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Arsatqn15SX23ShrFbccifSdlF5pxSfl3ueKXH
	Han0E=; b=adEXK19TUNY6SyUEhkrW/nPZVRIcw0aB4m7WnPfARoYKmEycU7M5ax
	XX3ebqEK9KX5eV3kUw/l2HsPOLCl0NHGEovDoy9XbwZR4l7aJrj5iWKC6vxWeTZd
	fDGSdlRSgEALiRtgDx7ny0K3+ScOqdLwYKHn5QTAGC8O4opmy74kY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AAD51DC186;
	Wed,  7 Feb 2024 22:08:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E53551DC185;
	Wed,  7 Feb 2024 22:08:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Sergey Kosukhin <skosukhin@gmail.com>
Subject: Re: [PATCH] tag: fix sign_buffer() call to create a signed tag
In-Reply-To: <20240208004757.GA1059751@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 7 Feb 2024 19:47:57 -0500")
References: <xmqq4jek9ko1.fsf@gitster.g>
	<20240208004757.GA1059751@coredump.intra.peff.net>
Date: Wed, 07 Feb 2024 19:08:37 -0800
Message-ID: <xmqq5xyzr6tm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B1EC828-C62F-11EE-A509-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

>>  * We alternatively could fix individual sign_buffer() backend that
>>    signals an error with a positive value (sign_buffer_ssh() in this
>>    case) to return a negative value, but this would hopefully be
>>    more future-proof.
>
> FWIW, I would have gone the other way, and fixed sign_buffer_ssh(). Your
> solution here is future-proofing the tag code against other
> sign_buffer_*() functions behaving like ssh. But it is also leaving
> other sign_buffer() callers to introduce the same bug.
>
> Your documentation change at least makes that less likely. But given how
> much of our code uses the "negative is error" convention, I wouldn't be
> surprised to see it happen anyway.

Yeah, but other callers are prepared to honor the current return
value convention used by gpg-interface, so "fixing" sign_buffer_ssh()
would not give us any future-proofing.

We could do belt and suspenders by tightening the other callers to
only expect negative for errors (but then what should they do when
they receive non-zero positive?  Should they BUG() out???) while
teaching sign_buffer_ssh() that our convention is to return negative
for an error, of course, but I am not sure if it that is worth it.

Thanks.

