Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C9C54EE9
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 00:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiINAsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiINAsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 20:48:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3452564D3
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 17:48:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB30E1A9FDF;
        Tue, 13 Sep 2022 20:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=tnnWg+02FnbwrMrDbjxCkns50sS0z1UFn4OHxVlWKAo=; b=P6pa
        NyEl+Xna2wlO3ExqT1I3JNSTfLkJwCgwZ9ACw1NGTf6Ckbrn9FHREXwfFuN1rfJx
        f4Fu7aQp1mCQgUcLnktCUjgEN3cFcVpmH8XNU/1PL1mXrybynPgr9rO/esaxIuRh
        uM6TzO652caEGGrlaIk0IBjj/4NmBoN8fx/Lzmo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D36011A9FDE;
        Tue, 13 Sep 2022 20:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 855FE1A9FDD;
        Tue, 13 Sep 2022 20:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v6 3/6] fsmonitor: relocate socket file if .git
 directory is remote
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <edef029a298a44ba59d19db53c2f7ba07e93aec6.1663100859.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 17:48:09 -0700
Message-ID: <xmqqillq7pdi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7E809F6-33C6-11ED-81B6-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +const char *fsmonitor_ipc__get_path(void)
> +{

Looks like a bit klunky API.  I would have expected it to take at
least the path to the worktree or a pointer to struct repository.

> +	static const char *ipc_path;
> +	SHA_CTX sha1ctx;
> +	char *sock_dir;
> +	struct strbuf ipc_file = STRBUF_INIT;
> +	unsigned char hash[SHA_DIGEST_LENGTH];
> +
> +	if (ipc_path)
> +		return ipc_path;
> +
> +	ipc_path = fsmonitor_ipc__get_default_path();
> +
> +	/* By default the socket file is created in the .git directory */
> +	if (fsmonitor__is_fs_remote(ipc_path) < 1)
> +		return ipc_path;
> +
> +	SHA1_Init(&sha1ctx);
> +	SHA1_Update(&sha1ctx, the_repository->worktree, strlen(the_repository->worktree));
> +	SHA1_Final(hash, &sha1ctx);

I would not worry about SHA-1 hash collision for this use case, but
would worry more about .worktree possible being unique.

Can the .worktree string be aliased for the same directory in some
way (e.g. depending on the initialization sequence, can it be a full
pathname, a relative pathname, or can a pathname that looks like a
full-pathname have symbolic link component in it?) that ends up
creating two or more socket for the same worktree?

> +	repo_config_get_string(the_repository, "fsmonitor.socketdir", &sock_dir);
> +
> +	/* Create the socket file in either socketDir or $HOME */
> +	if (sock_dir && *sock_dir)
> +		strbuf_addf(&ipc_file, "%s/.git-fsmonitor-%s",
> +					sock_dir, hash_to_hex(hash));
> +	else
> +		strbuf_addf(&ipc_file, "~/.git-fsmonitor-%s", hash_to_hex(hash));
> +
> +	ipc_path = interpolate_path(ipc_file.buf, 1);
> +	if (!ipc_path)
> +		die(_("Invalid path: %s"), ipc_file.buf);
> +
> +	strbuf_release(&ipc_file);
> +	return ipc_path;
> +}
