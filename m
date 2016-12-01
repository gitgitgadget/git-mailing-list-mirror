Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264E31FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933599AbcLATyO (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:54:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934103AbcLATyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:54:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40F7B533CF;
        Thu,  1 Dec 2016 14:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u1byxgkFfFzpCwRVyWT63o3sgqk=; b=ngTFOa
        tlWVhvnUZSOH4xnb/7szP5tNdyWHO/M+/+NiBhsDKLaJL4ZOkoP720WjT2Q//Ue9
        gdefM6AdgpJqXBW1gA5UW+vEm7Wsf2JrOt5mR+bBvRRC+yHbTgN4HapVVTC5ImS0
        7ca+hQv7e/1J9y4MpnSvjEve7aW5HJ1AIncvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nFZLv9Yt82ookqUN4sK/mrPCWME6a9sp
        DfF4kN8oGctt2c/0AniJ02iifKPtK/zoxsGU2v1xyZmrQM1Kn+nvDGaboLzpGU1r
        6SPrayNwRSS49KCicKJ1oajaLP1cFA/yVaBTf+0cuGGxGMID1M7xAkzAy2mZSIoq
        soHnWqctf4Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 365E7533CE;
        Thu,  1 Dec 2016 14:54:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3073533CD;
        Thu,  1 Dec 2016 14:54:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v6 4/4] transport: check if protocol can be used on a redirect
References: <1478555462-132573-1-git-send-email-bmwill@google.com>
        <1480621447-52399-1-git-send-email-bmwill@google.com>
        <1480621447-52399-5-git-send-email-bmwill@google.com>
        <20161201195031.fd4uwmvkyhk4so7i@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 11:54:09 -0800
In-Reply-To: <20161201195031.fd4uwmvkyhk4so7i@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 14:50:31 -0500")
Message-ID: <xmqqbmwva0im.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED4831EE-B7FF-11E6-A4C2-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 01, 2016 at 11:44:07AM -0800, Brandon Williams wrote:
>
>> Add a the 'redirect' parameter to 'is_transport_allowed' which allows
>> callers to query if a transport protocol can be used on a redirect.
>
> s/a the/a/
>
>> -int is_transport_allowed(const char *type)
>> +int is_transport_allowed(const char *type, int redirect)
>>  {
>>  	const struct string_list *whitelist = protocol_whitelist();
>>  	if (whitelist)
>> @@ -735,7 +735,7 @@ int is_transport_allowed(const char *type)
>>  	case PROTOCOL_ALLOW_NEVER:
>>  		return 0;
>>  	case PROTOCOL_ALLOW_USER_ONLY:
>> -		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
>> +		return git_env_bool("GIT_PROTOCOL_FROM_USER", !redirect);
>>  	}
>
> This has the older logic still.
>
> I'm not sure if we should call this "redirect" here. That's how it's
> used by the curl code, but I think from the perspective of the transport
> whitelist, it is really "are you overriding the from_user environment".
>
> Calling it "from_user" may be confusing though, as the default value
> would become "1", even though it means only "as far as I know this is
> from the user, but maybe the environment says otherwise". So bizarrely,
> I think calling it "not_from_user" is the clearest value.

Bikeshedding: perhaps call it "unsafe" (in the sense that it is "not
known to be safe")?

