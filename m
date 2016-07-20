Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06852034E
	for <e@80x24.org>; Wed, 20 Jul 2016 21:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbcGTVcB (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 17:32:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751641AbcGTVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 17:31:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAF052D055;
	Wed, 20 Jul 2016 17:31:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S1Y1fiNLyuiXl7wC5Oy35jrRRlU=; b=mM07KJ
	fvICSesN6Cu74NQpojHXimVZQ8r+CiCHqr/agmX655/NB+Vec/EuGIqSfkfHFJvK
	U4/ru3hAcrHT+zHBJbuEv2+44FwNPhpGInXhc6lQWsvVDafj2ejc/t8AJOmdfNtW
	QSMuCSW7ZLMPQKbaytKB4yBeviFBpK3vcPHPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqUrmfsBQguAJ+R77hUR73kddFy+rwcw
	OIKNh2NNc5K7iwlozFtJw9WhVhA+GBdh8GhzdJUwcjeAooP0H0j8cenAW8E3Rkcp
	4789KmBu6HzpE0DN7YlYWtPCwjo3qsZ5FD+7DDBwH1UUeBa1Db+tEcuqy9Gcv32u
	E9UDQJxWpwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B26E62D054;
	Wed, 20 Jul 2016 17:31:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B7132D052;
	Wed, 20 Jul 2016 17:31:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 3/6] Per-file output for Porcelain Status V2
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
	<1468966258-11191-4-git-send-email-jeffhost@microsoft.com>
Date:	Wed, 20 Jul 2016 14:31:54 -0700
In-Reply-To: <1468966258-11191-4-git-send-email-jeffhost@microsoft.com> (Jeff
	Hostetler's message of "Tue, 19 Jul 2016 18:10:55 -0400")
Message-ID: <xmqqh9bkc7xx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62994FE4-4EC1-11E6-B883-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <jeffhost@microsoft.com> writes:

> diff --git a/wt-status.c b/wt-status.c
> index c19b52c..2d4829e 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -406,6 +406,89 @@ static void wt_status_print_change_data(struct wt_status *s,
>  	strbuf_release(&twobuf);
>  }
>  
> +
> +/* Copy info for both sides of a head-vs-index change
> + * into the Porcelain V2 data.
> + */

	/* 
	 * Please don't use unbalanced/asymmetric comment.
         * Our multi-line comment blocks look more like
         * this.
         */

> +static void porcelain_v2_updated_entry(
> +	struct wt_status_change_data *d,
> +	struct diff_filepair *p)
> +{
> +	switch (p->status) {
> +	case DIFF_STATUS_ADDED:
> +		d->porcelain_v2.mode_index = p->two->mode;
> +		hashcpy(d->porcelain_v2.sha1_index, p->two->sha1);
> +		break;
> +
> +	case DIFF_STATUS_DELETED:
> +		d->porcelain_v2.mode_head = p->one->mode;
> +		hashcpy(d->porcelain_v2.sha1_head, p->one->sha1);
> +		break;
> +
> +	case DIFF_STATUS_RENAMED:
> +		d->porcelain_v2.rename_score = p->score * 100 / MAX_SCORE;
> +	case DIFF_STATUS_COPIED:
> +	case DIFF_STATUS_MODIFIED:
> +	case DIFF_STATUS_TYPE_CHANGED:
> +	case DIFF_STATUS_UNMERGED:
> +		d->porcelain_v2.mode_head = p->one->mode;
> +		d->porcelain_v2.mode_index = p->two->mode;
> +		hashcpy(d->porcelain_v2.sha1_head, p->one->sha1);
> +		hashcpy(d->porcelain_v2.sha1_index, p->two->sha1);
> +		break;
> +
> +	case DIFF_STATUS_UNKNOWN:
> +		/* This should never happen. */
> +		break;
> +	}

You may want to have

	die("BUG: status unknown???");

if you know "This should never happen.".

The code seems to assume that d->porcelain_v2.* fields are
initialized earlier in the callchain to reasonable values
(e.g. STATUS_ADDED case does not clear .mode_head to "missing"); I
am not sure if that is easier to read or fill in all the values
explicitly in this function.

> +}
> +
> +/* Copy info for both sides of an index-vs-worktree change
> + * into the very verbose porcelain data.
> + */
> +static void porcelain_v2_changed_entry(
> +	struct wt_status_change_data *d,
> +	const struct diff_filepair *p)
> +{
> +	switch (p->status) {
> +	case DIFF_STATUS_ADDED:
> +		d->porcelain_v2.mode_worktree = p->two->mode;
> +		/* don't bother with worktree sha, since it is almost always zero. */
> +		break;
> +
> +	case DIFF_STATUS_DELETED:
> +		d->porcelain_v2.mode_index = p->one->mode;
> +		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
> +		break;
> +
> +	case DIFF_STATUS_COPIED:
> +	case DIFF_STATUS_MODIFIED:
> +	case DIFF_STATUS_RENAMED:

Can RENAMED or COPIED happen here?

> +	case DIFF_STATUS_TYPE_CHANGED:
> +		d->porcelain_v2.mode_index = p->one->mode;
> +		d->porcelain_v2.mode_worktree = p->two->mode;
> +		hashcpy(d->porcelain_v2.sha1_index, p->one->sha1);
> +		/* don't bother with worktree sha, since it is almost always zero. */
> +		break;
> +
> +	case DIFF_STATUS_UNKNOWN:
> +		/* This should never happen. */
> +		break;
> +
> +	case DIFF_STATUS_UNMERGED:
> +		/* This should never happen. */
> +		break;
> +	}
> +}

Other than that, the same comments as the ones for _updated_ apply
to this _changed_ function.

> +static void porcelain_v2_added_initial_entry(
> +	struct wt_status_change_data *d,
> +	const struct cache_entry *ce)
> +{
> +	d->porcelain_v2.mode_index = ce->ce_mode;
> +	hashcpy(d->porcelain_v2.sha1_index, ce->sha1);
> +}
> +
>  static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  					 struct diff_options *options,
>  					 void *data)
> @@ -433,6 +516,9 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  		d->dirty_submodule = p->two->dirty_submodule;
>  		if (S_ISGITLINK(p->two->mode))
>  			d->new_submodule_commits = !!hashcmp(p->one->sha1, p->two->sha1);
> +
> +		if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
> +			porcelain_v2_changed_entry(d, p);
>  	}
>  }
>  
> @@ -486,6 +572,9 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  			d->stagemask = unmerged_mask(p->two->path);
>  			break;
>  		}
> +
> +		if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
> +			porcelain_v2_updated_entry(d, p);
>  	}
>  }
> @@ -565,8 +654,12 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
>  			d->index_status = DIFF_STATUS_UNMERGED;
>  			d->stagemask |= (1 << (ce_stage(ce) - 1));
>  		}
> -		else
> +		else {
>  			d->index_status = DIFF_STATUS_ADDED;
> +
> +			if (s->status_format == STATUS_FORMAT_PORCELAIN_V2)
> +				porcelain_v2_added_initial_entry(d, ce);
> +		}
>  	}
>  }

