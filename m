Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB232047F
	for <e@80x24.org>; Sat, 29 Jul 2017 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdG2QFD (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 12:05:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62093 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752644AbdG2QFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 12:05:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1AD5A0CF0;
        Sat, 29 Jul 2017 12:04:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1CBP8SFTEGaSihw5BVRbitMgzyo=; b=ITWXft
        o2XNaKLEmyLCXDqMPtgzuReaNCNPV4GUUV1SsREixYfJyUOdDUjLk7MJTq1gCG9Q
        3Yva4k5ORQie1T0lf26RQdVk6EvqaCfACiML0dpMUL2/S4VwpZO2F0Pl7aL2kj1t
        5NKKaZA26vk0CvKalRfhj+WIz/rKm+w96wLfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JtNLZN4kYE2avR3N+gdjbcVVCydNzXp8
        VjYfRZciqyN92sZDbD7TPTyCD1AqLbwsEkgQ5C7lbezoDSO1XDsMq1bptBSBercu
        eNTFUMaOU+3I743ZQLJvE1yyW1NV1hdT2LnLv7b6KBg6ni9jjvRbltxV2wCycJAD
        FSz3MVcV+is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9993A0CEF;
        Sat, 29 Jul 2017 12:04:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2769DA0CEE;
        Sat, 29 Jul 2017 12:04:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 3/4] fsck: support referenced lazy objects
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
Date:   Sat, 29 Jul 2017 09:04:46 -0700
In-Reply-To: <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 26 Jul 2017 16:30:01 -0700")
Message-ID: <xmqq379fkz4x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A553D516-7477-11E7-9CFA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach fsck to not treat missing objects indirectly pointed to by refs as
> an error when extensions.lazyobject is set.

I forgot to mention a potential flaw in this approach in my previous
message.

If you are a pure sightseer, then this is perfectly fine.  The
object store in your local Git client working in that mode is purely
a cache, lazily populated while browsing the object store backed by
the source of what lazy-object "hook" talks with.  As long as that
cache does not give us a corrupt object, we are OK, because missing
objects do not matter.

But once you start using the repository as more than a sightseer,
you will have objects that only exist in your local "cache" and are
not yet in that backing store behind the lazy-object "hook".  You
need to notice it when any of them goes corrupt or missing, or your
next "git push" to send them over to a remote location will fail by
definition because you are the only one with these objects.

If we had the "promise" thing, then we could say that it is OK if
traversal terminated at a "promised but not fetched yet" boundary,
but we cannot afford the "promise", and more importantly, I do not
think "promise" has to be the only approach to ensure that the
objects that exist only in the local repository are all connected.

For example, if we know that the remote 'origin' is the actual
backing store lazy-object "hook" talks with, a validation rule to
ensure that we haven't lost any local commit is to ensure that a
traversal from our local branch tips down to remote-tracking
branches taken from 'origin' must not hit _any_ missing commit.

That covers only the commit objects.  I do not know offhand if we
can and how we extend this concept to protect the tags, trees and
blobs we have locally generated and haven't pushed out, but you and
Ben hopefully can come up with ways to cover them.



