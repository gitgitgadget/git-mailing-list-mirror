Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886BCC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFAF206D7
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eaUH75oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFVyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:54:31 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63731 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFVyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 16:54:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F302B33D4;
        Fri,  6 Mar 2020 16:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bEMGrUIyypRJ7d1M3fBPQ84i8ZU=; b=eaUH75
        ooZGfoh2QG964UQQffDnyT1HSkoZFZHqGQPF2QJoZwV+fHaEGGsFvVGHslWp6piG
        V6/wnWYszV2pihikx8HylsngHonVosDpajO5CEs+MlWrZ3WhcETpb1dseez4/4yo
        3vywhtwYC60h5jafG9kEeCN3U+9ZE4gEspB8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KIkHntEijhmZsV4us6yYCT2HqDS+I45W
        p3ZDqs18GDRDEWPziZ9EvlxTg7H9M112+ijefggaCADn1VNO3yYn3dXITN/oM//N
        Mz1ng6eiXiGzADIpnnvGhd8A/zFh2Ci4HT607LAdZ5Sp9rJtE1Ow8q8vcj6PVUUJ
        5NsmhRLz0mE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06DD2B33D3;
        Fri,  6 Mar 2020 16:54:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 32B2BB33D2;
        Fri,  6 Mar 2020 16:54:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 1/4] set_git_dir: fix crash when used with real_path()
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <f7afcb4cc83a955b04283475facc02349207557c.1583521396.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 13:54:24 -0800
In-Reply-To: <f7afcb4cc83a955b04283475facc02349207557c.1583521396.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Fri, 06 Mar 2020
        19:03:13 +0000")
Message-ID: <xmqqa74t2lpr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C103018-5FF5-11EA-AD32-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>
> `real_path()` returns result from a shared buffer, inviting subtle
> reentrance bugs. One of these bugs occur when invoked this way:
>     set_git_dir(real_path(git_dir))
>
> In this case, `real_path()` has reentrance:
>     real_path
>     read_gitfile_gently
>     repo_set_gitdir
>     setup_git_env
>     set_git_dir_1
>     set_git_dir
>
> Later, `set_git_dir()` uses its now-dead parameter:
>     !is_absolute_path(path)
>
> Fix this by using a dedicated `strbuf` to hold `strbuf_realpath()`.

With this detailed explanation, I expected to see a test or two that
demonstrates a breakage, but reading a stale value may not
reproducibly give the same wrong result or crash the program,
perhaps?

> -void set_git_dir(const char *path)
> +void set_git_dir(const char *path, int make_realpath)
>  {
> +	struct strbuf realpath = STRBUF_INIT;
> +
> +	if (make_realpath) {
> +		strbuf_realpath(&realpath, path, 1);
> +		path = realpath.buf;
> +	}
> +
>  	set_git_dir_1(path);
>  	if (!is_absolute_path(path))
>  		chdir_notify_register(NULL, update_relative_gitdir, NULL);
> +
> +	strbuf_release(&realpath);
>  }

Makes sense.  I looked at changes to the callers in this patch and
it all made sense.
