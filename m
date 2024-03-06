Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E7134BF
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690297; cv=none; b=SPPv0z6k+vEQo2FqMg3ykl1V01JMW4SVk1uZzBWRbyUZyFgP+QfsYhRYhO1aBTDVFCJVVwJFKppNdApjZ5XM5ZzEkficHIJ0Vx6XxLAv0S+2fO/7oOEJ/Ya6SD52+Btqe3fXxklNnPord7yIGkNHpjfp9u587hm/9YlXuN+B2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690297; c=relaxed/simple;
	bh=G/F8GJBued7D2P/RKa/qqVh14I3pbvQUmTlu5VYqeow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A6Vr90Btezm8Zx+BwBfzkhqfLmDscwVcY2yrjK7Nv/0rWhW9hm/4Do4PdkeCe+HCm7NDKvrr2b5NJ9xe5jO8QOvVVAAvkMjvj34gD612Q6DIXdVwXieAJKJI6FrO/opNhgUYKQEWVFop8wnwtVdx22TyYk2mpl03ENz8r0izaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AOyd1phg; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AOyd1phg"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ECD4919737;
	Tue,  5 Mar 2024 20:58:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G/F8GJBued7D2P/RKa/qqVh14I3pbvQUmTlu5V
	Yqeow=; b=AOyd1phg7wMF4otLe3aLTNLiHXWH5dTlRIszMBeX/wYc3gBsSi1mRX
	PJgA+xOKOr9wYXPFlcZ2bZ4N4t7yY79yQ5/MmgTFyyqRBKx4vqGrpoxYgsm9k9aP
	gVLutGSPD7qZ2BrvG6wRjMomQRDNi1ap+NzUS4CqvIJzVRRlxX3EA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E441419736;
	Tue,  5 Mar 2024 20:58:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E23A19733;
	Tue,  5 Mar 2024 20:58:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Atneya Nair <atneya@google.com>,  git@vger.kernel.org,
  jeffhost@microsoft.com,  me@ttaylorr.com,  nasamuffin@google.com,  Tanay
 Abhra <tanayabh@gmail.com>,  Glen Choo <glencbz@gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
In-Reply-To: <20240306012323.GA3817803@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 5 Mar 2024 20:23:23 -0500")
References: <20240305012112.1598053-2-atneya@google.com>
	<20240305012112.1598053-4-atneya@google.com>
	<xmqqwmqg38u2.fsf@gitster.g> <xmqqsf141pf5.fsf@gitster.g>
	<20240306012323.GA3817803@coredump.intra.peff.net>
Date: Tue, 05 Mar 2024 17:58:09 -0800
Message-ID: <xmqqzfvcunny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC886420-DB5C-11EE-BFA6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> There is one more, I think: if you _do_ free the allocated string to
> avoid the leak you mention, then some other code which was relying on
> the lifetime of that string to be effectively infinite will now have a
> user-after-free.

Ah, yes, you're right.  I completely forgot about that shallow copy.

> A few other things to note, looking at this code:
>
>   - isn't kvi->path in the same boat? We do not duplicate it at all, so
>     it seems like the shallow copy made in the configset could cause a
>     user-after-free.
>
>   - the "fix" I showed above hits your point 2: now we are making a lot
>     more copies of that string. I will note that we're already making a
>     lot of copies of the kvi struct in the first place, so unless you
>     have really long pathnames, it probably isn't a big difference.
>
>     But it possibly could make sense to have the configset own a single
>     duplicate string, and then let the kvi structs it holds point to
>     that string. But IMHO all of this should be details of the configset
>     code, and the main config-iteration code should not have to worry
>     about this at all. I.e., I think kvi_from_source() should not be
>     duplicating anything in the first place.

Thanks for a detailed write-up.
