Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FC31FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdJFE0v (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:26:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750768AbdJFE0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:26:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 623B0A9758;
        Fri,  6 Oct 2017 00:26:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bcJLG3ovKgBSkj153KZpA5hIdj4=; b=UBj2+B
        lCFSthA5MafDUogLRHzyVOO6v4SNT6cN6ZGmRTUPZn529qSlAjikEPH0eQZY7W+y
        g20qslR4Bj47qu9+/MQtcZ+ycCM/sUv96xBaRRgKVEzPwfl4IlGIExEtTt60+CVj
        I8IjrVfzUTuPqpmwh1Mmc7hHmvVmJMHB/w5mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kSkeffk8se8CZWS1RJSGuv1IF029Rxj7
        1arMbvHOkSTroetNvWCsx+qT0VuH1B0DensfefNMVoASPWhZIRujSsjK/WMqSVYt
        ABOEam1VWmfHXw0UAYuEySpGSYDv6YWFIIsXGW1J5bct08fY2pfL+3di+zpbpLUF
        M3kugyyh7Xo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AA24A9757;
        Fri,  6 Oct 2017 00:26:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB8E8A9756;
        Fri,  6 Oct 2017 00:26:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 2/2] entry.c: check if file exists after checkout
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
        <20171005104407.65948-3-lars.schneider@autodesk.com>
        <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net>
Date:   Fri, 06 Oct 2017 13:26:48 +0900
In-Reply-To: <20171005112355.lsoqxybgsovpqriy@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Oct 2017 07:23:55 -0400")
Message-ID: <xmqqlgkoyk8n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92668F04-AA4E-11E7-9AFF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/entry.c b/entry.c
>> index 5dab656364..2252d96756 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -355,7 +355,8 @@ static int write_entry(struct cache_entry *ce,
>>  	if (state->refresh_cache) {
>>  		assert(state->istate);
>>  		if (!fstat_done)
>> -			lstat(ce->name, &st);
>> +			if (lstat(ce->name, &st) < 0)
>> +				return error("unable to get status of file %s", ce->name);
>
> We could probably be a bit more specific about the situation, since the
> user will see this message with no context. Maybe something like:
>
>   unable to stat just-written file %s
>
> or something. We should probably also use error_errno(). I'd bet if this
> ever triggers that it's likely to be ENOENT, but certainly if it _isn't_
> that would be interesting information.

ENOTDIR and to a lesser degree EACCES and ELOOP are also
uninteresting, as we are talking about somebody else mucking with
the filesystem.

To tie the loose end, here is what will be queued and merged to
'next' soonish.

Thanks.

-- >8 --
From: Lars Schneider <larsxschneider@gmail.com>
Date: Thu, 5 Oct 2017 12:44:07 +0200
Subject: [PATCH] entry.c: check if file exists after checkout

If we are checking out a file and somebody else racily deletes our file,
then we would write garbage to the cache entry. Fix that by checking
the result of the lstat() call on that file. Print an error to the user
if the file does not exist.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 entry.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/entry.c b/entry.c
index f879758c73..6d9de3a5aa 100644
--- a/entry.c
+++ b/entry.c
@@ -341,7 +341,9 @@ static int write_entry(struct cache_entry *ce,
 	if (state->refresh_cache) {
 		assert(state->istate);
 		if (!fstat_done)
-			lstat(ce->name, &st);
+			if (lstat(ce->name, &st) < 0)
+				return error_errno("unable stat just-written file %s",
+						   ce->name);
 		fill_stat_cache_info(ce, &st);
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
-- 
2.15.0-rc0-155-g07e9c1a78d

