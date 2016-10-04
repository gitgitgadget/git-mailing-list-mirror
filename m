Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DE020986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbcJDRfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:35:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53663 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751146AbcJDRfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:35:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 848DF42DF0;
        Tue,  4 Oct 2016 13:35:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pClxO8v8mG9u3ZeA7nW2OugNMkw=; b=bYIuI5
        hc7haRgtEafnxa+cIz1j8taoZW6yuJxcmO/nAk+MkJBo+uMo4udrgEMxhiujMjan
        McNPLatrPKARaWfZpur22jMYcVu5B4aFVdU+6kiQgEcC3z1zBo63UPdVzXDVZKX2
        +TAY6XiiayYe5K8/CmqXjXvwYUpFc715763Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p3FnEWCH4wYtPHQmla3X+AQUMMkJkmM3
        Y+ixiSdb8Rl7qcGPIYr5XQIS8Rc5iUWAsbFkQAhNmq18RM+gB9koUqVACzOQ1x+W
        qlNEdLa6aiI/A7H+98Gd3TQk674LHWR7DqKRHCqR5NigbAHvH2xZGz4eo3Eh1hgS
        1XFZoPbbgOk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C67D42DEF;
        Tue,  4 Oct 2016 13:35:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0874642DEE;
        Tue,  4 Oct 2016 13:35:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 1/4] git: make super-prefix option
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
        <1475185723-36871-1-git-send-email-bmwill@google.com>
        <1475185723-36871-2-git-send-email-bmwill@google.com>
        <CAGZ79kax9g-FLMhPnDBP+7wJwYT884B5bGodpopo9GKgnE6+PQ@mail.gmail.com>
Date:   Tue, 04 Oct 2016 10:35:12 -0700
In-Reply-To: <CAGZ79kax9g-FLMhPnDBP+7wJwYT884B5bGodpopo9GKgnE6+PQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 4 Oct 2016 10:31:51 -0700")
Message-ID: <xmqqoa30uien.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E84CAEB0-8A58-11E6-B24B-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 29, 2016 at 2:48 PM, Brandon Williams <bmwill@google.com> wrote:
>
>>
>> +const char *get_super_prefix(void)
>> +{
>> +       if (!super_prefix)
>> +               super_prefix = getenv(GIT_SUPER_PREFIX_ENVIRONMENT);
>> +       return super_prefix;
>> +}
>> +
>
> As said earlier, is the following a valid thought:
>
>> The getenv() function returns a pointer to the value in the
>> environment, or NULL if there is no match.
>> So in case this is not set (when e.g. the user did not specify the
>> super prefix), we would probe it a couple of times.
>> The caching effect only occurs when the string is set. So this looks
>> like we save repetitive calls, but we do not always do that.

That reading is correct.  If the code wants to do the caching, it
should do so correctly.  Unless we expect that some callers might
want to be able to invalidate the cache,

	get_super_prefix(void)
	{
		static int initialized;
		if (!initialized) {
			super_prefix = getenv(...);
			initialized = 1;
		}
                return super_prefix;
	}                

would suffice.

Thanks for careful reading.
