Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379C120133
	for <e@80x24.org>; Mon,  6 Mar 2017 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbdCFWYq (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 17:24:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61379 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753707AbdCFWYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 17:24:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC31370053;
        Mon,  6 Mar 2017 16:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=le0ZnngcdST4RVtenAjQTNpd3qg=; b=c/obQk
        gx42a2KhbN253km/30EjeB+2aBBjoEUPj24Pt+9vP+0IaniogfAkEHcsDAMXF4uT
        W41LAo52DnxrA7YtJvVlSchhUPPsBfRto61mrD9NTGY13y7wytOhOEQGIGlcznQn
        6SKTag5JmLZhUDL0NA4GfbX1dqLToO/YuiBoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=huIBepr3h7c3bUyqwXdTDIVO8ieNq2Zy
        cf0/pYGywIDV+zZ+7ZnXDdObeH3yBl3331lOsOGmwsZsVYIkxeQ+cAJa0ToYsfqz
        UM8rPiz0etPyOq6GYPQeWl9xAK7aprC8KNgI+XKt/qApLXcrK4nlURtwPqIvy+YY
        kSINwlQxn0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5BFC70052;
        Mon,  6 Mar 2017 16:08:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 189FC70051;
        Mon,  6 Mar 2017 16:08:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
        <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com>
Date:   Mon, 06 Mar 2017 13:08:40 -0800
In-Reply-To: <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com> (Lars
        Schneider's message of "Sat, 4 Mar 2017 18:32:34 +0100")
Message-ID: <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13B42D64-02B1-11E7-9E8B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 04 Mar 2017, at 00:26, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> 
>> * ls/filter-process-delayed (2017-01-08) 1 commit
>> . convert: add "status=delayed" to filter process protocol
>> 
>> Ejected, as does not build when merged to 'pu'.
>
> I send v2 [1] where I tried to address the points in your feedback [2].

Ah, I took a look at it back then and then forgot about it.  I'll
try to see if I can replace the stale one I have and merge it to
'pu'.

> v2 not the final roll. My goal for v2 is to get the interface
> to convert.h right.

You sound like you are trying to make the interface to the callers
finalized before doing further work, but after re-reading the
exchange between you and Peff in that thread [*1*], I am not sure
that is feasible to begin with.  

For example, your async_convert_to_working_tree() returns Success or
Delayed [*2*] and the callers of write_entry() cannot tell which the
paths on the filesystem needs a call to checkout_delayed_entries()
to finish them before they can safely tell the outside world that
these paths are safe to use.  

It seems to me that any caller that calls checkout_entry() needs to
essentially do:

	- compute which entries in the index need to be checked out
          to the filesystem;

	- for each of them:
		- call checkout_entry()

	- call checkout_delayed_entries(), because among the
          checkout_entry() calls we did in the above loop, some of
          them may have "delayed", but we do not know which one(s).

Output from "git grep -e checkout_delayed_entries -e checkout_entry"
seems to tell me that at least builtin/apply.c and
builtin/checkout-index.c forget the last step.

I'd understand the design better if the delayed-item list were a
part of the "struct checkout" state structure, and write_entry(),
when delaying the write, returned enough information (not just "this
has been delayed") that can be used to later instruct the
long-running filter process things like "you gave me this 'delayed'
token earlier; I want the result for it now!", "are you finished
processing my earlier request, to which you gave me this 'delayed'
token?", etc.  One of these instructions could be "here is the
path. write the result out for the earlier request of mine you gave
me this 'delayed' token for.  I do not need the result in-core.  And
take as much time as you need--I do not mind blocking here at this
point."  In a future, a new instruction may be added to ask "please
give me the result in-core, as if you returned the result to my
earlier original async_convert_to_working_tree() call without
delaying the request."

Within such a framework, your checkout_delayed_entries() would be a
special case for finalizing a "struct checkout" that has been in
use.  By enforcing that any "struct checkout" begins its life by a
"state = CHECKOUT_INIT" initialization and finishes its life by a
"finish_checkout(&state)" call, we will reduce risks to forget
making necessary call to checkout_delayed_entries(), I would think.


[References and Footnotes]

*1* http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/

*2* By the way, the code in write_entry() should have a final else
clause that diagnoses an error return from
async_convert_to_working_tree() and act on it---an unexpected return
will fall through to the code that opens output fd and
