Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250671FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbcHQVcj (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:32:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752488AbcHQVci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:32:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B794937C85;
	Wed, 17 Aug 2016 17:31:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SxqkB98epZddM9aIhgapqCJs7HM=; b=KBeDwz
	Zn+WkY6Q/bLWhy7cZ0bImCQy7idcDEV7yFmPvLkZtSHUioxsTWz4QyC3k4BQj+ek
	0g1lRJ/mNz/OhkM7qOMdnhi7Ptp9l+nVfPgXirp1M6AMJZiLp4uK156/srYuUzKg
	tb1oR0dh1J8vpJpdIW4YZ5vtHY/TUOG+fojOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b15StELH1RfbdiTVY9OI6yLQR21YvPUB
	wtXNQzKeAfhTWdo6VWX+0XHhZvuvl5fvHgS770vSHC3jYLoJpvxocjaE//wMA4bN
	ENwDcLQDobmykPweKwP8xKycHqEXTj0WappvzOJkenI8JbZFLXRnRV3XdwMQY23f
	bqy3vrfqxWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AED5737C84;
	Wed, 17 Aug 2016 17:31:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3307F37C83;
	Wed, 17 Aug 2016 17:31:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv4 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160811231405.17318-1-sbeller@google.com>
	<20160811231405.17318-9-sbeller@google.com>
	<xmqqr39n88pg.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 17 Aug 2016 14:31:40 -0700
In-Reply-To: <xmqqr39n88pg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 17 Aug 2016 13:02:51 -0700")
Message-ID: <xmqqd1l784lf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD48362A-64C1-11E6-ADE4-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> +static void prepare_possible_alternates(const char *sm_name,
>> +		struct string_list *reference)
>> +{
>> +	char *sm_alternate = NULL, *error_strategy = NULL;
>> +	struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
>> +
>> +	git_config_get_string("submodule.alternateLocation", &sm_alternate);
>> +	if (!sm_alternate)
>> +		return;
>> +
>> +	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
>
> I have to admit that I need to follow the codepath in config.c every
> time to check, but I _think_ git_config_get_string() gives you your
> own copy of the value.  As this function does not give ownership of
> sm_alternate or error_strategy to something else, they are leaked
> every time this function is called, I think.
>
>> +	sas.submodule_name = sm_name;
>> +	sas.reference = reference;
>> +	if (!strcmp(error_strategy, "die"))
>> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;

Another thing I noticed but forgot to mention.  Can error_strategy
be NULL here?  We are assuming sm_alternate can be, so I presume
that it is sensible to protect against dereferencing a NULL here,
too?

>> +	if (!strcmp(error_strategy, "info"))
>> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;
>> +	if (!strcmp(sm_alternate, "superproject"))
>> +		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
>> +}
