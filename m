Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061E42018E
	for <e@80x24.org>; Mon,  8 Aug 2016 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbcHHQI4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 12:08:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752185AbcHHQIz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 12:08:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E441A34A44;
	Mon,  8 Aug 2016 12:08:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YEYXx6SCdNfPl1TTV6Gmd93r/Uo=; b=AbMTQB
	BLkNyy4rd6EwMygsemFW/zeC+DASqSGFXvhAyqeZXLRSSGAcjDm2x+gRi0lbWiWA
	RQ+yrBnbOM60RAaG7esGV8lhnXSw1Rrj7sMe3fjAnu28quRJCKYoqE58CqJg27Z+
	kjyr0V1G+KxSxFh2MnEmkpXJKIoKRmGO1RbWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=on1WY8T5jt9/zLdtElxEv0xPBCUovJCb
	2YnJGYbGTipI6c/scCnqK4SK/renQYeF8G/0zQgzswgyU0UIl9zrQm04lOycYEA8
	b0znalbmIuz0ZbGQZJ0IIYYxFbonBubuThlLilT97XjqJtT7hVhm6kgxPKM9rkgK
	6jfR9blnXqw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC03034A43;
	Mon,  8 Aug 2016 12:08:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65BC234A42;
	Mon,  8 Aug 2016 12:08:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Kirill Smelkov <kirr@nexedi.com>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074656.23813-1-kirr@nexedi.com>
	<xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
	<20160808123734.GA3995@teco.navytux.spb.ru>
	<20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
Date:	Mon, 08 Aug 2016 09:08:51 -0700
In-Reply-To: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 8 Aug 2016 09:50:20 -0400")
Message-ID: <xmqqk2frgs4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E6FA0E-5D82-11E6-82B9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 08, 2016 at 03:37:35PM +0300, Kirill Smelkov wrote:
> ...
>   static int want_object_in_pack(...)
>   {
> 	...
> 	if (!exclude && local && has_loose_object_nonlocal(sha1))
> 		return 0;
>
> 	if (*found_pack) {
> 		int ret = want_found_object(exclude, *found_pack);
> 		if (ret != -1)
> 			return ret;
> 	}
>
> 	for (p = packed_git; p; p = p->next) {
> 		off_t offset;
>
> 		if (p == *found_pack)
> 			offset = *found_offset;
> 		else
> 			offset = find_pack_entry(sha1, p);
> 		if (offset) {
> 			... fill in *found_pack ...
> 			int ret = want_found_object(exclude, p);
> 			if (ret != -1)
> 				return ret;
> 		}
> 	}
> 	return 1;
>   }
>
> That's a little more verbose, but IMHO the flow is a lot easier to
> follow (especially as the later re-rolls of that series actually muck
> with the loop order more, but with this approach there's no conflict).

I agree; Kirill's version was so confusing that I couldn't see what
it was trying to do with "pack1_seen" flag that is reset every time
loop repeats (at least, before got my coffee ;-).  A helper function
like the above makes the logic a lot easier to grasp.

>>  static int add_object_entry(const unsigned char *sha1, enum object_type type,
>>  			    const char *name, int exclude)
>>  {
>> -	struct packed_git *found_pack;
>> -	off_t found_offset;
>> +	struct packed_git *found_pack = NULL;
>> +	off_t found_offset = 0;
>>  	uint32_t index_pos;
>>  
>>  	if (have_duplicate_entry(sha1, exclude, &index_pos))
>> @@ -1073,6 +1088,9 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
>>  	if (have_duplicate_entry(sha1, 0, &index_pos))
>>  		return 0;
>>  
>> +	if (!want_object_in_pack(sha1, 0, &pack, &offset))
>> +		return 0;
>> +
>
> This part looks correct and easy to understand.

Yes.
