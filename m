Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21967CF39
	for <git@vger.kernel.org>; Tue, 21 May 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298598; cv=none; b=FWqLPq0IbFX9VWpQvgVfJyRNWcEGB+zmZrCapbADkhtbgavKCw6Gge+KN9LPffdBtzBo0hsIQB+PkRzsF66CdwS9D9AoyPjyxfNlJDlnVMaDxj/PkMCUN2Ozl+sEsSkAHLfHRZekG4n+abOxMZy02uAKdqx6Z7Bfxy38LtpyXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298598; c=relaxed/simple;
	bh=PQj1uT+Wt47asBqf50Ggp7DNv98wfQ9+SRopep+yTv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=syJpw/QobV0kmh6dsZ+nafN4pfxw2lRFXGKytJsHTcF4gvYrtt9MBEt6V54J7g1SSZW/EW/tC4lB7Whm9zC3Zxgo2HT2V+sostyR+AEyjAL4Jzhr9hwhZa6KvFa58jnnh15D6gYs6D9BH2BaZWGg6sDo6T8DTGs2PK7RoDbn+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u/lGbry/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u/lGbry/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F05FB2B3DF;
	Tue, 21 May 2024 09:36:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PQj1uT+Wt47asBqf50Ggp7DNv98wfQ9+SRopep
	+yTv8=; b=u/lGbry/Ev8HJy7e7rDrUg3Vakgmlbl+/JMK7vZoK4I4QpP6DB/9aX
	YA9db1XfV+xDuT/ZoK6/iXXgsG4hGLTUAC9GcOvJAYUoqmeMUvgKp/5MWfSYn8yQ
	otDBtF3HeXCyoltxTzy0U5/Pbv0xMLf46ahCxpi2R5l2qJJX9Ywv0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E8B9B2B3DD;
	Tue, 21 May 2024 09:36:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B847C2B3DC;
	Tue, 21 May 2024 09:36:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 5/5] apply: fix uninitialized hash function
In-Reply-To: <ZkxUEP7HifEVlDZY@tanuki> (Patrick Steinhardt's message of "Tue,
	21 May 2024 09:58:08 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240520231434.1816979-1-gitster@pobox.com>
	<20240520231434.1816979-6-gitster@pobox.com> <ZkxUEP7HifEVlDZY@tanuki>
Date: Tue, 21 May 2024 06:36:31 -0700
Message-ID: <xmqqcypfcmn4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2302E1E2-1777-11EF-9746-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> +	if (!the_hash_algo)
>> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>> +
>
> Do we also want to add a comment here that mentions that we may want to
> make this configureable via a command line option, like we have in the
> preceding commits?

We may want a comment here that says 

    we could to redo the "apply.c" machinery to make this arbitrary
    fallback unnecessary, but the benefit to do so is dubious and
    the risk of breaking the code is probably not worth the effort.

When working as "better GNU patch" mode without a repository, we
should not and do not use the_hash_algo for the purpose of hashing
at all.  We do not do the binary diff (because we cannot grab the
preimage object out of the object store (that does not exist) to
apply the delta to form the postimage, we do not do the 3-way
fallback using the preimage blob object names that appear on the
"index" lines.  As far as I recall, the only thing we use
the_hash_algo for is for the max length of the hash to ask "is this
hexadecimal string a plausible looking object name?  We are parsing
a line that started with 'index ' and trying to see if the line
syntactically looks like a valid 'index' line" and the like.  If we
assume SHA-1 and if somebody tries to injest a SHA-256 --full-index
patch, that logic may say "nah, we didn't find a valid 'index'
header", but I think we'll just leave the fields like old-object
blank, which does not affect anything because we won't do "apply
--3way" anyway.

So we _could_ identify such places and tell the code "when
the_hash_algo is NULL, instead of the_hash_algo->hexsz, use 0 as
hexsz" (this example is from apply.c:gitdiff_index()) and it indeed
was the approach I tried in my unpublished draft before the first
version I posted.  It quickly got ugly.

