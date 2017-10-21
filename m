Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496D7202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbdJUBzv (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 21:55:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64789 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753222AbdJUBzu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 21:55:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1CB5B5DF8;
        Fri, 20 Oct 2017 21:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RZ1xfyAzvJDe0ldjMH/uvHkA3CM=; b=VxYgG4
        /u3rR3CaSEL4JKF5KBBAbwiTPcfzSu0VMLZBK5dgyhbozuN6MqzBQSsv9efeVe4x
        CkOQJruZJLhhQBCAX/eQW6vCEaqOI9PxENd/loqmEXTUlxElfn1MxjXPo5yw5z4V
        jxRvg8mnGOLEa5Dg90e9xU0cXri5px554v6CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AI0YvqehlOv3l9NqmztTHSyNy2BYR3l+
        s4p2zXMX431df+NizpHbtcL2f66496FKY1EOSbmO2jfcgA674oUY9KyZBq17S1a7
        WAiPfrs8kwHH+woSW15JwUs9BoU4nBboJURHmlkQfNDzAomn5d12mKS16bJBY4GA
        wgcSfp+XJGE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9EF8B5DF7;
        Fri, 20 Oct 2017 21:55:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26926B5DF6;
        Fri, 20 Oct 2017 21:55:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache entry order to speed index loading
References: <20171018142725.10948-1-benpeart@microsoft.com>
        <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com>
        <db8da340-f8f5-0114-392d-e415b5564993@gmail.com>
        <CAGZ79kZfw7Cb8Qs4BKuESukBL8rCgmYh0=BcNYm9mXJ1LYCg0g@mail.gmail.com>
        <alpine.DEB.2.21.1.1710201444590.40514@virtualbox>
        <CAGZ79kZ_WjnH-vM84C8cE-jS=V=p4tGSiwXX3cKwbDOUvUs_dA@mail.gmail.com>
Date:   Sat, 21 Oct 2017 10:55:46 +0900
In-Reply-To: <CAGZ79kZ_WjnH-vM84C8cE-jS=V=p4tGSiwXX3cKwbDOUvUs_dA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 20 Oct 2017 11:53:25 -0700")
Message-ID: <xmqqbml1gt7h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4DC74FE-B602-11E7-BC47-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There was a recent thread (which I assumed was the one I linked), that talked
> about security implications as soon as we loose the rather strict "git
> is to be used
> in a posix world", e.g. sharing your repo over NFS/Dropbox. The
> specific question
> that Peff asked was how the internal formats can be exploited. (Can a malicious
> index file be crafted such that it is not just a segfault, but a
> 'remote' code execution,
> given that you deploy the maliciously crafted file via NFS. Removing checks that
> we already have made me a bit suspicious that it *may* be helping an
> attacker here,
> though I have no hard data to show)
>
> Sorry for the confusion,

Thanks for an explanation, as I had the same reaction as Dscho
initially.  I'd assumed that the worst would be to create a wrong
state (e.g. the same path registered twice with different contents
in the index, a malformed tree written out of it, etc.), but that's
merely an assumption not the result of an audit.

