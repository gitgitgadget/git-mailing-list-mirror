Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47C320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 23:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752954AbdLEXNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 18:13:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752844AbdLEXNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 18:13:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C104C3D02;
        Tue,  5 Dec 2017 18:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8vXKrtz5aHUTWLgaNii01ph1tik=; b=eTg+gb
        5njIo5Cxg67Ob71amB11soETHSVnAjBXVRBRZAYSwNo/gX6H2851QJmmwSCNzHtX
        BQEYWHc9jfuT7eUNKwlUZlb1vCg7qbo1uuAZJmNFEJXrxa4iCzZ+Aw1ngNWsWWAi
        KLHUh6Ji0yVm4uUvriz3qpIbFkT44O9RrQy6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fZMHjOQ6KMaDH7oPhetc9cOFVGBRmftZ
        NdZUKDY1Is32YzYAHCTU1Xiey92OsnGEmbO9jR6HgEeZ2j3kgzWrm/ymMpN+zqcm
        2SMmy/UlaZaQjHu4NFxBa3985Wgi8lI8x4VZ4AUHA96iKtgx3M54M+j9v4rDSVaV
        mbBZNw826Mw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20FA5C3D01;
        Tue,  5 Dec 2017 18:13:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D1F0C3CFF;
        Tue,  5 Dec 2017 18:13:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, ben.boeckel@kitware.com
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in bare repositories
References: <20171205194801.GA31721@megas.kitware.com>
        <20171205221337.140548-1-bmwill@google.com>
Date:   Tue, 05 Dec 2017 15:13:38 -0800
In-Reply-To: <20171205221337.140548-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 5 Dec 2017 14:13:37 -0800")
Message-ID: <xmqqy3mghiot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDB2C65A-DA11-11E7-A4CD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> A regression was introduced in 557a5998d (submodule: remove
> gitmodules_config, 2017-08-03) to how attribute processing was handled
> in bare repositories when running the diff-tree command.
>
> By default the attribute system will first try to read ".gitattribute"
> files from the working tree and then falls back to reading them from the
> index if there isn't a copy checked out in the worktree.  Prior to
> 557a5998d the index was read as a side effect of the call to
> 'gitmodules_config()' which ensured that the index was already populated
> before entering the attribute subsystem.
>
> Since the call to 'gitmodules_config()' was removed the index is no
> longer being read so when the attribute system tries to read from the
> in-memory index it doesn't find any ".gitattribute" entries effectively
> ignoring any configured attributes.
>
> Fix this by explicitly reading the index during the setup of diff-tree.

Thanks, both.  Will queue.




> Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> This patch should fix the regression.  Let me know if it doesn't solve the
> issue and I'll investigate some more.
>
>  builtin/diff-tree.c        |  1 +
>  t/t4015-diff-whitespace.sh | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index d66499909..cfe7d0281 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>  	init_revisions(opt, prefix);
> +	read_cache();
>  	opt->abbrev = 0;
>  	opt->diff = 1;
>  	opt->disable_stdin = 1;
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 559a7541a..6e061a002 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -636,6 +636,23 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
>  	test_must_fail git diff-tree --check HEAD^ HEAD
>  '
>  
> +test_expect_success 'check with ignored trailing whitespace attr (diff-tree)' '
> +	test_when_finished "git reset --hard HEAD^" &&
> +
> +	# Create a whitespace error that should be ignored.
> +	echo "* -whitespace" > ".gitattributes" &&
> +	git add ".gitattributes" &&
> +	echo "trailing space -> " > "trailing-space" &&
> +	git add "trailing-space" &&
> +	git commit -m "trailing space" &&
> +
> +	# With a worktree diff-tree ignores the whitespace error
> +	git diff-tree --root --check HEAD &&
> +
> +	# Without a worktree diff-tree still ignores the whitespace error
> +	git -C .git diff-tree --root --check HEAD
> +'
> +
>  test_expect_success 'check trailing whitespace (trailing-space: off)' '
>  	git config core.whitespace "-trailing-space" &&
>  	echo "foo ();   " >x &&
