Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218681F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 05:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdKIFrO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 00:47:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751135AbdKIFrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 00:47:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B77CEA0F12;
        Thu,  9 Nov 2017 00:47:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X15HlVjwsyc3/054o83LQK1qIb0=; b=afAiiu
        tGfgh9qHNcST9UCDhRsNsJC/JtttTMF0f0kjAjZjN53sIlYO0wxhoZs5VE3dOBb7
        By3sAN/3cH910nAFqTWP/1QxlCji6LhD2399kdf7onnTvS357o3S67JJ//n0580I
        3TuPLoPdYThxSGJF8thGWzFSX0dU3GE1EyueQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c/tgwVjxD3nIXDGxIgNwcuxjpB7KXH+j
        yD3X0HHUXdRZCe9HJQ7iBk0qyz5W7xmS6S5jhRoW46lPkhtrBPTZCw3SlIxddCMb
        IdbAPHHYEAa6F+ZAhE7/jDLbNYngmF2CpGkpjJlxhDKcPY38d7JMzuC7CcQ/CNZ+
        ckn/ZJkQXp4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF901A0F10;
        Thu,  9 Nov 2017 00:47:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28775A0F0D;
        Thu,  9 Nov 2017 00:47:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [RFD] Long term plan with submodule refs?
References: <20171108143646.2e1870a82360072557094e01@google.com>
        <20171109001007.11894-1-sbeller@google.com>
        <20171108172945.33c42a0e91b4ac494217b788@google.com>
Date:   Thu, 09 Nov 2017 14:47:10 +0900
In-Reply-To: <20171108172945.33c42a0e91b4ac494217b788@google.com> (Jonathan
        Tan's message of "Wed, 8 Nov 2017 17:29:45 -0800")
Message-ID: <xmqq7ev0j95t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EC84776-C511-11E7-A274-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> What if, in the submodule, we have a new ref backend that mirrors the
> superproject? When initializing the submodule, its original refs are not
> cloned at all, but instead virtual refs are used.
> ...
> These rules seem straightforward to me (although I have been working
> with Git for a while, so perhaps I'm not the best judge), and I think
> leads to a good workflow, as discussed below.

Indeed this is intriguing.

> The above rules allow the following workflow:
>  - "checkout --recurse-submodules" the branch you want on the
>    superproject
>  - make whatever changes you want in each submodule
>  - commit each individual submodule (which updates the index of the
>    superproject), then commit the superproject (we can introduce a
>    commit --recurse-submodules to make this more convenient)

The "recurse" option would also give users an extra atomicity, and
would not be merely for convenience; when a user wants to treat a
superproject and its two submodules as if the combined whole were a
single repository, there shouldn't be two separate commits in the
history of the superproject only because two submodules made one
commit each to work on a single theme that spans all of them.

