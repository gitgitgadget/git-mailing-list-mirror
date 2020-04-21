Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F841C54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3F920724
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IywTVpYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDUUmE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:42:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62521 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUUmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:42:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2763622DB;
        Tue, 21 Apr 2020 16:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gRA3xP8RgdtGDBawqB0XL6mwRdg=; b=IywTVp
        Yv+OUZek9z65FMH4b0nA8G9ZGJX8ld9TnZKuP1BxuzxMAHTAJSBiYvt9YdAkyvxC
        yhgng2UELqvDWAe+qCRYuLWxwyKUjLixhYeQbxX973BQF7foxyI+gYVwzYGf4L4G
        TzE1GXjM+oa35kZfv3FBXWFs5y1FHnflyVqIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WNfMbJ2Ye4iNAtSE/8Pv1a3n1Tu2iVGt
        HtOTZL8Q77Duo56DN629AOwdwPVVDCF5dCuKJGhxAfWDbz13muXfIebFaWOHeOf3
        8DCP5pRtShM8e06S+uOSwYKyMCQwLugDwyOFV04n8WM45r5qShP5pv6qtT8wzqbE
        Othfk/hjcAg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA33E622DA;
        Tue, 21 Apr 2020 16:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44584622D9;
        Tue, 21 Apr 2020 16:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when appropriate
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
Date:   Tue, 21 Apr 2020 13:41:56 -0700
In-Reply-To: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 21 Apr 2020 12:09:18 -0600")
Message-ID: <xmqqeesgmuzv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE6F270-8410-11EA-9FAE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In bd0b42aed3 (fetch-pack: do not take shallow lock unnecessarily,
> 2019-01-10), the author noted that 'is_repository_shallow' produces
> visible side-effect(s) by setting 'is_shallow' and 'shallow_stat'.
>
> This is a problem for e.g., fetching with '--update-shallow' in a
> shallow repsoitory with 'fetch.writeCommitGraph' enabled, since the

repository.

> update to '.git/shallow' will cause Git to think that the repository
> isn't shallow when it is, thereby circumventing the commit-graph
> compatability check.
>
> This causes problems in shallow repositories with at least shallow refs
> that have at least one ancestor (since the client won't have those
> objects, and therefore can't take the reachability closure over commits
> when writing a commit-graph).

OK.

> Address this by introducing 'reset_repository_shallow()', and calling
> it whenever the shallow files is updated. This happens in two cases:
>
>   * during 'update_shallow', when either the repository is
>     un-shallowing, or after commit_lock_file, when the contents of
>     .git/shallow is changing, and
>
>   * in 'prune_shallow', when the repository can go from shallow to
>     un-shallow when the shallow file is updated, forcing
>     'is_repository_shallow' to re-evaluate whether the repository is
>     still shallow after fetching in the above scenario.
>
> As a result of the second change, 'prune_shallow' can now only be called
> once (since 'check_shallow_file_for_update' will die after calling
> 'reset_repository_shallow'). But, this is OK since we only call
> 'prune_shallow' at most once per process.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>
> Here's a cleaned up version of the patch that we were originally
> discussing in
> https://lore.kernel.org/git/20200414235057.GA6863@syl.local/, which
> addresses some of Jonathan's feedback and adds a test to make sure that
> the new behavior is working correctly.
>
>  commit.h                 |  1 +
>  fetch-pack.c             |  1 +
>  shallow.c                | 15 ++++++++-------
>  t/t5537-fetch-shallow.sh | 36 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/commit.h b/commit.h
> index 008a0fa4a0..ee1ba139d4 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -251,6 +251,7 @@ int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
>  int for_each_commit_graft(each_commit_graft_fn, void *);
>  int is_repository_shallow(struct repository *r);
> +void reset_repository_shallow(struct repository *r);
>  struct commit_list *get_shallow_commits(struct object_array *heads,
>  					int depth, int shallow_flag, int not_shallow_flag);
>  struct commit_list *get_shallow_commits_by_rev_list(
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1734a573b0..684868bc17 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1632,6 +1632,7 @@ static void update_shallow(struct fetch_pack_args *args,
>  			rollback_lock_file(&shallow_lock);
>  		} else
>  			commit_lock_file(&shallow_lock);
> +		reset_repository_shallow(the_repository);
>  		alternate_shallow_file = NULL;
>  		return;
>  	}

So, after updating shallow file with "fetch --update-shallow" (or
failing to do so), we reset the in-core data.

> +void reset_repository_shallow(struct repository *r)
> +{
> +	r->parsed_objects->is_shallow = -1;
> +	stat_validity_clear(r->parsed_objects->shallow_stat);
> +}

OK.

> @@ -362,6 +361,7 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
>  		 * shallow file".
>  		 */
>  		*alternate_shallow_file = "";
> +	reset_repository_shallow(the_repository);
>  	strbuf_release(&sb);
>  }

And also after writing out the alternate shallow file (whether it is
empty or polulated).

> @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
>  	} else {
>  		unlink(git_path_shallow(the_repository));
>  		rollback_lock_file(&shallow_lock);
> +		reset_repository_shallow(the_repository);
>  	}

Here, we reset only after we realize we cannot write the updated
shallow file.  Intended?

> +	cat <<EOF >expect.refs &&
> +refs/remotes/shallow/master
> +refs/remotes/shallow/no-shallow
> +refs/tags/heavy-tag
> +refs/tags/heavy-tag-for-graph
> +refs/tags/light-tag
> +refs/tags/light-tag-for-graph
> +EOF

	cat <<-EOF >expect.refs &&
	... body can be indented by any number of TAB
	... to make it easier to view
	EOF

> +	test_cmp expect.refs actual.refs &&
> +	git log --format=%s shallow/master >actual &&
> +	cat <<EOF >expect &&

Likewise.
