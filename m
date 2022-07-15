Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0AC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 17:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiGORsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGORr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 13:47:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD42F03C
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 10:47:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD7B41A8FF6;
        Fri, 15 Jul 2022 13:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZV6eSMvQZ0kOBtgaNP/bMI7uVrgXQx5+PCWC6R
        kRD7A=; b=Uqjn56CWsTrzab2tNVh95OnpUiplw+ECUNaguM4fdKsyFDqIv4bJrQ
        OAP/s9Z7PIw3ATHVl1jX2gwY1TpxX9fsGFMea8KaUYH+eBL0VUoc7Jnwa/47oKsi
        kBgKrrv2cHfHU1fB5fkBTXbCuRyMs4BaIPbcsSo2knKuDHVSVQhZ0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5C141A8FF5;
        Fri, 15 Jul 2022 13:47:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 781891A8FF2;
        Fri, 15 Jul 2022 13:47:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pierre Garnier <pgarnier@mega.com>
Subject: Re: [PATCH] refs: work around network caching on Windows
References: <pull.1291.git.1657872416216.gitgitgadget@gmail.com>
        <CAPig+cT17vZcsf2pGQh-S6UjZib3=4Am7RVf=gQq_sDZzKD08w@mail.gmail.com>
Date:   Fri, 15 Jul 2022 10:47:50 -0700
In-Reply-To: <CAPig+cT17vZcsf2pGQh-S6UjZib3=4Am7RVf=gQq_sDZzKD08w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 15 Jul 2022 04:29:11 -0400")
Message-ID: <xmqqy1wuz2rd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F649A7C-0466-11ED-A84D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> The underlying culprit is that `GetFileAttributesExW()` that is called from
>> `mingw_lstat()` can raise an error `ERROR_PATH_NOT_FOUND`, which is
>> translated to `ENOTDIR`, as opposed to `ENOENT` as expected on Linux.
>> ...
>> @@ -480,7 +480,7 @@ static int load_contents(struct snapshot *snapshot)
>> -               if (errno == ENOENT) {
>> +               if (errno == ENOENT || errno == ENOTDIR) {
>
> The first question which popped into my mind upon reading the patch
> was why these changes need to be made to files-backend.c and
> packed-backend.c rather than "fixing" mingw_lstat() to return ENOENT
> instead of ENOTDIR. Patching mingw_lstat() seems more tractable and
> less likely to lead to discovery of other code in the future which
> needs to be patched in a similar way to how files-backend.c and
> packed-backend.c are being patched here.
>
> Perhaps it's a silly question and the answer is perfectly obvious to
> folks directly involved in Git development on Windows, but the commit
> message doesn't seem to answer it for people who don't have such
> inside knowledge.

FWIW, I had the same reaction.  ENOTDIR does not mean an attempt to
access "test_dir/test_tag" failed because "test_dir" did not
exist---it means "test_dir" exists as something that is not a
directory (hence there is no way "test_dir/test_file" to exist).

In the example scenario in the proposed log message, a new tag
"test_dir/test_tag" is created, and (even though the proposed log
message does not explicitly say so) presumably, "test_dir" needs to
be created while doing so.  A failure to access "test_dir/test_file"
due to lack of "test_dir" shouldn't report ENOTDIR but should report
ENOENT.  So something is fishy.

Unless the internal implementation of the filesystem creates a
placeholder that is not a directory at "test_dir", returns the
control to the application, and does further work to turn that
placeholder object into a directory in the background, and the
application attempts to create "test_dir/test_tag" in the meantime,
racing with the filesystem, or something silly like that?

It sounds like a platform specific bug that is not specific to the
ref-files subsystem.  If it can be fixed at lstat() emulation, that
would benefit other checks for ENOENT.

Having said all that.

Stepping back a bit, one situation where we would want to special
case ENOENT is when we have an optional file at known location and
it is OK for the file to be missing.  We may attempt to read from
"$XDG_CONFIG_HOME/git/config" and it may fail due to ENOENT or
ENOTDIR because the user may not be using XDG config location at all
(hence $XDG_CONFIG_HOME or XDG_CONFIG_HOME/git may be missing) or
the leading directories may be there but not the file at the leaf
level.  In such a use case, we should ignore ENOTDIR just like we
ignore ENOENT as an error that does not matter.

In any case, the posted patch may hide a repository corruption from
the codepath affected and cause it to silently return a bogus
answer.  The first hunk touches read_ref_internal() where "path"
variable contains the path we expect to find the on-disk loose ref
file

	if (lstat(path, &st) < 0) {
		int ignore_errno;
		myerr = errno;
		if (myerr != ENOENT || skip_packed_refs)
			goto out;
		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
				      referent, type, &ignore_errno)) {
			myerr = ENOENT;
			goto out;
		}
		ret = 0;
		goto out;
	}

The idea is that a ref does not have to exist as a loose ref file,
so an error from lstat() is not immediately an error.  If the ref
were previously packed, then we should fall back to read it from the
packed-ref file.

So we say that if the error is *NOT* ENOENT, we jump to 'out' label
to report the failed lstat() as an error".  Otherwise we proceed to
attempt to read from the packed-ref file.  Is there any case where
an attempt to read from a loose ref fails with ENOTDIR and it is OK
that we can proceed without reading from the packed-refs file?

If we have a branch "js/foo" that is packed, and then if we removed
it, and then created a branch "js", the original "js/foo" should not
be in the packed-refs file, but supposed a repository is corrupt and
"js/foo" remains in the packed-refs file.  Now imagine that we ask
for "js/foo".  What happens?

We fail to lstat ".git/refs/heads/js/foo" due to ENOTDIR, because
the "js" branch exists loose at ".git/refs/heads/js".  In the
original, because ENOTDIR is not ENOENT, we jumped to "out" to
report the error.  The patched code to allow ENOTDIR will instead
happily read the stale version of "js/foo" out of the packed-refs
file.

