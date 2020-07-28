Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D4C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC87D2075D
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZhPmWxR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgG1VBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:01:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59949 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1VBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 17:01:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6298F784BB;
        Tue, 28 Jul 2020 17:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o6hMjp/ZnGhlrGuC7ah/x9w2WG4=; b=WZhPmW
        xR5IlwzhuFyHVIFMvQbR2fM529FDhfCBp8qa8WzuIbHrfUmam7xCNzsce4J8V27w
        KZIpGGmm/q+IX9dpvvaJJZcoPimBVUssGU/tRkEUMOC22g+AP0Z8YgbTjAJypyTv
        xshuuDsr/lTBtU62Fur3OmmNWdDQ/zVZ+DqJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UYAKRW4jGINVbVHkot/BVvH4U0klI7Td
        +aB6RgX/gu9g5ctxBdVETP+JSjtgc9nPC1/TpR8I2w/cUDyitI8TdxN7B/UBWkCn
        AqXX2a6XJBQTEqAr+Qkg2NUjVo/LmLRaIi9Ln9C8SASr3ikpubh8LD9X7wwALyfp
        CbVBWyVFEH4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59F45784BA;
        Tue, 28 Jul 2020 17:01:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DCA59784B9;
        Tue, 28 Jul 2020 17:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: add "--ignore-merges" option to counteract "-m"
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200728163853.GB2650252@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 14:01:27 -0700
In-Reply-To: <20200728163853.GB2650252@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 28 Jul 2020 12:38:53 -0400")
Message-ID: <xmqqv9i7cq1k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 812123A8-D115-11EA-862C-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The "-m" option sets revs->ignore_merges to "0", but there's no way to
> undo it. This probably isn't something anybody overly cares about, since
> "1" is already the default, but it will serve as an escape hatch when we
> flip the default for ignore_merges to "0" in more situations.
>
> We'll also add a few extra niceties:
>
>   - initialize the value to "-1" to indicate "not set", and then resolve
>     it to the normal 0/1 bool in setup_revisions(). This lets any tweak
>     functions, as well as setup_revisions() itself, avoid clobbering the
>     user's preference (which until now they couldn't actually express).
>
>   - since we now have --ignore-merges, let's add the matching
>     --no-ignore-merges, which is just a synonym for "-m". In fact, it's
>     simpler to just document --no-ignore-merges alongside "-m", and
>     leave it implied that its opposite countermands it.
>
> The new test shows that this behaves just the same as the current
> behavior without "-m".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I pulled the option name from the rev_info field name. It might be too
> broad (we are not ignoring merges during the traversal, only for the
> diff). It could be "--no-diff-merges" or something, but that would
> involve flipping the sense of the boolean (but that would just be in the
> code, not user-visible, so not that big a deal).
>
>  Documentation/rev-list-options.txt            |  1 +
>  builtin/log.c                                 |  4 +-
>  revision.c                                    | 10 ++-
>  revision.h                                    |  2 +-
>  t/t4013-diff-various.sh                       |  1 +
>  ...g_--ignore-merges_-p_--first-parent_master | 78 +++++++++++++++++++
>  6 files changed, 90 insertions(+), 6 deletions(-)
>  create mode 100644 t/t4013/diff.log_--ignore-merges_-p_--first-parent_master
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index b01b2b6773..fbd8fa0381 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1148,6 +1148,7 @@ options may be given. See linkgit:git-diff-files[1] for more options.
>  	rename or copy detection have been requested).
>  
>  -m::
> +--no-ignore-merges::

This invites a natural "does --ignore-merges exist, and if so what
does it do?"  Why not to have "--[no-]ignore-merges" as a separate
entry immediately after the existing "-m" instead?

>  	This flag makes the merge commits show the full diff like
>  	regular commits; for each merge parent, a separate log entry
>  	and diff is generated. An exception is that only diff against

That is,

	--[no-]ignore-merges::

		`--no-ignore-merges` is a synonym to `-m`.
		`--ignore-merges` countermands an earlier `-m` that
		is either explicitly or implicitly given.

or something along the line, perhaps?

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 43267d6024..8f9181316f 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -297,6 +297,7 @@ log --root --patch-with-stat --summary master
>  log --root -c --patch-with-stat --summary master
>  # improved by Timo's patch
>  log --root --cc --patch-with-stat --summary master
> +log --ignore-merges -p --first-parent master

This explicitly says "I do not want to see diff for merges" ...

>  log -p --first-parent master
>  log -m -p --first-parent master
>  log -m -p master
> diff --git a/t/t4013/diff.log_--ignore-merges_-p_--first-parent_master b/t/t4013/diff.log_--ignore-merges_-p_--first-parent_master
> new file mode 100644
> index 0000000000..fa0cdc8a23
> --- /dev/null
> +++ b/t/t4013/diff.log_--ignore-merges_-p_--first-parent_master
> @@ -0,0 +1,78 @@
> +$ git log --ignore-merges -p --first-parent master
> +commit 59d314ad6f356dd08601a4cd5e530381da3e3c64
> +Merge: 9a6d494 c7a2ab9
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:04:00 2006 +0000
> +
> +    Merge branch 'side' into master

... and that is honored here?  Good.

