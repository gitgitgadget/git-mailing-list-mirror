Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBB62018B
	for <e@80x24.org>; Mon, 18 Jul 2016 19:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcGRTK6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 15:10:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751563AbcGRTK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 15:10:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E39F72CB48;
	Mon, 18 Jul 2016 15:10:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O27/w1O+VtRCJw/ONKgHJAYT3xo=; b=MqjLtk
	Vr/KMxVNoS1wDR+A6MCCSl73w5ocBOg9vnoXC3X3QJHe5bG2kepGkvrdLuMagyhP
	OCqU1R6kVko4hLaaPphv5JdNjwAeawm9v5+xTedpCPIYKjO/dCDXyanmI2SDVvMP
	g5POcz519TQbZxpyTwE2vFHqQCWF/SFcg2zo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qk8lIp4kY80yKRtr62A/ufUAzBjVy9M7
	IRpB1YQL4JkpKehNkFaZok1hSfa01ZcLen2E82CrZGYxMJNfL3e4USV/hSWKBZT0
	1TpiDuntaY5LeLZl1Rmf8Pl4WGSA6DRlSSrQDzz7IP7I5hxUL/f1zZgJacNhO35T
	44eITTZAuuY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAAFC2CB47;
	Mon, 18 Jul 2016 15:10:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DFB72CB45;
	Mon, 18 Jul 2016 15:10:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
	sbeller@google.com
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
	<20160718185527.GB29326@google.com>
Date:	Mon, 18 Jul 2016 12:10:52 -0700
In-Reply-To: <20160718185527.GB29326@google.com> (Jonathan Nieder's message of
	"Mon, 18 Jul 2016 11:55:28 -0700")
Message-ID: <xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59985BB2-4D1B-11E6-8CA4-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Yay, thanks for this.
>
> When this condition triggers (count >= 10240), we have already
> experienced 10 rounds of negotiation.  Negotiation ought to have
> finished by then.  So this is a pretty conservative change to try to
> salvage an already bad situation.
>
> The condition ensures that the exponential growth will go faster
> than the previous heuristic of linear growth.
>
> Memory usage grows with the number of 'have's to be sent.  Linear
> growth didn't bound memory usage. This exponential growth makes memory
> usage increase faster, but not aggressively so and the unbounded
> memory usage is already something we'd want to address separately to
> handle hostile servers.
>
> All in all, this looks likely to allow negotiation to finish in fewer
> rounds, speeding up fetch, without much downside, so for what it's
> worth,
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> I'd expect us to need more aggressive improvements to negotiation in the
> end (e.g. finding a way to order SHA-1s sent as 'have's to finish in
> fewer rounds).  But this is a good start.  Thanks for writing it.

Sorry, while I agree with the general sentiment that the windowing
heuristics can be improved, from your description, I would have
expected an updated curve goes like "aggressive exponential ->
conservative exponential -> slow linear", but the new comparison
reads the other way around, i.e. "aggressive exponential -> slow
linear -> conservative exponential".

I'd understand if it were more like "aggressive exponential ->
conservative exponential" without linear phase when stateless_rpc is
in use, though.  I just do not quite understand the justification
behind the order of three phases introduced by this change.


>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index b501d5c..3fcbda2 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -251,6 +251,8 @@ static int next_flush(struct fetch_pack_args *args, int count)
>>  
>>  	if (count < flush_limit)
>>  		count <<= 1;
>> +	else if (args->stateless_rpc && count >= flush_limit * 10)
>> +		count = count * 11 / 10;
>>  	else
>>  		count += flush_limit;
>>  	return count;
