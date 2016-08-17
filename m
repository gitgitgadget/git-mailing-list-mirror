Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927F11FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 20:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbcHQUC4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 16:02:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753435AbcHQUCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 16:02:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA40337185;
	Wed, 17 Aug 2016 16:02:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=333fBSUcr/49FAILTAbaCU1am3g=; b=HKZLP3
	eLeT+6Mh6Ke0J/ezMSQhDfWrGJrw4DJ4dVBayATgj0uImlRzjDriB/aDYcB/hA+f
	BUdag4XVON+Rf9LTRijumfGrW8oVU/uiDe78iJwmVKS7oVZ+9Qci8fLvvavRvDZC
	0JIy0uUWAz4Hky1v9dCfr3OQCaAffqxXp9YCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RIYTvA4AYCo2uJEFxY6uE2kF+YPinKj7
	nyAvLua4mSlqXctLyp8HwdRFPBXoqVCXogshY4qibMpXidod/nRVVvbbIQOEuGpv
	Lz6jgOORHpzL1jGsR+ncNXbtmiRgi2XempJPMpEBYGI0DZKQSq/RTuektFoXy5Lt
	1fNoaFiw/90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EA937184;
	Wed, 17 Aug 2016 16:02:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7650537183;
	Wed, 17 Aug 2016 16:02:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv4 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160811231405.17318-1-sbeller@google.com>
	<20160811231405.17318-9-sbeller@google.com>
Date:	Wed, 17 Aug 2016 13:02:51 -0700
In-Reply-To: <20160811231405.17318-9-sbeller@google.com> (Stefan Beller's
	message of "Thu, 11 Aug 2016 16:14:05 -0700")
Message-ID: <xmqqr39n88pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 951D2E5E-64B5-11E6-95AB-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static void prepare_possible_alternates(const char *sm_name,
> +		struct string_list *reference)
> +{
> +	char *sm_alternate = NULL, *error_strategy = NULL;
> +	struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
> +
> +	git_config_get_string("submodule.alternateLocation", &sm_alternate);
> +	if (!sm_alternate)
> +		return;
> +
> +	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);

I have to admit that I need to follow the codepath in config.c every
time to check, but I _think_ git_config_get_string() gives you your
own copy of the value.  As this function does not give ownership of
sm_alternate or error_strategy to something else, they are leaked
every time this function is called, I think.

> +	sas.submodule_name = sm_name;
> +	sas.reference = reference;
> +	if (!strcmp(error_strategy, "die"))
> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;
> +	if (!strcmp(error_strategy, "info"))
> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;
> +	if (!strcmp(sm_alternate, "superproject"))
> +		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
> +}
