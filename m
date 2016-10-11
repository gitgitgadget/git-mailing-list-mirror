Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BA81F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbcJKTuq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:50:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56662 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752580AbcJKTuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:50:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E85F42B06;
        Tue, 11 Oct 2016 15:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h7G6UmGHAbyYMZ/vU9DHR2frj7o=; b=HhNHTF
        SRz40zaZrGWoHlzIHNwFTKGRwTAdFEXIwQX1t4ie7gjHKqHJklm68QY7raSYRXKx
        Kkjb2sWWPQL3NlNs4NVfIwclnCz7MRC4MkPy9mAp93ZPmyJLvpN3c1UAqrXTdPD2
        oMvSClWuZfAqNQz5bvz8g4quhRf0rp5prFKgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RD3Tp42D63OFmE3PS/FzUaDeE6B4wFjG
        /EM3o5r7Y9EYUWwfgjl4nYnc+eKmWhpUEeEdIp2KES3UgcSyfmGflpJTG1qCAUvz
        m4Pc7MoNk8d7ZD2PEFwdYgRmNCGguWGaeSrF5JJMcegqi5R3COmhP6wdEifVVLEn
        jQm3zRUohao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26EC842B05;
        Tue, 11 Oct 2016 15:47:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C1AA42B03;
        Tue, 11 Oct 2016 15:47:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
References: <20161011002115.23312-1-sbeller@google.com>
        <20161011002115.23312-29-sbeller@google.com>
        <xmqqmviaaina.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaQKDdJfMOjDKEK_dZJhgj+R7rByQS++B3OOBy6uO1x2w@mail.gmail.com>
        <xmqqa8eaagoq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbdvs88Gt_XW801DPs7rj8kvcfPqCV7kjL_Jz9XiVn7fg@mail.gmail.com>
Date:   Tue, 11 Oct 2016 12:47:49 -0700
In-Reply-To: <CAGZ79kbdvs88Gt_XW801DPs7rj8kvcfPqCV7kjL_Jz9XiVn7fg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 11:56:04 -0700")
Message-ID: <xmqqeg3m8y6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 984B2B7E-8FEB-11E6-850B-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> You can have many different callsites (think: hits "git grep" finds)
>> that call git_attr_check_initl() and they all may be asking for
>> different set of attributes.  As long as they are using different
>> "check" instance to receive these sets of attributes, they are OK.
>
> Right, but that requires a mutex per callsite; up to now I imagined
> a global mutex only, which is how I came to the conclusion.

Hmph, why?  I agree it would make it easier to allow a mutex keyed
by the address of "check" to enhance parallelism, but I do not think
it _requires_ it, in the sense that if you were anticipating low
contention, one mutex to cover any and all callers to initl() would
still give you a correct result.

I wonder if we can assume and rely on atomicity of store, e.g. if we
can cheaply notice "ah this check is already initialized" without
locking.  Then initl() might become something like

    initl(char **variable, ...)
    {
	struct git_attr_check *check;

    	if (*variable)
            return; /* somebody else did it already */
        acquire lock;
        if (*variable) {
	    /* somebody else was about to finish when we checked earlier */
	    release lock;
	    return;
        }
	check = alloc();
	populate check;
	*variable = check;
	release lock;
    }

and once the system starts running and starts asking the same
question for thousands of paths, the majority of initl() calls
can still be almost no-op, like the original single-threaded

	static struct git_attr_check *check = NULL;
        if (!check)
		check = init();

can avoid heavyweight init() most of the time.
