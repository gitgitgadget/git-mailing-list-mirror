Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB76C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357588AbiALUMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 15:12:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50908 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357579AbiALUMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 15:12:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF65215A102;
        Wed, 12 Jan 2022 15:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EoRZHGg3+yU/BTOcus5GWv1EOiPI4kejvQ5ARN
        KmyKE=; b=aDeuhdrMJo27aF5eUV/1cZjJclusyK63Na8ZnO3pBsdcKo6UahTA6V
        3MIKx4YH9dJDlOzd8gBwJj6BrRRxT/kXcWAQxDY50svjqbNZ6XLF4wrULQEDbjv0
        g2yXUMJ2Jpc7kldoMhNo1v+niYb8YYLR6o4Qau/nJ9qwp1Pzy3SZk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B76EA15A0FF;
        Wed, 12 Jan 2022 15:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2B4CC15A0FE;
        Wed, 12 Jan 2022 15:12:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile: avoid overflowing shift during decode
References: <20211110234033.3144165-1-jonathantanmy@google.com>
        <xmqqpmr7v4gf.fsf@gitster.g>
        <5ab9257c-9eba-a171-86d6-3fe7d3a4faec@syntevo.com>
        <xmqq8rvku3bq.fsf@gitster.g>
Date:   Wed, 12 Jan 2022 12:12:34 -0800
In-Reply-To: <xmqq8rvku3bq.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 Jan 2022 12:06:01 -0800")
Message-ID: <xmqq4k68u30t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBDC574E-73E3-11EC-AB02-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Marc Strapetz <marc.strapetz@syntevo.com> writes:
>
>> On 11/11/2021 02:58, Junio C Hamano wrote:
>>> Jonathan Tan <jonathantanmy@google.com> writes:
>>> 
>>>> diff --git a/packfile.c b/packfile.c
>>>> index 89402cfc69..972c327e29 100644
>>>> --- a/packfile.c
>>>> +++ b/packfile.c
>>>> @@ -1068,7 +1068,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
>>>>   	size = c & 15;
>>>>   	shift = 4;
>>>>   	while (c & 0x80) {
>>>> -		if (len <= used || bitsizeof(long) <= shift) {
>>>> +		if (len <= used || (bitsizeof(long) - 7) <= shift) {
>>
>> This seems to cause troubles now for 32-bit systems (in my case Git
>> for Windows 32-Bit): `shift` will go through 4, 11, 18 and for 25 it
>> finally errors out. This means that objects >= 32MB can't be processed
>> anymore. The condition should probably be changed to:
>>
>> +		if (len <= used || (bitsizeof(long) - 7) < shift) {
>>
>> This still ensures that the shift can never overflow and on 32-bit
>> systems restores the maximum size of 4G with a final shift of 127<<25 
>> (the old condition `bitsizeof(long) <= shift` was perfectly valid for
>> 32-bit systems).
>
> Jonathan?


----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Date: Wed, 12 Jan 2022 12:11:42 -0800
Subject: [PATCH] packfile: fix off-by-one error in decoding logic

shift count being exactly at 7-bit smaller than the long is OK; on
32-bit architecture, shift count starts at 4 and goes through 11, 18
and 25, at which point the guard triggers one iteration too early.

Reported-by: Marc Strapetz <marc.strapetz@syntevo.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index d3820c780b..667e21ce97 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1067,7 +1067,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	size = c & 15;
 	shift = 4;
 	while (c & 0x80) {
-		if (len <= used || (bitsizeof(long) - 7) <= shift) {
+		if (len <= used || (bitsizeof(long) - 7) < shift) {
 			error("bad object header");
 			size = used = 0;
 			break;
-- 
2.35.0-rc0-170-g6a31d082e5
