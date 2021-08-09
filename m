Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E15EC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D9604DC
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhHIRbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:31:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55557 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhHIRbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:31:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B90B9CE99C;
        Mon,  9 Aug 2021 13:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nr+ruoBDGs5Pmf3Xn/KIFTGUeULhWcDW3qaU4m
        Q5OCI=; b=jBdRKFwZpqFqB/qznXGjKytW/VMj0bvhoQYFsknv8ihUZpM8lZE9JG
        RIChMR+e+xjTTQHmB5nn6X1+yDZjiAZi9I/+hxitMKpCKqa2jOpDgzZO70wv62ru
        AuW5cB2kAYQjuD8fs/RTeo6t4fe+AbAWwZrDMUSbqICtw3tCPPMko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0A2CCE99B;
        Mon,  9 Aug 2021 13:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BD7FCE99A;
        Mon,  9 Aug 2021 13:31:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport: no warning if no server wait-for-done
References: <20210806214612.1501980-1-jonathantanmy@google.com>
Date:   Mon, 09 Aug 2021 10:31:18 -0700
In-Reply-To: <20210806214612.1501980-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 6 Aug 2021 14:46:12 -0700")
Message-ID: <xmqqh7fyfrtl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B663230-F937-11EB-8D2C-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the push.negotiate configuration variable was implemented in
> 477673d6f3 ("send-pack: support push negotiation", 2021-05-05), Git was
> taught to print warning messages whenever that variable was set to true
> but push negotiation didn't happen. However, the lack of push
> negotiation is more similar to things like the usage of protocol v2 - in
> which the new feature is desired for performance, but if the feature
> is not there, the user does not intend to take any action - than to
> things like the usage of --filter - in which the new feature is desired
> for a certain outcome, and if the outcome does not happen, there is a
> high chance that the user would need to do something else (in this case,
> for example, reclone with "--depth" if the user needs the disk space).
>
> Therefore, when pushing with push.negotiate set to true, do not warn if
> wait-for-done is not supported for any reason (e.g. if the server is
> using an older version of Git or if protocol v2 is deactivated on the
> server). This is done by using an internal-use-only parameter to "git
> fetch".

Hmph, if this were a hard error, instead of "print warning
messages", the above discussion is entirely reasonable.  But I am
not sure if squelching the warning unconditionally, especially given
that the feature is relatively young, is a good idea.

I suspect that you are trying to hide the "failed" message that may
sound more alarming then it should be from the end users, but if
that is the case, wouldn't it be a better solution to reword the
message to tone it down?

> -	if (finish_command(&child)) {
> -		/*
> -		 * The information that push negotiation provides is useful but
> -		 * not mandatory.
> -		 */
> -		warning(_("push negotiation failed; proceeding anyway with push"));
> -	}

Perhaps like "optional ancestry negotiation failed---pushing
normally" or some phrasing that assures the users that pushing
without negotiation is perfectly normal?
