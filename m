Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60161F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKMFiv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 00:38:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57687 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeKMFiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 00:38:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A60641C44C;
        Mon, 12 Nov 2018 14:44:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g/zskTFGFsPDGiQOb8ZhcXcz8PY=; b=ik2jib
        LiL0bVZgCDmeOGlsnhDNpGLb+AWGmdc5sGOI7m5nk2jouu5e58E/dOxLK87sVbBv
        MkrDjiEmqjzb0S1B9yk4D4UqhHzPxIohiQxgK4DbC6qUDC9MsWRp7oUHqvfcV1B4
        Am3utHAkS2R7ecWjpKNxv79r6gFu4gBEz9ycs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JO4rTNvvDrnGMu6dhQwgunADpDhyBK+m
        LF8YzELmOxfPfX6B/1s4r7uiVQduao9TFc/1TC+ASC0eNCYmu/s9sgSEKSnmzqmo
        W1l11vWP2jLQ0FxldC3iqjk29MD21oNqzRDgl1WjT+pCz2CqZKFEVjdlnnq+Lbjv
        XKhdsWzIRcU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E6991C44A;
        Mon, 12 Nov 2018 14:44:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B26AE1C446;
        Mon, 12 Nov 2018 14:44:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] checkout: disambiguate dwim tracking branches and local files
References: <20181110120707.25846-1-pclouds@gmail.com>
        <xmqq36s63idd.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DZy2hozNypxizF=LmJn8gw9z5HGhV0paiMuM9+gxYVvg@mail.gmail.com>
Date:   Tue, 13 Nov 2018 04:44:03 +0900
In-Reply-To: <CACsJy8DZy2hozNypxizF=LmJn8gw9z5HGhV0paiMuM9+gxYVvg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 12 Nov 2018 18:26:15 +0100")
Message-ID: <xmqq36s613p8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5069B458-E6B3-11E8-A0BE-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Is it that different between an exact path name and a pathspec?
> Suppose it is a pathspec (with wildcards) that matches some paths, and
> we happen to have the remote branch origin/<that-pathspec>, then it is
> still ambiguous whether we should go create branch
> "<that-pathspec>" or go check out the paths matched by the pathspec.
:
A huge difference between these two

	$ echo Hello >'n??t' && git add 'n??t'
	$ git branch 'n??t'

is that the former is taken and the latter is rejected, even though
neither of them is particularly a sane or a likely thing.

Isn't that a good enough reason why

	$ git checkout 'n??t'

cannot mean checking 'n??t' branch out, be it either an existing
local one or auto-vivified one out of a remote-tracking branch?

> I think you see 'n??t' as a pathspec, but I'm thinking about a user
> who sees 'n??t' as a branch name, not pathspec and he would have a
> different expectation.

See above for the reason why I think there is no room for different
expectations to come in the picture in this case.

