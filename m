Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A284C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 05:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA1A2184D
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 05:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r/0gqHc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgJIFKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 01:10:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60179 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIFKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 01:10:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53BD8FE90D;
        Fri,  9 Oct 2020 01:10:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UGjLZAXb8ugKtgwOz1+o8J5ohhE=; b=r/0gqH
        c0QyLoCnSJaKIaR+qyAGaepmR2FgVH1fTT1kw2EQnhEa9KReU7xjaIDCUcWP65xl
        /kmHNV7CjhcGb7OmVMBKDfkr4kJcCyc1rCacJ7uhDFjpqwMeqBJqgneRoI9ldFg2
        HkdLIaltykBukTetkzoIziAybmJBoA1QBdy2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BIzELWYdip86T18kxsujTWWHhpleqbCW
        QWWdZRxUScBdssgiAnSfBd9Qk1PDTzEdJx6n0ylYUKtHVhTIAhvxb5MRCqaHAgXL
        QK1Pp1HzCvIffLQsYXi95HLzeYvJRGTUnddvGOy+/wUPpp2IzcgjakEzTFG8ign/
        sQkFonNr+js=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48862FE90C;
        Fri,  9 Oct 2020 01:10:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90508FE90B;
        Fri,  9 Oct 2020 01:09:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
References: <20201007074538.25891-1-shouryashukla.oo@gmail.com>
        <20201007074538.25891-3-shouryashukla.oo@gmail.com>
Date:   Thu, 08 Oct 2020 22:09:55 -0700
In-Reply-To: <20201007074538.25891-3-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Wed, 7 Oct 2020 13:15:37 +0530")
Message-ID: <xmqqd01sugrg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACCF02DE-09ED-11EB-B678-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> +static void config_added_submodule(struct add_data *info)
> +{
> +	char *key, *var = NULL;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	key = xstrfmt("submodule.%s.url", info->sm_name);
> +	git_config_set_gently(key, info->realrepo);
> +	free(key);
> +
> +	cp.git_cmd = 1;
> +	strvec_pushl(&cp.args, "add", "--no-warn-embedded-repo", NULL);
> +	if (info->force)
> +		strvec_push(&cp.args, "--force");
> +	strvec_pushl(&cp.args, "--", info->sm_path, ".gitmodules", NULL);

Hmph, you lost me.  I think this ought to correspond to this part of
the original:

	git add --no-warn-embedded-repo $force "$sm_path" ||
	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"

I can see that adding "--" before $sm_path may be an improvement,
but why do we also add .gitmodules here, and ...

> +	key = xstrfmt("submodule.%s.path", info->sm_name);
> +	git_config_set_in_file_gently(".gitmodules", key, info->sm_path);
> +	free(key);
> +	key = xstrfmt("submodule.%s.url", info->sm_name);
> +	git_config_set_in_file_gently(".gitmodules", key, info->repo);
> +	free(key);
> +	key = xstrfmt("submodule.%s.branch", info->sm_name);
> +	if (info->branch)
> +		git_config_set_in_file_gently(".gitmodules", key, info->branch);
> +	free(key);

... perform quite a lot of configuration writing, before actually
spawning the "git add" and make sure it succeeds?  The original
won't futz with any of these .gitmodules entries if "git add" of the
$sm_path fails and that is a good discipline to follow.

> +	if (run_command(&cp))
> +		die(_("failed to add submodule '%s'"), info->sm_path);
> +
> +	/*
> +	 * NEEDSWORK: In a multi-working-tree world, this needs to be
> +	 * set in the per-worktree config.
> +	 */
> +	if (!git_config_get_string("submodule.active", &var) && var) {

What if this were a valueless true ("[submodule] active\n" without
"= true")?  Wouldn't get_string() fail?

> +		/*
> +		 * If the submodule being adding isn't already covered by the
> +		 * current configured pathspec, set the submodule's active flag
> +		 */
> +		if (!is_submodule_active(the_repository, info->sm_path)) {
> +			key = xstrfmt("submodule.%s.active", info->sm_name);
> +			git_config_set_gently(key, "true");
> +			free(key);
> +		}
> +	} else {
> +		key = xstrfmt("submodule.%s.active", info->sm_name);
> +		git_config_set_gently(key, "true");
> +		free(key);
> +	}
> +}
> +
> + ...
> +	info.prefix = prefix;
> +	info.sm_name = name;
> +	info.sm_path = path;
> +	info.repo = repo;
> +	info.realrepo = realrepo;
> +	info.reference_path = reference_path;
> +	info.branch = branch;
> +	info.depth = depth;
> +	info.progress = !!progress;
> +	info.dissociate = !!dissociate;
> +	info.force = !!force;
> +	info.quiet = !!quiet;
> +
> +	if (add_submodule(&info))
> +		return 1;
> +	config_added_submodule(&info);

Whew.

This was way too big to be reviewed in a single sitting.  I do not
know offhand if there is a better way to structure the changes into
a more digestible pieces to help prevent reviewers from overlooking
potential mistakes, though.

Thanks.

