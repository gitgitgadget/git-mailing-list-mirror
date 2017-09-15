Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C654C20281
	for <e@80x24.org>; Fri, 15 Sep 2017 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbdIOSYN (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 14:24:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64589 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751201AbdIOSYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 14:24:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08281985E4;
        Fri, 15 Sep 2017 14:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jucVPup4mz1oHyP3VIYeYhUdKAA=; b=KCQr32
        QH1HAfyJ2LlEZfBREQFxcqdI67ynpNzUgTmjSC3LZeOn8slT3R8Ud1hUIlgT4hIH
        8CMJjLFpXk5ZVDE94uPI53o/xbTto9ThEI1G0rgflrDOKwN8/O9U8zbiVBnVjph+
        MMkwhtn4TAzgiC+zdUUscM6GbHFtryXtzbpwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vGYQZanVaLZ9K375uZXH2ubpOHH1XVHH
        3fy0l4OBt2Wn7CHay0PYUCx2oyXIUnVtV8xXPvun3n7UWib04l8n5/NKXrmjxEhY
        cZYQx6kUEP0jpWI6NcJKfEIdE8Tc+a+PAKSJPUhUTYEaBfkTnaxK9vsYmODZK2ut
        gwC9UgZxH0k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 002D0985E3;
        Fri, 15 Sep 2017 14:24:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EC40985E2;
        Fri, 15 Sep 2017 14:24:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
        <cover.1505394278.git.git@grubix.eu>
        <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
        <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
        <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
Date:   Sat, 16 Sep 2017 03:24:10 +0900
In-Reply-To: <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu> (Michael
        J. Gruber's message of "Fri, 15 Sep 2017 12:23:33 +0200")
Message-ID: <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1207078C-9A43-11E7-BCA3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> I did not look up the discussion preceeding 4f21454b55 ("merge-base:
> handle --fork-point without reflog", 2016-10-12), but if "merge-base
> --fork-point" were about a "strict reflog" notion then there was nothing
> to fix back then - no reflog, no merge-base candidates. Period.
>
> I don't mind having two modes, say "--reflog" (strict reflog notion) and
> "--fork-point" (reflog plus DAG), but the current implementation is
> neither, and the current documentation clearly is the latter, which is
> what I'm trying to bring the implementaion in line with. Strict mode
> would need a revert of 4f21454b55 (which adds the tip of ref if the
> reflog is empty) for that mode.

Thanks for pointing out a flaw in the logic in my response.

When the user runs "merge-base --fork-point Branch Derived", the
question she is asking is: "what is the merge-base between the
Derived and a virtual commit across all the commits that we know
were at the tip of the Branch at some point and is the merge-base
commit among one of these historical tips of Branch?"

You are correct to point out that loosening the definition of the
"--fork-point" to lose the "and is the merge-base among the one of
these historical tips?" half of the question may be useful, and we
need to introduce "strict" vs "non-strict" modes in order to allow
such a distinction.  I somehow thought that giving and not giving
the "--fork-point" option would be a sufficient clue to express that
distinction, but that is not the same thing and my reasoning was
flawed.  Even when the exact answer of the more strict version of
the "--fork-point" (i.e. what the current implementation computes)
is not available because of missing reflog entries, the merge-base
computation that takes available reflog entries into account but
that does not insist that the resulting base must be among the known
historical tips (i.e. what your patch 2/3 wants to compute) could be
closer to the fork-point than "merge-base Branch Derived" without
"--fork-point" option would compute, and could be more useful as a
"best --onto commit that is guessed automatically" for the purpose
of "rebase".  I agree that there is a value in what your patch 2/3
wants to do when the current one that is more strict would say
"there is no known fork-point"---we would gain a way to say "... but
this is the best guess based on available data that may be better
than getting no answer." which we lack.

Having said all that, I do not agree with your last sentence in the
paragraph I quoted above.  It is a mere implementation detail to
consult the reflog to find out the set of "historical tips of the
Branch"; the current tip by definition is among the commits in that
set, even when the reflog of Branch is missing.  What 4f21454b55 did
was a reasonable "fix" that is still in line with the definition of
"--fork-point" from that point of view.

Whether we add a "looser" version of "--fork-point" to the system or
not, the more strict version should still use the current tip as one
of the historical tips (i.e. those that we would take from the
reflog if the reflog were not empty) in the more "strict" mode.  The
looser version may also want to do so as well.

Thanks.

