Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C0D1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395482AbfHWPUg (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 11:20:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60823 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390470AbfHWPUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 11:20:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87FC878CE2;
        Fri, 23 Aug 2019 11:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LAnnED0+DDL89HN6W84l1C8jtK8=; b=SAC0R/
        bnasrJrpGTpTYIffhfYrO6DzCon95xinyhICsWw1ZDYOhOsMSnOtRT9ziImGo7rJ
        qp/J142Dd9JK+8Wv/jjMZGeFM++o32gBpuxYIEaMIxbFO8jUlOp8fbxxcn77U1SN
        wRTz+PMss8n/HTWTnIFKURD/GqV7aSH9apwMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aR/6bkEOGB5vDpEq1CuWKnR8tTuT+3o6
        Av4JlPCu1pwZeTKSi1DD1C4akL4o7egRhmkZT2YvSYW3z0aobkLFl1aTrsJ4p8ro
        eJeS9E2JIy8oAKPS7w3levmTK9F2GAEmHAvHH8qQSiRdxswVZDmqkNnelgWBM3W9
        JMX5dBIuQZQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80CF678CE0;
        Fri, 23 Aug 2019 11:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DD2D78CDF;
        Fri, 23 Aug 2019 11:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v3 2/6] sequencer: add NULL checks under read_author_script
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
        <20190820034536.13071-3-rohit.ashiwal265@gmail.com>
Date:   Fri, 23 Aug 2019 08:20:29 -0700
In-Reply-To: <20190820034536.13071-3-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 20 Aug 2019 09:15:31 +0530")
Message-ID: <xmqqsgprnc1u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BC361A8-C5B9-11E9-ADEA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> read_author_script reads name, email and author date from the author
> script. However, it does not check if the arguments are NULL. Adding
> NULL checks will allow us to selectively get the required value,...

I had a hard time understanding the argument here without knowing
why I had trouble, and I think I figured it out.  What you wrote may
not be incorrect per-se, but the logic is backwards.

The function has been about reading all three, and it always took
and required the callers to pass three valid pointers to locations
to store these three.  It did not check for NULL; passing NULL was
simply a bug in the caller who deserved a segfault.

This series, however, wants to allow new callers of the function to
selectively read some among the three and ignore the rest, and you
happened to choose "pass NULL for an uninteresting field" as the
new calling convention.

That choice is where "checking for NULL" comes in.

In other words, "checking for NULL" is merely an implementation
detail for a more important change this patch brings in: We now
can read some and ignore the rest, while requiring that the input
file is well formed even for the fields we do not care about.



    sequencer: allow callers of read_author_script() to ignore fields

    The current callers of the read_author_script() function read
    name, email and date from the author script.  Allow callers to
    signal that they are not interested in some among these three
    fields by passing NULL.

    Note that fields that are ignored still must exist and be
    formatted correctly in the author script.

or something like that, perhaps.

