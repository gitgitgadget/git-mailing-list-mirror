Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D39C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AED920725
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vSgUfa23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392039AbgDPBDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:03:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64742 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgDPBDd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 21:03:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 665514D962;
        Wed, 15 Apr 2020 21:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aNBeazWc10vGBwLknPoRwD46mwo=; b=vSgUfa
        23lRtke0zBIjJmtsFs9LTOXjgihjUGXxyWDu6qfcJyp3rhqMhf6atOigy5ym6eIO
        G2vAOMwlUMJWBIBunroaNi1GeLUQazQHNxFNBoJcH8H0Qy1qGtjHVawcQXEqpxsh
        E/HMP2hNUcSwCAF80Ru6HIB7XjpRgB1kvNVxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLi+UcWKXheeQfWayCJdglFe+VVCrIer
        FedFTExS8g2HYQTUIlql2QpBULeerioubwVonvJyr4NmcE8oDVxaUD0r7b7DVRtl
        J8P57q743m3o6IcRAmvkmpt0nfb7VAYTBlZbmJVibDrAcSgwtRrc34+cJpKc5MmG
        SB+3Bcd/Po4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E3944D961;
        Wed, 15 Apr 2020 21:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D884D960;
        Wed, 15 Apr 2020 21:03:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, vd@FreeBSD.org
