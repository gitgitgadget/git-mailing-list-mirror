Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048ED17557
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213551; cv=none; b=TdQxO8FKt7s8Lhel8rkTZuAfc9nCRV0NqyGsA0SBLtLl57M2l9dcXq95IwfZy3hjlmRRq5x1ZKmdv/Ioo+NhvyIJKqfnWFEO1AhiZuJB0Q9D5OV2j+W9C4MrSDVqRC9igXZnYpW2B7uLiLufQAezbWNioKYT/IVIQYqKxhj11P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213551; c=relaxed/simple;
	bh=anhxnD5ap/Gamx05MJ9qx53AFnvR3VZQAYCmyDJTvOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qiMNpgJo4bZv2I4uqGYFLyG1ZoQm7cmDZhXEYCLFWa3mtY1+8Fll4/JxmZQXuvfTrAgSuUOFokKomxkHwLgE9OSJgqcW71IZwlMxWYxQfg5SyqaHg42pQFadoE7JNQ5yEgPvI4zFJX4IXyfj1ISoJiwFugUM2Qbx1i1LceY/4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E6DThr1O; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E6DThr1O"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 453941A496;
	Tue, 24 Sep 2024 17:32:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=anhxnD5ap/Gamx05MJ9qx53AFnvR3VZQAYCmyD
	JTvOk=; b=E6DThr1ODk+eGspUdi3ps3jFDavWdMSBjWpL1V5CsltMM4ohdzCdgo
	k372cCrip0U9bOhDZOr4eQ+RAU8VjtYnpDAKk8Cng182rd1nu8t64ShV0d7+A7CX
	P+xJlNO9yaCKpKMLrRdU5m62hahrfWYIQx7BUoNtMBrPVwFD/oHxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D5201A495;
	Tue, 24 Sep 2024 17:32:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A39A81A492;
	Tue, 24 Sep 2024 17:32:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 3/8] finalize_object_file(): implement collision check
In-Reply-To: <ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 24 Sep 2024 13:32:17 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1727199118.git.me@ttaylorr.com>
	<ed9eeef8513e08935c59defafde99956eb62d49a.1727199118.git.me@ttaylorr.com>
Date: Tue, 24 Sep 2024 14:32:21 -0700
Message-ID: <xmqqzfnwrb4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C22CD0C-7ABC-11EF-98DD-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> One of the reasons we never implemented this is because the files it
> moves are all named after the cryptographic hash of their contents
> (either loose objects, or packs which have their hash in the name these
> days).

So we are saying that both loose objects and packfiles would benefit
if we did collision checks here.

> ... So in preparation, let's actually
> implement a byte-for-byte collision check.

But the byte-for-byte collision check is only good for packfiles.

In other words, the definition of "content" that gets hashed to
derive the name can differ among csum-file users, so the way to
check for collision can be written for these different types.

> Note that this may cause some extra computation when the files are in
> fact identical, but this should happen rarely.
>
> Loose objects are exempt from this check, and the collision check may be
> skipped by calling the _flags variant of this function with the
> FOF_SKIP_COLLISION_CHECK bit set. This is done for a couple of reasons:
>
>   - We don't treat the hash of the loose object file's contents as a
>     checksum, since the same loose object can be stored using different
>     bytes on disk (e.g., when adjusting core.compression, using a
>     different version of zlib, etc.).

That's a good explanation why byte-for-byte check is inappropriate.

>   - We already use the path of the loose object as its hash value /
>     object name, so checking for collisions at the content level doesn't
>     add anything.

"We already ... doesn't add anything" -> "The point of collision
check is to find an attempt to store different contents that hashes
down to the same object name, and we continue to use sha1dc to hash
the content name so such a collision would have already been
detected".

>     This is why we do not bother to check the inflated object contents
>     for collisions either, since either (a) the object contents have the
>     fingerprint of a SHA-1 collision, in which case the collision
>     detecting SHA-1 implementation used to hash the contents to give us
>     a path would have already rejected it, or (b) the contents are part
>     of a colliding pair which does not bear the same fingerprints of
>     known collision attacks, in which case we would not have caught it
>     anyway.

I do not understand (b).  If you compare inflated contents, you
would find such a pair that sha1dc missed but the "implement
collision check" patch would have caught as a pair of byte sequences
that hash to the same value.  Isn't it an opportunity to make it safer
to implement such a loose object collision check?

Thanks.
