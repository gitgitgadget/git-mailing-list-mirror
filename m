Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E589C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C662065F
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 22:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PQjM4gSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgGJWkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:40:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53666 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgGJWke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 18:40:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD8736C7D8;
        Fri, 10 Jul 2020 18:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MauZhregPVYjalKgLa9OguLDWRA=; b=PQjM4g
        SyG3UyGY7J4SbJPxUnMtfe4cCsI4JkX2a7qKSufiSKUp3iLsoGjXbFvRR3ITkg2M
        /92l/0skCpl0MeplHpQGnEzoYCM+W6ZZONvigRoIRbn4GwYtED7UO1DIFkn0j/Xk
        qUS++cLoyps+FBjumfLqiFKhth6be1cTtNCuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yUDl4K5Z6xJ/jZlqQm0Eb9/6cjeynETi
        yZCfpM6kC+4mKCle1rY24iyXH7W1IfiY864acdx3uUjnYu/AFYLapw3gznFebtDo
        pwB1Q63qzJ1coa0G1o4XUZZ6QFYAhFMAL8CiSktquX8LYwbJFlbs3ZW5VacjU2iE
        2D+Tnm0JbOQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A27636C7D6;
        Fri, 10 Jul 2020 18:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C47D6C7D5;
        Fri, 10 Jul 2020 18:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] progress: create progress struct in 'verbose' mode
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-2-emilyshaffer@google.com>
Date:   Fri, 10 Jul 2020 15:40:25 -0700
In-Reply-To: <20200710014242.1088216-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 9 Jul 2020 18:42:41 -0700")
Message-ID: <xmqq365zro2u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 592F8076-C2FE-11EA-89D9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Before now, the progress API is used by conditionally calling
> start_progress() or a similar call, and then unconditionally calling
> display_progress() and stop_progress(), both of which are tolerant of
> NULL or uninitialized inputs. However, in
> 98a136474082cdc7228d7e0e45672c5274fab701 (trace: log progress time and
> throughput), the progress library learned to log traces during expensive
> operations. In cases where progress should not be displayed to the user
> - such as when Git is called by a script - no traces will be logged,
> because the progress object is never created.
>
> Instead, to allow us to collect traces from scripted Git commands, teach
> a progress->verbose flag, which is specified via a new argument to
> start_progress() and friends. display_progress() also learns to filter
> for that flag. With these changes, start_progress() can be called
> unconditionally but with a conditional as an argument to determine
> whether to report progress to the user.
>
> Since this changes the API, also modify callers of start_progress() and
> friends to drop their conditional and pass a new argument in instead.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  builtin/blame.c             |   4 +-
>  builtin/commit-graph.c      |   5 +-
>  builtin/fsck.c              |  25 ++++---
>  builtin/index-pack.c        |  16 ++---
>  builtin/log.c               |   4 +-
>  builtin/pack-objects.c      |  18 +++--
>  builtin/prune.c             |   4 +-
>  builtin/rev-list.c          |   9 ++-
>  builtin/unpack-objects.c    |   3 +-
>  commit-graph.c              | 140 +++++++++++++++++-------------------
>  delta-islands.c             |   4 +-
>  diffcore-rename.c           |   9 ++-
>  entry.c                     |   2 +-
>  midx.c                      |  43 +++++------
>  pack-bitmap-write.c         |   8 +--
>  pack-bitmap.c               |   5 +-
>  preload-index.c             |   7 +-
>  progress.c                  |  27 ++++---
>  progress.h                  |  10 +--
>  prune-packed.c              |   4 +-
>  read-cache.c                |   6 +-
>  t/helper/test-progress.c    |   6 +-
>  t/t0500-progress-display.sh |  27 +++++++
>  unpack-trees.c              |  14 ++--
>  walker.c                    |   4 +-
>  25 files changed, 212 insertions(+), 192 deletions(-)

So, the gist of the change is these, where all functions in the
progress API that prepare a progress structure now take "verbose"
parameter, and the function that emits the output looks at the
flag.  Counters and timers are used no matter what as long as
progress is shown.

