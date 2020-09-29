Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F71C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC012075E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkVXzjhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgI2Syk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:54:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51158 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Syk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 14:54:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA051F7281;
        Tue, 29 Sep 2020 14:54:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wPdfBIUSf4uiAfC9AN90jQp83x4=; b=TkVXzj
        hTQ7u0wpENCsxrU3b69xCNTAhT5jTCm6QpIzdUkAWOk568Lxt9/cJew1KpwBZ2E5
        YCrD4yDilFaZbJnYdj59kUv0ELxFKmqqdEDymqHdRSMCDo8qWBy8zEXPAM8qB8R8
        I9xD8jvCmlMaXKVh+ZpY6KbmLAhbR6dxfUqV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hPlTcxCQ/R/iGT5DuRlcCjlE00TPXZAH
        8WnrgBSqM0bVmAaABJIgGQyxjjiUK5svwuJ+/QEvP2nhy1Fb3xGzJDFQzOBLqonJ
        DRuAbxi3qgX7fITWw9hoDKkycAnSYJqtefCjdArRu6sSiruMULkkcChlZnvhExzj
        Pyqu78cUKHs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3152F7280;
        Tue, 29 Sep 2020 14:54:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE5E2F727F;
        Tue, 29 Sep 2020 14:54:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] diff: get rid of redundant 'dense' argument
References: <20200929113122.14201-1-sorganov@gmail.com>
Date:   Tue, 29 Sep 2020 11:54:28 -0700
In-Reply-To: <20200929113122.14201-1-sorganov@gmail.com> (Sergey Organov's
        message of "Tue, 29 Sep 2020 14:31:22 +0300")
Message-ID: <xmqqh7rgifbv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 347A1310-0285-11EB-9318-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Get rid of 'dense' argument that is redundant for every function that has
> 'struct rev_info *rev' argument as well, as the value of 'dense' passed is
> always taken from 'rev->dense_combined_merges' field.
>
> The only place where this was not the case is in 'submodule.c' where
> 'diff_tree_combined_merge()' was called with '1' for 'dense' argument. However,
> at that call the 'revs' instance used is local to the function, and we now just
> set 'revs->dense_combined_merges' to 1 in this local instance.

Interesting.  This dates back to 91539833 (Log message printout
cleanups, 2006-04-17), where show_patch_diff() in combine-diff.c
that used to take "struct diff_options *" was modified to take
"struct rev_info *".  I think the codepath took "int dense" from
the beginning of the combined diff feature and I suspect this
change could have been made in that old commit.

Looking at the history, it seems that it definititely could have
been noticed when I reorganized the codepath involved in combined
and dense combined patches in 0fe7c1de (built-in diff: assorted
updates., 2006-04-29).  Back when the callers of diff_tree_combined()
were only a few and it was more obvious that the singleton 'dense'
was (or would soon become) redundant.

