Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49722301
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048788; cv=none; b=uYu19AM1cQiXDKYHuQ4DrgfUgsk5eKHAAXFAo891wawM2dzyykFDRsYxqM6+NH4kIbhi+PjZdE7eZoN1KmmTCVbGXKezsh53NjH77gFRhoFdHTLOqefQu6C71iC0Ed3maaYZ2COlg16zPv17rAkh5W8iu7B8Vl+fNIxBBXOOw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048788; c=relaxed/simple;
	bh=t3CR05myygbrMOIKi5L6z97TJQjMRznUV3Z4zmbRtm8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5piyI6VZ4v8QJH5upSV9gDTD64xj5BgrEfWruxMkiBLUOdQKPv0vvQutEHDJb3wf9rywWSVk1ye7nEbudVc6eGjGxhyyPq/et6FDuCYVKzV8OnWfVGNyPQ/t0cELm0npF9/unjVn53NOXcecrI3d7DOuiN/vuI59MCAnH3t7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 60M2QBRC2355815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 02:26:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Jeff King'" <peff@peff.net>, "'Elijah Newren'" <newren@gmail.com>
References: <cover.1765053054.git.me@ttaylorr.com> <cover.1768420450.git.me@ttaylorr.com> <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com> <xmqqpl7beugj.fsf@gitster.g> <aWgSzI30k0BZfZ4Q@nand.local> <aWgwn2rk/qw+fRoA@nand.local> <aXCTkVpjJkTabx_0@pks.im> <aXFni2tE7vn1dKFp@nand.local>
In-Reply-To: <aXFni2tE7vn1dKFp@nand.local>
Subject: RE: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Date: Wed, 21 Jan 2026 21:26:06 -0500
Organization: Nexbridge Inc.
Message-ID: <014c01dc8b46$7a2997b0$6e7cc710$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJLRUIcsGc0vZFOf7bQGsMkQWFk9gGsF+6rAm25p1EA/7rhDgFEsTRpAR7U36wB7fyjTQMGPrwXtBx30SA=
X-Antivirus: Norton (VPS 260121-8, 1/21/2026), Outbound message
X-Antivirus-Status: Clean

On Taylor Blau January 21, 2026 6:56 PM writes:
>On Wed, Jan 21, 2026 at 09:51:36AM +0100, Patrick Steinhardt wrote:
>> > diff --git a/midx-write.c b/midx-write.c index
>> > 87b97c70872..6006b6569c8 100644
>> > --- a/midx-write.c
>> > +++ b/midx-write.c
>> > @@ -1738,8 +1738,19 @@ static void fill_included_packs_batch(struct
>repository *r,
>> >  		 */
>> >  		expected_size =3D (uint64_t)pack_info[i].referenced_objects << =
14;
>> >  		expected_size /=3D p->num_objects;
>> > -		expected_size =3D u64_mult(expected_size, p->pack_size);
>> > -		expected_size =3D u64_add(expected_size, 1u << 13) >> 14;
>> > +
>> > +		if (unsigned_mult_overflows(expected_size,
>> > +					    (uint64_t)p->pack_size))
>> > +			die(_("overflow during fixed-point multiply (%"PRIu64" "
>> > +			      "* %"PRIu64")"),
>> > +			    expected_size, (uint64_t)p->pack_size);
>> > +		expected_size =3D expected_size * p->pack_size;
>> > +
>> > +		if (unsigned_add_overflows(expected_size, 1u << 13))
>> > +			die(_("overflow during fixed-point rounding (%"PRIu64" "
>> > +			      " + %"PRIu64")"),
>> > +			    expected_size, (uint64_t)(1ul << 13));
>> > +		expected_size =3D (expected_size + (1u << 13)) >> 14;
>>
>> One downside this pattern has is that we repeat the computation, =
which
>> makes it easy to get it wrong or forget updating either the check or
>> the computation.
>>
>> I think ideally, we would have interfaces that combine the two
>> approaches in `u64_mult()` and `unsigned_mult_overflows()`. Something
>> like this for example:
>>
>>     static intline bool u64_mult(uint64_t a, uint64_t b, uint64_t =
*out)
>>     {
>>         if (unsigned_mult_overflows(a, b))
>>             return false;
>>         *out =3D a * b;
>>         return true;
>>     }
>
>I had considered this approach when writing, but ultimately decided =
against it, since
>it felt a little clunky to have to pass a pointer in to do a simple =
arithmetic operation.
>But I think your point about ensuring that we actually do:
>
>    if (unsigned_mult_overflows(a, b))
>      die(...);
>    result =3D a * b;
>
>and not "result =3D a * c" or some other expression which is not "a * =
b"
>is a good one.
>
>I dunno. The spots in this patch are the only uses of u64_mult() and =
u64_add(), so
>I'm hesitant to keep a helper function around just for that sole =
use-case. I wonder if
>we should do what you suggest here for the much more frequently used =
st_add() /
>st_mult() / st_sub() functions?
>
>> This would let the caller handle the failure and is thus quite
>> flexible, which results in the following code:
>>
>> 	if (!u64_mult(expected_size, (uint64_t)p->pack_size, =
&expected_size))
>> 		die(_("overflow during fixed-point multiply (%"PRIu64" "
>> 		      "* %"PRIu64")"), expected_size, (uint64_t)p->pack_size);
>
>It does read quite cleanly, so I think I'm convinced.

Are all of these changes endian-safe?

