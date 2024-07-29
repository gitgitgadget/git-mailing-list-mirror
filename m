Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE12186E2A
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283969; cv=none; b=aJhQFBwlzRDMOSoTuQW6Gd0XrjGWQggZjlf1z+y3lDcYmNmx+uDMeNnKu5Jzk5JQHZFEosg20HrPNRvqhO1mb6Mjri8SXgk+vuAAjJsrWb5IJXMlrwfz5S0YcFjxogNEItwLZCR8GarlGPpDsLONCflJZNqfkJThHq3X4JGHut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283969; c=relaxed/simple;
	bh=uu6neDkJwdPucDd6DrQzi8/KbO4PLpROmaLwvQkSKuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=if3SgSOpOo4Ag7wsLI8HHBR17niv8Q4QlYUvqBbtrYZJryzSYmRfduTzJyLsoxetl2c6cAtS6XS/7v+u7yza1WCwMplrAAMK9i3vSVzp1D/+7zM2/kz+pcub85b35Enp4gE156Uvmm9fd162l8RIr3vTM0GHoJuCQ215kbbjhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rZYnaMrn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rZYnaMrn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 55A9638BC3;
	Mon, 29 Jul 2024 16:12:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uu6neDkJwdPucDd6DrQzi8/KbO4PLpROmaLwvQ
	kSKuY=; b=rZYnaMrn9X4j7Oamhf707hdn4D/XQ3+4IyLd/+RmaLgQUXZxrZGxfG
	PMSEduS9JWFCjeM8a2nORXBiQuVh/+Ptd/Dpsywukdyxp2jpKoId8dWpPBkd9JNt
	QoBg4yiUjvo856HXB2bjHr36iDJLVoYKrg9fqKVLlZK1Jk26Z64as=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EEF438BC2;
	Mon, 29 Jul 2024 16:12:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB5BF38BC0;
	Mon, 29 Jul 2024 16:12:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] patch-id: tighten code to detect the patch header
In-Reply-To: <ZqeGBJrqIrU2A4jl@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jul 2024 14:07:32 +0200")
References: <20240621231826.3280338-1-gitster@pobox.com>
	<20240621231826.3280338-6-gitster@pobox.com> <ZqeGBJrqIrU2A4jl@tanuki>
Date: Mon, 29 Jul 2024 13:12:42 -0700
Message-ID: <xmqqwml4gdol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA37973A-4DE6-11EF-AF63-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jun 21, 2024 at 04:18:26PM -0700, Junio C Hamano wrote:
>> @@ -196,11 +211,13 @@ static void generate_id_list(unsigned flags)
>>  	struct strbuf line_buf = STRBUF_INIT;
>>  
>>  	oidclr(&oid);
>> +	flags |= GOPID_FIND_HEADER;
>>  	while (!feof(stdin)) {
>>  		patchlen = get_one_patchid(&n, &result, &line_buf, flags);
>>  		if (patchlen)
>>  			flush_current_id(&oid, &result);
>>  		oidcpy(&oid, &n);
>> +		flags &= ~GOPID_FIND_HEADER;
>>  	}
>
> I think I'm missing the obvious. But why don't we have to set
> `GOPID_FIND_HEADER` when we have flushed the current patch ID? Is this
> because we know that `get_one_patchid()` stops once it finds the next
> line starting with a commit?

Yup the original control flow is rather convoluted.  The first call
stops when it finds the header that begins the log message part and
returns, but the subsequent calls are to (1) skip the log message
and then (2) parse and hash the diff part, until it finds another
header that begins the log message part of the _next_ patch and
return.  GOPID_FIND_HEADER bit is used to tell the callee when we
haven't found the header (hence we can stop at a line whose
beginning looks like a hash) or the previous round already found the
header and we positively know we are now in the "skip the log
message" phase (hence a line whose beginning looks like a hash is
not a new header).

> Makes me wonder what happens when there is
> non-diff garbage between patches for which we are about to generate
> patch IDs.

"Skip non-diff garbage until we see a patch" is the mechanism used
to skip the log message, so it would be a reasonable thing to skip
such no-diff garbage between patches, no?