Subject: Re: [PATCH] diff-tree.c: load notes machinery when required
References: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
Date:   Wed, 15 Apr 2020 18:03:23 -0700
In-Reply-To: <ce1ba0641e37ac84a104cd44af63e759324feb14.1586997354.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 15 Apr 2020 18:37:38 -0600")
Message-ID: <xmqq5ze044ys.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 125EA442-7F7E-11EA-99A3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Since its introduction in 7249e91 (revision.c: support --notes
> command-line option, 2011-03-29), combining '--notes' with any option
> that causes us to format notes (e.g., '--pretty', '--format="%N"', etc)
> results in a failed assertion at runtime.
>
>   $ git rev-list HEAD | git diff-tree --stdin --pretty=medium --notes
>   commit 8f3d9f354286745c751374f5f1fcafee6b3f3136
>   git: notes.c:1308: format_display_notes: Assertion `display_notes_trees' failed.
>   Aborted
>
> This failure is due to diff-tree not calling 'load_display_notes' to
> initialize the notes machinery.
>
> Ordinarily, this failure isn't triggered, because it requires passing
> both '--notes' and another of the above mentioned options. In the case
> of '--pretty', for example, we set 'opt->verbose_header', causing
> 'show_log()' to eventually call 'format_display_notes()', which expects
> a non-NULL 'display_note_trees'.
>
> Without initializing the notes machinery, 'display_note_trees' remains
> NULL, and thus triggers an assertion failure.
>
> Fix this by initializing the notes machinery after parsing our options,
> and harden this behavior against regression with a test in t4013. (Note
> that the added ref in this test requires updating two unrelated tests
> which use 'log --all', and thus need to learn about the new refs).
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> This is the remainder of the fix that I started earlier today, with some
> additional suggestions from Peff incorporated.

Yeah, with the auto-detection of userformat requirement, the fix
looks good to me, too.

Will queue.  Thanks.

>
>  builtin/diff-tree.c                          |  9 +++++++++
>  t/t4013-diff-various.sh                      | 11 +++++++++++
>  t/t4013/diff.diff-tree_--format=%N_note      |  6 ++++++
>  t/t4013/diff.diff-tree_--pretty_--notes_note | 12 ++++++++++++
>  t/t4013/diff.log_--decorate=full_--all       | 15 +++++++++++++++
>  t/t4013/diff.log_--decorate_--all            | 15 +++++++++++++++
>  6 files changed, 68 insertions(+)
>  create mode 100644 t/t4013/diff.diff-tree_--format=%N_note
>  create mode 100644 t/t4013/diff.diff-tree_--pretty_--notes_note
>
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index cb9ea79367..11551a20cc 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -109,6 +109,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	struct object *tree1, *tree2;
>  	static struct rev_info *opt = &log_tree_opt;
>  	struct setup_revision_opt s_r_opt;
> +	struct userformat_want w;
>  	int read_stdin = 0;
>
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
> @@ -127,6 +128,14 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
>  	precompose_argv(argc, argv);
>  	argc = setup_revisions(argc, argv, opt, &s_r_opt);
>
> +	memset(&w, 0, sizeof(w));
> +	userformat_find_requirements(NULL, &w);
> +
> +	if (!opt->show_notes_given && (!opt->pretty_given || w.notes))
> +		opt->show_notes = 1;
> +	if (opt->show_notes)
> +		load_display_notes(&opt->notes_opt);
> +
>  	while (--argc > 0) {
>  		const char *arg = *++argv;
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index dde3f11fec..4263b95ca6 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -95,6 +95,15 @@ test_expect_success setup '
>  	git commit -m "update mode" &&
>  	git checkout -f master &&
>
> +	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
> +	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
> +	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
> +	git checkout -b note initial &&
> +	git update-index --chmod=+x file2 &&
> +	git commit -m "update mode (file2)" &&
> +	git notes add -m "note" &&
> +	git checkout -f master &&
> +
>  	# Same merge as master, but with parents reversed. Hide it in a
>  	# pseudo-ref to avoid impacting tests with --all.
>  	commit=$(echo reverse |
> @@ -398,6 +407,8 @@ diff --no-index --raw --no-abbrev dir2 dir
>
>  diff-tree --pretty --root --stat --compact-summary initial
>  diff-tree --pretty -R --root --stat --compact-summary initial
> +diff-tree --pretty --notes note
> +diff-tree --format=%N note
>  diff-tree --stat --compact-summary initial mode
>  diff-tree -R --stat --compact-summary initial mode
>  EOF
> diff --git a/t/t4013/diff.diff-tree_--format=%N_note b/t/t4013/diff.diff-tree_--format=%N_note
> new file mode 100644
> index 0000000000..93042ed539
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--format=%N_note
> @@ -0,0 +1,6 @@
> +$ git diff-tree --format=%N note
> +note
> +
> +
> +:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file2
> +$
> diff --git a/t/t4013/diff.diff-tree_--pretty_--notes_note b/t/t4013/diff.diff-tree_--pretty_--notes_note
> new file mode 100644
> index 0000000000..4d0bde601c
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--pretty_--notes_note
> @@ -0,0 +1,12 @@
> +$ git diff-tree --pretty --notes note
> +commit a6f364368ca320bc5a92e18912e16fa6b3dff598
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:06:00 2006 +0000
> +
> +    update mode (file2)
> +
> +Notes:
> +    note
> +
> +:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file2
> +$
> diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
> index 2afe91f116..3f9b872ece 100644
> --- a/t/t4013/diff.log_--decorate=full_--all
> +++ b/t/t4013/diff.log_--decorate=full_--all
> @@ -5,12 +5,27 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      update mode
>
> +commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:06:00 2006 +0000
> +
> +    update mode (file2)
> +
> +Notes:
> +    note
> +
>  commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      Rearranged lines in dir/sub
>
> +commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:06:00 2006 +0000
> +
> +    Notes added by 'git notes add'
> +
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
> index d0f308ab2b..f5e20e1e14 100644
> --- a/t/t4013/diff.log_--decorate_--all
> +++ b/t/t4013/diff.log_--decorate_--all
> @@ -5,12 +5,27 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      update mode
>
> +commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:06:00 2006 +0000
> +
> +    update mode (file2)
> +
> +Notes:
> +    note
> +
>  commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
>  Author: A U Thor <author@example.com>
>  Date:   Mon Jun 26 00:06:00 2006 +0000
>
>      Rearranged lines in dir/sub
>
> +commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:06:00 2006 +0000
> +
> +    Notes added by 'git notes add'
> +
>  commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
>  Merge: 9a6d494 c7a2ab9
>  Author: A U Thor <author@example.com>
> --
> 2.26.0.121.gefe3874640.dirty
