Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3CF1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfHWQ4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:56:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51942 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfHWQ4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:56:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20D8F15D79B;
        Fri, 23 Aug 2019 12:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hx/7GzoV+PY6I6mWLxzuOZal4Ho=; b=SQpi5x
        lPZGmz9gkMHD3e/owISKxlOS+PykTL8Ira8NtFuqdmwnht8DHj5fhaCzvxHtJOrg
        5L9sjFwIuTBuYWs//PeOiZoqAT8Hvv9X2lC9JgF6ALQo29PfkuSjElBEvzi5B0ve
        +uR6Qczh5lwTyJyJxvpe5tPcQfIco8XYyzfNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p9tSE4rMrkXanaIUhbWbmM/gAKazRu7U
        tOcmCgHE0k1X2WDiq5SsI6U96ziH/ZHVKOpYCEl2tyICpkwL938Y39g34pBJfzqQ
        6d8LH2Cc1KtLzZ6IPa/ctN/bzkdAO0N6x8yrXJzDYKO8HwHPteYe4EWccZUph3gp
        q0aa0QrK6sA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 187E115D799;
        Fri, 23 Aug 2019 12:56:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C9C815D797;
        Fri, 23 Aug 2019 12:56:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] builtin "stash apply" does not refresh index
References: <20190823052737.GA10592@sigill.intra.peff.net>
Date:   Fri, 23 Aug 2019 09:56:45 -0700
In-Reply-To: <20190823052737.GA10592@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 23 Aug 2019 01:27:37 -0400")
Message-ID: <xmqqa7bzn7le.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDE3759A-C5C6-11E9-9E2C-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This started with 8a0fc8d19d (stash: convert apply to builtin,
> 2019-02-25), which is in v2.22.0. Interestingly, do_stash_apply() does
> in fact call refresh_cache(). But it looks like we don't ever write it
> out to disk. So when we later call merge_recursive(), it presumably uses
> the on-disk index, not what we have in memory.

Ouch.

> It's not clear to me where the fix should go, though. Should
> "stash apply" be writing out the refreshed index before
> proceeding? Or should merge_recursive() be more careful about
> refreshing the index after it locks it?  The former is what
> happened with stash as a shell script, but the latter would save
> us an otherwise pointless write.

I wonder if the third solution be possible.  "I am a new caller of
merge-recursive machinery, I did some operations on the working tree
and the index (in core), and while I would, in the old world order,
write out the in-core index to on-disk and call the merge-recursive
machinery, expecing the callee to read the on-disk index, for the
sake of performance, I am using this new calling convention, where a
new entry point of merge-recursivey machinery allows me to call it
and tell it to use the in-core index."  For that to happen, the
codepath in the merge-recursive machinery entered from the new entry
point needs to learn not only omit a call to read_cache() but also
it needs to write in-core index out lazily for the caller (e.g.
imagine it needs to exit early without doing any of the merge?  The
caller skipped the "otherwise pointless write", which needs to now
happen before the whole thing exits).

And before the third one, introduction of a new entry point that
makes merge-recursive machinery inherit the already populated
in-core index, happens, I think the right solution is to write the
in-core index out---the write is not pointless.





