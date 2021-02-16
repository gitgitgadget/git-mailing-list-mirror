Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE6C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D879A64E7A
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 22:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhBPW6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:58:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56624 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBPW6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 17:58:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1CB669ED20;
        Tue, 16 Feb 2021 17:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3Y2CfPN0NN5hw7wgGxf8/ZgG0h8=; b=GVHSES
        BNmg2TMMsLWF+BmBNYYG/XiID+sk/ZS5EjtM078bbLKjLNzuO3t1qE+z7l9xDTzh
        GnA5J/a0kDZDTqyU8oNcEHYnec+hWuZDOkqXhwrJQxDnh6u3ylkYoKtqukowIy9/
        xrCO+OIEtv2kT/pqNIwORuJ+9AZRYmmftE68E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CpJ5zvxdvzUOMIJDuA2M9qGgZcfFoBN2
        cbM+1dHgO0V2tol1HnjR7kdsOcJYiuhcMpYU1BeQWHIlNF6EOOaXMRR/l1g7pO60
        9MUIUeyeKbYWrsRZ5Ro7dWf9BrkQAgTtkr/f+QybjiHRSMBO9fUcpcoLfhAvouJ4
        8WMZk97dbqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0ABDC9ED1F;
        Tue, 16 Feb 2021 17:57:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54E509ED1E;
        Tue, 16 Feb 2021 17:57:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] http-fetch: allow custom index-pack args
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
        <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
        <YCwvycbylJ9O4qx8@google.com>
Date:   Tue, 16 Feb 2021 14:57:38 -0800
In-Reply-To: <YCwvycbylJ9O4qx8@google.com> (Josh Steadmon's message of "Tue,
        16 Feb 2021 12:49:13 -0800")
Message-ID: <xmqqpn0zoc2l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E4B6B2E-70AA-11EB-A603-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>> +--index-pack-args=<args>::
>> +	For internal use only. The command to run on the contents of the
>> +	downloaded pack. Arguments are URL-encoded separated by spaces.
>
> I'm a bit skeptical of using URL encoding to work around embedded
> spaces. I believe in Emily's config-based hooks series, she wrote an
> argument parser to pull repeated arguments into a strvec, could you do
> something like that here?
>
> I'm sympathetic to the idea that since this is an internal-only flag, we
> can be a bit weird with the argument format, though.

We tend to prefer quote.c::sq_quote*() suite of quoting; does this
codepath have very different constraints that require different
encoding?

Thanks.
