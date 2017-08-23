Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3760620899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932572AbdHWTwo (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:52:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932531AbdHWTwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:52:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93C7CA8492;
        Wed, 23 Aug 2017 15:52:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OBOYZvNueQiEF6ddP2Yly/3mvk8=; b=m61EgY
        n8j4hRIBi8i7quY/8VgpHLObuUgDsb54NvkzMgkN6+xZrPxOhvCfAIb01jSsSfZk
        KAZVwlxfByG5Crq873zl6zs85pvOPLdqaA7trcS/Q9CzA74XRRGAU6XpoS3bq5VY
        V9iIKnh5cN6TPa+s96/upHSH5sK6IqRIUs2Cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TqI4reN6tn9IsaT7h4Kgk122PJBI0CNv
        V+FPXBar0e/cULFIZ9YldVHbC5wnIwbutCwTAy2n9hkGksshzo0J+kV/HExhYxI3
        EKTuE3SVcj3ULvlGfCUvgd2D59Ouva7QTTTPZCx2dwgy8H54ROCdlHIAPXUz6rnS
        +zctfPI+A80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89E08A8490;
        Wed, 23 Aug 2017 15:52:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3E26A848E;
        Wed, 23 Aug 2017 15:52:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v2 2/4] submodule--helper: introduce for_each_submodule()
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
        <20170823181506.8557-1-pc44800@gmail.com>
        <20170823181506.8557-3-pc44800@gmail.com>
        <xmqqbmn6yu5u.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbTHkcK8-rwpJbwy-v3NcfvVq=TbvVRG189bq4S9w14GA@mail.gmail.com>
Date:   Wed, 23 Aug 2017 12:52:40 -0700
In-Reply-To: <CAGZ79kbTHkcK8-rwpJbwy-v3NcfvVq=TbvVRG189bq4S9w14GA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 23 Aug 2017 12:31:13 -0700")
Message-ID: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FE64D74-883C-11E7-855A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Aug 23, 2017 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Prathamesh Chavan <pc44800@gmail.com> writes:
>>
>>> +typedef void (*submodule_list_func_t)(const struct cache_entry *list_item,
>>> +                                   void *cb_data);
>>> +
>>>  static char *get_default_remote(void)
>>>  {
>>>       char *dest = NULL, *ret;
>>> @@ -353,17 +356,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
>>>       return 0;
>>>  }
>>>
>>> -static void init_submodule(const char *path, const char *prefix, int quiet)
>>> +static void for_each_submodule(const struct module_list *list,
>>> +                            submodule_list_func_t fn, void *cb_data)
>>
>> In the output from
>>
>>         $ git grep for_each \*.h
>>
>> we find that the convention is that an interator over a group of X
>> is for_each_X,
>
> ... which this is...
>
>> the callback function that is given to for_each_X is
>> of type each_X_fn.
>
> So you suggest s/submodule_list_func_t/each_submodule_fn/

It's not _I_ suggest---the remainder of the codebase screams that
the above name is wrong ;-).  Didn't it for the mentors while they
were reading this code?

>> An interator over a subset of group of X that
>> has trait Y, for_each_Y_X() iterates and calls back a function of
>> type each_X_fn (e.g. for_each_tag_ref() still calls each_ref_fn).
>
> This reads as a suggestion for for_each_listed_submodule
> as the name.

If you need to have two ways to iterate over them, i.e. (1) over all
submodules and (2) over only the listed ones (whatever that means),
then yes, for_each_listed_submodule() would be a good name for the
latter which would be a complement to for_each_submodule() that is
the former.

>
>> I do not offhand think of a reason why the above code need to
>> deviate from that pattern.
