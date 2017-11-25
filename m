Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506A62036D
	for <e@80x24.org>; Sat, 25 Nov 2017 04:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbdKYE7h (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 23:59:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61746 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750724AbdKYE7h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 23:59:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EFFCC43EF;
        Fri, 24 Nov 2017 23:59:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCOkVyQthg/MXwNqbzJbRUxQYTY=; b=q2fGeU
        ggCCO7IY/g+/zAUnN3wvMUXo1U4Hto/S1TUEVtcFWXrOWoaIzMeFKu20rGp3TWyt
        Ql49Zv6Lk4FTWlVhrxkXEkz7g03LoZQJ1Z+0oN6FinVWD3oHyQ+i4EZOv+hOwSVE
        R8VdVDNGqok5FevyftVv0C8h35tDAN+AnMx5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JXcj4ExdsO0v6hH/B60NFTfxQIS3sbSY
        B7tCMqHEggzDQ4iWfNil0pN/F7D+lHEqGnQHZMHUOVEMn4xyqkLbNhpaafPkx/jI
        GYldN4NtSviJ53pOvd3oaYCkXfCb5sjpPucvu9jXsLbgScMHqq+6LuyZUBhWCqNq
        ZY6ZzR5EDic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56901C43EE;
        Fri, 24 Nov 2017 23:59:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7152C43ED;
        Fri, 24 Nov 2017 23:59:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
References: <20171120222529.24995-1-sbeller@google.com>
        <20171120222529.24995-2-sbeller@google.com>
        <xmqqpo88m896.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 25 Nov 2017 13:59:34 +0900
In-Reply-To: <xmqqpo88m896.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Nov 2017 16:43:49 +0900")
Message-ID: <xmqq8tevkl6x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EDF5F9A-D19D-11E7-8CF7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If that is the case, shouldn't we make this new mode imply
> --full-history to forbid history simplification?  "git log" is a
> tool to find _an_ explanation of the current state, and the usual
> history simplification makes tons of sense there, but blobfind is
> run most likely in order to find _all_ mention of the set of blobs
> given.

One scenario that I think we may want to be careful about is this:

 ---o---*---*---A*--M*--o---X
     \             /
      o---*---o---B

where commits marked with '*' has the same blob M:Makefile you are
looking for at the same path Makefile, and we start traversal at X
with "git log --blobfind=M:Makefile X" (or even with a pathspec, i.e.
"git log --blobfind=M:Makefile X -- Makefile).

The usual merge simplification rules would say "Ah, M and A are
TREESAME so we do not have to look at the side branch that ends at
B".  If the user is interested in finding all the introduction and
the retirement of a specific blob object, we would miss the
transition around the '*' on that side branch and ends up finding
only the transitions after the fork point where the blob is
introduced, and after M where the blob is retired.

Another interesting case we may want to be careful is this:

    ---A*--M*--o---X
          /
      ---B*

for the same reason.  The usual merge simplification rules are
designed to come up with _an_ explanation for the state in X,
and because M is TREESAME with both A and B, it would pick just
one (the first parent) while ignoring the other.  Again, that would
not be appropriate if the reason why the user is running the command
is to find all the introduction and the retirement of an object.

It may be worth covering these in the tests (I didn't try to see
specifically if the patch has these cases already, as I didn't think
of the issue when I responded---sorry about that).

Thanks.


