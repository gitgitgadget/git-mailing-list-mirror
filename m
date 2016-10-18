Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B538E20988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938928AbcJRRIy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:08:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755582AbcJRRIu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:08:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E50B04894B;
        Tue, 18 Oct 2016 13:08:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KU0Q/CMjqSBqhWwxP2FrHp74MBQ=; b=T81Bco
        Z/+frCtm7fnrHJzyQKPwjGCN8QxcF5SMfMv0LYBfJxse0eZKJFT/mqJBuywMNInv
        pr+8PEPVakq0pGpuQa36nlrP5pH8mz1pjjwSdSYKEdYyMrZbshEkwjqEQ8u1kqz/
        NQFt1CFOREYecvyDga5HVCoeI2qVGuBtN9wIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dhOylCf3gUVr4+b9IQ+/vV+pq5eKV/IU
        rdxZRdFGiRV9kebpLUdFWPbKmJ7/q1cbgGxwqhV49wmPH3KwN3VCn6/Vsm9OK2y9
        A6aFp6j8TkkTJ2zeXHnWSF3gzSvL+l4SHY3UraVLuaox7j3K6YbN6AeIVhKbSghV
        WNYWZEPvmIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCB174894A;
        Tue, 18 Oct 2016 13:08:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A62048949;
        Tue, 18 Oct 2016 13:08:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Shumaker <lukeshu@sbcglobal.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH] daemon, path.c: fix a bug with ~ in repo paths
References: <20161018150629.23205-1-lukeshu@sbcglobal.net>
Date:   Tue, 18 Oct 2016 10:08:45 -0700
In-Reply-To: <20161018150629.23205-1-lukeshu@sbcglobal.net> (Luke Shumaker's
        message of "Tue, 18 Oct 2016 11:06:29 -0400")
Message-ID: <xmqqvawppote.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 885B913A-9555-11E6-A615-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Shumaker <lukeshu@sbcglobal.net> writes:

> The superficial aspect of this change is that git-daemon now allows paths
> that start with a "~".  Previously, if git-daemon was run with
> "--base-path=/srv/git", it was impossible to get it to serve
> "/srv/git/~foo/bar.git".

I am not sure I understand what you are saying here.  Do you mean

    I have a path on my server /srv/git/~foo/bar.git; the tilde does
    not mean anything special--it is just a byte in a valid pathname.

    I want to allow my users to say

	git fetch git://my.server/~foo/bar.git

    and fetch from that repository, but "git daemon" lacks the way
    to configure to allow it.

If that is the case, what happens instead?  Due to the leading
"~foo/" getting noticed as an attempt to use the user-path expansion
it is not treated as just a literal character?

I am not sure if it is even a bug.  As you can easily lose that
tilde that appears in front of subdirectory of /srv/git/ or replace
it with something else (e.g. "u/"), this smells like "Don't do it if
it hurts" thing to me.

