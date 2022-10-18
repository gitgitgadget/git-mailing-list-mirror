Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8DC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 16:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJRQcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJRQck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 12:32:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F041B03E3
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 09:32:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0A861D35B7;
        Tue, 18 Oct 2022 12:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rKizhSZEVMRNHYlmcvRjXr7annkev/Q/stTQUJ
        9/WwA=; b=w3tr95e2wAcUvuDOB0cuqabglWmiWwRWfsq9iFnNh6PrMPoHFPtYb6
        YskQsZ7P54kJnqvG7OsYN+mv3RrMsVKwNWfcaDAzcA/s8htlAHn/Ogw7oj+Urrl1
        wBro6m3SdiiXoot5TwQEWXtYS3Lu4cGKOYD6CaeUEBHXhR6XNw08U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E976B1D35B6;
        Tue, 18 Oct 2022 12:32:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 273581D35B5;
        Tue, 18 Oct 2022 12:32:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathias Rav <m@git.strova.dk>
Cc:     git@vger.kernel.org, peff@peff.net, pwagland@gmail.com
Subject: Re: [PATCH] revision: ignore non-existent objects in resolve-undo list
References: <20221018175530.086c8c74@apus>
Date:   Tue, 18 Oct 2022 09:32:35 -0700
In-Reply-To: <20221018175530.086c8c74@apus> (Mathias Rav's message of "Tue, 18
        Oct 2022 17:55:30 +0200")
Message-ID: <xmqqfsflum70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7949D022-4F02-11ED-AF0B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathias Rav <m@git.strova.dk> writes:

> Garbage collection could inadvertently prune blobs mentioned only in the
> resolve-undo extension prior to the bugfix in 5a5ea141e7
> ("revision: mark blobs needed for resolve-undo as reachable", 2022-06-09).

Older versions of Git did not consider blobs referenced by the
resolve-undo as reachable, and allowed "git gc" to expire them out
of existence.  And "git fsck" in these versions did report that
these blobs are unreachable.

Newer versions of Git on the other hand do consider these blobs as
reachable, so "git gc" would not expire them.  And "git fsck" would
complain when they are missing, because by definition we should not
lose reachable objects.

The error discussed recently on the list was only because older
version was used to "git gc" away blobs that are still in use.

I think the right solution for such a transitory error is not to
hide the problem and pretend that such a blob reference does not
exist, which is what ...

> Fix the error by emitting a warning when the resolve-undo list mentions
> objects that do not exist and then ignoring the nonexistent object.

... this approach is about.  I think it is backwards to sweep the
problem under the rug without fixing the underlying problem.

We should instead be removing the reference that is no longer even
usable for the purpose of resolve-undo, e.g. when "rerere forget
<pathspec>" reads from the resolve-undo extension to recreate the
conflicts.

Perhaps "git reflog --state-fix" is a good model to follow.  Back
when the option was introduced, we found that there was a buggy
implementation of "git gc" that did not consider commits referenced
by reflog entries reachable and removed them, breaking "git reflog".
The solution was to remove these reflog entries that accidentally
lost commits that they reference because they no longer are usable.

The manual procedure Peff gave in the thread does work OK, but if it
makes it more friendly, a new option to "update-index" to fix the
index file by removing things that refer to missing objects would
not be a bad idea.

Thanks.
