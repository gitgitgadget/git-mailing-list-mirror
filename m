Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD121F462
	for <e@80x24.org>; Sat, 27 Jul 2019 17:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfG0Rqs (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 13:46:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51179 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfG0Rqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 13:46:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D5816FB43;
        Sat, 27 Jul 2019 13:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L2ZotNhVT45y
        lSzs+9zzq9OSeQU=; b=mW9mYfEfLJThxByHwk65S0t63UOQkwKhSJ3K8KBkjg6X
        AnnzKPSlp8+x4SfNEf2NojUApDKgp+L/oUQ7sbG3WR38lbkbJWwpRuojC9K5ymOY
        AzIgLZKobok3UpnIe/X8ribeAhMIJzP/16KdBU3tFRgp/Lz0XeNXqhsw3IPWqew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q5ToSU
        CLDB1rl8oh/ByGmH+jEvO8nytTBBEB6h9nriSruoTdCduRxEB+P9Xe4ZtJb1ZiZV
        n7aaZKtelyj+uAF/5ZaaIOs4SMlG5uMFEaR8Kl+wYx5dsFjj/sFEYziCq+86pf2O
        ZDj3u4KHWcw/PBHgvN9rZfCzVMtFDoB3aNk20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E44F16FB42;
        Sat, 27 Jul 2019 13:46:45 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1476F16FB3F;
        Sat, 27 Jul 2019 13:46:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christopher Head <bugs@chead.ca>
Cc:     git@vger.kernel.org
Subject: Re: Push force-with-lease with multi-URL remote
References: <20190727095440.1aac3b3c@amdahl.home.chead.ca>
Date:   Sat, 27 Jul 2019 10:46:43 -0700
In-Reply-To: <20190727095440.1aac3b3c@amdahl.home.chead.ca> (Christopher
        Head's message of "Sat, 27 Jul 2019 09:54:40 -0700")
Message-ID: <xmqqzhkzl69o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8006892C-B096-11E9-BA61-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christopher Head <bugs@chead.ca> writes:

> Hi folks,
> When a single remote has multiple push URLs, Git=E2=80=99s force-with-l=
ease
> logic appears to be:
>
> For each URL:
> 1. Read refs/heads/mybranch (call this commit X)
> 2. Read refs/remotes/myremote/mybranch (call this commit Y)
> 3....
> from Y to X, and therefore the second compare-and-swap fails. I can=E2=80=
=99t
> imagine any situation in which this behaviour is actually useful.

Quite honestly, the true culprit of the above story is that you are
letting multiple logically different remote repositories [*1*] use
the same single remote-tracking refes/remotes/myremote/ hierarchy.

If your previous "git push myremote" (with or without lease does not
matter, as this discussion is to illustrate that your setup is
fundamentally wrong) updated X but for some reason failed to update
Y (perhaps the network to Y was unreachable back then), and
refs/remotes/myremote/mybrach got updated to reflect the update to
X, what happens to your next "git push myremote" (or more
specifically, "git push Y")?  The repository on your local side
thinks that the other party has already took the previous push but
in reality that is the state of X, and Y hasn't seen that previous
push.

