Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6E91F461
	for <e@80x24.org>; Thu, 16 May 2019 23:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfEPXNW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:13:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55447 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:13:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58A3371B7C;
        Thu, 16 May 2019 19:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bv02mEOBSDqpSB6wszfxyu07dk0=; b=sXl0mi
        1891Ox6MCpt8GpsVoo1L0PrZJGu3J0rvKA53d0yqJSLpcaw/R5jKHOFy3aoRBhjV
        F4TR4x4WcL+ZnFOud/nAMcEVfzPSK6h7zwm/tKeXSdJFIAY/xJ1H2ARO3ZCo15yQ
        gJzy0/Gel0zt9d5bS69inlxMUyJx/0IZum8hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FUp3fBCtH/5o4YDOCr17Ocm3ibpzsVfh
        T1tWmYAWDdK7OLJjUyafq/ogI7bvbBbBRF52+MWZ50uY3meHd1IIyydWDxngLBJa
        BdvFIA5/dZVj+lcjB5U0ciCpJL+9idVCdKjL9V0cI9CmwhPkEh8vsm46i9+r1vcX
        wMSDup7Nsd8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3ADE671B7B;
        Thu, 16 May 2019 19:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B64B71B7A;
        Thu, 16 May 2019 19:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
References: <20190508105607.178244-1-gitster@pobox.com>
        <20190508105607.178244-1-gitster@pobox.com>
        <5cddeb61.1c69fb81.47ed4.e648@mx.google.com>
Date:   Fri, 17 May 2019 08:13:15 +0900
In-Reply-To: <5cddeb61.1c69fb81.47ed4.e648@mx.google.com> (Stephen Boyd's
        message of "Thu, 16 May 2019 15:59:44 -0700")
Message-ID: <xmqqh89u3sdw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 303CB5D6-7830-11E9-B709-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen Boyd <swboyd@chromium.org> writes:

>> As can be seen in this change the only place where we actually want to
>> do something clever is with the to/cc/bcc variables, where setting
>> them on the command-line (or using --no-{to,cc,bcc}) should clear out
>> values we grab from the config.
>> 
>> All the rest are things where the command-line should simply override
>> the config values, and by reading the config first the config code
>> doesn't need all this "let's not set it was on the command-line"
>> special-casing, as [1] shows we'd otherwise need to care about the
>> difference between whether something was a default or present in
>> config to fix the bug in e67a228cd8.
>
> This broke my workflow.
>
> I specify --identity=<account> on the commandline and I want that to
> pick out my send-email config from my global .gitconfig file that
> corresponds to that identity. With this change, the config is parsed
> before the getopt part so --identity on the commandline is a nop and
> never looks into the config file to figure this out. So at least
> --identity is special in addition to --to,cc,bcc.

Ah, sorry that nobody noticed that case, but you are right.  Because
the ident is used as a part of the key to find identity-specific
configuration values, if the command line gives one, we must have an
access to it before we start reading the configuration.  In that sense,
it is more fundamental to special-case the option.

We are past -rc0, so I am inclined to revert the change (and perhaps
replace it with the other "fix" that did not break the parsing order
like these patches did), with an expectation that a clever fix will
be found later, *unless* a simple and correct fix is found quickly.

