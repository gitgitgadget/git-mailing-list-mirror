Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB80189BB5
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605622; cv=none; b=SkVXOPePF4JcfYCIenM+W+hIjB1aFBSCzEsc0QbdwENFaCDRA4jauIQFdYLgBw/jheXnbeLrxz2LhuCD5MQIMj3D5FH5jVLf++29w7xvRTQ6k1m1DQ+yhiZKMnZH6Vky/ID2V1PA3ClMt4rzl5Ig4M73QLnXqyTqXnoG3Bqjgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605622; c=relaxed/simple;
	bh=2NiJEgt8Vufip5Mg+Mweq7WEvdthe+plt7P3eY901gU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AaPbTpACJqKOL1BhrPZgMpdwQZL+GxbWtdTVxBlXTNiusfdsj4tRO64hmh854tfrG6cIYtOVM5YqnytRimrR/EbezpnN/eGQhCJ87oJCfRa3vvAwoW+eTTKUQfSouUze4FT2SKgQHXHGFJK5TRA0h4KaucXzhOnmKnGMlBthGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yHxyN81B; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yHxyN81B"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F7C827A1B;
	Tue, 17 Sep 2024 16:40:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2NiJEgt8Vufip5Mg+Mweq7WEvdthe+plt7P3eY
	901gU=; b=yHxyN81BMJAjwkbLvj0xqQAimHt3BZiFE8GhkMmAqcn+A4dxm58J6V
	YnWq0jZBxtC22a4CkAaKEcojT6auuRVM2jYDSnxHgr47dsmBtISYM4193omKzWHw
	RGoCOjd80u4TlftZ2ANodgByvGAcwu968poMOMDVUK6G4ywXSlV1U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 466D127A1A;
	Tue, 17 Sep 2024 16:40:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D22E27A19;
	Tue, 17 Sep 2024 16:40:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
In-Reply-To: <ZugMUv1xbnjYH-el@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Sep 2024 12:45:38 +0200")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
	<0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
	<ZugMUv1xbnjYH-el@pks.im>
Date: Tue, 17 Sep 2024 13:40:11 -0700
Message-ID: <xmqqa5g6ko9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0A299A1E-7535-11EF-BCCA-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +static int check_collision(const char *filename_a, const char *filename_b)
>> +{
>> ...
>> +	return ret;
>> +}
>> +
>>  /*
>>   * Move the just written object into its final resting place.
>>   */
>
> This function compares the exact contents, but isn't that wrong? The
> contents may differ even though the object is the same because the
> object hash is derived from the uncompressed data, whereas we store
> compressed data on disk.

Very true.  So check_collision is *not* a good name for this helper
function.  

For .pack files, a collision means two resulting files have the
identical contents, so the above function, perhaps renamed to
"compare_files()" or something, is a very appropriate helper to
detect a collision once you get two files that claim to be the same
.pack file.

For loose object files, a collision means the contents before
compression are the same, so if we wanted to check collisions within
the same framework, we'd need "compare_files_after_inflating()" or
something, that opens both files and compare their contents while
"inflating" via zlib.

Thanks.
