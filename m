Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889801FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 00:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdJSAg7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 20:36:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751060AbdJSAg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 20:36:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB709B33AF;
        Wed, 18 Oct 2017 20:36:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k2i9jkPSBg5gLFRZOMGwv2IC01A=; b=fBE8lv
        QLjK42kt1ItmZtRzK1uBz6ch28ZNoEXE8M2KqkdLwJ1cZnNhu/ENIbspi9wSTPit
        QNHpk+Ix3Z/c0pAKpuNjZItCFnsnTV9zsgTTT2/F4kFI5/h502ZPZbFKFpiXW10t
        Hrhi+jtm0j14lV/6nlDOchseYAg6WeONXyFgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lUby2Ajh6uVikAuQzu4PUhQiZfVw/vsU
        wJ4imv8Tch9ZuF7CHjJ3WIkQXj1479m0QTPsF1wFrFOVoS8w+3G50LVFfwJGcEdt
        MP7qQxpstCR/SkmGDGjmxJHeLdt6El7I6yOUsPGlRSx1whyFy2y+JpVKUKdVd0t+
        O/Xgbrdpt7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C39FCB33AE;
        Wed, 18 Oct 2017 20:36:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37742B33A8;
        Wed, 18 Oct 2017 20:36:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>, sbeller@google.com,
        jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or not to fetch
References: <20171016135623.GA12756@book.hvoigt.net>
        <20171016135905.GD12756@book.hvoigt.net>
        <20171018180322.GA155019@google.com>
Date:   Thu, 19 Oct 2017 09:36:47 +0900
In-Reply-To: <20171018180322.GA155019@google.com> (Brandon Williams's message
        of "Wed, 18 Oct 2017 11:03:22 -0700")
Message-ID: <xmqqshegj7mo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97601022-B465-11E7-AAD1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 10/16, Heiko Voigt wrote:
>> To make extending this logic later easier.
>
> This makes things so much clearer, thanks!

I agree that it is clear to see what the code after the patch does,
but the code before the patch is so convoluted to follow that it is
a bit hard to see if the code before and after are doing the same
thing, though ;-)

>
>> 
>> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>> ---
>>  submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
>>  1 file changed, 37 insertions(+), 37 deletions(-)
>> 
>> diff --git a/submodule.c b/submodule.c
>> index 71d1773e2e..82d206eb65 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1187,6 +1187,31 @@ struct submodule_parallel_fetch {
>>  };
>>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
>>  
>> +static int get_fetch_recurse_config(const struct submodule *submodule,
>> +				    struct submodule_parallel_fetch *spf)
>> +{
>> +	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
>> +		return spf->command_line_option;
>> +
>> +	if (submodule) {
>> +		char *key;
>> +		const char *value;
>> +
>> +		int fetch_recurse = submodule->fetch_recurse;
>> +		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
>> +		if (!repo_config_get_string_const(the_repository, key, &value)) {
>> +			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
>> +		}
>> +		free(key);
>> +
>> +		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
>> +			/* local config overrules everything except commandline */
>> +			return fetch_recurse;
>> +	}
>> +
>> +	return spf->default_option;
>> +}
>> +
>>  static int get_next_submodule(struct child_process *cp,
>>  			      struct strbuf *err, void *data, void **task_cb)
>>  {
>> @@ -1214,46 +1239,21 @@ static int get_next_submodule(struct child_process *cp,
>>  			}
>>  		}
>>  
>> -		default_argv = "yes";
>> -		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
>> -			int fetch_recurse = RECURSE_SUBMODULES_NONE;
>> -
>> -			if (submodule) {
>> -				char *key;
>> -				const char *value;
>> -
>> -				fetch_recurse = submodule->fetch_recurse;
>> -				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
>> -				if (!repo_config_get_string_const(the_repository, key, &value)) {
>> -					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
>> -				}
>> -				free(key);
>> -			}
>> -
>> -			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
>> -				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
>> -					continue;
>> -				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
>> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
>> -									 submodule->name))
>> -						continue;
>> -					default_argv = "on-demand";
>> -				}
>> -			} else {
>> -				if (spf->default_option == RECURSE_SUBMODULES_OFF)
>> -					continue;
>> -				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
>> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
>> -									  submodule->name))
>> -						continue;
>> -					default_argv = "on-demand";
>> -				}
>> -			}
>> -		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
>> -			if (!unsorted_string_list_lookup(&changed_submodule_names,
>> +		switch (get_fetch_recurse_config(submodule, spf))
>> +		{
>> +		default:
>> +		case RECURSE_SUBMODULES_DEFAULT:
>> +		case RECURSE_SUBMODULES_ON_DEMAND:
>> +			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
>>  							 submodule->name))
>>  				continue;
>>  			default_argv = "on-demand";
>> +			break;
>> +		case RECURSE_SUBMODULES_ON:
>> +			default_argv = "yes";
>> +			break;
>> +		case RECURSE_SUBMODULES_OFF:
>> +			continue;
>>  		}
>>  
>>  		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
>> -- 
>> 2.14.1.145.gb3622a4
>> 
