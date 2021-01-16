Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02C2C433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 00:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4F5229C9
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 00:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbhAPAaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 19:30:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61060 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPAay (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 19:30:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52F2E89168;
        Fri, 15 Jan 2021 19:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImZg7J8g+MOWzpLLwgRAftPbP1I=; b=Dq7JL7
        uQIxSNzkooKLIEaBHPY5Rh2SPGvYseKiyE4nDJO29Iny496/Wsw4xd/J0Qzn+YLW
        EkyNbU0yWMvigcr1M3eQZBe5oWQEJVgOhSNxZZVhe+iyorncPs4MouH0l/Efeulx
        jiIT6ZQ01n6p/aRmV6YbrILOcI0YVKMc1TuR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rCPtdKTusSv8AGDytNDxwdsnFCTfQ3TX
        EruwOkgF3h13wfU+Ed23Q3EB6VOGIjBp8qBEjhObevOE62k8Aa5QScMeXepZU6gc
        uHnD6OXptuWyO8eZCMUcxzH2goh12RD7DJb3cJtzXuNjwFOOS+gTeunHC8VTQ4tX
        pTgFhePI8VE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F3AC89165;
        Fri, 15 Jan 2021 19:30:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5566E89164;
        Fri, 15 Jan 2021 19:30:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: RFC on packfile URIs and .gitmodules check
References: <20210115234300.350442-1-jonathantanmy@google.com>
Date:   Fri, 15 Jan 2021 16:30:07 -0800
In-Reply-To: <20210115234300.350442-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 15 Jan 2021 15:43:00 -0800")
Message-ID: <xmqqim7xraeo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC8F3A04-5791-11EB-9D41-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Someone at $DAYJOB noticed that if a .gitmodules-containing tree and the
> .gitmodules blob itself are sent in 2 separate packfiles during a fetch
> (which can happen when packfile URIs are used), transfer.fsckobjects
> causes the fetch to fail. You can reproduce it as follows (as of the
> time of writing):
>
>   $ git -c fetch.uriprotocols=https -c transfer.fsckobjects=true clone https://chromium.googlesource.com/chromiumos/codesearch
>   Cloning into 'codesearch'...
>   remote: Total 2242 (delta 0), reused 2242 (delta 0)
>   Receiving objects: 100% (2242/2242), 1.77 MiB | 4.62 MiB/s, done.
>   error: object 1f155c20935ee1154a813a814f03ef2b3976680f: gitmodulesMissing: unable to read .gitmodules blob
>   fatal: fsck error in pack objects
>   fatal: index-pack failed
>
> This happens because the fsck part is currently being done in
> index-pack, which operates on one pack at a time. When index-pack sees
> the tree, it runs fsck on it (like any other object), and the fsck
> subsystem remembers the .gitmodules target (specifically, in
> gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
> checks if the target exists, but it doesn't, so it reports the failure.

Is this because the gitmodules blob is contained in the base image
served via the pack URI mechansim, and the "dynamic" packfile for
the latest part of the history refers to the gitmodules file that is
unchanged, hence the latter one lacks it?

> Another option is to do it within the connectivity check instead - so,
> update rev-list and the object walking mechanism to be able to detect
> .gitmodules in trees and fsck the target blob whenever such an entry
> occurs. This has the advantage that there is no extra re-inflation,
> although it might be strange to have object walking be able to fsck.
>
> The simplest solution would be to just relax this - check the blob if it
> exists, but if it doesn't, it's OK. Some things in favor of this
> solution:
>
>  - This is something we already do in the partial clone case (although
>    it could be argued that in this case, we're already trusting the
>    server for far more than .gitmodules, so just because it's OK in the
>    partial clone case doesn't mean that it's OK in the regular case).
>
>  - Also, the commit message for this feature (from ed8b10f631 ("fsck: check
>    .gitmodules content", 2018-05-21)) gives a rationale of a newer
>    server being able to protect older clients.
>     - Servers using receive-pack (instead of fetch-pack) to obtain
>       objects would still be protected, since receive-pack still only
>       accepts one packfile at a time (and there are currently no plans
>       to expand this).
>     - Also, malicious .gitobjects files could still be crafted that pass
>       fsck checking - for example, by containing a URL (of another
>       server) that refers to a repo with a .gitobjects that would fail
>       fsck.
>
> So I would rather go with just relaxing the check, but if consensus is
> that we should still do it, I'll investigate doing it in the
> connectivity check.

You've listed two possible solutions, i.e.

 (1) punt and declare that we assume an missing and uncheckable blob
     is OK,

 (2) defer the check after transfer completes.

Between the two, my gut feeling is that the latter is preferrable.
If we assume an missing and uncheckable one is OK, then even if a
blob is available to be checked, there is not much point in
checking, no?

As long as the quarantine of incoming pack works correctly,
streaming the incoming packdata (and packfile downloaded out of line
via a separate mechanism like pack URI) to index-pack that does not
check to complete the transfer, with a separate step to check the
sanity of these packs as a whole, should not harm the repository
even if it is interrupted in the middle, after transfer is done but
before checking says it is OK.

As a potential third option, I wonder if it is easier for everybody
involved (including third-party implementation of their
index-pack/fsck equivalent) if we made it a rule that a pack that
has a tree that refers to .git<something> must include the blob for
it?

Thanks.
