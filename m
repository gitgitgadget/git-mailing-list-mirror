Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F4C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241396AbiEYV66 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 25 May 2022 17:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiEYV64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:58:56 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB97B8BFA
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:58:55 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 24PLwrGY082276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 May 2022 17:58:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>,
        <derrickstolee@github.com>, <gitster@pobox.com>,
        <larsxschneider@gmail.com>, <tytso@mit.edu>
References: <cover.1638224692.git.me@ttaylorr.com> <cover.1653088640.git.me@ttaylorr.com> <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com> <Yo0ysWZKFJoiCSqv@google.com> <Yo1aaLDmPKJ5/rh5@nand.local> <Yo3fZkpkCLPbAC8B@google.com> <Yo6hcOjIlYglqdxs@nand.local>
In-Reply-To: <Yo6hcOjIlYglqdxs@nand.local>
Subject: RE: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Date:   Wed, 25 May 2022 17:58:49 -0400
Organization: Nexbridge Inc.
Message-ID: <01df01d87082$a0757020$e1605060$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHb/488bX7VmyGm7lOI8s5Sc6VeLQKg6TD0AnqYOkcA3OyauQIQpadJAa1sKgUCM5uXrazJtL4g
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 25, 2022 5:37 PM, Taylor Blau wrote:
>On Wed, May 25, 2022 at 12:48:54AM -0700, Jonathan Nieder wrote:
>> >> What does mtimes_map contain?  A comment would help.
>> >
>> > It contains a pointer at the beginning of the mmapped region of the
>> > .mtimes file, similar to revindex_map above it.
>>
>> To be clear, in cases like this by "comment" I mean "in-code comment".
>> I.e., my interest is not that _I_ find out the answer but that the
>> code becomes more maintainable via the answer becoming easier to find.
>
>OK. I'll add a comment in the fixup! patch which I'm about to send.
>
>> [...]
>> >> This seems simple enough that it's not obvious we need more code
>> >> sharing.  Do you agree?  If so, I'd suggest just removing the
>> >> NEEDSWORK comment.
>> >
>> > Yeah, it is conceptually simple, though it feels like the sort of
>> > thing that could benefit from not having to be written once for each
>> > extension (hence the comment).
>>
>> The reason I asked is that the NEEDSWORK here actually got in the way
>> of comprehension for me --- it made me wonder "is there some
>> complexity here I'm missing?"
>>
>> That's why I'd suggest one of
>> - removing the NEEDSWORK comment
>> - going ahead and implementing the code sharing you mean, or
>> - fleshing out the NEEDSWORK comment so the reader can wonder less
>
>I am a little sad to remove it, since I thought it was useful as-is. But I can just as
>easily remember to come back to this myself in the future, so if it is distracting to
>you in the meantime, then I don't mind holding onto it in my own head.
>
>> >>> +
>> >>> +#define MTIMES_HEADER_SIZE (12)
>> >>> +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 *
>> >>> +the_hash_algo->rawsz))
>> >>
>> >> Hm, the all-caps name makes this feel like a compile-time constant
>> >> but it contains a reference to the_hash_algo.  Could it be an
>> >> inline function instead?
>> >
>> > Yes, it could be an inline function, but I don't think there is
>> > necessarily anything wrong with it being a #define'd macro. There
>> > are some other examples, e.g., RIDX_MIN_SIZE, MIDX_MIN_SIZE,
>> > GRAPH_DATA_WIDTH, and PACK_SIZE_THRESHOLD (to name a few) which
>also
>> > use the_hash_algo on the right-hand side of a `#define`.
>>
>> Those are due to an incomplete migration from use of the true constant
>> GIT_SHA1_RAWSZ to use of the dynamic value the_hash_algo->rawsz, no?
>> In other words, "other examples do it wrong" doesn't feel like a great
>> justification for making it worse in new code.
>
>Fair point. I can imagine reasons for the existing pattern, but updating it to handle
>the variable rawsz is easy to do (and it probably should have been that way since
>the beginning).
>
>> [...]
>> >>> +static int load_pack_mtimes_file(char *mtimes_file,
>> >>> +				 uint32_t num_objects,
>> >>> +				 const uint32_t **data_p, size_t *len_p)
>> >>
>> >> What does this function do?  A comment would help.
>> >
>> > I know that I'm biased as the author of this code, but I think the
>> > signature is clear here. At least, I'm not sure what information a
>> > comment would add that the function name and its arguments don't
>> > already convey.
>>
>> Ah, thanks for this point of clarification.  What isn't clear from the
>> signature is
>> - when should I call this function?
>> - what does its return value represent?
>> - how does it handle errors?
>>
>> I agree that the parameters are self-explanatory.
>
>I'm hesitant to over-document a static function with a single caller, but when
>looking at this, I think there is an opportunity to document _its_ caller
>(`load_pack_mtimes()`) which isn't static, but was also missing documentation.
>
>> >>> +cleanup:
>> >>> +	if (ret) {
>> >>> +		if (data)
>> >>> +			munmap(data, mtimes_size);
>> >>> +	} else {
>> >>> +		*len_p = mtimes_size;
>> >>> +		*data_p = (const uint32_t *)data;
>> >>
>> >> Do we know that 'data' is uint32_t aligned?  Casting earlier in the
>> >> function could make that more obvious.
>> >
>> > `data` is definitely uint32_t aligned, but this is a tradeoff, since
>> > if we wrote:
>> >
>> >     uint32_t *data = xmmap(...);
>> >
>> > then I think we would have to change the case where ret is non-zero to be:
>> >
>> >     if (data)
>> >         munmap((void*)data, ...);
>> >
>> > and likewise, data_p is const.
>>
>> Doing it that way sounds great to me.  That way, the type contains the
>> information we need up-front and the safety of the cast is obvious in
>> the place where the cast is needed.
>>
>> (Although my understanding is also that in C it's fine to pass a
>> uint32_t* to a function expecting a void*, so the second cast would
>> also not be needed.)

I do not think c99 allows this in 100% of cases - specifically if there a const void * involved. gcc does not care. I do not think c89 cares either. I will watch out for it when this is merged.
--Randall

