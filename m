Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2021020756
	for <e@80x24.org>; Fri, 20 Jan 2017 21:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdATVm0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 16:42:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59909 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbdATVl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 16:41:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C8E5620B6;
        Fri, 20 Jan 2017 16:41:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=50B27WexR+CEAhcAPweLIQYBHXc=; b=hroJuh
        /vKMdt077UcqiQXXmfU10oNH3jJQKw86z8+s1ecS8ABBGKBJ2HZ4IR6Vg201rX5k
        ZNSSH6vlfsVyBFnYhJCzfivKD3LyWjmFQB9kx1vvq7y9VxD1I3JlmcVczerF9N7z
        fmRvS1XigOSEJYdxQWz9Mf6o8GTMDS+gy9POA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wHKI6o9QIqr3/NDy/Fhb0xQ7Wps+mi09
        T9lpJnpUF14cWG4YsDMAA5JB3ND+KuSVgTXm1ahogk9B741Y1huN2dqt183CIFQo
        gqhgSh1ckJ+QkWyGJ/payCw1lsyNvKXYKNblv1hs2cIWf7FkVNKEw5cYJJzHw04W
        h8/AZYC7kws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03F2F620B5;
        Fri, 20 Jan 2017 16:41:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FFB5620B4;
        Fri, 20 Jan 2017 16:41:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
References: <20170119193023.26837-1-sbeller@google.com>
        <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
        <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
        <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
        <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
        <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
Date:   Fri, 20 Jan 2017 13:41:54 -0800
In-Reply-To: <20170120200041.hefg44stddqe344z@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 20 Jan 2017 15:00:41 -0500")
Message-ID: <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43CFA4F4-DF59-11E6-AD27-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> And in my current understanding of submodules the check in
>> .gitmodules ought to be enough, too.
>
> Yeah, that probably makes sense. You can have a gitlink without a
> .gitmodules file, but I don't quite know what that would mean in terms
> of submodules (I guess it's not a submodule but "something else").

That may be a lot better than reading the index unconditionally, but
I'd rather not to see "git rev-parse" read ".gitmodules" at all.  It
would discourage scripted use of Git for no good reason.


