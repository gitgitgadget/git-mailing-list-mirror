Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E88C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EF9206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 19:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GVnUQjH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDUTOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:14:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63135 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgDUTO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 15:14:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 484BABA384;
        Tue, 21 Apr 2020 15:14:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/SYUSqTmGadJDOrxU+i5PCSQqfo=; b=GVnUQj
        H9U1/3DAj3+5NcGsN/p5oUet7CgHRJB5gEXJO8mvZ2HJEJ7o93y6/b1CLiLvtdBP
        jq1KpmUSA3ScXaHjZ/Jeas0Ifqq6laaC3KX0aGKGACGzRMYkyNL6Ju7Y9GkNg0bh
        J5l24mztSQshuQ6d9oW0vPK00vTDtleLHAP/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y3RfLXZ66gDxNd7bQpgE5O5hbQYUePbV
        fN0cdGhswiEWd/XE4ClLzjyq12IEqamDGSCmV7e8QBFMng48OJLWKGb0hokeJyBC
        kIihQPYhNKlxjR5oAnZuqLkJTRQJ75Mt8G9toEU6u2bJXDZhDZBGLepm+b8n3+Re
        6wiTkfgPgE4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 409A7BA383;
        Tue, 21 Apr 2020 15:14:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 887D2BA37C;
        Tue, 21 Apr 2020 15:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     git@vger.kernel.org
Subject: Re: how to (integrity) verify a whole git repo
References: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
Date:   Tue, 21 Apr 2020 12:14:21 -0700
In-Reply-To: <acb9a2da98bce7ea3044cbf37c92163497f7e9e2.camel@scientia.net>
        (Christoph Anton Mitterer's message of "Tue, 21 Apr 2020 06:45:35
        +0200")
Message-ID: <xmqqftcwodma.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F70E086-8404-11EA-A576-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Anton Mitterer <calestyo@scientia.net> writes:

> How to check everything else? Is it enough to git fsck --full?
>
> Everything earlier in the history of a verified tag/commit should be
> cryptographically safe (assuming SHA1 would be still secure enough),
> right?

Correct.

> 2) But this of course won't show me anything which is in the repo but
> not earlier in the history of the tag/commit I've checked, right?!
> Is there a way to e.g. have everything dropped which is not verifiable
> via some signed commit/tag?

You can compute the commits that are not reachable from any of the
signed tags.

    git rev-list --all --not $list_tags_and_commits_you_trust_here

will enumerate all the commits that are not reachable from those
tags.

But your "have everything dropped" is a fuzzy notion and you must be
more precise to define what you want.  Imagine this history:


    ----o-----o-----L-----x----x-----x-----x-----x----x HEAD (master)
                                          /
                                         /
                                        /
                   ... ------o----o----G

where you have two people you trust (Linus and Greg), HEAD is the
tip of your 'master' branch, probably you fetched from Linus, L and
G are the two recent tags Linus and Greg signed.

If you enumerate commits that are not reachable from L or G, you'll
get all commits that are marked with 'x'.  Commits marked with 'o'
are reachable from either 'L' or 'G', and you would want to keep
them.

Now, you need to define what you mean by "have everything dropped".
You can remove commits 'x' but then after that where would your
'master' branch point at?  There is no good answer to that question.

What you could do is remove all branches and tags except for the
signed tags you trust from your repository and then use "git repack"
the repository.  Then there will be tags that point at L and G but
you'd be discarding 'master' (which is not signed) and repack will
discard all 'x' in the sample history illustrated above.
