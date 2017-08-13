Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F601F667
	for <e@80x24.org>; Sun, 13 Aug 2017 22:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdHMWPw (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 18:15:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55893 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750867AbdHMWPv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 18:15:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B467C8E328;
        Sun, 13 Aug 2017 18:15:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZCVSeX01v8V5xHhfsA0KTnxBq6s=; b=P/8Dlk
        rGQGUW92SkJa9mA6Io1o8CkHENUHyuyuFMStBIeqSjmoWy4lwXOuJrybpIt4skMT
        +xcIFMWQraLEmsVGXzN0Md+KMKxbD/vIoDRDg9Spt8AQOwwwcRr9fTcV7cmJAyOr
        4ymLJkORAJzUBFDhz7R9pJ6ydqK7hX292T2LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OjNKmrsV2pjMlvI07Oxms+um3082+/3N
        H/B/lql1NBvED8lozvDKJgMst2ENddaSO8ZRuiqJH9jq4jG9NVrNPhBatjC4AWYY
        /1Ik7oHLipzXjBKnYHm2whkfHPqf7p4CeUfSWpJkdts2jrWnCq9FbVv+lccApGO2
        QajfjwuWyD4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A43888E326;
        Sun, 13 Aug 2017 18:15:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17CE68E321;
        Sun, 13 Aug 2017 18:15:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Martin Koegler <martin.koegler@chello.at>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
        <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
        <20170813183026.GC31079@mail.zuhause>
        <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
Date:   Sun, 13 Aug 2017 15:15:41 -0700
In-Reply-To: <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 13 Aug 2017 20:45:04 +0100")
Message-ID: <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F27F6BE4-8074-11E7-8DB6-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> It should be, see commit b97e911643 ("Support for large files
> on 32bit systems.", 17-02-2007), where you can see that the
> _FILE_OFFSET_BITS macro is set to 64. This asks <stdio.h> et.al.,
> to use the "Large File System" API and a 64-bit off_t.

Correct.  Roughly speaking, we should view off_t as size of things
you can store in a file, and size_t as size of things you can have
in core.  When we allocate a region of memory, and then repeatedly
fill it with some data and hand that memory to a helper function
e.g. git_deflate(), each of these calls should expect to get data
whose size can be representable by size_t, and if that is shorter
than ulong which we currently use, we are artificially limiting our
potential by using a type that is narrower than necessary.  

The result from these helper functions that are repeatedly called
may be sent to a file as the output from the loop.  If that logic in
the outer loop wants to keep a tally of the total size of data they
processed, that number may not be fit in size_t and instead may
require off_t.

One interesting question is which of these two types we should use
for the size of objects Git uses.  

Most of the "interesting" operations done by Git require that the
thing is in core as a whole before we can do anything (e.g. compare
two such things to produce delta, have one in core and apply patch),
so it is tempting that we deal with size_t, but at the lowest level
to serve as a SCM, i.e. recording the state of a file at each
version, we actually should be able to exceed the in-core
limit---both "git add" of a huge file whose contents would not fit
in-core and "git checkout" of a huge blob whose inflated contents
would not fit in-core should (in theory, modulo bugs) be able to
exercise the streaming interface to handle such case without holding
everything in-core at once.  So from that point of view, even size_t
may not be the "correct" type to use.
