Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B1C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF9260F56
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 16:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhIKQKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 12:10:02 -0400
Received: from mout.web.de ([212.227.15.14]:46847 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhIKQKA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 12:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631376519;
        bh=dI3iM5jCgFc1MEgSGb+zG+pgsm9EOaKLc1nN5JjOiGI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QmEYfgvotEjq+nMbCE5P21h9bodavpOPhtZJ1dwXQ4PydRS+sQxs90um0tv01NQDZ
         5/NKHeMj4YFzVqrb+FCESlzJHyPQ3/8B97nngJ+i4x378v0m/Hmg+GVVFYrtCnfItH
         i7BFVFQbxv07QdTzMh/kF5nomdOB+DcVCBpSTW/o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LnjRP-1mrGRM2ZwN-00huLM; Sat, 11 Sep 2021 18:08:39 +0200
Subject: Re: [PATCH 3/3] packfile: use oidset for bad objects
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
 <YTy8o3qXvyVv8fNr@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3d637be1-f89f-414c-19ef-65c3943457e9@web.de>
Date:   Sat, 11 Sep 2021 18:08:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YTy8o3qXvyVv8fNr@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3b1b3zuih0ES9RwIDI74kFalO8eKVJ9jAJiPPsXzEruSlFE4Kl
 R4bdYhy1D8mPkBW7FqWCgZnH8+XzyXrjdkQo9p7S4xCusliEUpwpEShoNDpan7mqLvcMHAB
 gIF7rAXO9qFFSAlgo3mXkRn/OECBDJ5m7wWEQkA8GA0Bcsh1QImlFxgbgWGNGCXl880TolJ
 xdNmA2rBW90W+ouplBeLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5uZplIi6U8=:WfuEqzrJgymcOY3wfOjqEs
 ecpIKXyUuxZyehKAMhJLATTIc2JNbfn0EIy2GE2QZzb/FxZK99OGQX8rxVOY6XcR7e3ba6MAS
 JWfzLOcsJvBmyFI0hEWWGZ/BFI8TfpNGK9Kf8Vifba9LxbayBUHJHzQo5yWpWQucAEurUX89o
 KWSKBsCrt/5TD8d4E2ySrRGVbnfZnJYWTt1hE37M6LnYqjA4tg2cwtibr64kH8r0Uar8MlqBQ
 eiRDpPPL7PrVlIM65Rq81zuDSKGeJ/+sdp+2qlw/EEKmSvlMfllr3lAkAimglQgZJOAb/Dsc/
 iekTyYqTROKa0ZP1w5/nwE7qyapf0mP+sb75rQfI+I79Jsz2ieL0uQxZ4oJPsxdBkwa66fR64
 R8Dfo/a3vIcSGbahmZ0Tdkya9mpFbwfHgyaHhLWbSIjJZ9f/J+9Afjmq6s87E74hSond/g6Wv
 ZajeZ22ihFofgcdwYIsbDcCT2bg2Mpghw9NgB2v/HmYp2yRGSnA0YcR0F7xZE/vjlSLg9RLGE
 vAZoLSnxs61XGkdY5wnw8PRAKZRQQKtsP3UxKWWS9g3DfvuY9lSukjoajxTkKCfmuRxuguhtJ
 ILLlummkbNFpzcIdkvpIfRBpsdjSyb1lGldyHvenbehF9Ed7o4OefUzA+9VxZe1JfQxj4mECh
 L88jrshbOs1+/imSz6e/SqkzcOPL/AsoB6vPfuao91vH32MEU22Fn039OdJa3zWHi+oB+waUK
 LHLgqTWh95mrhcuJMhL88jbc6SOhvxHw18haUnZkOz52DnqiBG93zl2j2l+Dy4wl5bJ6DvKXx
 lXLPNHiJIXzhuhtwQb9Zxav+Eb4jKpG3K+Ke+yC+NFfMII5qBmfG+lDBHhJtSMuj1Ua5Q0wqF
 2BJU7bqHoGiI4aDt4T7wPC25Bx83TDbaAj5+wY/0O9PDebcQD2nlguAe/oC7OXMkB7vFpUYwh
 RnAya6K7pkRHUMBE8TqQgMFjH6A6lUH0sRufiONIR3d4Z2cPlu99+Usn9RRw3ptFllVC9mYmO
 WeKAz+T5YY1eQHRJpH9UqjDVO3oFj5wL1ZLIZr9Jctw4x2o6TUt9FFpcMZgUIECAhMBlKJUJr
 s/DlHmLH9RMH8U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 16:26 schrieb Jeff King:
> On Sat, Sep 11, 2021 at 10:01:40AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Store the object ID of broken pack entries in an oidset instead of
>> keeping only their hashes in an unsorted array.  The resulting code is
>> shorter and easier to read.  It also handles the (hopefully) very rare
>> case of having a high number of bad objects better.
>
> Yay, I'm very happy to see this kind of cleanup replacing ad hoc data
> structures with well-tested ones.
>
>> @@ -303,15 +304,9 @@ static int nth_midxed_pack_entry(struct repository=
 *r,
>>  	if (!is_pack_valid(p))
>>  		return 0;
>>
>> -	if (p->num_bad_objects) {
>> -		uint32_t i;
>> -		struct object_id oid;
>> -		nth_midxed_object_oid(&oid, m, pos);
>> -		for (i =3D 0; i < p->num_bad_objects; i++)
>> -			if (hasheq(oid.hash,
>> -				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
>> -				return 0;
>> -	}
>> +	nth_midxed_object_oid(&oid, m, pos);
>> +	if (oidset_contains(&p->bad_objects, &oid))
>> +		return 0;
>
> Calling nth_midxed_object_oid() implies a memcpy() under the hood. In
> the old code, we'd skip that in the common case that we had no corrupt
> objects, but now we'll pay the cost regardless. memcpy() isn't _that_
> expensive, but I'd expect this to be a relatively hot code path.
>
> Is it worth sticking all of this inside:
>
>   if (oidset_size(&p->bad_objects))
>
> ?

Hard to say.  It would certainly match the old code more closely.  Is a
function call cheaper than copying 32 bytes?  Depends on the CPU and
whether the hash is cached, I guess.  And cached it probably is, because
the caller did a binary search for it..

We can pass on the original oid to avoid the nth_midxed_object_oid()
call, but inlining the whole thing might even be nicer.

Ren=C3=A9
