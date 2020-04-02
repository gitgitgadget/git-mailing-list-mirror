Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFEC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64C120678
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 20:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ME+06J/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbgDBU3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:29:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50744 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBU27 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 16:28:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E584ACCFE6;
        Thu,  2 Apr 2020 16:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nHwxFgQWsSPVWteVL48HyQBUsQ=; b=ME+06J
        /sx+oDw84tNuCYi/GftZ/fcY6jIX9uKLdHVz0zKsM9bZGuzF+4xUYmVFEYqs+DnK
        DSpVPqbRXCmahCVVfBH9d9rQP8W8Bb9uznDirOqPSBugwisF2pmwgW5yEBmLXjG8
        w/dtAFDiC4nOD9vVjtviNdPu2FLxdpUsFPsFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N+KRcvZ+f6T/mxTL7MXZB6vLL0aRTWm3
        MfU2pQlcOPMvAg9PoG7fKlRKuFn/ZaskDbOuwF9kKMeSJ2SpLGSx2hbxE9PvJeMV
        LIPnW8NZdG1xGytzn3iDxPMNKViLg9oY6ZHsIcS4puumc9BL8oqUkve8dxwrZGvz
        LORqEjXlkNI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDDEECCFE4;
        Thu,  2 Apr 2020 16:28:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 367F5CCFE2;
        Thu,  2 Apr 2020 16:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 0/2] Restrict when prefetcing occurs
References: <20200331020418.55640-1-jonathantanmy@google.com>
        <cover.1585854639.git.jonathantanmy@google.com>
Date:   Thu, 02 Apr 2020 13:28:53 -0700
In-Reply-To: <cover.1585854639.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 2 Apr 2020 12:19:15 -0700")
Message-ID: <xmqq369l3a4a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92E9339C-7520-11EA-9B45-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, everyone, for your review.
>
> New in v2:
>  - added restriction on fetching rename_src's blob, following Stolee's
>    comment
>  - folded oid_nr==0 check into promisor_remote_get_direct(), following
>    Stolee's comment
>  - used "mv server/b server/c", following Stolee's comment
>  - made diff_add_if_missing() public function, following Junio's comment
>
> I didn't change the "continue" part that Stolee suggested [1].
>
> [1] https://lore.kernel.org/git/xmqqlfng75cl.fsf@gitster.c.googlers.com/
>
> Jonathan Tan (2):
>   promisor-remote: accept 0 as oid_nr in function
>   diff: restrict when prefetching occurs
>
>  builtin/index-pack.c          |  5 ++--
>  diff.c                        | 49 +++++++++++++++++++++++------------
>  diffcore-rename.c             | 37 +++++++++++++++++++++++++-
>  diffcore.h                    | 10 ++++++-
>  promisor-remote.c             |  3 +++
>  promisor-remote.h             |  8 ++++++
>  t/t4067-diff-partial-clone.sh | 48 ++++++++++++++++++++++++++++++++++
>  unpack-trees.c                |  5 ++--
>  8 files changed, 141 insertions(+), 24 deletions(-)

I notice that a439b4ef (diff: skip batch object download when
possible, 2020-03-30) by Garima seems to aim for something similar.

I'll for now keep both topics with conflict resolution, but it may
make sense for you two to compare notes.  

I especially like the way this series enumerates the formats that
matter to prefetching and the way the change is localized in
diffcore_std(); the other topic splits a similar logic (with
different criteria) between diff_setup_done() and diffcore_std(),
which I found suboptimal.

Thanks.