> diff --git a/progress.c b/progress.c
> index 3eda914518..f014908b05 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -43,6 +43,7 @@ struct progress {
>  	struct strbuf counters_sb;
>  	int title_len;
>  	int split;
> +	int verbose;
>  };
>  
>  static volatile sig_atomic_t progress_update;
> @@ -245,12 +246,13 @@ void display_throughput(struct progress *progress, uint64_t total)
>  
>  void display_progress(struct progress *progress, uint64_t n)
>  {
> -	if (progress)
> +	if (progress && progress->verbose)
>  		display(progress, n, NULL);
>  }
>  
>  static struct progress *start_progress_delay(const char *title, uint64_t total,
> -					     unsigned delay, unsigned sparse)
> +					     unsigned delay, unsigned sparse,
> +					     int verbose)
>  {
>  	struct progress *progress = xmalloc(sizeof(*progress));
>  	progress->title = title;
> @@ -264,6 +266,7 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  	strbuf_init(&progress->counters_sb, 0);
>  	progress->title_len = utf8_strwidth(title);
>  	progress->split = 0;
> +	progress->verbose = verbose;
>  	set_progress_signal();
>  	trace2_region_enter("progress", title, the_repository);
>  	return progress;
> @@ -279,14 +282,16 @@ static int get_default_delay(void)
>  	return delay_in_secs;
>  }
>  
> -struct progress *start_delayed_progress(const char *title, uint64_t total)
> +struct progress *start_delayed_progress(const char *title, uint64_t total,
> +					int verbose)
>  {
> -	return start_progress_delay(title, total, get_default_delay(), 0);
> +	return start_progress_delay(title, total, get_default_delay(), 0,
> +				    verbose);
>  }
>  
> -struct progress *start_progress(const char *title, uint64_t total)
> +struct progress *start_progress(const char *title, uint64_t total, int verbose)
>  {
> -	return start_progress_delay(title, total, 0, 0);
> +	return start_progress_delay(title, total, 0, 0, verbose);
>  }
>  
>  /*
> @@ -298,15 +303,17 @@ struct progress *start_progress(const char *title, uint64_t total)
>   * When "sparse" is set, stop_progress() will automatically force the done
>   * message to show 100%.
>   */
> -struct progress *start_sparse_progress(const char *title, uint64_t total)
> +struct progress *start_sparse_progress(const char *title, uint64_t total,
> +				       int verbose)
>  {
> -	return start_progress_delay(title, total, 0, 1);
> +	return start_progress_delay(title, total, 0, 1, verbose);
>  }
>  
>  struct progress *start_delayed_sparse_progress(const char *title,
> -					       uint64_t total)
> +					       uint64_t total, int verbose)
>  {
> -	return start_progress_delay(title, total, get_default_delay(), 1);
> +	return start_progress_delay(title, total, get_default_delay(), 1,
> +				    verbose);
>  }
>  
>  static void finish_if_sparse(struct progress *progress)
> diff --git a/progress.h b/progress.h
> index f1913acf73..0c64557231 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -13,11 +13,13 @@ void progress_test_force_update(void);
>  
>  void display_throughput(struct progress *progress, uint64_t total);
>  void display_progress(struct progress *progress, uint64_t n);
> -struct progress *start_progress(const char *title, uint64_t total);
> -struct progress *start_sparse_progress(const char *title, uint64_t total);
> -struct progress *start_delayed_progress(const char *title, uint64_t total);
> +struct progress *start_progress(const char *title, uint64_t total, int verbose);
> +struct progress *start_sparse_progress(const char *title, uint64_t total,
> +				       int verbose);
> +struct progress *start_delayed_progress(const char *title, uint64_t total,
> +					int verbose);
>  struct progress *start_delayed_sparse_progress(const char *title,
> -					       uint64_t total);
> +					       uint64_t total, int verbose);
>  void stop_progress(struct progress **progress);
>  void stop_progress_msg(struct progress **progress, const char *msg);
>  


And then this is how a typical caller gets updated.

