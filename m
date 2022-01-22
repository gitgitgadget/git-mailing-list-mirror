Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1479C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 01:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiAVBtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 20:49:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65427 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiAVBtI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 20:49:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3628E10D4E7;
        Fri, 21 Jan 2022 20:49:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3G7uT4H69hxOosmDipHMdJXqepcsjga+ZZbC1
        CypJY=; b=dwX6I+Of+bjocN3Vj+klQS/g68XfL3l90dmIB6l9QLvFztiWJ6RJ+6
        ssyeofzXFrXJZ7zdBjAYaXuy3EJHiv1TK7sVzfOBo9Q0GtC5iyahnXiDhY1z4tmr
        ZJdG83jcykq9AEJoKUQDWYlVHz5wicffLQRwH8ZU+J0NN9Rvl7j70=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB59D10D4E6;
        Fri, 21 Jan 2022 20:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EB4210D4E5;
        Fri, 21 Jan 2022 20:49:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to submodules
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
Date:   Fri, 21 Jan 2022 17:49:01 -0800
In-Reply-To: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 20 Jan 2022 19:32:48 -0800")
Message-ID: <xmqqsftgbkvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7961AFBE-7B25-11EC-880E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> When cloning a repo with a --filter and with --recurse-submodules
> enabled, the partial clone filter only applies to
> the top-level repo. This can lead to unexpected bandwidth and disk
> usage for projects which include large submodules. For example, a user
> might wish to make a partial clone of Gerrit and would run:
> `git clone --recurse-submodules --filter=blob:5k
> https://gerrit.googlesource.com/gerrit`. However, only the superproject
> would be a partial clone; all the submodules would have all blobs
> downloaded regardless of their size. With this change, the same filter
> applies to submodules, meaning the expected bandwidth and disk savings
> apply consistently.
>
> Plumb the --filter argument from git-clone through git-submodule and
> git-submodule--helper, such that submodule clones also have the filter
> applied.
>
> This applies the same filter to the superproject and all submodules.
> Users who prefer the current behavior (i.e., a filter only on the
> superproject) would need to clone with `--no-recurse-submodules` and
> then manually initialize each submodule.

Two concerns (I do not say "issues", because I honestly do not know
how much this will hurt in the future).

 - Obviously, this changes the end user experience.  To users in the
   scenario that motivated this change (described above), obviously
   it is a change in a good way, and but I wonder if there are
   workflows that are hurt and actually have to resort to the
   workaround to preserve the current behaviour.

 - Passing the filter down to submodules means that the filter
   settings are universal across projects.  The current set of
   filters, I do not think such an assumption is too bad.  If 5k
   blob is too large for the top-level superproject, it is OK for
   the superproject to dictate that 5k blob is too large for any of
   the submodules the superproject uses.  But can we forever limit
   the filter vocabulary to the ones that can sensibly be applied
   recursively?  If we had a filter that goes with pathnames
   (e.g. "I only want src/ and test/ directories and nothing else
   initially"), such a set of pathnames appropriate in the context
   of the superproject is unlikely to apply to its submodules.  Even
   the existing "depth" filter is iffy, if a toplevel superproject
   is fairly flat and one of the submodules has a directory
   hierarchy that is ultra deep.

Will queue and wait for others to comment.

Thanks.
