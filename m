Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916C629E4
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549373; cv=none; b=DzZTJspRrz/4T/UiwCd9Emi+pcQRqnRdnH0ewXI3Gh8/1mCDrec1REMNuQrUo91umrYM3n/N0bGqU4+a4ZknjXmH31IYrttxqOUzLY0fTEC407MPt8DLUglZC2Wfl8/Dn5sxW5qQJokh8U9P0L4WsVpMCEEgokOGJwRVkixqUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549373; c=relaxed/simple;
	bh=tXEBExTYjbanNDzkVD8iLcDri1UOhnnd07GWWL5BJTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N2HB00i3wmXq89aEckWuryr0cUxj8XI1q4g3nSMuGvRD/B1f4sfVZyM8F/79UTPg1XLY4+RqbLgv7GABzTNMF4j6YO7RqXtvC6G70IglodDb1yS9aMD1THwvSxR+0bWuj8XtEnlqeI3HNgANyblLELm3McCinUhQIYlkdQ2+jls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UgpaE7vf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UgpaE7vf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C3442B92E;
	Thu,  5 Sep 2024 11:16:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tXEBExTYjbanNDzkVD8iLcDri1UOhnnd07GWWL
	5BJTo=; b=UgpaE7vfFWkoqWTDWwZXaQe5L9fKAWWnCx8F+fse7kvNux5yo3xEB4
	ayJvjjEEmSYejWelxp7wUeQSp1T63GSWC4Mv5R6JpZLos0LUSz3s4g6RZqT/WXbT
	FShL16mBoQ0jOLL8PCmbk0zpfMoamTM9L9aDIYxTfMInbHITXWitE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C1D72B92D;
	Thu,  5 Sep 2024 11:16:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 543D62B92C;
	Thu,  5 Sep 2024 11:16:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
In-Reply-To: <20240905082749.GA88220@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 04:27:49 -0400")
References: <20240905082749.GA88220@coredump.intra.peff.net>
Date: Thu, 05 Sep 2024 08:16:05 -0700
Message-ID: <xmqqle065dxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7896D64-6B99-11EF-B5E9-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> We do have to adjust the code a bit:
>
>   - we have to handle errors ourselves; we can just die(), since that's
>     what xfdopen() would have done (and we can even provide a more
>     specific error message).
>
>   - we no longer need to call fflush(); committing the lock-file
>     auto-closes it, which will now do the flush for us. As a bonus, this
>     will actually check that the flush was successful before renaming
>     the file into place. Let's likewise report when committing the lock
>     fails (rather than quietly returning success from the command).
>
>   - we can get rid of the local "fd" variable, since we never look at it
>     ourselves now

OK.  The neessary change is surprisingly small.

> I found this because I was building git on an Android system,...

Sounds like fun.

Will queue.  Thanks.