For this particular one, it is not _too_ bad, even though it does
feel a bit roundabout way to say "we are starting delayed progress
at this point" by having this call unconditionally, but then the
reader needs to realize "ah, not really, because show_progress is
not enabled" when the reading reaches the end of the call.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 94ef57c1cc..1d72b27fda 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1129,8 +1129,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  
>  	sb.found_guilty_entry = &found_guilty_entry;
>  	sb.found_guilty_entry_data = &pi;
> -	if (show_progress)
> -		pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines);
> +	pi.progress = start_delayed_progress(_("Blaming lines"), sb.num_lines,
> +					     show_progress);
>  
>  	assign_blame(&sb, opt);

But there are others that look a bit problematic.  In this example
taken from fsck, we open all the pack index, only because it is
needed to show the progress, and the existing conditionals are ways
to avoid spending unneeded cycles.

> @@ -836,16 +836,15 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  			uint32_t total = 0, count = 0;
>  			struct progress *progress = NULL;
>  
> -			if (show_progress) {
> -				for (p = get_all_packs(the_repository); p;
> -				     p = p->next) {
> -					if (open_pack_index(p))
> -						continue;
> -					total += p->num_objects;
> -				}
> -
> -				progress = start_progress(_("Checking objects"), total);
> +			for (p = get_all_packs(the_repository); p;
> +			     p = p->next) {
> +				if (open_pack_index(p))
> +					continue;
> +				total += p->num_objects;
>  			}
> +
> +			progress = start_progress(_("Checking objects"), total,
> +						  show_progress);
>  			for (p = get_all_packs(the_repository); p;
>  			     p = p->next) {
>  				/* verify gives error messages itself */

Likewise, we do not even have to be scanning the index entries
upfront if we are not showing the progress report (and more
importantly, the user likely has chosen the speed/cycles over eye
candy progress meter) while checking out paths from the index.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 4be5fc3075..fa84244466 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -338,16 +338,14 @@ static struct progress *get_progress(struct unpack_trees_options *o,
>  {
>  	unsigned cnt = 0, total = 0;
>  
> -	if (!o->update || !o->verbose_update)
> -		return NULL;
> -
>  	for (; cnt < index->cache_nr; cnt++) {
>  		const struct cache_entry *ce = index->cache[cnt];
>  		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
>  			total++;
>  	}
>  
> -	return start_delayed_progress(_("Updating files"), total);
> +	return start_delayed_progress(_("Updating files"), total,
> +				      (o->update && o->verbose_update));
>  }
>  
>  static void setup_collided_checkout_detection(struct checkout *state,


And there are cases where the "is progress enabled?" parameter (by
the way, I am not sure 'verbose' is quite the right name for the
parameter and the field name, as that word implies there can be
multiple verbosity levels---what I see you've done is that you added
an "is this enabled?" flag) is not a simple variable, like these.
Some are simple enough, but some are not.  Some of the worst appear
in preload-index.c and read-cache.c---they may become easier to read
if we introduced a variable to be passed as the "enable?"  parameter
and compute it before makng a call, and that might be enough, though.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7016b28485..1a97a9f0be 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1012,8 +1012,8 @@ static void write_pack_file(void)
>  	time_t last_mtime = 0;
>  	struct object_entry **write_order;
>  
> -	if (progress > pack_to_stdout)
> -		progress_state = start_progress(_("Writing objects"), nr_result);
> +	progress_state = start_progress(_("Writing objects"), nr_result,
> +					(progress > pack_to_stdout));
>  	ALLOC_ARRAY(written_list, to_pack.nr_objects);
>  	write_order = compute_write_order();
>  

> @@ -1418,9 +1415,9 @@ int write_commit_graph_reachable(struct object_directory *odb,
>  
>  	memset(&data, 0, sizeof(data));
>  	data.commits = &commits;
> -	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
> -		data.progress = start_delayed_progress(
> -			_("Collecting referenced commits"), 0);
> +	data.progress = start_delayed_progress(
> +		_("Collecting referenced commits"), 0,
> +		(flags & COMMIT_GRAPH_WRITE_PROGRESS));
>  
>  	for_each_ref(add_ref_to_set, &data);
>  	result = write_commit_graph(odb, NULL, &commits,

> @@ -2301,9 +2295,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>  	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;
>  
> -	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
> -		progress = start_progress(_("Verifying commits in commit graph"),
> -					g->num_commits);
> +	progress = start_progress(_("Verifying commits in commit graph"),
> +				g->num_commits,
> +				(flags & COMMIT_GRAPH_WRITE_PROGRESS));
>  
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;

> diff --git a/midx.c b/midx.c
> index 6d1584ca51..d9ab163340 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -836,10 +836,8 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	}
>  
>  	packs.pack_paths_checked = 0;
> -	if (flags & MIDX_PROGRESS)
> -		packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0);
> -	else
> -		packs.progress = NULL;
> +	packs.progress = start_progress(_("Adding packfiles to multi-pack-index"), 0,
> +						(flags & MIDX_PROGRESS));
>  
>  	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
>  	stop_progress(&packs.progress);

> diff --git a/preload-index.c b/preload-index.c
> index ed6eaa4738..a924a84a14 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -115,10 +115,9 @@ void preload_index(struct index_state *index,
>  	memset(&data, 0, sizeof(data));
>  
>  	memset(&pd, 0, sizeof(pd));
> -	if (refresh_flags & REFRESH_PROGRESS && isatty(2)) {
> -		pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr);
> -		pthread_mutex_init(&pd.mutex, NULL);
> -	}
> +	pd.progress = start_delayed_progress(_("Refreshing index"), index->cache_nr,
> +					     (refresh_flags & REFRESH_PROGRESS && isatty(2)));
> +	pthread_mutex_init(&pd.mutex, NULL);
>  
>  	for (i = 0; i < threads; i++) {
>  		struct thread_data *p = data+i;

> diff --git a/read-cache.c b/read-cache.c
> index aa427c5c17..2ddc422dbd 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1532,9 +1532,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>  	const char *unmerged_fmt;
>  	struct progress *progress = NULL;
>  
> -	if (flags & REFRESH_PROGRESS && isatty(2))
> -		progress = start_delayed_progress(_("Refresh index"),
> -						  istate->cache_nr);
> +	progress = start_delayed_progress(_("Refresh index"),
> +					  istate->cache_nr,
> +					  (flags & REFRESH_PROGRESS && isatty(2)));
>  
>  	trace_performance_enter();
>  	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";


And here is the only one that may benefit from this change, which
cares that the codepath prepared in rev-list, primarily to support
the progress meter, is exercised because those pieces of code
happens to be used by the tracing output as well.  Perhaps we
shouldn't have tied the "when showing progress, we can also trace"
earlier and we didn't have to touch this many codepath only to spend
cycles when progress output is not desired?

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index f520111eda..f64cad8390 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -620,8 +620,13 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (bisect_list)
>  		revs.limited = 1;
>  
> -	if (show_progress)
> -		progress = start_delayed_progress(show_progress, 0);
> +	/*
> +	 * When progress is not printed to the user, we still want to be able to
> +	 * classify the progress during tracing. So, use a placeholder name.
> +	 */
> +	progress = start_delayed_progress(
> +			show_progress ? show_progress : _("Quiet rev-list operation"),
> +			0, show_progress != NULL);

I've cut out the hunks that exhibits similar looking patterns as the
ones I covered in the above discussion.  You are right to say that
these are simple and similar changes all over the place.  I am not
yet convinced that the simplicity supports that this change is the
right thing to do, though.  The only saving grace might be that
there aren't that many hunks that explicitly do unnecessary things
like the ones in unpack-trees.c and builtin/fsck.c even when we are
not showing progress.  

But the other codepaths may be doing conditional computation not
based on "if (show_progress)" but on "if (progress)", in which case
with this patch, we may be paying a lot more overhead even if we
know progress meter won't be shown and the worse part from
reviewability point of view is that this patch does not explicitly
do anything to make it happen because start_delayed_progress() now
unconditionally give a non-NULL progress structure to enable them.

So I dunno.  It certainly is not for the upcoming release, but we do
want to make sure that trace requested even when the command is quiet
gets collected in the longer term (i.e. during the next cycle).

Thanks.

