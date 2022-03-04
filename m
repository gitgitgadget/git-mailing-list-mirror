Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7BC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiCDXgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDXgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:36:23 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417D1C7EB4
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:35:33 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3F05112EC2;
        Fri,  4 Mar 2022 18:35:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ns0CFZsiWKh4sdGUOD6BmqbH3zWX4gsdRMkT4q
        41fSk=; b=pTtq46JotDV/b4cVsKyJ0v24DjTgk4uatlrnTfogwh949QcSH2X0tg
        5TsqFNruFcigIEjKdEvTk2FDKxHJR3h+1JClVjtS9Q10UQchvfwQw/Tp/Om4FONU
        R3whDulIFLZs0aZUh+uqN2RQhQRfH5FZ9H8yf/oLqPKbWVBAbAOl0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC38E112EC1;
        Fri,  4 Mar 2022 18:35:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60F8F112EC0;
        Fri,  4 Mar 2022 18:35:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 10/11] bundle: create filtered bundles
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:35:31 -0800
In-Reply-To: <5393e74708dfd38e5596d9e877a491e6ed8dda24.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:10 +0000")
Message-ID: <xmqq5yotxpdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8853318-9C13-11EC-8C7F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> A previous change allowed Git to parse bundles with the 'filter'
> capability. Now, teach Git to create bundles with this option.
>
> Some rearranging of code is required to get the option parsing in the
> correct spot. There are now two reasons why we might need capabilities
> (a new hash algorithm or an object filter) so that is pulled out into a
> place where we can check both at the same time.
>
> The --filter option is parsed as part of setup_revisions(), but it
> expected the --objects flag, too. That flag is somewhat implied by 'git
> bundle' because it creates a pack-file walking objects, but there is
> also a walk that walks the revision range expecting only commits. Make
> this parsing work by setting 'revs.tree_objects' and 'revs.blob_objects'
> before the call to setup_revisions().
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

Now, the gem of the series ;-)

> @@ -334,6 +334,9 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
>  		     "--stdout", "--thin", "--delta-base-offset",
>  		     NULL);
>  	strvec_pushv(&pack_objects.args, pack_options->v);
> +	if (revs->filter)
> +		strvec_pushf(&pack_objects.args, "--filter=%s",
> +			     list_objects_filter_spec(revs->filter));
>  	pack_objects.in = -1;
>  	pack_objects.out = bundle_fd;
>  	pack_objects.git_cmd = 1;

Quite expected.

> @@ -507,10 +510,38 @@ int create_bundle(struct repository *r, const char *path,
>  	int bundle_to_stdout;
>  	int ref_count = 0;
>  	struct rev_info revs, revs_copy;
> -	int min_version = the_hash_algo == &hash_algos[GIT_HASH_SHA1] ? 2 : 3;
> +	int min_version = 2;
>  	struct bundle_prerequisites_info bpi;
>  	int i;
>  
> +	/* init revs to list objects for pack-objects later */
> +	save_commit_buffer = 0;
> +	repo_init_revisions(r, &revs, NULL);
> +
> +	/*
> +	 * Pre-initialize the '--objects' flag so we can parse a
> +	 * --filter option successfully.
> +	 */
> +	revs.tree_objects = revs.blob_objects = 1;

Tricky, but true.

> +	argc = setup_revisions(argc, argv, &revs, NULL);
> +
> +	/*
> +	 * Reasons to require version 3:
> +	 *
> +	 * 1. @object-format is required because our hash algorithm is not
> +	 *    SHA1.
> +	 * 2. @filter is required because we parsed an object filter.
> +	 */

OK.

> +	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1] ||
> +	    revs.filter)

Did we need to wrap?  With these on a single line, the line is way
shorter than the line with "because our hash algorithm is not" on
it.

> +		min_version = 3;
> +
> +	if (argc > 1) {
> +		error(_("unrecognized argument: %s"), argv[1]);
> +		goto err;
> +	}
> +

OK.  We are moving original logic around correctly and there is not
much to see here ;-)

> @@ -533,17 +564,14 @@ int create_bundle(struct repository *r, const char *path,
>  		write_or_die(bundle_fd, capability, strlen(capability));
>  		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
>  		write_or_die(bundle_fd, "\n", 1);
> ...
> +		if (revs.filter) {
> +			const char *value = expand_list_objects_filter_spec(revs.filter);
> +			capability = "@filter=";
> +			write_or_die(bundle_fd, capability, strlen(capability));
> +			write_or_die(bundle_fd, value, strlen(value));
> +			write_or_die(bundle_fd, "\n", 1);
> +		}

This block is added at the end of the code to write the v3 preamble
and it adds the @filter= capability.  Looking good.

> @@ -566,6 +594,12 @@ int create_bundle(struct repository *r, const char *path,
>  	bpi.fd = bundle_fd;
>  	bpi.pending = &revs_copy.pending;
>  
> +	/*
> +	 * Nullify the filter here, and any object walking. We only care
> +	 * about commits and tags here. The revs_copy has the right
> +	 * instances of these values.
> +	 */
> +	revs.filter = NULL;
>  	revs.blob_objects = revs.tree_objects = 0;
>  	traverse_commit_list(&revs, write_bundle_prerequisites, ignore_object, &bpi);
>  	object_array_remove_duplicates(&revs_copy.pending);

OK.  We prepare revs, and we save it to revs_copy, because we
perform two traversals, one to determine which bottom commits are
required to unbundle the bundle (which is done with the instance
"revs"), and then later to actually enumerate the objects to place
in the bundle (using "revs_copy").  Is there a reason why we need to
remove .filter in order to perform the first traversal?

This is a tangent, but I wish we could reliably determine when we
can optimize the first traversal away, by inspecting revs.  If there
are any pending objects with UNINTERESTING bit, or members like
max_count, max_age, min_age are set, we'd end up traversing down to
all roots and the prerequisites list would be empty.

> +	test_expect_success 'filtered bundle: $filter' '
> +		test_when_finished rm -rf .git/objects/pack &&
> +		git bundle create partial.bdl \
> +			--all \
> +			--filter=$filter &&
> +
> +		git bundle verify partial.bdl >unfiltered &&
> +		make_user_friendly_and_stable_output <unfiltered >actual &&
> +
> +		cat >expect <<-EOF &&
> +		The bundle contains these 10 refs:
> +		<COMMIT-P> refs/heads/main
> +		<COMMIT-N> refs/heads/release
> +		<COMMIT-D> refs/heads/topic/1
> +		<COMMIT-H> refs/heads/topic/2
> +		<COMMIT-D> refs/pull/1/head
> +		<COMMIT-G> refs/pull/2/head
> +		<TAG-1> refs/tags/v1
> +		<TAG-2> refs/tags/v2
> +		<TAG-3> refs/tags/v3
> +		<COMMIT-P> HEAD
> +		The bundle uses this filter: $filter
> +		The bundle records a complete history.
> +		EOF
> +		test_cmp expect actual
> +	'

OK.

It is somewhat curious why our bundle tests do not unbundle and
check the resulting contents of the repository we unbundle it in.

> +done
> +
>  test_done
