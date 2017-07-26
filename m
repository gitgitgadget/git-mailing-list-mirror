Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C27A2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 21:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdGZVGM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 17:06:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750996AbdGZVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 17:06:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE95691C41;
        Wed, 26 Jul 2017 17:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7jsmLhoKPrIm1gKHNNuhp2wmR+I=; b=jR+7XC
        v1mBW9sNLe3aV921rEFiGq6xk0xtTrN6QM6LMPBMkqP7lJ9s4t9Yz//wrQJyOQNr
        v7kDhIHg/X0oCfBfS7Ent3JXEHaQNw4doIQibXbrvK+S9epKsESHRd1322b1JwVN
        Q0z5Di2xPAI8WllWeqZ8qi1Q7xacItJv/BnIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mrfsDcHHsJqNLQeY69gW1jJnDhIHgpv2
        qZ2OTh+eWc1pP+TAjMZMo4eQxjHfyQ4y+9Ayb4ggizOJoAt5BbsDUTW28JtXEsoI
        hUwIug19smna0hu25IRKs5L3PUHUu+HeVWHIYIpO/m1F305elKn3sB5CJCdu0RWH
        XkuVUU6KKjM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1D7491C3E;
        Wed, 26 Jul 2017 17:06:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11BD591C3D;
        Wed, 26 Jul 2017 17:06:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
References: <20170725213928.125998-1-bmwill@google.com>
        <20170725213928.125998-3-bmwill@google.com>
        <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
Date:   Wed, 26 Jul 2017 14:06:03 -0700
In-Reply-To: <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
        (Stefan Beller's message of "Tue, 25 Jul 2017 16:17:42 -0700")
Message-ID: <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CCEB0F2-7246-11E7-A551-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Rereading the archives, there was quite some discussion on the design
> of these patches, but these lines of code did not get any attention
>
>     https://public-inbox.org/git/4CDB3063.5010801@web.de/
>
> I cc'd Jens in the hope of him having a good memory why he
> wrote the code that way. :)

Thanks for digging.  I wouldn't be surprised if this were a fallback
to help a broken entry in .gitmodules that lack .path variable, but
we shouldn't be sweeping the problem under the rug like that.  

I wonder if we should barf loudly if there shouldn't be a submodule
at that path, i.e.

	if (!submodule)
		die("there is no submodule defined for path '%s'"...);

though.

> Note that this is the last caller of submodule_from_name being
> removed, so I would expect removal of submodule_from_name from
> the t/helper/test-submodule-config.c as well as
> Documentation/technical/api-submodule-config.txt
> in a later part of this series. (Well technically it could go outside
> of the series, but in the mean time we'd document and test
> dead code)

Good thinking.  As this is "cleanup" series, I think it is within
its scope to remove an API function that becomes unused.

>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  submodule.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 7e87e4698..fd391aea6 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
>>                         continue;
>>
>>                 submodule = submodule_from_path(&null_oid, ce->name);
>> -               if (!submodule)
>> -                       submodule = submodule_from_name(&null_oid, ce->name);
>>
>>                 default_argv = "yes";
>>                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
>> --
>> 2.14.0.rc0.400.g1c36432dff-goog
>>
