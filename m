Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5A10787
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UkwLZTFj"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E39921F726;
	Thu, 28 Dec 2023 15:42:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hhUtUcrkcPLtNicBl2ZNCjuEKDb/wrW6V3uREC
	bnqGk=; b=UkwLZTFjn29JCVJlPoG5QnFoFn7rvx3fWLZA9mDZYSE+A3YFZtbBBW
	qrpDE8EQ0X/WZoIdy3Lc8LqFKGpJSho1p6qMJAeCCO/sww5fGy/m3+eri3kJKYcT
	oyRiqR0SsC+QOBxkmm8z+lff4WHtJiiIDUj4hWvw3d/YGQ9Qf9P3E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DC12E1F71D;
	Thu, 28 Dec 2023 15:42:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81CFD1F6F8;
	Thu, 28 Dec 2023 15:42:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/12] refs: refactor logic to look up storage backends
In-Reply-To: <ZY3Wcua6dtzO2jG4@framework> (Patrick Steinhardt's message of
	"Thu, 28 Dec 2023 21:11:30 +0100")
References: <cover.1703067989.git.ps@pks.im> <cover.1703753910.git.ps@pks.im>
	<12329b99b753f79fe93fe017e71b08227d213c1e.1703753910.git.ps@pks.im>
	<xmqqjzoygrx8.fsf@gitster.g> <ZY3Wcua6dtzO2jG4@framework>
Date: Thu, 28 Dec 2023 12:42:22 -0800
Message-ID: <xmqq4jg2gitt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9A9039C6-A5C1-11EE-961C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Yeah, we do not really discern those two cases for now and instead just
> return `NULL` both for any unknown ref storage format. All callers know
> to handle `NULL`, but the error handling will only report a generic
> "unknown" backend error.
>
> The easiest way to discern those cases would be to `BUG()` when being
> passed an invalid ref storage format smaller than 0 or larger than the
> number of known backends. Because ultimately it is just that, a bug that
> shouldn't ever occur.
>
> Not sure whether this is worth a reroll?

By using an unsigned type, you no longer have to worry about getting
handed a negative index, as the "must be smaller than ARRAY_SIZE()"
check will be sufficient to catch anybody who passes "-1" (casted to
unsigned by parameter passing).  So I would say that would be a good
enough reason to reroll, whether we differentiate 0 and an index
that is larger than refs_backends[] (or a negative one) with an
explicit BUG(), or just leave it to the caller by returning NULL.
As to the error handling, I suspect it is sufficient to return NULL
and let the caller handle it.

Thanks.


>
> Patrick
>
>> > +static const struct ref_storage_be *refs_backends[] = {
>> > +	[REF_STORAGE_FORMAT_FILES] = &refs_be_files,
>> > +};
>> > ...
>> > +static const struct ref_storage_be *find_ref_storage_backend(int ref_storage_format)
>> >  {
>> > +	if (ref_storage_format < ARRAY_SIZE(refs_backends))
>> > +		return refs_backends[ref_storage_format];
>> >  	return NULL;
>> >  }