The code would be simpler and we'll catch bugs more uniformly if
"collect" phase is made oblivious to s->status_format, I would
suspect, by making unconditional call to porcelain_v2_*_entry()
functions from all of these "collect" functions.

> +/* Convert various submodule status values into a
> + * string of characters in the buffer provided.
> + */
> +static void wt_porcelain_v2_submodule_state(
> +	struct wt_status_change_data *d,
> +	char sub[5])
> +{
> +	int k = 0;
> +
> +	if (S_ISGITLINK(d->porcelain_v2.mode_head) ||
> +		S_ISGITLINK(d->porcelain_v2.mode_index) ||
> +		S_ISGITLINK(d->porcelain_v2.mode_worktree)) {
> +		/* We have a submodule */
> +		sub[k++] = 'S';
> +
> +		/* Sub-flags for each type of dirt */
> +		if (d->new_submodule_commits)
> +			sub[k++] = 'C';
> +		if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> +			sub[k++] = 'M';
> +		if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> +			sub[k++] = 'U';
> +	} else {
> +		/* Not a submodule */
> +		sub[k++] = 'N';
> +	}
> +
> +	sub[k] = 0;
> +}

The above seems to do "up to 5"; if these come early in the output,
it may instead be easier to read if "fixed 5 columns, many of them
may be SP, and some may be C or M or U", which would align on fixed
column terminal people use for coding.

