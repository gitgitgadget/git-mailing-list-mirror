Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B713120899
	for <e@80x24.org>; Sun, 20 Aug 2017 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbdHTQZp (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 12:25:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57472 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753122AbdHTQZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 12:25:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 208EE998CB;
        Sun, 20 Aug 2017 12:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmmdcK3jKSxxz17YarzG6yAGPhY=; b=cxf6T+
        d0vscxLiazkmbIHruLtZ8Xl7BVSppCujMYVUoLRjhDGl9Ds5pFqxschozBvLshz6
        rE7p6YTqL6SSjggjf9dfjWA6PKbVWQ4zWa6CBSEqmLgvqgRZnYqjvatzHKEG1kp/
        pGqJ7MHWRGzxXyDrJ0esdfuVl9qqPzvDF6Hdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fqXzMS7okv4uI2a9wNGq1y9cF0jwtR3C
        Y2JBuziTThmZW6rb/EGB4n9I9dsruZTC5LkjHwZC93lzgjiIlv7k30rA01aCsP/h
        UYhg10AIPIOMk03ssEo3j+HyCkmX+Xi5Q33qq39JTx5dhNCmlVyNXB+jiUDun3Y1
        OGfxxE1vhfo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EC44998CA;
        Sun, 20 Aug 2017 12:25:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C5FF998C9;
        Sun, 20 Aug 2017 12:25:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
        <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
        <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
        <20170817091503.vsd4lncogphy5gxx@sigill.intra.peff.net>
        <xmqq60dmgftg.fsf@gitster.mtv.corp.google.com>
        <20170820081936.i2e2rdvxl5wmpepd@sigill.intra.peff.net>
Date:   Sun, 20 Aug 2017 09:25:42 -0700
In-Reply-To: <20170820081936.i2e2rdvxl5wmpepd@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 20 Aug 2017 04:19:37 -0400")
Message-ID: <xmqq4lt28aux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 369F3968-85C4-11E7-A3F4-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So that's one question I'm puzzled by: why does it work without an edit,
> but fail with one.

As this is the part of the system I long time ago declared a "works
only some of the time" hack, I do not recall the exact details, but
a key phrase "DIRTY" in the old discussion thread made me look.

Doesn't coalesce_overlapping_hunks in add-interactive.perl play a
role in the difference?  I _think_ that one tries to do the right
thing by enabling the logic before the "(e)dit" hack was introduced;
I haven't actually checked out and looked the code before the
addition of the option, but "add-p" should back then have actually
understood the offsets and hunk length and merged the surviving
hunks as needed to avoid feeding overlaps to "git apply"---it may
even have fixed the offset before doing so.  Edited hunks whose
mechanical integrity has become dubious are marked with DIRTY, as
the hunk touched by "(e)dit" codepath, by the time it reaches that
helper function, no longer has trustable information in the correct
offset information there.

> My second question is how "add -p" could generate the corrected hunk
> headers.
>
> In the non-edit case, we know that our second hunk's leading context
> must always match the first hunk's trailing context (since that's how we
> do a split). So we'd know that the preimage "-pos" field of the second
> hunk header should be offset by the net sum of the added/changed lines
> for any previous split hunks.
>
> In the original case we had net two added lines in the first hunk. So if
> it's selected, that's how our "-1" becomes "-3". And after the edit, we
> should be able to apply the same, I think? We have a single added line,
> so it becomes "-2". That doesn't require knowing what was in the hunk
> before the user edited at all. We just need to know which other hunks
> it's split from, so we know which overlapping hunks we need to take into
> account when recomputing.
>
> "add -p" certainly has that information. I _think_ git-apply also has
> that information if it bothers to find out.

I am not sure about the latter.  If we declare that we assume the
user never touches the hunk header line (i.e. "@@ ... @@") when
editing the patch text (i.e. " /-/+" lines), the receiving end can
probably guess by counting how many preimage and postimage lines are
described in the hunk and then seeing the change from the numbers on
the hunk header.  

I do not think the "--recount/--overlap" code trusts its input that
much in the current code, and there may be a room to tweak that band
aid with such an additional assumption.

But I dunno.  Once we go that route, and then if we want to assume
less about random things the end-user may do to make it more robust,
"add -p" would need to keep the hunk header before giving the hunk
to the user, and then replace the (possibly modified) hunk header in
the edited patch with the original to tell the receiving end what
the original numbers were to help --recount logic.  At that point, I
do not think it is too big a stretch for the "(e)dit" to actually
correct the hunk headers to not just express the correct offset but
also show the right number of lines, so that it does not have to be
marked with the "DIRTY" bit.  That way, coalesce_overlapping_hunks
logic can finish it off just like other "picked but unedited" hunks.

And when that happens, we may not even need to run "apply" with the
"--recount" and "--allow-overlap" options from this codepath to go
back to the state before 8cbd4310 ("git-add--interactive: replace
hunk recounting with apply --recount", 2008-07-02), where "add -p"
did not fly blind and always knew (or at least "supposed to know")
everything that is happening, which IMO is a preferrable endgame.
If the language spoken between "add -p" and "apply" is "patch", we
should try to stick to that language.  Butchering the listener to
allow this speaker to speak in loose and ambiguous terms, especially
when we can teach the speaker to do so, was a big mistake.

