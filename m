Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0FC120C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbdLHRn6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:43:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57630 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753267AbdLHRnz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:43:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F9AEAB38C;
        Fri,  8 Dec 2017 12:43:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cToU55TnQ8IkpscPXOOv2Z8Xk64=; b=G3nvfD
        Zt1n4B8lVH9bNhFJHBVUQUM7s8y01HEZMq+LAhLRnjmbbGJUeQCz5xpAR46Ygi3p
        GY3y54Ulz2PyW/cxbmPI2CUi7vac9jXNzV7L+cZ5bqn1KJGlVz6FC4Xci7QnEvR7
        c7N0MTdyDiTx2MrgZKLqxXqQqiKfQJtCyP4g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QsTnXWI3screNQh0azcylB37JoNy9uj4
        YWOylJFUJxZxU2OUs5Evm1BCXKLkleoXpdJCyOHPN9InYLbUQ5LxlukSgeQqd4J2
        RUmbHcUvPf/9snO42e4k8JXbUuLFOTiNdDedp7o9Wf3CX+EiCCFl4cwqthEiuk/0
        aMende/qPG0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05D73AB38B;
        Fri,  8 Dec 2017 12:43:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BC56AB389;
        Fri,  8 Dec 2017 12:43:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Adric Norris <landstander668@gmail.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build platform, too
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
        <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
        <20171208172324.GB14261@aiede.mtv.corp.google.com>
Date:   Fri, 08 Dec 2017 09:43:53 -0800
In-Reply-To: <20171208172324.GB14261@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 8 Dec 2017 09:23:24 -0800")
Message-ID: <xmqq374l9kti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C1D3042-DC3F-11E7-A700-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -390,6 +390,7 @@ const char *help_unknown_cmd(const char *cmd)
>>  
>>  int cmd_version(int argc, const char **argv, const char *prefix)
>>  {
>> +	static char build_platform[] = GIT_BUILD_PLATFORM;
>>  	int build_options = 0;
>>  	const char * const usage[] = {
>>  		N_("git version [<options>]"),
>> @@ -413,6 +414,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>>  
>>  	if (build_options) {
>>  		printf("sizeof-long: %d\n", (int)sizeof(long));
>> +		printf("machine: %s\n", build_platform);
>
> Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
> of a mutable static string?  That is, something like
>
> 		printf("machine: %s\n", GIT_BUILD_PLATFORM);

Good point.  And if this is externally identified as "machine",
probably the macro should also use the same word, not "platform".
We can go either way, as long as we are consistent, though.

>> --- a/help.h
>> +++ b/help.h
>> @@ -33,3 +33,16 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
>>   */
>>  extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
>>  #endif /* HELP_H */
>> +
>> +/*
>> + * identify build platform
>> + */
>> +#ifndef GIT_BUILD_PLATFORM
>> +	#if defined __x86__ || defined __i386__ || defined __i586__ || defined __i686__
>> +		#define GIT_BUILD_PLATFORM "x86"
>> +	#elif defined __x86_64__
>> +		#define GIT_BUILD_PLATFORM "x86_64"
>> +	#else
>> +		#define GIT_BUILD_PLATFORM "unknown"
>> +	#endif
>> +#endif
>
> This code needs to be inside the HELP_H header guard.

Certainly.

Thanks.
