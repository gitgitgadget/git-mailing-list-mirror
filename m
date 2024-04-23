Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF94CB55
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891281; cv=none; b=BVMC7WB9OWwpZ1BsWvSuwG24Grz9e8zJ6QAmIMP2mxyIK63gnfutAC7fdQYrQCcwvJ6C2NA3IDpzZIacsCSfxjlKpJLh6zXhhFUcnyA4dl7Cs6BMT3+DtuzU7Vsm/7thDC2MHCWbVaIuUvNj5XglaF4T/hePtdvAZ6zNW8siH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891281; c=relaxed/simple;
	bh=RWOd+zT5aFUT3v3m5HjfWUlTalPHjFoqcNbJOndRFuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8bRe1FrxsNFo31p21GosYhPs1QPjmHpLfGRN7urlkJCvOBB5x/U8NIm7IICyGgyvYr7wa6ZfDJqhqIEqXDgprvZu0oRRgSAVNwzt1Ah7+9BydPFVcvll/kiP9rFngKxG2fCZNwAiXmE3WMSKtaOoOfU1Z5iDhe8T5H5Tq/VRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IAoafgKd; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IAoafgKd"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B35432434;
	Tue, 23 Apr 2024 12:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RWOd+zT5aFUT3v3m5HjfWUlTalPHjFoqcNbJOn
	dRFuM=; b=IAoafgKdgSpUdhlmo4K9VkHkXQqsirlX3yhDm892Jtxdyl4VEF/0kC
	L77B2bBzxPR7zD/UR8zIO36SC3vAoxK13lI0DKdlbT015CAzxTi5qbfBBKfM8TyR
	yWWtJqZ18lN0y72PK13dZIdq1OfabfsmvRS/K7oTQX8oPC9IExuJE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 91EF932433;
	Tue, 23 Apr 2024 12:54:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6FD332432;
	Tue, 23 Apr 2024 12:54:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
In-Reply-To: <Zic-B7oSlv1PwvOL@tanuki> (Patrick Steinhardt's message of "Tue,
	23 Apr 2024 06:50:15 +0200")
References: <cover.1713519789.git.ps@pks.im>
	<aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
	<xmqqjzkpxtjm.fsf@gitster.g> <Zic-B7oSlv1PwvOL@tanuki>
Date: Tue, 23 Apr 2024 09:54:32 -0700
Message-ID: <xmqqttjsow8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2925DBF6-0192-11EF-9AD5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> All makes sense, and given the above, I strongly suspect that we
>> would want to make the validate_headref() function a file-scope
>> static in setup.c to make sure it is only called/callable from the
>> repository discovery codepath.  Especially that if somebody calls
>> this function again after we find out that the repository uses
>> SHA-256, we would want to let the caller know that the detached HEAD
>> records SHA-1 and we are in an inconsistent state.
>
> Fair enough, we can definitely do so. It only has a single callsite
> anyway.

I was wondering if I was missing a future plans to call it from
other code paths that are triggered after the set-up was done.  If
that is not the case, we should do so.  It matters more for the
future callers than the current ones.  They _all_ have to be aware
of the deliberate looseness of the check here.

Thanks.  
