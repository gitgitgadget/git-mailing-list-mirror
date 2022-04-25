Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A35BC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiDYTBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbiDYTBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 15:01:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09200B8239
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:58:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD4811B87E;
        Mon, 25 Apr 2022 14:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mAQZh5Fhwmxud+HWTZ693+gIpIR+q6B4XcX4BC
        jxi7c=; b=vHTU6O1l0mjdDCRQWkLjcr3EImZcCN9Nhf3XG2AJ72Jr0M45kU+oVt
        R2KSvlvnoh/Hobv7wAJwgQSMsPFkSlSZUIYdD/5P/beALsZK4KPRxkND2oUqt5hO
        8hWOAfUvaZ8Sackb9h+EHpNBmqlzqexHHpI6VmWJaIYZGnJXy5UdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81C2411B87C;
        Mon, 25 Apr 2022 14:58:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDCA611B87B;
        Mon, 25 Apr 2022 14:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] multi-pack-index: use --object-dir real path
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
        <pull.1221.v2.git.1650911234.gitgitgadget@gmail.com>
        <fd580e7947743db545a839e81f027984e70b7717.1650911234.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 11:58:38 -0700
In-Reply-To: <fd580e7947743db545a839e81f027984e70b7717.1650911234.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 25 Apr 2022
        18:27:13 +0000")
Message-ID: <xmqqy1ztuh0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B83A5662-C4C9-11EC-81B8-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The --object-dir argument to 'git multi-pack-index' allows a user to
> specify an alternate to use instead of the local $GITDIR. This is used
> by third-party tools like VFS for Git to maintain the pack-files in a
> "shared object cache" used by multiple clones.
>
> On Windows, the user can specify a path using a Windows-style file path
> with backslashes such as "C:\Path\To\ObjectDir". This same path style is
> used in the .git/objects/info/alternates file, so it already matches the
> path of that alternate. However, find_odb() converts these paths to
> real-paths for the comparison, which use forward slashes. As of the
> previous change, lookup_multi_pack_index() uses real-paths, so it
> correctly finds the target multi-pack-index when given these paths.
>
> Some commands such as 'git multi-pack-index repack' call child processes
> using the object_dir value, so it can be helpful to convert the path to
> the real-path before sending it to those locations.
>
> Add a callback to convert the real path immediately upon parsing the
> argument. We need to be careful that we don't store the exact value out
> of get_object_directory() and free it, or we could corrupt a later use
> of the_repository->objects->odb->path.
>
> We don't use get_object_directory() for the initial instantiation in
> cmd_multi_pack_index() because we need 'git multi-pack-index -h' to work
> without a Git repository.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/multi-pack-index.c | 45 ++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)

Much nicer compared to the previous round, by doing the
normalization early.

Will queue.  thanks.