Will queue.  Thanks.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  builtin/diff.c |  3 +--
>  combine-diff.c | 21 +++++++++------------
>  diff-lib.c     |  6 ++----
>  diff.h         |  6 +++---
>  log-tree.c     |  2 +-
>  submodule.c    |  3 ++-
>  6 files changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index cb98811c21db..cd4083fed96e 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -203,8 +203,7 @@ static int builtin_diff_combined(struct rev_info *revs,
>  		revs->dense_combined_merges = revs->combine_merges = 1;
>  	for (i = 1; i < ents; i++)
>  		oid_array_append(&parents, &ent[i].item->oid);
> -	diff_tree_combined(&ent[0].item->oid, &parents,
> -			   revs->dense_combined_merges, revs);
> +	diff_tree_combined(&ent[0].item->oid, &parents, revs);
>  	oid_array_clear(&parents);
>  	return 0;
>  }
> diff --git a/combine-diff.c b/combine-diff.c
> index 002e0e5438bc..555b812a9975 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -923,7 +923,6 @@ static void dump_quoted_path(const char *head,
>  
>  static void show_combined_header(struct combine_diff_path *elem,
>  				 int num_parent,
> -				 int dense,
>  				 struct rev_info *rev,
>  				 const char *line_prefix,
>  				 int mode_differs,
> @@ -939,6 +938,7 @@ static void show_combined_header(struct combine_diff_path *elem,
>  	int added = 0;
>  	int deleted = 0;
>  	int i;
> +	int dense = rev->dense_combined_merges;
>  
>  	if (rev->loginfo && !rev->no_commit_id)
>  		show_log(rev);
> @@ -1012,7 +1012,7 @@ static void show_combined_header(struct combine_diff_path *elem,
>  }
>  
>  static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
> -			    int dense, int working_tree_file,
> +			    int working_tree_file,
>  			    struct rev_info *rev)
>  {
>  	struct diff_options *opt = &rev->diffopt;
> @@ -1145,7 +1145,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  		}
>  	}
>  	if (is_binary) {
> -		show_combined_header(elem, num_parent, dense, rev,
> +		show_combined_header(elem, num_parent, rev,
>  				     line_prefix, mode_differs, 0);
>  		printf("Binary files differ\n");
>  		free(result);
> @@ -1200,10 +1200,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  				     textconv, elem->path, opt->xdl_opts);
>  	}
>  
> -	show_hunks = make_hunks(sline, cnt, num_parent, dense);
> +	show_hunks = make_hunks(sline, cnt, num_parent, rev->dense_combined_merges);
>  
>  	if (show_hunks || mode_differs || working_tree_file) {
> -		show_combined_header(elem, num_parent, dense, rev,
> +		show_combined_header(elem, num_parent, rev,
>  				     line_prefix, mode_differs, 1);
>  		dump_sline(sline, line_prefix, cnt, num_parent,
>  			   opt->use_color, result_deleted);
> @@ -1284,7 +1284,6 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
>   */
>  void show_combined_diff(struct combine_diff_path *p,
>  		       int num_parent,
> -		       int dense,
>  		       struct rev_info *rev)
>  {
>  	struct diff_options *opt = &rev->diffopt;
> @@ -1294,7 +1293,7 @@ void show_combined_diff(struct combine_diff_path *p,
>  				  DIFF_FORMAT_NAME_STATUS))
>  		show_raw_diff(p, num_parent, rev);
>  	else if (opt->output_format & DIFF_FORMAT_PATCH)
> -		show_patch_diff(p, num_parent, dense, 1, rev);
> +		show_patch_diff(p, num_parent, 1, rev);
>  }
>  
>  static void free_combined_pair(struct diff_filepair *pair)
> @@ -1454,7 +1453,6 @@ static struct combine_diff_path *find_paths_multitree(
>  
>  void diff_tree_combined(const struct object_id *oid,
>  			const struct oid_array *parents,
> -			int dense,
>  			struct rev_info *rev)
>  {
>  	struct diff_options *opt = &rev->diffopt;
> @@ -1581,8 +1579,7 @@ void diff_tree_combined(const struct object_id *oid,
>  				printf("%s%c", diff_line_prefix(opt),
>  				       opt->line_termination);
>  			for (p = paths; p; p = p->next)
> -				show_patch_diff(p, num_parent, dense,
> -						0, rev);
> +				show_patch_diff(p, num_parent, 0, rev);
>  		}
>  	}
>  
> @@ -1600,7 +1597,7 @@ void diff_tree_combined(const struct object_id *oid,
>  	clear_pathspec(&diffopts.pathspec);
>  }
>  
> -void diff_tree_combined_merge(const struct commit *commit, int dense,
> +void diff_tree_combined_merge(const struct commit *commit,
>  			      struct rev_info *rev)
>  {
>  	struct commit_list *parent = get_saved_parents(rev, commit);
> @@ -1610,6 +1607,6 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
>  		oid_array_append(&parents, &parent->item->object.oid);
>  		parent = parent->next;
>  	}
> -	diff_tree_combined(&commit->object.oid, &parents, dense, rev);
> +	diff_tree_combined(&commit->object.oid, &parents, rev);
>  	oid_array_clear(&parents);
>  }
> diff --git a/diff-lib.c b/diff-lib.c
> index 346fdcf0b0ce..f95c6de75fc8 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -177,9 +177,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			i--;
>  
>  			if (revs->combine_merges && num_compare_stages == 2) {
> -				show_combined_diff(dpath, 2,
> -						   revs->dense_combined_merges,
> -						   revs);
> +				show_combined_diff(dpath, 2, revs);
>  				free(dpath);
>  				continue;
>  			}
> @@ -361,7 +359,7 @@ static int show_modified(struct rev_info *revs,
>  		p->parent[1].status = DIFF_STATUS_MODIFIED;
>  		p->parent[1].mode = old_entry->ce_mode;
>  		oidcpy(&p->parent[1].oid, &old_entry->oid);
> -		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
> +		show_combined_diff(p, 2, revs);
>  		free(p);
>  		return 0;
>  	}
> diff --git a/diff.h b/diff.h
> index 49242d2733c0..dc6e09a55e62 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -454,11 +454,11 @@ struct combine_diff_path {
>  		st_mult(sizeof(struct combine_diff_parent), (n)))
>  
>  void show_combined_diff(struct combine_diff_path *elem, int num_parent,
> -			int dense, struct rev_info *);
> +			struct rev_info *);
>  
> -void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, int dense, struct rev_info *rev);
> +void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, struct rev_info *rev);
>  
> -void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
> +void diff_tree_combined_merge(const struct commit *commit, struct rev_info *rev);
>  
>  void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
>  
> diff --git a/log-tree.c b/log-tree.c
> index cb8942fec181..1927f917ce94 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -885,7 +885,7 @@ int log_tree_diff_flush(struct rev_info *opt)
>  
>  static int do_diff_combined(struct rev_info *opt, struct commit *commit)
>  {
> -	diff_tree_combined_merge(commit, opt->dense_combined_merges, opt);
> +	diff_tree_combined_merge(commit, opt);
>  	return !opt->loginfo;
>  }
>  
> diff --git a/submodule.c b/submodule.c
> index 543b1123ae12..b3bb59f06644 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -865,7 +865,8 @@ static void collect_changed_submodules(struct repository *r,
>  		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
>  		diff_rev.diffopt.format_callback_data = &data;
> -		diff_tree_combined_merge(commit, 1, &diff_rev);
> +		diff_rev.dense_combined_merges = 1;
> +		diff_tree_combined_merge(commit, &diff_rev);
>  	}
>  
>  	reset_revision_walk();
