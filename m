Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C6C1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbdLVXrN (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:47:13 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:24792 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756065AbdLVXrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:47:12 -0500
Received: from [IPv6:2a01:e34:ef19:d4a0:202d:ed17:5458:2741] (unknown [IPv6:2a01:e34:ef19:d4a0:202d:ed17:5458:2741])
        (Authenticated sender: julien.dusser)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 3CEDE200381;
        Sat, 23 Dec 2017 00:47:08 +0100 (CET)
Subject: Re: [PATCH] Fix urlencode format string on signed char.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20171222172437.19505-1-julien.dusser@free.fr>
 <xmqqk1xeph6r.fsf@gitster.mtv.corp.google.com>
From:   Julien Dusser <julien.dusser@free.fr>
Message-ID: <9073fcc7-c751-5563-81c8-d4992eefd298@free.fr>
Date:   Sat, 23 Dec 2017 00:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1xeph6r.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for review. I didn't find any other error.
Code in http.c:quote_ref_url() is almost the same but ch is a signed 
int, so there's no issue.

Le 22/12/2017 à 22:48, Junio C Hamano a écrit :
> Julien Dusser <julien.dusser@free.fr> writes:
> 
>> Git credential fails with special char in password.
>> remote: Invalid username or password.
>> fatal: Authentication failed for
>>
>> File ~/.git-credential contains badly urlencoded characters
>> %ffffffXX%ffffffYY instead of %XX%YY.
>>
>> Add a cast to an unsigned char to fix urlencode use of %02x
>> on a char.
>>
>> Signed-off-by: Julien Dusser <julien.dusser@free.fr>
>> ---
>>   strbuf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index 323c49ceb..4d5a9ce55 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -658,7 +658,7 @@ static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
>>   		    (!reserved && is_rfc3986_reserved(ch)))
>>   			strbuf_addch(sb, ch);
>>   		else
>> -			strbuf_addf(sb, "%%%02x", ch);
>> +			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
>>   	}
>>   }
> 
> The issue is not limited to credential but anywhere where we need to
> show a byte with hi-bit set, and it is obvious and straight-forward.
> 
> I briefly wondered if the data type for the strings involved in the
> codepaths that reach this place should all be "uchar*" but it feels
> strange to have "unsigned char *username" etc., and the signeness
> matters only here, so the patch smells like the best one among other
> possibilities.
> 
> Thanks.
> 

