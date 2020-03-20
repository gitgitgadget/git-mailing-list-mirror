Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B6C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D313720714
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mtskwrYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCTWvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:51:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50248 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:51:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4686F4D865;
        Fri, 20 Mar 2020 18:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mUvhcvdvbJm7OCHdXz8Zzte1P3c=; b=mtskwr
        YkzGH1X+eYwlznK5r60XNyAZhfgPnCSKpQzxioPZ0TnpYcK81eHWkWUGZuL2+mF3
        XilcsZw0E3BR2m9yk/RhTTV8XjuG8KpIfIAptbUMP4yQDFxdyZGK+9c15XY4PR5q
        d/YLAUAdgX7kbphFpEKlMzGK+0PLZeXqJ2kMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ulmR5KXQytdyI8Ilqq2AzHWZcpBvRLdv
        TFrZ0zojKieXyyMeFR0Se45XP7OH1pAXISHWNA7/RNyg+1SfLn1+xzI4e4zYJqbI
        WKoJqS3H37OzhF5yS/FQxUP3v42Q4lvxpJNB0a+VhrFUb8vhUc45xKkSpXjqFkl2
        7VVnV4ejRUc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E3494D864;
        Fri, 20 Mar 2020 18:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B93A94D862;
        Fri, 20 Mar 2020 18:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Feature request: rebase -i inside of rebase -i
References: <20200320223015.GA19579@SDF.ORG>
Date:   Fri, 20 Mar 2020 15:51:20 -0700
In-Reply-To: <20200320223015.GA19579@SDF.ORG> (George Spelvin's message of
        "Fri, 20 Mar 2020 22:30:15 +0000")
Message-ID: <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 511384B8-6AFD-11EA-B00A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Spelvin <lkml@SDF.ORG> writes:

> I'm cleaning up a patch series for submission, and came across a fixup in
> patch #4/20 that belongs in #2/20.
>
> Unfortunately, I can't go back two patches to apply the fix until I get to 
> the end of the current rebase, then go back down to clean it up. :-(
>
> Thinking about it, I realized that a rebase in a rebase is a perfectly 
> well defined operation.  *If* you don't bother setting a new abort point 
> (it's not a fully nested transaction), *and* require that the tree be 
> clean (no stashing allowed; create a WIP commit instead), it's just a 
> matter of putting some commits back on the front of the todo-list and 
> checking out the old version.

I thought that "git rebase -i" allows the todo file (i.e. list of
steps still to be performed) to be edited before continuing; would
your use case be supported by using that?
