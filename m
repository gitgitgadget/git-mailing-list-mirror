Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF57F7EA
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413593; cv=none; b=RuCpMnFUsEOaQvqSDfgKC18HqKiK6b20AJ2C6HEAUFuca9tI7ypuouR1QzmKmhy6YOjsBCqPeU+y0UX93Yp+vygaQHPeI9bRsJB2RP8S2ou9nquBg2pYy2TxY21wevCwP0oRSpgRd2hNEKCpgdYbGVyj72j7JYcjxtihG7y0JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413593; c=relaxed/simple;
	bh=1r++o9wWx7QVg10vbs6HVuJow9IXLvXKIengSCLzLP4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XW0/VlBmcIWb0QW7+CK3UoxMqBrFFd8QeSYJhIZVKSXvyRj4THltCmqRHWbKwlFuKTSheF9WZ7tQg82j9BdYCAUuxN++v04TGCVkgYPoSxACp92QjuxAZdhOvVpbgodnIpiPYglNPXbMiVWXdKCFrkzKsmHvo0rzMDffFLddtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wlbqOnEb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wlbqOnEb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A49261E186C;
	Thu,  8 Feb 2024 12:33:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1r++o9wWx7QVg10vbs6HVuJow9IXLvXKIengSC
	LzLP4=; b=wlbqOnEbDo2WYRrnyU5QhZnb35M8+8tLdi0Y9r5G2SJ9cpkWZB1zZ0
	A62/rZn5fwp4d0wV7rOt8ACvdB4ReSZoZvpkRD4fGXizWCVCYUeIyJXPeovYnhZb
	p1G1Ux3pPyoPSWT/dnwDCmmP65fN+QShz9LBgkUeOqkAkE/1c8lIM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98D341E186B;
	Thu,  8 Feb 2024 12:33:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2CAC1E186A;
	Thu,  8 Feb 2024 12:33:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Linus Arver <linusa@google.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] oidset: refactor oidset_insert_from_set()
In-Reply-To: <20240208135055.2705260-3-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 8 Feb 2024 14:50:53 +0100")
References: <20240208135055.2705260-1-christian.couder@gmail.com>
	<20240208135055.2705260-3-christian.couder@gmail.com>
Date: Thu, 08 Feb 2024 09:33:08 -0800
Message-ID: <xmqqo7cqoo8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 209A3FBA-C6A8-11EE-9A75-25B3960A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit, we will need to add all the oids from a set into
> another set. In "list-objects-filter.c", there is already a static
> function called add_all() to do that.
>
> Let's rename this function oidset_insert_from_set() and move it into
> oidset.{c,h} to make it generally available.
>
> While at it, let's remove a useless `!= NULL`.

Makes sense.  

My initial reaction was that copying underlying bits may even be
more efficient, but that was only because silly-me did not realize
that dst can be non-empty when the operation starts.  The name of
the function is not "copy oidset" but "insert from set" that makes
it crystal clear what is going on.  Good.
