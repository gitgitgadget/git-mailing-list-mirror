Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DE8821
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653739; cv=none; b=YJIGaY1xQSoSTYoc+JU6rB62yIaTZZS0O9yUaQ1oEhdyH8mkUBOVKVb8SE24UvdUKFCk+u3+k0AzspNexBDYDN00tQ5qCVe3LuJl5IFScuG90ELaKH2e4w1gCz9C0c+5t1w4AGwTNAlwGPLdmPIk9nGcuJRIXHWsHM/bXY99h3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653739; c=relaxed/simple;
	bh=IB3HLk96EZ++vu8vNh87YSUCswTUIrpWKor56eK0OG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+HUGMd0J1geIoVOxGTqGzWBEERL+fNdI7yWEU2yXJSIjEaoVw7Pf3TFo6egdQfalAiK7xF03pq9Lv3quzCSK/C65XsY718VH70AptC3mpqwA0wlzEUcB0frsnauMzegcKC7TdlN8m7UBBnnK3oAVbICOc+ZPhwbBLXo4dqFhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PZh1vG9D; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PZh1vG9D"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8EE542A494;
	Thu,  6 Jun 2024 02:02:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IB3HLk96EZ++vu8vNh87YSUCswTUIrpWKor56e
	K0OG0=; b=PZh1vG9DV/b3Tat2om0neEh11dhZjRofVWsTyLsXRTIYVjmlLH69/y
	KKQO19cjKEDiXCyBRXGLSCQ1x49dsHitgIsJ34akPiLyFezv2/oKs6thaCU6e3GL
	jqccAqbkjIPTUyUas0UJwU2Nj7G/Sxtt7tJpHl3aU9jaef6hYAWRo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 872702A493;
	Thu,  6 Jun 2024 02:02:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A0FB32A492;
	Thu,  6 Jun 2024 02:02:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] object-file: mark cached object buffers as const
In-Reply-To: <ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 4 Jun 2024 14:37:47 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
	<ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
Date: Wed, 05 Jun 2024 23:02:07 -0700
Message-ID: <xmqqr0dapq1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4EF3E152-23CA-11EF-8EBC-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The buffers of cached objects are never modified, but are still stored
> as a non-constant pointer. This will cause a compiler warning once we
> enable the `-Wwrite-strings` compiler warning as we assign an empty
> constant string when initializing the static `empty_tree` cached object.
>
> Convert the field to be constant. This requires us to shuffle around
> the code a bit because we memcpy(3P) into the allocated buffer in
> `pretend_object_file()`. This is easily fixed though by allocating the
> buffer into a temporary variable first.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

I haven't dug into the exact details, but I noticed that t6130,
t7010, and t8002 started breaking linux-leaks/linux-reftable-leaks
CI jobs for 'seen'.  'seen' excluding ps/no-writable-strings seems
to pass the tests, and bisection indicates that 'seen' excluding
ps/no-writable-strings after this step [12/27] still passes, but
once this step is included, the leak tests break.

> diff --git a/object-file.c b/object-file.c
> index 610b1f465c..3afe9fce06 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -277,7 +277,7 @@ int hash_algo_by_length(int len)
>  static struct cached_object {
>  	struct object_id oid;
>  	enum object_type type;
> -	void *buf;
> +	const void *buf;
>  	unsigned long size;
>  } *cached_objects;
>  static int cached_object_nr, cached_object_alloc;
> @@ -1778,6 +1778,10 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
>  			struct object_id *oid)
>  {
>  	struct cached_object *co;
> +	char *co_buf;
> +
> +	co_buf = xmalloc(len);
> +	memcpy(co_buf, buf, len);
>  
>  	hash_object_file(the_hash_algo, buf, len, type, oid);
>  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||

There is an early return around here.  Perhaps we are leaking co_buf
when we hit it?

> @@ -1787,8 +1791,7 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
>  	co = &cached_objects[cached_object_nr++];
>  	co->size = len;
>  	co->type = type;
> -	co->buf = xmalloc(len);
> -	memcpy(co->buf, buf, len);
> +	co->buf = co_buf;
>  	oidcpy(&co->oid, oid);
>  	return 0;
>  }
