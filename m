Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B3CC388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC232467F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rj8UkbcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgKQAkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:40:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57357 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgKQAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:40:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CA7DF81AD;
        Mon, 16 Nov 2020 19:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OP7imzGwJlhcOyZ+cwsX1yjKl94=; b=Rj8Ukb
        cP7wHD276AgfAR/iFgnfGX6e2Bkr1MZbJtqJgGF1DMTNW/vVUwHOSIs1TR+ayP25
        fKbXLonbDEnQ1a51KjGXMtKiWMhHTi2sk5poKfkmyN5M/Qw7MMxHnq2u48I2EOY1
        WJxqFBxic2e22PZQ9ErhdnwI+k1TSMO3H7VVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h5zbFZGFQyBdVZVr+iZ/j1/NU+J+N5YF
        2p0ZBSz2LNdbFb+UOmoVBJEhzBHzTAcPhTLOUw5dgRN0hibMCClOkT/P6u8TcCE9
        ivgdmwc2NGCkPx7PdeuQ62tjy/B6L3hMaOYKZ/31SDvH6GQAWijTjF9NVDm4y4Ck
        V0b+lfUmcE8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15B92F81AC;
        Mon, 16 Nov 2020 19:40:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 58FE1F81AB;
        Mon, 16 Nov 2020 19:40:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
        <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
        <20201116235642.GA15562@google.com>
Date:   Mon, 16 Nov 2020 16:40:35 -0800
In-Reply-To: <20201116235642.GA15562@google.com> (Emily Shaffer's message of
        "Mon, 16 Nov 2020 15:56:42 -0800")
Message-ID: <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82AC040E-286D-11EB-B627-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Because 'git maintenance unregister' spins a child process to call 'git
> config --unset maintenance.repo <cwd>', it actually fails if "cwd"
> contains a POSIX regular expression special character:
>
>   git config [<file-option>] --unset name [value_regex]

Good find.  And it is even worse that value_regex uses ERE, not BRE,
which means even an otherwise innocuous letter like '+' cannot be
used without quoting.

> You can demo it for yourself like so:
>
>   git init repro+for+maintenance
>   git maintenance register
>   git maintenance unregister
>   echo $?	# returns '5'
>   git config --list --global
>
> I see two paths forward:
>

0. Quote the value_regex properly, instead of blindly using a value
   that comes from the environment.

> 1. Teach 'git config' to learn either which regex parser to use
> (including fixed), or at least to learn "value isn't a regex", or
>
> 2. Don't spin a child process in 'git maintenance [un]register' and
> instead just call the config API.

> I'd suggest #2. The config API is very nice, and seems to have a simple
> way to add or remove configs to your global file in just a couple of
> lines. If there's a reason why it's not simpler to do it that way, it's
> my fault for missing the review :)

My short-to-mid-term preference is to do #1 to allow a value to be
spelled literally (i.e. remove entry with _this_ value, and add this
one instead), and optionally do #2 as an optimization that is not
essential.  I do not offhand know how you can make #2 alone fly
without doing some form of #1, as I think the same value_regex that
ought to be ERE to specify entries to be replaced needs to be used
under the cover even if you use "config API" anyway.

Thanks.





