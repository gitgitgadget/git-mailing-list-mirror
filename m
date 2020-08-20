Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87CC433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 00:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E9B2076E
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZR/I8PsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHTA4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:56:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56411 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHTA4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 20:56:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6164F2A42;
        Wed, 19 Aug 2020 20:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vm2yGzd4dQv0ippROeyOXulswF4=; b=ZR/I8P
        sVZZkwvO95u5xzmm7D56UvtZbp4yMIi1HLclTfI4P9Eq/Ly3nGB69H7iWdXBcOt0
        +sYPdK345I9lIZJY+rwUcz9s+gyQrFFNh82Zh+webu7iaPeSAMi4RS1CAyz94S+R
        MIlVg8TlRpYhFMLqLbMYth4jz4T6iRC2fS1ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZvcQtLTHHGCnCGKb777ifprL7+F2B7dW
        9TZdDfV+0fBcIk8kuGwriH5oUbEnVlIERxRPEqwUGKmUkgv3YB2O4Udg7N0MzleA
        Xd8O53ALMpY2Qetsh7B8E4JmK0PlZErD2CzvjjqCuxnYxuXxd/gfEpaidH0QoXEe
        ScPxmo/OnZA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE005F2A41;
        Wed, 19 Aug 2020 20:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35E28F2A40;
        Wed, 19 Aug 2020 20:56:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v3] diff: teach --stat to ignore uninteresting modifications
References: <pull.689.v2.git.1597445151824.gitgitgadget@gmail.com>
        <pull.689.v3.git.1597884092580.gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 17:56:24 -0700
In-Reply-To: <pull.689.v3.git.1597884092580.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Thu, 20 Aug 2020 00:41:32
        +0000")
Message-ID: <xmqqzh6qb0ef.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9786BF6-E27F-11EA-8771-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> When options such as --ignore-space-change are in use, files with
> modifications can have no interesting textual changes worth showing.  In
> such cases, "git diff --stat" shows 0 lines of additions and deletions.
> Teach "git diff --stat" not to show such a path in its output, which
> would be more natural.
>
> However, we don't want to prevent the display  of all files that have 0
> effective diffs since they could be the result of a rename, permission
> change, or other similar operation that may still be of interest so we
> special case additions and deletions as they are always interesting.
>
> Signed-off-by: Matthew Rogers <mattr94@gmail.com>
> ---

Looks good, thanks.  Will queue.


By the way, before making your commits, please make sure you do not
have whitespace errors.  I've let my "git am" to fix them, so no
need to resend, but for future reference...

.git/rebase-apply/patch:116: trailing whitespace.
			struct diffstat_file *file = 
.git/rebase-apply/patch:119: trailing whitespace.
			 * Omit diffstats of modified files where nothing changed. 
.git/rebase-apply/patch:122: trailing whitespace.
			 * 
.git/rebase-apply/patch:124: trailing whitespace.
			 * renames, and mode changes as adding an empty file, 
.git/rebase-apply/patch:127: trailing whitespace.
			if ((p->status == DIFF_STATUS_MODIFIED) 
warning: 5 lines applied after fixing whitespace errors.
Applying: diff: teach --stat to ignore uninteresting modifications

