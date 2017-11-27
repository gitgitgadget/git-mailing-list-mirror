Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFE220A40
	for <e@80x24.org>; Mon, 27 Nov 2017 00:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdK0ArX (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 19:47:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752114AbdK0ArX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 19:47:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3750FAEFBD;
        Sun, 26 Nov 2017 19:47:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B0JKQvIrt6HYD+dSbsTd+n9Qp4o=; b=kh+L/0
        KE8TESNACoQ7TGcxAoU/zCRbktSyYPavZF0ZfLxo8h+Qexcomu10jm9hzvkwVTwI
        Bnc9VVMRewQy8O4kwWgYJ9ttJ28gWC0acbI7A0noY3xLYpf+bnEeFUBQa4FX2W0h
        CYslzfQ0Yu3sE5pc5OGphbLluoxvlJ62kbdKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IPXF8kDKkaQoT23+HZwGWPR/bdn0Qg8D
        CsAw8fDip1seq69WAxXcBn0zFshBCpD4T//9z4BwjYq6sddPU9tvUHwbkZkxuiZ1
        1cMPY3a9rMstWLfzc7BvY6uKs2hVt61rLoHkQ9bEjSMkfsMwNApRfaox+OxfaFF8
        H5CylGKAJTA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E059AEFBC;
        Sun, 26 Nov 2017 19:47:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FA67AEFBA;
        Sun, 26 Nov 2017 19:47:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
        <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
        <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
        <20171126192749.GC1501@sigill>
Date:   Mon, 27 Nov 2017 09:47:20 +0900
In-Reply-To: <20171126192749.GC1501@sigill> (Jeff King's message of "Sun, 26
        Nov 2017 14:27:49 -0500")
Message-ID: <xmqq7euch7jb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87093D5A-D30C-11E7-8A32-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure I agree. Lockless writes are actually fine for the original
> use case of --no-optional-locks (which is a process for the same user
> that just happens to run in the background).

The phrase "lockless write" scares me---it sounds as if you
overwrite the index file no matter what other people (including
another instance of yourself) are doing to it.  

    Side note: What 'use-optional-locks' actually does is not to
    give any file descriptor to write into when we invoke the
    wt-status helpers (which would want to make an opportunistic
    update to the index under the lock), so "--no-optional-locks" is
    quite different from "lockless write".  Whew.  It is part of
    what "semantically read-only things do not write" would have
    been.

How would a true "lockless write" that is OK for background
opportunistic refresh work?  Read, compute and then open the final
index file under its final name for writing and write it out,
without involving any rename?  As long as it finishes writing the
result in full and closes, its competing with a real "lockful write"
would probably be safe when it loses (the lockful one will rename
its result over to the refreshed one).  It cannot "win" the race by
writing into the temporary lock file the other party is using ;-)
But it may lose the race in a messy way---the lockful one tries to
rename its result over to the real index, which the lockless one has
still open and writing.  Unix variants are probably OK with it and
the lockless one would lose gracefully, but on other platforms the
lockful one would fail to rename, I suspect?  Or the lockless one
can crash while it is writing even if there is no race.

Or do you mean something different by "lockless write"?
