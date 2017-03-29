Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CA2020958
	for <e@80x24.org>; Wed, 29 Mar 2017 21:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbdC2VbU (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 17:31:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58095 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752050AbdC2Va3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 17:30:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D440783D0E;
        Wed, 29 Mar 2017 17:30:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lz1GL5Sdtd9IDwHvI39duaLcOK4=; b=a2UOwm
        3JNruVibQy9Flu89a3JTV+gTbPlIT+ZLxulW+zrcHDeUUP7DVf9LO6qacaR+Csv6
        WjJSYUprs0DaBTnBHskjK4XAqeZ+tBK/0fOMSt4yJXhTI+xG34gJJz3K+6qNdw6o
        0oJ6aR05UWhNz44tH+qTqee2V1zAEIRJxQOIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xsprdzSRaN07iGuVOK/LIXnD2/oFyl0X
        gv2vtCX5360EVMo8dA5g3ZBLBK0kaD7t3VBXjRFDsvyrjxHdr6Aa/4RwnKxu44Nq
        jeHkJ0zzPhhuHAWj+YI5cmr0/5JJF7TByuZiO5wKLp0fG0P9pWdOivEY6Yl619Z8
        qP36vqQiljk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD57383D0D;
        Wed, 29 Mar 2017 17:30:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 405D883D0A;
        Wed, 29 Mar 2017 17:30:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] entry.c: submodule recursing: respect force flag correctly
References: <20170329183743.27506-1-sbeller@google.com>
        <20170329184519.GW31294@aiede.mtv.corp.google.com>
Date:   Wed, 29 Mar 2017 14:30:11 -0700
In-Reply-To: <20170329184519.GW31294@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 29 Mar 2017 11:45:19 -0700")
Message-ID: <xmqq37dvahzw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED246902-14C6-11E7-A111-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> In case of a non-forced worktree update, the submodule movement is tested
>> in a dry run first, such that it doesn't matter if the actual update is
>> done via the force flag. However for correctness, we want to give the
>> flag is specified by the user.
>
> "for correctness" means "to avoid races"?

Sorry, but neither explanation makes much sense to me.

The codepath the patch touches says "if the submodule is not
populated, then checkout the submodule by switching from NULL
(nothing checked out) to the commit bound to the index of the
superproject; otherwise, checkout the submodule by switching from
HEAD (what is currently checked out) to the commit in the index".

Where does that "tested in a dry run first" come into play?
Whatever code calls checkout_entry(), does it call it twice, first
with a "--dry-run" option and then without one?  How does this
codepath respond differently to these two invocations, and how does
this change affect the way these two invocations behave?



>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  entry.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/entry.c b/entry.c
>> index d2b512da90..645121f828 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -287,7 +287,7 @@ int checkout_entry(struct cache_entry *ce,
>>  			} else
>>  				return submodule_move_head(ce->name,
>>  					"HEAD", oid_to_hex(&ce->oid),
>> -					SUBMODULE_MOVE_HEAD_FORCE);
>> +					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>
> Looks like a good change.
>
> This moves past the 80-column margin.  I wish there were a tool like
> gofmt or clang-format that would take care of formatting for us.
>
> This isn't the only place SUBMODULE_MOVE_HEAD_FORCE is used in the
> file.  Do they need the same treatment?
>
> Thanks,
> Jonathan
