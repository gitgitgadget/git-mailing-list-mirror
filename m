Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6CA31F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 07:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeKQRw0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 12:52:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64990 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeKQRw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 12:52:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D4441E68E;
        Sat, 17 Nov 2018 02:36:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DbwPeYHlsJ03
        IDipQQXC0IN+zjk=; b=hYJmQQAmQTBStVSew6HUIZllsqPmm3bBoMbW2ITPNO9N
        iyB76zJLZSLfXjkil3FpYzZLH+fllsYRK3EUaKk8Qv3es9WQoPsXPIhqWlYyZO4R
        d7lIBDc+WA0HffKgO13rHYqo/bqRSLqx1l9eU5aUoZf8xQSjj4UgJ+2Cj0K5XYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qlfjhT
        IuOKFHhYwAbInC/UzmJjCm5lwp8onzCeivlekTOf3woD/TMLs7NJLxEDecHiOhVR
        GfRx/bjTDFzdqLl3VBmBZfZotCCnYM1VHIopJJxm9ppey0ASAV2Oufs07aW6jBVZ
        UtWCMXRTyjeXIyGZUrpVnxhUGTHpa6A8h0KCk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54C6C1E68C;
        Sat, 17 Nov 2018 02:36:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D09A1E68B;
        Sat, 17 Nov 2018 02:36:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org, sbeller@google.com, jrn@google.com,
        jch@google.com, jonathantanmy@google.com, stolee@gmail.com,
        carl@ecbaldwin.net, dborowitz@google.com
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
Date:   Sat, 17 Nov 2018 16:36:27 +0900
In-Reply-To: <20181115005546.212538-1-sxenos@google.com> (sxenos's message of
        "Wed, 14 Nov 2018 16:55:46 -0800")
Message-ID: <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7F58D588-EA3B-11E8-9E43-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sxenos@google.com writes:

> +Detailed design
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Obsolescence information is stored as a graph of meta-commits. A meta-=
commit is
> +a specially-formatted merge commit that describes how one commit was c=
reated
> +from others.
> +
> +Meta-commits look like this:
> +
> +$ git cat-file -p <example_meta_commit>
> +tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> +parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> +parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> +author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> +parent-type content
> +parent-type obsolete
> +parent-type origin
> +
> +This says =E2=80=9Ccommit aa7ce555 makes commit d64309ee obsolete. It =
was created by
> +cherry-picking commit 7e1bbcd3=E2=80=9D.
> +
> +The tree for meta-commits is always the empty tree whose hash matches
> +4b825dc642cb6eb9a060e54bf8d69288fbee4904 exactly, but future versions =
of git may
> +attach other trees here. For forward-compatibility fsck should ignore =
such trees
> +if found on future repository versions. Similarly, current versions of=
 git
> +should always fill in an empty commit comment and tools like fsck shou=
ld ignore
> +the content of the commit comment if present in a future repository ve=
rsion.
> +This will allow future versions of git to add metadata to the meta-com=
mit
> +comments or tree without breaking forwards compatibility.

Am I correct to understand that the reason why a commit object is
(ab|re)used to represent a meta-commit is because by doing so we
would get connectivity (i.e. fetching & pushing would transfer all
the associated objects along) for free, and by not representing it
as a new and different object type, existing implementations can
just pass them along without understanding what they are, and as
long as these are not mixed as parts of the main history of the
project (e.g. when enumerating commits that has aa7ce5 as its
parents, because somebody else obsoleted aa7ce5 and you want to
evolve anything that built on it, you do not want to mistake the
above "meta" commit as a commit that is part of the ordinary history
and rebuild on top of the new version of aa7ce5, which would lead to
a disaster), everything would work just fine?

Perhaps you'd use something like "presence of parent-type header
marks that a commit is a meta-commit and not part of the main
history".

How are these meta commits anchored so that it won't be reclaimed by
repack?  I do not see any "parent" field used to chain them
together, but I do not think we can afford to spend one ref per meta
commit, as refs are not designed to point into each and every object
in the repository.

I have a moderately strong opposition against "origin" thing.  If
aa7ce555 replaces d664309ee, in order for the tool to be able to
"evolve" other histories that build on top of d664309ee, it only
needs the history between aa7ce555 and d664309ee and it would not
matter how aa7ce555 was built relative to its parent.  The user may
have typed/developed it from scratch, the user may have borrowed 70%
of its change from 7e1bbcd while remaining 30% was done from
scratch, or it was a concatenation of the change made in 7e1bbcd and
another commit. =20

One half of my point being that we can do _without_ it, and in all
cases, aa7ce555, if leaving the fact that it was derived from
7e1bbcd is so important, can mention that in its log message how it
relates to the "origin" thing.

And the other half is that while I consider the "origin" thing is
unnecessary for the above reasons, having it means we need to not
just transfer the history reading to aa7ce555 and d664309ee (which
are necessary anyway while we have histories to transplant from
d664309ee to aa7ce555) but also have to pull in the history leading
to 7e1bbcd and we cannot discard it.

