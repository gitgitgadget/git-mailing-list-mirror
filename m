Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2969C433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 00:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiBSAd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 19:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 19:33:25 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116F7177E76
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 16:33:06 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 880A818FBE1;
        Fri, 18 Feb 2022 19:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dRCloNlBpRBZOWo4sHhWo5LpS979Lf2mtXVLOt
        3f6CQ=; b=TCmETxFI6e4OPUcx231Nl9muov5JcXDEBiQz9I09z9v38SRu2YCDhW
        caQ8sQWIUicuSp93COq5+azQn8Ka99ztTsD2wQsHia+TYQj/uCIDCbyvLRjXylQM
        g1a51YJMf1N7vnVP0b6zeHPYWcWwunURg1kW43oWz6UOMIFk4nMT8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 814CE18FBE0;
        Fri, 18 Feb 2022 19:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A69B218FBDE;
        Fri, 18 Feb 2022 19:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] ls-files: support --recurse-submodules --stage
References: <20220218223212.1139366-1-jonathantanmy@google.com>
Date:   Fri, 18 Feb 2022 16:33:01 -0800
In-Reply-To: <20220218223212.1139366-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 18 Feb 2022 14:32:11 -0800")
Message-ID: <xmqqzgmnwv9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F440A88-911B-11EC-9277-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index f7ea56cc63..e791b65e7e 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -244,7 +244,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
>  			printf("%s%06o %s %d\t",
>  			       tag,
>  			       ce->ce_mode,
> -			       find_unique_abbrev(&ce->oid, abbrev),
> +			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
>  			       ce_stage(ce));
>  		}

Quite straight-forward.  At this point, repo is the repository we
are currently working in (which will be updated to the submodule
repository by show_submodule() and passed down to show_files()), so
the only thing we need to do is to make sure we use that repo
consistently.  Makes sense.

>  		write_eolinfo(repo->index, ce, fullname);
> @@ -726,7 +726,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		setup_work_tree();
>  
>  	if (recurse_submodules &&
> -	    (show_stage || show_deleted || show_others || show_unmerged ||
> +	    (show_deleted || show_others || show_unmerged ||
>  	     show_killed || show_modified || show_resolve_undo || with_tree))
>  		die("ls-files --recurse-submodules unsupported mode");
>  
> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> index 4a08000713..3d2da360d1 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -34,6 +34,25 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '--stage' '
> +	# In order to test hash abbreviation, write two objects that have the
> +	# same first 4 hexadecimal characters in their (SHA-1) hashes.
> +	echo brocdnra >submodule/c &&
> +	git -C submodule commit -am "update c" &&
> +	echo brigddsv >submodule/c &&
> +	git -C submodule commit -am "update c again" &&
> +
> +	cat >expect <<-\EOF &&
> +	100644 6da7 0	.gitmodules
> +	100644 7898 0	a
> +	100644 6178 0	b/b
> +	100644 dead9 0	submodule/c
> +	EOF
> +
> +	git ls-files --stage --recurse-submodules --abbrev=4 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'ls-files correctly outputs files in submodule with -z' '
>  	lf_to_nul >expect <<-\EOF &&
>  	.gitmodules
> @@ -292,7 +311,6 @@ test_incompatible_with_recurse_submodules () {
>  test_incompatible_with_recurse_submodules --deleted
>  test_incompatible_with_recurse_submodules --modified
>  test_incompatible_with_recurse_submodules --others
> -test_incompatible_with_recurse_submodules --stage
>  test_incompatible_with_recurse_submodules --killed
>  test_incompatible_with_recurse_submodules --unmerged
