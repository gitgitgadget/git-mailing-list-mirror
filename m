Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFCC43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 23:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiFLXaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 19:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiFLXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 19:30:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FD3532E4
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 16:30:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3017F12D2EC;
        Sun, 12 Jun 2022 19:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y1WL6DdPnEHCx7MSG6UUiu7aic2IvKvvrJAcuW
        xK+Io=; b=C0x5WsqR19jR60bl6XJqdkO/ifJECwreAqZg7xlM8c1WNz9WyXyuAQ
        ETXSynjvgBaStgCMwMJPJFU9XzC2pC+C2mLu5TdpkiOaL8dNYPfsxZQJRbU93qSC
        haIC3gCmGIhX9UTwDsHkIMOf6HYPMl6JADQusgAEkCI0xwoodt2RY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26CB712D2EB;
        Sun, 12 Jun 2022 19:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D33312D2EA;
        Sun, 12 Jun 2022 19:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] apply: support case-only renames in case-insensitive
 filesystems
References: <pull.1257.git.1654967038802.gitgitgadget@gmail.com>
Date:   Sun, 12 Jun 2022 16:30:12 -0700
In-Reply-To: <pull.1257.git.1654967038802.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Sat, 11 Jun 2022 17:03:58 +0000")
Message-ID: <xmqqr13t8np7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BC26D68-EAA7-11EC-B53A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +if ! test_have_prereq CASE_INSENSITIVE_FS
> +then
> +	test_set_prereq CASE_SENSITIVE_FS
> +	echo nuts
> +fi

You can easily say !CASE_INSENSITIVE_FS as the prerequiste, so I do
not see the point of this.  I do not see the point of "nuts", either.

But it probably is a moot point as I do not think you should do the
prerequisite at all.

Instead, you can explicitly set the core.ignorecase configuration,
i.e. "git -c core.ignorecase=yes/no", and possibly "apply --cached"
so that you do not have to worry about the case sensitivity of the
filesystem at all.

> +test_expect_success setup '
> +	echo "This is some content in the file." > file1 &&

Style.  Redirection operator ">" sticks to its operand, i.e.

	echo "This is some content in the file." >file1 &&

> +	echo "A completely different file." > file2 &&
> +	git update-index --add file1 &&
> +	git update-index --add file2 &&
> +	cat >case_only_rename_patch <<-\EOF
> +	diff --git a/file1 b/File1
> +	similarity index 100%
> +	rename from file1
> +	rename to File1
> +	EOF

You are better off not writing the diff output manually.  Instead,
you can let the test write it for you, e.g.

	echo "This is some content in the file." >file1 &&
	git update-index --add file1 &&
        file1blob=$(git rev-parse :file1) &&
	git commit -m "Initial - file1" &&
	git update-index --add --cacheinfo 100644,$file1blob,File1 &&
	git rm --cached file1 &&
	git diff --cached -M HEAD >case-only-rename-patch

If you want to be extra careful not to rely on your filesystem
corrupting the pathnames you feed (e.g. the redireciton to "file1"
might create file FILE1 on MS-DOS ;-), you could even do:

	file1blob=$(echo "This is some content in the file." |
		    git hash-object -w --stdin) &&
	file2blob=$(echo "A completeloy different contents." |
		    git hash-object -w --stdin) &&
	git update-index --add --cacheinfo 100644,$file1blob,file1 &&

	git commit -m "Initial - file1" &&
	git update-index --add --cacheinfo 100644,$file1blob,File1 &&
	git rm --cached file1 &&
	git diff --cached -M HEAD >rename-file1-to-File2 &&

	git reset --hard HEAD &&
        git update-index --add --cacheinfo 100644,$file1blob,file2 &&
	git rm --cached file1 &&
	git diff --cached -M HEAD >rename-file1-to-file2 &&

	# from here on, HEAD has file1 and file2
	git reset --hard HEAD &&
	git update-index --add --cacheinfo 100644,$file2blob,file2 &&
	git commit -m 'file1 and file2'

> +'
> +
> +test_expect_success 'refuse to apply rename patch with conflict' '
> +	cat >conflict_patch <<-\EOF &&
> +	diff --git a/file1 b/file2
> +	similarity index 100%
> +	rename from file1
> +	rename to file2
> +	EOF
> +	test_must_fail git apply --index conflict_patch

And then, you could use --cached (not --index) to bypass the working
tree altogether, which is a good way to test the feature without
getting affected by the underlying filesystem.  Check both case
sensitive and case insensitive cases:

	# Start from a known state
	git reset --hard HEAD &&
	test_must_fail git -c core.ignorecase=no apply --cached rename-file1-to-file2 &&

	# Start from a known state
	git reset --hard HEAD &&
	test_must_fail git -c core.ignorecase=yes apply --cached rename-file1-to-file2 &&

> +'
> +
> +test_expect_success CASE_SENSITIVE_FS 'refuse to apply case-only rename patch with conflict, in case-sensitive FS' '

Lose the prerequisite, replace --index with --cached, and force core.ignorecase
to both case insensitive and sensitive to check the behaviour.

> +	test_when_finished "git mv File1 file2" &&
> +	git mv file2 File1 &&
> +	test_must_fail git apply --index case_only_rename_patch
> +'
> +
> +test_expect_success 'apply case-only rename patch without conflict' '

Likewise, try both sensitive and insensitive one.

> +	git apply --index case_only_rename_patch
> +'
> +
> +test_done
>
> base-commit: 1e59178e3f65880188caedb965e70db5ceeb2d64

Thanks.

