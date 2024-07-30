Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95371183CDB
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356537; cv=none; b=T191D+zVjOen1jcAvZ2i4oLCQKzjI7Jy6KjZle0NgDx+A9r+XOXdpGV5hf2pJR+JGEQSoOj7iac8H9rQqCwyPYX/shfvotCAxz8g471mAXqwYZw5dVphAlKWHr5dpcWJpyK3EkJCuusb9hVzia+/9wfwEd+QdGnkEF16X0lfF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356537; c=relaxed/simple;
	bh=+WvSQQqBWbPiqt2oE+69etHDTua+3otMlaFvtOIOPUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ia36xR/wZAuMsDlBdDob3np1MM4GX9dRdwN7vkFQ8334D3/j/OEiVivwvfJd66wDgCihhNEI3cwu+g+L19DG37QR9F7UJm/FtZKEPcrXJ3nq5OyhMk9UQSvquSRgdxQGjeUeQuu4S/BsnQl4pracHHdxbXSIPNMeunIaXEni0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W64wvrwu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W64wvrwu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D4D83871C;
	Tue, 30 Jul 2024 12:22:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+WvSQQqBWbPiqt2oE+69etHDTua+3otMlaFvtO
	IOPUo=; b=W64wvrwu2HO3vqx4lU5bX5103YdtUM7pqwgnKwKMmeGXYoQrndNy8J
	O83f+tASlqhbqy0zXAgRdSzgSihS6InIV+vcUuHvmJchnA6wnxmlZK7mn9fw5IEv
	X8fpegqbcayJc2sSdIFZfVsGDpc833RuMClwCX7Qv8DMHukZlgVEs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 267413871B;
	Tue, 30 Jul 2024 12:22:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A20C43871A;
	Tue, 30 Jul 2024 12:22:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
In-Reply-To: <20240730074307.GB562212@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jul 2024 03:43:07 -0400")
References: <20240723021900.388020-1-gitster@pobox.com>
	<20240720220915.2933266-1-gitster@pobox.com>
	<20240730011004.4030246-1-gitster@pobox.com>
	<20240730011004.4030246-3-gitster@pobox.com>
	<20240730074307.GB562212@coredump.intra.peff.net>
Date: Tue, 30 Jul 2024 09:22:09 -0700
Message-ID: <xmqqv80metou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DFFA71BC-4E8F-11EF-A51C-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> On Mon, Jul 29, 2024 at 06:10:03PM -0700, Junio C Hamano wrote:
>
>> @@ -1236,14 +1236,43 @@ static int safe_directory_cb(const char *key, const char *value,
>>  
>>  		if (!git_config_pathname(&allowed, key, value)) {
>>  			const char *check = allowed ? allowed : value;
>> -			if (ends_with(check, "/*")) {
>> -				size_t len = strlen(check);
>> -				if (!fspathncmp(check, data->path, len - 1))
>
> BTW, one oddity I noticed in the existing code:
>
> Under what circumstances will "allowed" be NULL in that ternary? I think
> if git_config_pathname() returns non-zero, then we called
> interpolate_path(). It can return NULL, but in that case
> git_config_pathname() will die(). We might change that later, but then
> I'd expect it to return non-zero. So I suspect the whole "check"
> variable could just be dropped in favor of using "allowed".
>
> Obviously not new in your patch, but maybe worth fixing while in the
> area? I think it comes from an evil merge in b8bdb2f283 (Merge branch
> 'jc/safe-directory-leading-path', 2024-06-12).

I think it deserves to be a separate change, probably a preliminary
clean-up, as it predates that by a few years, and goes back to the
initial introduction of the safe.directory feature.  The merge you
found had this bit:

diff --cc setup.c
index e47946d0e7,4c5de0960b..e112545f71
--- a/setup.c
+++ b/setup.c
@@@ -1230,13 -1176,21 +1230,20 @@@ static int safe_directory_cb(const cha
  	} else if (!strcmp(value, "*")) {
  		data->is_safe = 1;
  	} else {
- 		char *interpolated = NULL;
- 
- 		if (!git_config_pathname(&interpolated, key, value) &&
- 		    !fspathcmp(data->path, interpolated ? interpolated : value))
- 			data->is_safe = 1;
- 
- 		free(interpolated);
 ...


Notice that in the original, the code is prepared for the case where
interpolated is NULL when fspathcmp() needs to use it or value,
which is when git_config_pathname() returned 0/success.

It came from 8959555c (setup_git_directory(): add an owner check for
the top-level directory, 2022-03-02) that introduced the
safe.directory feature:

+		if (!git_config_pathname(&interpolated, key, value) &&
+		    !fspathcmp(data->path, interpolated ? interpolated : value))
+			data->is_safe = 1;

where it shared the same assumption.
