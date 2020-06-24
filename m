Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB2CC433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18C5207FC
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fq2RjK9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbgFXVUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:20:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53613 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 17:20:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFFD67AD53;
        Wed, 24 Jun 2020 17:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tczjow9EvUHxJGX7QvmR/VH0yfg=; b=Fq2RjK
        9kv9G+apBEw2wCWLo9J5XUa0xRddh1SidL6iwjgr9KEoqim6fKJSfard262gjKsA
        Bg3NFt9kwWIwfne2WDQiQLZrE8V2bww1ZjloVP/h7vzcxtGVBkQ5lvRxelsj2GXS
        GKC1Qp46WnVCGGnB6OO1ON6pzDW6YeRHbIQYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mrh07GYaFWk7IEm+jkE/RsuYIFhp7AGI
        AKXMiSeiiV/R4uMndsh93i9h7b22io7kYNzKSmdV4UF1jDkJZR2MUYEOU4rD6zH+
        Aj1gBoRu7xNilMLYIP55bmghOXlYgi1Ci37RD2slNIFiUeOBf7k45YXrAQ8xyhVg
        koJj+QYxymM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B61577AD52;
        Wed, 24 Jun 2020 17:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EA937AD51;
        Wed, 24 Jun 2020 17:20:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [PATCH] worktree: avoid dead-code in conditional
References: <20200624190541.5253-1-sunshine@sunshineco.com>
Date:   Wed, 24 Jun 2020 14:20:12 -0700
In-Reply-To: <20200624190541.5253-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Wed, 24 Jun 2020 15:05:41 -0400")
Message-ID: <xmqqsgek5fg3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DD9C530-B660-11EA-894B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> get_worktrees() retrieves a list of all worktrees associated with a
> repository, including the main worktree. The location of the main
> worktree is determined by get_main_worktree() which needs to handle
> three distinct cases for the main worktree after absolute-path
> conversion:
>
>     * <bare-repository>/.
>     * <main-worktree>/.git/. (when $CWD is .git)
>     * <main-worktree>/.git (when $CWD is any worktree)

It is unclear from the above but I would assume that you are talking
about the returned path from get_git_common_dir().

I can certainly understand why there needs two distinct cases
(i.e.. bare vs non-bare), but why is this codepath (or any caller of
get_git_common_dir()) forced to care about the two cases?

I wonder if the right "fix" to this instance, at the same time
preventing similar breakages in the future, is rather make sure
get_git_common_dir() not to return the redundant path with ".git/."
suffixed?  For that matter, I do not know why the bare case must
need "/." suffix.  There seem to be about a dozen callers of the
function, but don't some of them share a similar issue?  

Let's look at the other two grep hits from worktree.c

	strbuf_reset(&path);
	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);

	worktree = xcalloc(1, sizeof(*worktree));
	worktree->path = strbuf_detach(&worktree_path, NULL);
	worktree->id = xstrdup(id);
	add_head_info(worktree);

done:
	strbuf_release(&path);
	strbuf_release(&worktree_path);
	return worktree;
}

This looks somewhat bogus.  "sturct strbuf path" is populated, but
is released without ever getting used, isn't it?  Am I grossly
misreading the code?

The other one

	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
	dir = opendir(path.buf);
	strbuf_release(&path);
	if (dir) {
		while ((d = readdir(dir)) != NULL) {
		...

is a regular filesystem access, but it ends up opening the directory
with a path like "foo/.git/./worktrees", where we should be using a
more reasonable "foo/.git/worktrees" to access it.  The redundant
"/./" is not wrong per-se, but it looks sloppy to depend on "not
wrong per-se".

Puzzled.
