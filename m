Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26CCC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 19:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhLPTma (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 14:42:30 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51111 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbhLPTm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 14:42:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BA2816102B;
        Thu, 16 Dec 2021 14:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4XpRQ7ckNJcBmbR0uc5iWjfaszSysi8tYpUpTM
        8ieKM=; b=fbBwUQyucP692J20pWaEDrwu7pfH8kTKXXBACIQ1KceU5nBk2ldYP9
        6+73sqhHouC9Ipp7HhY91QtiaUfX+TzPzFOMRWg3FdH+YBoRl4KLQg3XZgMnkhmY
        jtd1vhH5DR7Vpqm5j+tX4LTKV2suapBz/jF+KtJ6hKszxoqRabexg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77F00161029;
        Thu, 16 Dec 2021 14:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C65DF161028;
        Thu, 16 Dec 2021 14:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dotan Cohen <dotancohen@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git bug: Filter ignored when "--invert-grep" option is used.
References: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
        <xmqqzgp134i4.fsf@gitster.g>
        <CAKDXFkOXNPTjQRvj7sy54YhH1QGFUsEXYeLKCShJP7_xueRseQ@mail.gmail.com>
Date:   Thu, 16 Dec 2021 11:42:24 -0800
In-Reply-To: <CAKDXFkOXNPTjQRvj7sy54YhH1QGFUsEXYeLKCShJP7_xueRseQ@mail.gmail.com>
        (Dotan Cohen's message of "Thu, 16 Dec 2021 16:54:39 +0200")
Message-ID: <xmqqee6cbalb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BA538DC-5EA8-11EC-9C55-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dotan Cohen <dotancohen@gmail.com> writes:

>> I think --author and --grep uses the same internal pattern matching
>> engine, so with --invert-grep, I would not be surprised if the
>> command looks for commits that do not have Revert and (or is that
>> or?  I dunno) not authored by Shachar.
>
> Possibly, but the flag is called --invert-grep not --invert-matches so
> one would expect it to revert grep only.

That is an actionable improvement idea to introduce a synonym ;-)

But in general, the way the internal "git grep" machinery is exposed
to the commands in the "git log" family is very limited.  With "git
grep", it is quite straight-forward to say "report hits for lines
that has this but not that"

    $ git grep -e this --and --not -e that

but because that the commands in the "log" family already use
"--not" for a quite different purpose, "git log --grep" cannot even
express something similar, even to find hits on a single line, let
alone finding hits on two different lines (i.e. one on the "author"
header, the other in the message part, of the commit object).


