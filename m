Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5482095B
	for <e@80x24.org>; Tue, 21 Mar 2017 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbdCURto (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 13:49:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63328 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757315AbdCURsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 13:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CBA36E39F;
        Tue, 21 Mar 2017 13:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PENcFGZj7cgeFJbTosZL7Ze6bRg=; b=hi7qPK
        +ai/x383wyXHF5u9kcI9HhddUeawLo6Z4GW4+Pk/UFrOUdP/fE3Exw8SORxxCAAz
        T49wnjohzoTQqFhcdrHlLyi9sDqybu1tgSS3cN7rdSwdP6H9bIVjxPSmz/hDM8kr
        X3pDLaFlCvOnObLYF+263wqJJWb6hdoYZ/OjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BCDi49ygbBSc5Wis7k4kmmavKPa3/tc5
        7X3IUE9qdhg+EO3IWldCFFwLYAqyPHoCpKf1ZXUm22TQxEFInVIDrKXnyQSrOI3p
        WuGguYW5Z1ARhnDLOGSCZ9RTGerkzDeJzgi5qTiWAhNI0fORetlvYR+R/DtnlwwK
        bbsxqO8X7/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04FC26E39E;
        Tue, 21 Mar 2017 13:43:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 572E86E39D;
        Tue, 21 Mar 2017 13:43:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #02; Fri, 3)
References: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
        <5C8A09B2-0C99-4BD9-A82B-B333EF1F155E@gmail.com>
        <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>
        <BA6E546F-3594-4673-A43B-7E4D4CEA8F68@gmail.com>
Date:   Tue, 21 Mar 2017 10:43:13 -0700
In-Reply-To: <BA6E546F-3594-4673-A43B-7E4D4CEA8F68@gmail.com> (Lars
        Schneider's message of "Tue, 21 Mar 2017 09:28:47 +0100")
Message-ID: <xmqqd1dasez2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBFE69DA-0E5D-11E7-9C3C-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Agreed. Would it be OK to store the "delayed" bit in the cache
> entry itself? The extended ce_flags are stored on disk which is not
> necessary I think. Would a new member in the cache_entry struct be
> an acceptable option?

I'd imagine that those with thousands of cache entries in their
index prefer not to bloat sizeof(struct cache_entry) for something
like this, that is _only_ used during the write-out phase.  Would a
new pointer in the "struct checkout" that points at whatever data
structure you need (perhaps a "string_list"?) work?  As long as the
pointer points at a constant thing, you may not even have to loosen
the constness of "struct checkout *" itself?

>> Within such a framework, your checkout_delayed_entries() would be a
>> special case for finalizing a "struct checkout" that has been in
>> use.  By enforcing that any "struct checkout" begins its life by a
>> "state = CHECKOUT_INIT" initialization and finishes its life by a
>> "finish_checkout(&state)" call, we will reduce risks to forget
>> making necessary call to checkout_delayed_entries(), I would think.
>
> Agreed. How would you want to enforce "finish_checkout(&state)", though?
> By convention or by different means?

We can start with "convention", just like "if you did STRBUF_INIT,
you must do strbuf_release() at some point" has served us well, I
would think.

Thanks.
