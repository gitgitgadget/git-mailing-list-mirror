Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223822EE4
	for <git@vger.kernel.org>; Thu, 30 May 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085248; cv=none; b=NMirBUQniCrac7vWyvAY6/1aNx97jmzt4TH1vYTr5pKhkWDJSM6YRYS7bdmhfyfv1vZEd5IkfzwnnAfNFLE0oIOIdNnLQ6rCIuMDK4cH/bhwJcVCzZS2uHt5GUG7ZjlTpaRKQ4Jn+GjaOCH7qMX2Cg90JoqJr+uHdBk9rvSD/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085248; c=relaxed/simple;
	bh=ED4lJAoXbnKryVXSGCEOBwUjnI4gAlqcEM5CyNrkDH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e/U4sfo39kDVBBKUcIxWV8xU4MUImshumGfnDBtdQki1nbxLcxsaRHVL/anBt8+j1+yuMs94yI8mq1f7JuC/o4g9kFBwabGDipGWRPeDj406GxKI/N+0if8++JBkorgJqoBKzx9pqCKVJlY/rRoVqpQIy9pYtLsZD67iQ6I5U+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cyn8sF8p; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cyn8sF8p"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6EE503317A;
	Thu, 30 May 2024 12:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ED4lJAoXbnKryVXSGCEOBwUjnI4gAlqcEM5CyN
	rkDH8=; b=cyn8sF8pWA92l2enjYFlMjn5cRZWSn3V4L8qKWyMTkmLxIx5YKc4wp
	SnuLE2cN84SPHfETaHD7joqsyXEsW/KikvNptoofGmjMkTz94/moUXfBUmNG5/5S
	4jqI2i+CLI2jiD7lvcC3sRQqcPbZ54tn1jlaettqo9nTlGBnDbUQw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 66F7B33179;
	Thu, 30 May 2024 12:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7955233178;
	Thu, 30 May 2024 12:07:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/19] reftable: improve const correctness when
 assigning string constants
In-Reply-To: <ZlhjVIEld7_T0q-M@tanuki> (Patrick Steinhardt's message of "Thu,
	30 May 2024 13:30:28 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<dc5d85257eef747f2331638ed718b0f7a5bb1da2.1716983704.git.ps@pks.im>
	<xmqqed9ky0mk.fsf@gitster.g> <ZlhjVIEld7_T0q-M@tanuki>
Date: Thu, 30 May 2024 09:07:17 -0700
Message-ID: <xmqq7cfbqo5m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B06908C6-1E9E-11EF-9BFA-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 29, 2024 at 10:43:47AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > diff --git a/reftable/basics_test.c b/reftable/basics_test.c
>> > index 997c4d9e01..af9209d535 100644
>> > --- a/reftable/basics_test.c
>> > +++ b/reftable/basics_test.c
>> > @@ -58,8 +58,8 @@ static void test_binsearch(void)
>> >  
>> >  static void test_names_length(void)
>> >  {
>> > -	char *a[] = { "a", "b", NULL };
>> > -	EXPECT(names_length(a) == 2);
>> > +	char *names[] = { (char *)"a", (char *)"b", NULL };
>> > +	EXPECT(names_length(names) == 2);
>> >  }
>> 
>> I would have preferred to see this kind of rewrite more than
>> separate and clearly writable variables that are initialied with the
>> constant contents e.g. branches[] = "refs/heads/*", we saw in
>> earlier steps.  Wouldn't that approach, combined with making the
>> literal constants stored in read-only segment to trigger runtime
>> failure when a bug causes the "unfortunately non-const" variables
>> to be written, give us a better result?
>
> Depends on what we mean by "better", I guess. But yeah, I was torn
> myself when writing this commit because there are so many string
> constants in the reftable tests that we assign to non-constant fields. I
> didn't find the result particularly easy to read when putting each of
> the constants into a separate variable.

Oh, I do *not* want to see.

	char a_string[] = "a";
	char *names[] = { a_string, ... };

As a way to workaround the -Wwritable-strings warnings, what we see
in this patch is much better.

I was referring to a redoing of this series in the other direction.
The earlier one that introduced

	char refspec_string[] = "refs/heads/*";

and rewrite assignments of

	non_const_pointer_to_char = "refs/heads/*";

with

	non_const_pointer_to_char = refspec_string;

would have been better if it were done without refspec_string[]
array.  It is a runtime bug to overwrite the refspec_string[] via
the non_const_pointer_to_char, but use of refspec_string[] would
make it impossible for us to catch.


