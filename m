Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDD920437
	for <e@80x24.org>; Wed, 11 Oct 2017 05:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbdJKF6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 01:58:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55796 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754212AbdJKF6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 01:58:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 885BBA93BB;
        Wed, 11 Oct 2017 01:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m5xI4BsMCrX+xWW8+YMwQKayhno=; b=iafcdp
        Hdnirka/726OaIN8QlhfR3jHA9dT8PnWOGu3HQ1qiC3Of37E4OhY7d8BvEHQ4V0y
        mI4666O8rDcy0bXetHSpT94Avtofnnbbj0T65mzaGMFOsghT53P9DLHwlmqB0MX+
        NxAqhuPWt8kqceMG3xjneJqRHkehSoDUj9irk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rw2PV6Ex9pnaHqOPzIsiWvoOoOT6ILDT
        SeOuM1q+RUf7Hk8VsJ9nNd/yeDILCL08T+2mu86L26HfVrIZ1esXXLrgjIoESzyk
        bpaJM1/8Dwd3IS6Gan4gt6On20HaFD2AhCNJviLTcxJQjNvv0u0yl3CKEB60sFuP
        mlAKumZun/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA0AA93B9;
        Wed, 11 Oct 2017 01:58:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE12AA93B8;
        Wed, 11 Oct 2017 01:58:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
        <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 14:58:45 +0900
In-Reply-To: <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 06 Oct 2017 14:10:07 +0900")
Message-ID: <xmqqvajmmdii.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EE6D6E6-AE49-11E7-BF45-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
>
> No verb?  s/optionally/report/ perhaps?

I just noticed that I didn't tweak the copy I have in my tree after
sending this message, but now I did s/optionally/& report the/;

I am still puzzled by the hunk below, though.

>> @@ -1262,6 +1265,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>>  			*s = xstrdup(remote);
>>  		else
>>  			*s = "";
>> +	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
>> +		int explicit, for_push = starts_with(atom->name, "push");
>
> Hmph, the previous step got rid of starts_with() rather nicely by
> introducing atom->u.remote_ref.push bit; can't we do the same in
> this step?
>
> Other than that, looks nicer.

Thanks.