> +/* Various fix-up steps before we start printing an item.
> + */
> +static void wt_porcelain_v2_fix_up_status(
> +	struct string_list_item *it,
> +	struct wt_status *s)
> +{
> +	struct wt_status_change_data *d = it->util;
> +
> +	if (!d->index_status) {
> +		if (d->worktree_status == DIFF_STATUS_MODIFIED ||
> +			d->worktree_status == DIFF_STATUS_DELETED) {
> +			/* X=' ' Y=[MD]
> +			 * The item did not change in head-vs-index scan so the head
> +			 * column was never set. (The index column was set during the
> +			 * index-vs-worktree scan.)
> +			 * Force set the head column to make the output complete.
> +			 */
> +			d->porcelain_v2.mode_head = d->porcelain_v2.mode_index;
> +			hashcpy(d->porcelain_v2.sha1_head, d->porcelain_v2.sha1_index);
> +		}

Can there be "else" clause for this inner "if"?  When
d->index_status is not set, but worktree_status is not one of these
two, what does it indicate?  The same for the next one.

> +	}
> +
> +	if (!d->worktree_status) {
> +		if (d->index_status == DIFF_STATUS_MODIFIED ||
> +			d->index_status == DIFF_STATUS_ADDED ||
> +			d->index_status == DIFF_STATUS_RENAMED ||
> +			d->index_status == DIFF_STATUS_COPIED) {
> +			/* X=[MARC] Y=' '
> +			 * The item did not changed in the index-vs-worktree scan so

s/changed/change/

> +			 * the worktree column was never set.
> +			 * Force set the worktree mode to make the output complete.
> +			 */
> +			d->porcelain_v2.mode_worktree = d->porcelain_v2.mode_index;
> +		}
> +	}
> +}
> +
> +/*
> + * Define a single format for tracked entries. This includes:
> + * normal changes, rename changes, and unmerged changes.
> + *
> + * The meanings of modes_[abcd] and sha_[abc] depends on the
> + * change type, but are always present.
> + *
> + * Path(s) are C-Quoted if necessary. Current path is ALWAYS
> + * first. The rename source path is only present when necessary.
> + * A single TAB separates them (because paths can contain spaces
> + * and C-Quoting converts actual tabs in pathnames to a C escape
> + * sequence).
> + */
> +static void wt_porcelain_v2_print_tracked_entry(
> +	FILE *fp,
> +	char x_staged,
> +	char y_unstaged,
> +	const char *submodule,
> +	int mode_a,
> +	int mode_b,
> +	int mode_c,
> +	int mode_d,
> +	const unsigned char sha_a[GIT_SHA1_RAWSZ],
> +	const unsigned char sha_b[GIT_SHA1_RAWSZ],
> +	const unsigned char sha_c[GIT_SHA1_RAWSZ],

x, y, a, b, c, d are all mystery.  When we see a/b/c, they typically
mean stage#1, stage#2 and stage#3, but that does not seem to be it.
When we see a/b, they typically mean old and new, but that does not
seem to be the case here, either.

If you are saying in the above comment, which curiously is formatted
correctly unlike many other multi-line comments we see in this patch
;-), that the meaning of these are not fixed but the function is to
always show 2 things, then four things in the fixed order without
knowing what they mean, it would be easier to understand if you made
them into an array, i.e.e.g. instead of having x_staged and
y_unstaged, have "char prefix[2]" or something that tells the reader
that whatever meaning these have, these come early in the output.

