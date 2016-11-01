Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62ABD20229
	for <e@80x24.org>; Tue,  1 Nov 2016 19:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbcKATFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 15:05:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751469AbcKATFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 15:05:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ACC14AB64;
        Tue,  1 Nov 2016 15:05:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I2gqB3E3Qm/fFIlpaf6LnsAczRc=; b=D8IaIr
        ygkG3deXbvKy8ifziFYaEo1scupoHQUop+iXlfR5e6p3/NUHfK4CJQdcXRens573
        yHhH8nyh6NEK2rosBBeXuLDuNDfsDRq7o0T/U+XYvg2JsSmpKEXATztYGHVdKPlI
        Nn3A21dHCSoBNYX5DsAf/p5RrF455MuRzg+io=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lyOIem4Ypb8anHAo/nJ5wz+9dSlIF4HE
        WLIORj8q72zfhbGUI11Q0waCfr9gd1CfcOL5YWjZ+Zz3s25IFdd292qjaTzLwL/X
        jcB5M60GS0DOzSue7A7gp0DLcmEadyzuxBMkXtFMGZWeYHdvneMSLlfw9/q7HvYu
        QZQzgCt7sP0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 828414AB62;
        Tue,  1 Nov 2016 15:05:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E204AB61;
        Tue,  1 Nov 2016 15:05:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-6-chriscool@tuxfamily.org>
        <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
Date:   Tue, 01 Nov 2016 12:05:07 -0700
In-Reply-To: <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Oct 2016 17:00:45 +0700")
Message-ID: <xmqqlgx3owbg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B85D2CA-A066-11E6-B70A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index b75ea03..a14dbf2 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>         }
>>
>>         if (split_index > 0) {
>> +               if (git_config_get_split_index() == 0)
>> +                       warning("core.splitIndex is set to false; "
>> +                               "remove or change it, if you really want to "
>> +                               "enable split index");
>
> Wrap this string and the one below with _() so they can be translated.

True.  

I further wonder if a natural reaction from users after seeing this
message is "I do want to--what else would I use that option to run
you for?  Just do as you are told, instead of telling me what to
do!".  Is this warning really a good idea, or shouldn't these places
be setting the configuration?

>>                 if (the_index.split_index)
>>                         the_index.cache_changed |= SPLIT_INDEX_ORDERED;
>>                 else
>>                         add_split_index(&the_index);
>> -       } else if (!split_index)
>> +       } else if (!split_index) {
>> +               if (git_config_get_split_index() == 1)
>> +                       warning("core.splitIndex is set to true; "
>> +                               "remove or change it, if you really want to "
>> +                               "disable split index");
>>                 remove_split_index(&the_index);
>> +       }
>>
>>         switch (untracked_cache) {
>>         case UC_UNSPECIFIED:
>> --
>> 2.10.1.462.g7e1e03a
