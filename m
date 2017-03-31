Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5FB1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbdCaST7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 14:19:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52941 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933370AbdCaST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 14:19:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3EB27C21D;
        Fri, 31 Mar 2017 14:19:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G7gr30wtcr59CYsqC+6wIJ32Cx0=; b=H+JgTJ
        /GJEzHcofhLB9hgz6DmOnalTfcFztmFejyfxNfNCY0KId1nWpbT9Ql1uH5mjv4E2
        lDI85oFixPX4/Mi2p8V4WxRN2ZSjUGKCjC/pX25mpbgvIjB6PdBe/0po3d1WtTyO
        6+HZWTrq4wTsViDuYrMUUEQdwQxUvGc98dvQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n0MvQSNddR6FCQyTV/9QXk95lzn/Oph4
        dW6UuB4/BD/ii8rSTJXDRhxYRu/EneDd8DJm0q/G8gzfwv2CF+LPNgJ1nikSYCj9
        eBPnBVn65OcHZ2GP/64c/AymiHK5AzX3IyzeC6Jeka2QasCdytHJiiEYKJsSjoGW
        kjT6rKJRhIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA5047C21C;
        Fri, 31 Mar 2017 14:19:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2246E7C21B;
        Fri, 31 Mar 2017 14:19:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: SHA1 collision in production repo?! (probably not)
References: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
        <xmqqh929z6wl.fsf@gitster.mtv.corp.google.com>
        <20170331174515.j2ruifuigskyvucc@sigill.intra.peff.net>
        <20170331174827.zheqstwtlsqtxa6e@sigill.intra.peff.net>
Date:   Fri, 31 Mar 2017 11:19:54 -0700
In-Reply-To: <20170331174827.zheqstwtlsqtxa6e@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 31 Mar 2017 13:48:27 -0400")
Message-ID: <xmqq4ly9z4tx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A47CE912-163E-11E7-B0BC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 31, 2017 at 01:45:15PM -0400, Jeff King wrote:
>
>> I suspect this may improve things, but I haven't dug deeper to see if
>> there are unwanted side effects, or if there are other spots that need
>> similar treatment.
>> 
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 43990dec7..38411f90b 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2952,7 +2952,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>>  	if (status && oi->typep)
>>  		*oi->typep = status;
>>  	strbuf_release(&hdrbuf);
>> -	return 0;
>> +	return status;
>>  }
>>  
>>  int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
>
> Er, no, that's totally wrong. "status' may be holding the type. It
> should really be:
>
>   return status < 0 ? status : 0;

Sounds more like it.  The only caller will say "ah, that object is
not available to us---let's try packs again", which is exactly what
we want to happen.

There is another bug in the codepath: the assignment to *oi->typep
in the pre-context must guard against negative status value.  By
returning an error correctly like you do above, that bug becomes
more or less irrelevant, though.



