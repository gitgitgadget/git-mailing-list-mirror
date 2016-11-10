Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E2420229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756170AbcKJX00 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:26:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50715 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755920AbcKJX0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:26:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 932744D263;
        Thu, 10 Nov 2016 18:26:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iBSWeypx02AV9vVOuu+IB4z75OY=; b=iD/gme
        PBv01H+J2L0a7gCnqGnr09BU4B4oVZ8PPm5K4bt4/MAb4CCpYOxMYQQJD6PCUBDx
        NT0xEJuXD/YnkbPHry7SZX5VNo4kncskumwcBtI4sX4Jm/13YI0LkTfyYOZFd1oR
        AVAD8IlkZiUGywaUbdY4p0p0GnOo4BNfITh6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hiJX+jesAoWXqpuI3MgJZKgEVjvYvAjW
        V6yopijt+xHZOsOd/DutxwsmT1fqW1s9nbgrxs0MQQ1Kezbxt0VFk7BvZpIafITu
        F9Gkbgcc8FYxvr+MpbNKSy4aZZe0hzDKM7qjtyEe5vb0CPnNs7ucfuWgLhBlZFgA
        stU4ELJvYRY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89CC64D262;
        Thu, 10 Nov 2016 18:26:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF0A54D25F;
        Thu, 10 Nov 2016 18:26:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-4-Karthik.188@gmail.com>
        <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com>
Date:   Thu, 10 Nov 2016 15:26:22 -0800
In-Reply-To: <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com>
        (Jacob Keller's message of "Tue, 8 Nov 2016 15:22:52 -0800")
Message-ID: <xmqqoa1m5335.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 183FE3BA-A79D-11E6-82EC-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> @@ -49,6 +51,10 @@ static struct used_atom {
>>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>>                         unsigned int nlines;
>>                 } contents;
>> +               struct {
>> +                       const char *if_equals,
>> +                               *not_equals;
>
>
> Same here, why do we need both strings here stored separately? Could
> we instead store which state to check and store the string once? I'm
> not sure that really buys us any storage.

I am not sure if storage is an issue, but I tend to agree that it
would be semantically cleaner if this was done as a pair of <what
operation uses this string constant?, the string constant>, and the
former would be enum { COMPARE_EQUAL, COMPARE_UNEQUAL}.

You could later enhance the comparison operator more easily with
such an arrangement (e.g. if-equals-case-insensitively).
