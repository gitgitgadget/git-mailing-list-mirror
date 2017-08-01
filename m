Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36A42047F
	for <e@80x24.org>; Tue,  1 Aug 2017 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdHARLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 13:11:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55257 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751805AbdHARLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 13:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0A32A7BD1;
        Tue,  1 Aug 2017 13:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZheOoFi3Y0bp+Y4loJf9hJot2AQ=; b=PsLEGx
        UMUTfG8OeG6NvottioQQtbsOP63gVdIhXzLxFmcS3FKXKe+ERtwRW/hSpI/eeM9m
        TQhsoD27H5aVjuk506np02fUe2as0q+C9KJfZM4+vYa2mhRwPD0/cIuc0A9X0zx8
        uDGF0Lep+3FebfWyvpVwnOROkvClxEDSdxFsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x2yW44SQ30lUX2ZV3CBBNnUNCLXakQ/3
        qA3aDnM5t/cuFNfbzTFZsUUYQGnwMtX/ujjPuyTzmyH1xf5QXEkZF1XtuDicG2/b
        OgYxM6AuF6XMJ+PsJZcqkbVg0/L84PpqgQVt4yGNFbJvb+aCaUwLsm2zqXdCRX0i
        lwx5DtvuV8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5C11A7BD0;
        Tue,  1 Aug 2017 13:11:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2F75A7BCF;
        Tue,  1 Aug 2017 13:11:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
Date:   Tue, 01 Aug 2017 10:11:38 -0700
In-Reply-To: <20170731160533.0a446244@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Mon, 31 Jul 2017 16:05:33 -0700")
Message-ID: <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BCE7F7C-76DC-11E7-B72D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Well, the fsck can still detect issues like corrupt objects (as you
> mention above) and dangling heads, which might be real issues. But it is
> true that it does not give you the guarantee you describe.

Which makes it pretty much useless.  The whole point of running
"fsck" is to make sure that we won't waste work by not finding
a corruption long after it was introduced and spent a lot of effort
building on top of a state that nobody can reproduce.

> From a user standpoint, this might be able to be worked around by
> providing a network-requiring object connectivity checking tool or by
> just having the user running a build to ensure that all necessary files
> are present.

I actually was hoping that you do not have to go to the network for
the checking.  And I have to say that "only the tip matters" is a
horrible cop-out that is not even a workaround.  Your users would be
served better if you honestly admit that your fsck will not be
useful when this feature is used---at least they won't be harmed by
a false expectation that "fsck" would give them some assurance,
which is not the case.

Let's step back a bit and think what already happens in the pre-
lazy-object world.  We record cut-off commits when a depth limited
clone is created in "shallow".  These essentially are promises,
saying something like:

    Rest assured that everything in the history behind these commits
    are on the other side and you can retrieve them by unshallowing.

    If you traverse from your local tips and find no missing objects
    before reaching one of these commits, then you do not have any
    local corruption you need to worry about.

the other end made to us, when the shallow clone was made.  And we
take this promise and build more commits on top, and then we adjust
these cut-off commits incrementally as we deepen our clone or make
it even shallower.  For this assurance to work, we of course need to
assume a bit more than what we assume for a complete clone, namely,
the "other side" will hold onto the history behind these, i.e. does
not remind the tips it already has shown to us, or even if it does,
the objects that are reachable from these cut-off points will
somehow always be available to us on demand.

Can we do something similar, i.e. maintain minimum set of cut-off
points and adjust that set incrementally, just sufficient to ensure
the integrity of objects locally created and not yet safely stored
away by pushing them the "other side"?

I haven't thought things through (and I know you, Ben and others
have thought much longer and harder), but I would imagine if we have
a commit object [*1*], some of whose parent commits, trees and blobs
are locally missing, and know that the commit exists on the "other
side", we know that all of these "missing" objects that are
referenced by the commit are also available from the "other side".
IOW, I suspect that the same principle "shallow" uses to give us the
integrity guarantee can be naturally extended to allow us to see if
a broken connectivity is OK.


[Footnote]

*1* The same can be said for a tag or a tree object that we know
    exist on the "other side"; they may refer, directly or
    indirectly through objects we locally have, to objects that that
    are missing locally, and as long as the starting point object
    are known to be available on the "other side", it is OK for them
    to be missing locally.

