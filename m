Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979D7202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdIVBj2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:39:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751790AbdIVBj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:39:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC813A5F38;
        Thu, 21 Sep 2017 21:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Uz9Co+ef0m2OD0JNxgqmWbQBRcA=; b=KgJpCl
        3838H/wjITr+fUd4aGkME3WVHkGMBOhmmm6s97nTwEgsnNSVOYNHhEI24PvkYlCs
        OAh8hf/iMEOdwe/JCSPuyMB8Ainosd0yt98PGwXBiuZWMaGvUXQ9lu5tI0XBdhEG
        sugIXNA1MxNBFIDqXqiS+kNH7iudGly6CuXoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MIFUFf745KTVx+OKuaHsXV+pj0H/vDgw
        USiwHyef/58vgTL6o7r2RJyPq5/XJJ3NuqJ2l8fv5FXNfX+TvG2703SYvpmS22A7
        lo5POwk6iincx32Ghmk1ABnpm6O4E8jPqZpN9k5G/hlYqrS4C3BrGpgq+4MeYeHc
        B964W7tLn94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2C3DA5F37;
        Thu, 21 Sep 2017 21:39:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF6C4A5F36;
        Thu, 21 Sep 2017 21:39:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        bmwill@google.com
Subject: Re: [PATCH v3] connect: in ref advertisement, shallows are last
References: <20170922000004.GB77641@google.com>
        <20170922000801.22560-1-jonathantanmy@google.com>
        <xmqqd16jmtjb.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 22 Sep 2017 10:39:23 +0900
In-Reply-To: <xmqqd16jmtjb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 22 Sep 2017 10:06:00 +0900")
Message-ID: <xmqq7ewrmrzo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE04C318-9F36-11E7-B270-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Currently, get_remote_heads() parses the ref advertisement in one loop,
>> allowing refs and shallow lines to intersperse, despite this not being
>> allowed by the specification. Refactor get_remote_heads() to use two
>> loops instead, enforcing that refs come first, and then shallows.
>>
>> This also makes it easier to teach get_remote_heads() to interpret other
>> lines in the ref advertisement, which will be done in a subsequent
>> patch.
>
> Sounds sensible.  This still replaces the earlier 1.5?

Well, it does, but it also invalidates how the new "pick the version
offered and used" feature is integrated to this callchain.  I guess
we'd need a new "we are now expecting the version info" state in a
patch to replace "connect: teach client to recognize v1 server
response".

>> +static int process_ref(int *state, int len, struct ref ***list,
>> +		       unsigned int flags, struct oid_array *extra_have)
>> +{
>> +	struct object_id old_oid;
>> +	char *name;
>> +	int name_len;
>> +
>> +	if (len < GIT_SHA1_HEXSZ + 2 ||
>> +	    get_oid_hex(packet_buffer, &old_oid) ||
>> +	    packet_buffer[GIT_SHA1_HEXSZ] != ' ') {
>> +		*state = EXPECTING_SHALLOW;
>> +		return 0;
>> +	}
>> +
>> +	name = packet_buffer + GIT_SHA1_HEXSZ + 1;
>> +	name_len = strlen(name);
>> +	if (*state == EXPECTING_REF_WITH_CAPABILITIES &&
>> +	    len != name_len + GIT_SHA1_HEXSZ + 1) {
>> +		free(server_capabilities);

Is this free() still needed?  After hitting this block, you'd set
*state to EXPECTING_REF before you return, so nobody would set
server_capabilities by hitting this block twice, and an attempt to
do so will hit the die("unexpected cap") below, no?

Or it may be a signal that this patch tightens it too much and
breaks older or third-party implementations of the other side that
can emit more than one refs with capability advertisement?

>> +		server_capabilities = xstrdup(name + name_len + 1);
>> +	} else if (*state == EXPECTING_REF) {
>> +		if (len != name_len + GIT_SHA1_HEXSZ + 1)
>> +			die("unexpected capabilities after ref name");
>> +	}
>> +	...
>> +	}
>> +	*state = EXPECTING_REF;
>> +	return 1;
>> +}

>> @@ -123,76 +208,26 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>>  	 * willing to talk to us.  A hang-up before seeing any
>>  	 * response does not necessarily mean an ACL problem, though.
>>  	 */
>> -	int saw_response;
>> -	int got_dummy_ref_with_capabilities_declaration = 0;
>> +	int responded = 0;
>> +	int len;
>> +	int state = EXPECTING_REF_WITH_CAPABILITIES;
>>  
>>  	*list = NULL;

>> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
>> +		switch (state) {
>> +		case EXPECTING_REF_WITH_CAPABILITIES:
>> +		case EXPECTING_REF:
>> +			if (process_ref(&state, len, &list, flags, extra_have))
>> +				break;
>> +			/* fallthrough */

OK.  This fallthrough is because expecting-ref is really expecting
ref or shallow and once we see a shallow, we no longer expect ref
and expect only shallow.  So from that point of view, an assignment
to set state to EXPECTING_SHALLOW could happen here, not inside
process_ref.  I mention this because in general, passing state
around and let it be updated in helper functions would make the
state transition harder to follow, not easier, even though
refactoring the processing needed in different stages into helper
functions like this patch does ought to make it easier to see by
shrinking the outer loop (i.e. this one) that controls the whole
process.

I think if we split process_ref() further into two, then we no
longer need to pass &state to that function?  We start this loop
with "expecting the dummy ref (or other)" state, have a new
process_dummy_ref() function check if we got "capabilities^{}" thing
and do its thing if that is the case (otherwise we fall through to
the call to process_ref(), just like the above code falls through to
call process_shallow() when it realizes what it got is not a ref),
and after the first call to process_dummy_ref() we'd be in the
"expecting ref (or other)" state---and the state transition can
happen in this caller, not in process_dummy_ref() or process_ref().

Inside process_dummy_ref() and process_ref(), there would be a call
to the same helper that notices and extracts the server capability
and stores it (or barfs against the second line that advertises the
capability, by noticing that server_capabilities is not NULL).

Wouldn't that make the presentation of the state machine cleaner?


