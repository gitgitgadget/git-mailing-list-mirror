Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1DA208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbdHOR2h (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:28:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62566 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752347AbdHOR2g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:28:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0CDE9888E;
        Tue, 15 Aug 2017 13:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l+W1rUzjfPqyaucdvmSnJ9ZEszE=; b=L1OVLj
        KH9tn+y8ZEP8IEfntzZMYZ3WnvT7oA5SYapkJilk0OnYmc4bR20shPWgCLhC0VAL
        KXfYHoCK1GYWEjhQRX9hQY6y1S7WGhBDCCAte3z98hNoYo5606w1zZhz1hWnpeyR
        efCaxDkyl0T9PoUgXcD+gDa9zRS70wRRlqSu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=clfUPMt5zBoW0jIg+8MombLWlx7Va7+l
        qGKmNJYSKFF11rymNZOG+t46v0YOPh/Ij/lqDqY/mz00kDz0gPx580qsWWn7tW/i
        ZNfn5lRE/stVoBVsatHMST5DDoddshSLt0YyQaSQb9Er5kQIXL0Tauyx27pSwkvB
        1t0bu69IRpA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C84049888D;
        Tue, 15 Aug 2017 13:28:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D5D09888C;
        Tue, 15 Aug 2017 13:28:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     sbeller@google.com, git@vger.kernel.org
Subject: Re: [PATCH] hook: use correct logical variable
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
        <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
        <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
        <4e2c5bd8-48c9-fc8c-2c2c-ede3951019fc@gmail.com>
Date:   Tue, 15 Aug 2017 10:28:33 -0700
In-Reply-To: <4e2c5bd8-48c9-fc8c-2c2c-ede3951019fc@gmail.com> (Kaartic
        Sivaraam's message of "Tue, 15 Aug 2017 15:01:14 +0530")
Message-ID: <xmqqa830sptq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA6F7BA-81DF-11E7-938B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I guess Junio's suggestion found below seems concise enough
> although it doesn't capture the reason I did the change.

I did shoot for conciseness, but what is a lot more important is to
record what is at the core of the issue.  "I found it by doing A"
can hint to careful readers why doing A leads to an undesirable
behaviour, but when there are other ways to trigger problems that
come from the same cause, "I found it by doing A" is less useful
unless we also record "Doing A reveals the underlying problem X"
that can be shared by other ways B, C, ... to trigger it.  The
careful readers need to guess what the X is.

And once you identify the underlying problem X and record _that_ in
the log message, I and A in "I found it by doing A" becomes much
less interesting and the readers do not have to guess.

Your "A" is 'git commit --amend -s' with the disabled part of hook
enabled.  But I think 'git commit' without "--amend" and "-s" would
also show an issue that come from the same root cause.  The hook
will add SoB that is based on the author, not the committer.  That
resulting commit would be different from 'git commit -s' without the
hook enabled, which would add SoB based on the commiter name (that
would be a "B", that causes a related but different problem that
comes from the same underlying issue "X" which is "we should
consistently use the committer info like other parts of the
system").

In any case, thanks for a fix-up.  Let's move this forward quickly,
as it is an update to a topic that is already in 'master'.

Thanks.
