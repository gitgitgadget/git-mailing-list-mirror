Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0CEC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 23:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiAQXFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 18:05:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62089 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQXFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 18:05:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 337DD160D4F;
        Mon, 17 Jan 2022 18:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KIsxMlsZo+2wMihn2A++7G+dFmDDyOG8oJQCqW
        PkrcY=; b=MRcJ8l5Sqs/z/ULqb9EoQG1gqulf18Or4JXhYHq6a4/EurB79R+FNA
        MPow3ZjbTIdisc2N2DJC88ceyJg2vZhQOn7q99jO+ivffuqvpmazZlzBYKB9+Isi
        HBgWgU8nLo1z9+4K32+6z5tR4tH6hKxDWpLf84VhSiyuvwja/0v4Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B38D160D4E;
        Mon, 17 Jan 2022 18:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4E1ED160D4D;
        Mon, 17 Jan 2022 18:05:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     git@vger.kernel.org
Subject: Re: Behavior of core.sharedRepository on non-bare Repositories
References: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
Date:   Mon, 17 Jan 2022 15:05:38 -0800
In-Reply-To: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1> (John A. Leuenhagen's
        message of "Mon, 17 Jan 2022 17:39:12 -0500")
Message-ID: <xmqqo84at131.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCC2940C-77E9-11EC-B995-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John A. Leuenhagen" <john@zlima12.com> writes:

> Based on the wording in the man page, I was under the impression that
> this would affect all files in any type of repository (bare or not), but
> it seems as though this is not the case. It affects bare repositories as
> one would expect, but it only affects the .git directory on non-bare
> repositories. The working tree is not affected by the option at all.

This behaviour, as far as I know, dates back way before "git
worktree add" was invented.  Such an arrangement to share the object
store and refs (i.e. contents of .git/) among multiple worktrees
were already available via contrib/workdir/ even back then.

The motivation behind the current design may be that sharing a
working tree between two people to allow overwriting each other's
change in an uncontrolled way with their editors is a total disaster
and nobody would consider doing such a nonsensical arrangement.  It
may be why we do not loosen the permission of working tree files
beyond what your umask does.

But allowing write access to the same repository from multiple
working trees were considered worth supporting.  More importantly,
the repository data access by git is not uncontrolled---there are
protections with lockfiles to avoid overwriting others' changes.

If multiple people must write into the same repository and the same
working tree, the umask(1) command is your friend.  Add these users
to the same single group, have the repository and working tree files
owned by that group, and make sure these users have umask no
stricter than 007.