> +	int rename_score,
> +	const char *path_current,
> +	const char *path_rename_src,
> +	int null_termination)
> +{
> +	char sep_char = null_termination ? '\0' : '\t';
> +	char eol_char = null_termination ? '\0' : '\n';

Mental note (i.e. shouldn't be done as part of this patch, but is
something we should fix, probably as a preparatory clean-up patch
before the series): these should be spelled nul_termination, as the
name of the '\0' character is NUL, not NULL.

> +	if (path_rename_src)
> +		fprintf(fp, "%c%c %s %06o %06o %06o %06o %s %s %s R%d %s%c%s%c",
> +				x_staged, y_unstaged, submodule,
> +				mode_a, mode_b, mode_c, mode_d,
> +				sha1_to_hex(sha_a), sha1_to_hex(sha_b), sha1_to_hex(sha_c),
> +				rename_score,
> +				path_current, sep_char, path_rename_src,
> +				eol_char);
> +	else
> +		fprintf(fp, "%c%c %s %06o %06o %06o %06o %s %s %s R%d %s%c",
> +				x_staged, y_unstaged, submodule,
> +				mode_a, mode_b, mode_c, mode_d,
> +				sha1_to_hex(sha_a), sha1_to_hex(sha_b), sha1_to_hex(sha_c),
> +				rename_score,
> +				path_current,
> +				eol_char);
> +}
> +
> +/*
> + * Print porcelain V2 info for normal tracked entries.
> + */
> +static void wt_porcelain_v2_print_normal_entry(
> +	struct string_list_item *it,
> +	struct wt_status *s)
> +{
> +	static const unsigned char sha_zero[GIT_SHA1_RAWSZ] = {0};
> +	struct wt_status_change_data *d = it->util;
> +	struct strbuf buf_current = STRBUF_INIT;
> +	struct strbuf buf_rename_src = STRBUF_INIT;
> +	const char *path_current = NULL;
> +	const char *path_rename_src = NULL;
> +	char x_staged, y_unstaged;
> +	char submodule[5];
> +
> +	wt_porcelain_v2_fix_up_status(it, s);
> +	x_staged = d->index_status ? d->index_status : '.';
> +	y_unstaged = d->worktree_status ? d->worktree_status : '.';

I see a curious and misleading use of the word "staged" around
here.  If these two are index-status and worktree-status (with
stand-in letter '.' when they are not available), why not call them
index-status and worktree-status instead?

> +/*
> + * Print very verbose porcelain status info for unmerged entries.
> + */
> +static void wt_porcelain_v2_print_unmerged_entry(
> +	struct string_list_item *it,
> +	struct wt_status *s)
> +{
> +	struct wt_status_change_data *d = it->util;
> +	const struct cache_entry *ce;
> +	struct strbuf buf_current = STRBUF_INIT;
> +	const char *path_current = NULL;
> +	int pos, stage;
> +	struct {
> +		int mode;
> +		unsigned char sha1[GIT_SHA1_RAWSZ];
> +	} stages[3];
> +	char x_us = 'U', y_them = 'U';

I really do not want to see these X_ and Y_ prefixes; they do not
convey any meaning; if X always corresponds to ours while Y always
corresponds to theirs, then they are even redundant.

> +	char submodule[5];
> +
> +	switch (d->stagemask) {
> +	case 1: x_us = 'D'; y_them = 'D'; break; /* both deleted */
> +	case 2: x_us = 'A'; y_them = 'U'; break; /* added by us */
> +	case 3: x_us = 'U'; y_them = 'D'; break; /* deleted by them */
> +	case 4: x_us = 'U'; y_them = 'A'; break; /* added by them */
> +	case 5: x_us = 'D'; y_them = 'U'; break; /* deleted by us */
> +	case 6: x_us = 'A'; y_them = 'A'; break; /* both added */
> +	case 7: x_us = 'U'; y_them = 'U'; break; /* both modified */
> +	}
> +
> +	wt_porcelain_v2_submodule_state(d, submodule);
> +
> +	/*
> +	 * Disregard the V2 {mode,sha} values for head and index
> +	 * that we computed from the diffs and lookup the actual
> +	 * stage data.
> +	 */
> +	memset(stages, 0, sizeof(stages));
> +	pos = cache_name_pos(it->string, strlen(it->string));
> +	assert(pos < 0);
> +	pos = -pos-1;
> +	while (pos < active_nr) {
> +		ce = active_cache[pos++];
> +		stage = ce_stage(ce);
> +		if (strcmp(ce->name, it->string) || !stage)
> +			break;
> +		stages[stage - 1].mode = ce->ce_mode;
> +		hashcpy(stages[stage - 1].sha1, ce->sha1);
> +	}

You did assert(pos < 0) to make sure that the path the caller told
you is unmerged indeed is unmerged, which is a very good check.  In
the same spirit, you would want to make sure that you got at least
one result from the above loop, to diagnose a bug where the path did
not even exist at all in the index.

Also, it is possible to have more than one stage#1 entries in the
index (stage#2 can only be one; I think stage#3 can theoretically
have more than one, but in practice, even merge-octopus does not do
that).  The above loop gives us the "last one wins" semantics to
make sure what you grab from the index always fit in stages[] array,
which is not wrong per-se, but that design decision may want to be
documented in a comment nearby for people to work on enhancing it in
the future.

