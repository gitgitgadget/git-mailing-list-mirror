Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F494C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiBFKhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 05:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 05:36:59 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF011C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 02:36:58 -0800 (PST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8BF0019F5AD;
        Sun,  6 Feb 2022 11:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1644143817;
        bh=nAEX6sDSB2FxGmwct4o07bg93dGXQu+YZ6UjqrPrNqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJC7o40+Q9BCl3x8MyZClttprh4oIOn6kdhIjKkT5nCUsVZwnX3pI/Us+nilYGyrw
         MrSYHUbb9hCTGwIbWrRgrMyTxu5vpJ/GBPz/kwz5zPAqBt6fXTmGFXudVZ1SOEcEkQ
         FnDF8ncRMjgfQR9KLaFJjbawneKPvtIy2NChkWTLQmtvCCHA+g7DzByscOt4CtvNXD
         vF6dHN/kaUi/viTbnB8R+fkDk/pxKwlE1uV9lRkhiQ4em3EWFTAdMf6hDr6Jz3DqvH
         oGQnkrbBdYru/FEBkANslk+rXpZ23EXRn/BFBJvyBZ/O9FBs/+p3HrowVRAYvjPT9B
         OW2C1CxmkzZdg==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config on add
Date:   Sun, 06 Feb 2022 11:36:47 +0100
Message-ID: <2328375.k9UJiU4Qo1@cayenne>
In-Reply-To: <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com> <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, 31 January 2022 16:00:59 CET Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When adding a new worktree, it is reasonable to expect that we want to
> use the current set of sparse-checkout settings for that new worktree.
> This is particularly important for repositories where the worktree would
> become too large to be useful. This is even more important when using
> partial clone as well, since we want to avoid downloading the missing
> blobs for files that should not be written to the new worktree.
> 
> The only way to create such a worktree without this intermediate step of
> expanding the full worktree is to copy the sparse-checkout patterns and
> config settings during 'git worktree add'. Each worktree has its own
> sparse-checkout patterns, and the default behavior when the
> sparse-checkout file is missing is to include all paths at HEAD. Thus,
> we need to have patterns from somewhere, they might as well be the
> current worktree's patterns. These are then modified independently in
> the future.
> 
> In addition to the sparse-checkout file, copy the worktree config file
> if worktree config is enabled and the file exists. This will copy over
> any important settings to ensure the new worktree behaves the same as
> the current one. The only exception we must continue to make is that
> core.bare and core.worktree should become unset in the worktree's config
> file.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/worktree.c                 | 60 ++++++++++++++++++++++++++++++
>  t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++----
>  t/t2400-worktree-add.sh            | 46 ++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 2838254f7f2..dc9cd6decc8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -335,6 +335,66 @@ static int add_worktree(const char *path, const char *refname,
>  	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>  	write_file(sb.buf, "../..");
>  
> +	/*
> +	 * If the current worktree has sparse-checkout enabled, then copy
> +	 * the sparse-checkout patterns from the current worktree.
> +	 */
> +	if (core_apply_sparse_checkout) {
> +		char *from_file = git_pathdup("info/sparse-checkout");
> +		char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
> +					realpath.buf, name);
> +
> +		if (file_exists(from_file)) {
> +			if (safe_create_leading_directories(to_file) ||
> +			    copy_file(to_file, from_file, 0666))
> +				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
> +				      from_file, to_file);
> +		}
> +
> +		free(from_file);
> +		free(to_file);
> +	}
> +
> +	/*
> +	 * If we are using worktree config, then copy all current config
> +	 * values from the current worktree into the new one, that way the
> +	 * new worktree behaves the same as this one.
> +	 */
> +	if (repository_format_worktree_config) {
> +		char *from_file = git_pathdup("config.worktree");
> +		char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
> +					realpath.buf, name);
> +
> +		if (file_exists(from_file)) {
> +			struct config_set cs = { { 0 }};
> +			const char *str_value;
> +			int bool_value;
> +
> +			if (safe_create_leading_directories(to_file) ||
> +			    copy_file(to_file, from_file, 0666))
> +				die(_("failed to copy worktree config from '%s' to '%s'"),
> +				    from_file, to_file);
> +
> +			git_configset_init(&cs);
> +			git_configset_add_file(&cs, from_file);
> +
> +			if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
> +			    bool_value &&
> +			    git_config_set_multivar_in_file_gently(
> +					to_file, "core.bare", NULL, "true", 0))
> +				error(_("failed to unset 'core.bare' in '%s'"), to_file);
> +			if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
> +			    git_config_set_in_file_gently(to_file,
> +							  "core.worktree", NULL))
> +				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> +

In the first patch of this series, you use _("unable to set '%s' in'%s'). Does it make sense to reuse this string here?




