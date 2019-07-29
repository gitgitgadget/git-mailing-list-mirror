Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDC31F462
	for <e@80x24.org>; Mon, 29 Jul 2019 04:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfG2Eqm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 00:46:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61687 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfG2Eql (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 00:46:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D7A4165BA8;
        Mon, 29 Jul 2019 00:46:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vjUemFgNqbe2OLuCZyxoQZo7LHA=; b=P1pKCy
        AHGwh4AQgiDZ/6FohPaPdwxMLyM4wPoIMGmUEgOVpvciSRvfPwyHMxSPvplGCPZd
        BGRdYbre6spToxmVtJQZKPIXJs8FA5JhR+6ZoQbavM7Rlxj/I9e4mGcY8SCeKAyA
        vqAEHcORa0cg2fSy0jw2mGQruQ3xqnJuX90Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gSBogSTo9hCdUBt/t5wcYBJ5pLSe+2b1
        1HpaaAfRsOuPEwt9p70EzHFoorjKVAvbeKtQS3LadOpGJF2y0ma7uXABQ145XjSh
        Hil+lxehJVDefzyXl6kiK+S1HXIA2wXMWIWTuiZoIek13Hji8YLxc1b+TSj02dSx
        Sn+jCWPHK/g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 64360165BA7;
        Mon, 29 Jul 2019 00:46:39 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CECFE165BA5;
        Mon, 29 Jul 2019 00:46:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/20] Use write_index_as_tree() in lieu of write_tree_from_memory()
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-8-newren@gmail.com>
        <xmqqy30kmu8r.fsf@gitster-ct.c.googlers.com>
        <CABPp-BExLuH9mz6sgjTbKXg44zmT3PcRsy+A8s-9PAQuxDuXfw@mail.gmail.com>
Date:   Sun, 28 Jul 2019 21:46:37 -0700
In-Reply-To: <CABPp-BExLuH9mz6sgjTbKXg44zmT3PcRsy+A8s-9PAQuxDuXfw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 26 Jul 2019 16:39:05 -0700")
Message-ID: <xmqqr269la6q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA28BD8C-B1BB-11E9-932A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I thought about that briefly yesterday, but the fact that the
> write_locked_index() call only happens if !cache_tree_fully_valid()
> meant refactoring slightly more to get the helper to also return that
> boolean value, and since I was a little unsure of myself with
> cache-tree stuff in general I wanted to propose what looked like the
> minimally invasive changes first (by which I mean smallest patch).

Or have the caller check if cache-tree is fully valid, which is the
only case that you can build a tree (and a fully merged index would
be fully valid after you do cache_tree_update()).

> I'll take a closer look at this path.
> ...
> So, yeah, I need to put something from those BUG() messages back in;
> they clearly helped with that issue, and might help again in the
> future.

Thanks.
