Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115792022A
	for <e@80x24.org>; Wed, 26 Oct 2016 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbcJZX7Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 19:59:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbcJZX7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 19:59:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A89749384;
        Wed, 26 Oct 2016 19:59:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bAhccc+SLp+68KXOodq6vrkMu3c=; b=bd/48k
        VjBM5sk2DVtqiUaHBaPvvrB0pq8c/b7KQ+7SAmydfXGsvM3Tzf05g33bmBKVKLof
        mncaQiSIADvlPXTcH9IjKro0zKUAdVtmzMDhGtvH6slfd6F9g+5ZW07xq6LireIp
        EIe0aftwwcQ69ONmm0AIfcYrFXl6nJe1U6gQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=winpRTnx7HP55vzs4FI9VAJEM9bw8O/Q
        QG75Ck3TkPM3J0JX9W9hEEXETwzwJANpXhcpOs7pwfDdEFYt/qgFIHmEvH3wGUIq
        r1E2nfbgxuphQuBACDNHmzWICuJaaJENYLyfnRqPh/SEiMkyUK4OQ9SD5u74lEO8
        fy9+ykuuYyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91CC049383;
        Wed, 26 Oct 2016 19:59:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0337849382;
        Wed, 26 Oct 2016 19:59:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and rebase
References: <1477523244.2764.114.camel@mattmccutchen.net>
        <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
Date:   Wed, 26 Oct 2016 16:59:20 -0700
In-Reply-To: <CAGZ79kaw0s_PC2AstRVwFT8N1CJVC_7yQfC19zPzRjAqkSpMDg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 26 Oct 2016 16:23:44 -0700")
Message-ID: <xmqqk2cuach3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 370E90DC-9BD8-11E6-9210-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> - We have to make separate commits and manage corresponding topic
>> branches for the superproject and subprojects.
>
> Well yeah, that is how submodule work on a conceptual level.
> While having multiple commits may seem like overhead, note
> the subtle difference for these commits. One if deep down in the
> stack patching one of the submodules, the other is a high level
> commit advancing the submodule pointer.
>
> Note that the target audience of these two commit messages
> might be vastly different, hence can be worded differently.
> (The submodule describing how you fixed e.g. a memleak or race condition
> and the superproject describes on why you needed to include that submodule,
> e.g. because you switched your toplevel application to use threads.)

Both good points. 

Another thing to keep in mind is that in a well-organized project,
it is expected that you would have multiple commits in a submodule,
solving one single issue that is needed by the superproject in a
finer grained way, before the resulting submodule tip is recorded in
the tree of the superproject in one commit.  IOW, between the time
the superproject's history moves by one commit, the submodule may
have multiple commits in order for the submodule to become ready to
be consumed by the superproject.


