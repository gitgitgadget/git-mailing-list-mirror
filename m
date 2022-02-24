Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46120C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBXSYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiBXSYr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:24:47 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7B25317F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:24:16 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFD2418202C;
        Thu, 24 Feb 2022 13:24:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+v6LUWIMi0i+Nh9LwD3nxTKHs9bYz1NRH2isbR
        JrcJg=; b=p5EZY4fSz/IpnpFQdCEWnB65si8vgMBtFfzZeA901jmSVkxQzxySvo
        ESYCr0Z8oG7xn0YLyd0x6gYZbAHOWzcoWsa/AoLOokiCxPvhVMB8x517XNcYMaQz
        6Z9+UmtZsXc2ZFagIQG6QZH4Ax8fmh3V30To+zFDhQDGQPBDDUWa0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B767518202B;
        Thu, 24 Feb 2022 13:24:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A5E918202A;
        Thu, 24 Feb 2022 13:24:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] repo_read_index: add config to expect files outside
 sparse patterns
References: <YhWbWOd6PeF1RZw1@google.com>
        <20220224052259.30498-1-newren@gmail.com>
Date:   Thu, 24 Feb 2022 10:24:12 -0800
In-Reply-To: <20220224052259.30498-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 23 Feb 2022 21:22:59 -0800")
Message-ID: <xmqq35k8nmwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F787ECEE-959E-11EC-969E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Typically with sparse checkouts, we expect files outside the sparsity
> patterns to be marked as SKIP_WORKTREE and be missing from the working
> tree.  In edge cases, this can be violated and cause confusion, so in a
> sparse checkout, since 11d46a399d ("repo_read_index: clear SKIP_WORKTREE

I think this refers to af6a5187 (repo_read_index: clear
SKIP_WORKTREE bit from files present in worktree, 2022-01-14).

> bit from files present in worktree", 2022-01-06), Git automatically
> clears the SKIP_WORKTREE bit at read time for entries corresponding to
> files that are present in the working tree.

So, this is a workflow where the user deliberately "creates" these
files outside the sparsity cone or pattern (by various non-automated
means like editing, copying/renaming, or untarring).  If they did so
on purpose, they may be interested in comparing them with existing
commits, or even including them as a newer version in the next
commit they create.  To help that workflow, clearing the bit makes
sense.

Am I on the right path?  I am wondering if mentioning some of that
would help understanding by the reader when it is contrasted with
the (competing) goal of supporting VFS use case mentioned next.

> However, there is a more atypical situation where this situation would

I wonder if that is "more atypical" (read: makes me wonder if it
depends on who the reader is what is typoical), and more importantly,
if it helps understanding of the reader (read: whether which one is
more common, we'd want to support both camps anyway).  

    There is another workflow, however, that it is expected that
    paths outside the sparsity patterns appear to exist in the
    working tree and that they do not lose the SKIP_WORKTREE bit, at
    least until they get modified.

or something?

> be expected.  A Git-aware virtual file system[1] takes advantage of its
> position as a file system driver to expose all files in the working
> tree, fetch them on demand using partial clone on access, and tell Git
> to pay attention to them on demand by updating the sparse checkout
> pattern on writes.  This means that commands like "git status" only have
> to examine files that have potentially been modified, whereas commands
> like "ls" are able to show the entire codebase without requiring manual
> updates to the sparse checkout pattern.

Well explained.

> Thus since 11d46a399d, Git with such Git-aware virtual file systems

The same stale reference.

> unsets the SKIP_WORKTREE bit for all files and commands like "git
> status" have to fetch and examine them all.
>
> Introduce a configuration setting sparse.expectFilesOutsideOfPatterns to
> allow limiting the tracked set of files to a small set once again.  A
> Git-aware virtual file system or other application that wants to
> maintain files outside of the sparse checkout can set this in a
> repository to instruct Git not to check for the presence of
> SKIP_WORKTREE files.  The setting defaults to false, so most users of
> sparse checkout will still get the benefit of an automatically updating
> index to recover from the variety of difficult issues detailed in
> 11d46a399d for paths with SKIP_WORKTREE set despite the path being

Ditto.

> I'm guessing that since there are no code (only documentation) changes since
> Jonathan's v2 submission, that this patch satisfies vfsd/Google's needs.
> I'm also guessing it matches what Stolee and Dscho stated in their comments
> on v1.  But it'd be nice to have an ack from each side just to make sure.

True.  Let me queue but leave it just outside 'next' until that
happens.

I think the name of the knob is what Jonathan suggested, so I
presume that their side would be fine with it, but I am curious (I
do not wonder, though) what the plan on the Microsoft's side going
forward.  When they update the version of Git bundled in their vfsd,
would this be reverted and an equivalent they have (and they may
have more such "workaround" in other areas as well?) will be kept,
so whatever we do here will add a minor inconvenience to them but
will not hurt them otherwise?

> diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> new file mode 100644
> index 0000000000..fba504173c
> --- /dev/null
> +++ b/Documentation/config/sparse.txt
> @@ -0,0 +1,28 @@
> +sparse.expectFilesOutsideOfPatterns::
> +	Typically with sparse checkouts, files not matching any
> +	sparsity patterns are marked as such in the index file and

s/index file/index/ perhaps.

> +	missing from the working tree.  Accordingly, Git will
> +	ordinarily check whether files that the index indicates are
> +	outside of the sparse area are present in the working tree and
> +	mark them as present in the index if so.  This option can be

Just an observation.  According to this sentence, "sparse area" is
"paths that ought to be present in the working tree", so paths
"outside of the sparse area" that are present need to be corrected
to be "in" the sparse area by futzing bits.  I always get confused
when I hear "sparse area" if the author meant "paths that ought to
be missing" or "present", but maybe it is just me.

> +	used to tell Git that such present-but-unmatching files are
> +	expected and to stop checking for them.

OK.

> ++
> +The default is `false`.  Paths which are marked as SKIP_WORKTREE
> +despite being present (which can occur for a few different reasons)
> +typically present a range of problems which are difficult for users to

s/typically // perhaps.

> +discover and recover from.  The default setting avoids such issues.
> ++
> +A Git-based virtual file system (VFS) can turn the usual expectation
> +on its head: files are present in the working copy but do not take
> +up much disk space because their contents are not downloaded until
> +they are accessed.  With such a virtual file system layer, most files
> +do not match the sparsity patterns at first, and the VFS layer
> +updates the sparsity patterns to add more files whenever files are
> +written.  Setting this to `true` supports such a setup where files are
> +expected to be present outside the sparse area and a separate, robust
> +mechanism is responsible for keeping the sparsity patterns up to date.

s/separate, robust/separate/ I would think.

We make the outside mechanism that makes these files appear to be
present to also be responsible for maintaining the sparse bit and
patterns.

When the user (or IDE) sets this knob to 'true', do we even have to
expect that files appear to be present?  In the use case we intend
to support with this feature, i.e. some VFS, we might expect all
paths to appear to be present, but if that VFS also allows users to
configure to expose only a subset of paths, not all paths may appear
to be present.  And we are perfectly OK with that, becuase we do not
expect anything about the working tree paths outside the sparsity
pattern.  Am I mistaken?

So, "... supports such a setup where some external system releaves
us of the responsibility of maintaining the consistency between the
presence of working tree files and sparsity patterns, so we stop
expecting whether files are present or missing outside the sparse
area", might be closer to the truth?

> +Note that the checking and clearing of the SKIP_WORKTREE bit only
> +happens when core.sparseCheckout is true, so this config option has no
> +effect unless core.sparseCheckout is true.

Good note to have.  There is no mention of "cone" mode in the entire
description; it is unclear if this only applies to "pattern" mode or
to both "pattern" and "cone" modes, which may want to be clarified.

Thanks.
