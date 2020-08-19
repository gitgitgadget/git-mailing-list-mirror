Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CAEC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB58E207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHSVea (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:34:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:53019 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgHSVe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 17:34:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 76BCF3F4844;
        Wed, 19 Aug 2020 17:34:24 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0BCF03F4133;
        Wed, 19 Aug 2020 17:34:24 -0400 (EDT)
Subject: Re: [RFC PATCH 11/21] parallel-checkout: make it truly parallel
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Paul Tan <pyokagan@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
 <7e7527ef3e8a9e71a012f1623e9642c47f7f741c.1597093021.git.matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f3291797-3ef1-8a2b-d6d5-394f3c32c83c@jeffhostetler.com>
Date:   Wed, 19 Aug 2020 17:34:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7e7527ef3e8a9e71a012f1623e9642c47f7f741c.1597093021.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/20 5:33 PM, Matheus Tavares wrote:
> Use multiple worker processes to distribute the queued entries and call
> write_checkout_item() in parallel for them. The items are distributed
> uniformly in contiguous chunks. This minimizes the chances of two
> workers writing to the same directory simultaneously, which could
> affect performance due to lock contention in the kernel. Work stealing
> (or any other format of re-distribution) is not implemented yet.
> 
> For now, the number of workers is equal to the number of logical cores
> available. But the next patch will add settings to configure this.
> Distributed file systems, such as NFS and EFS, can benefit from using
> more workers than the actual number of cores (see timings below).
> 
> The parallel version was benchmarked during three operations in the
> linux repo, with cold cache: cloning v5.8, checking out v5.8 from
> v2.6.15 (checkout I) and checking out v5.8 from v5.7 (checkout II). The
> three tables below show the mean run times and standard deviations for
> 5 runs in a local file system, a Linux NFS server and Amazon EFS. The
> numbers of workers were chosen based on what produces the best result
> for each case.
> 
> Local:
> 
>              Clone                  Checkout I             Checkout II
> Sequential  8.180 s ± 0.021 s      6.936 s ± 0.030 s      2.585 s ± 0.005 s
> 10 workers  3.633 s ± 0.040 s      2.288 s ± 0.026 s      1.058 s ± 0.015 s
> Speedup     2.25 ± 0.03            3.03 ± 0.04            2.44 ± 0.03
> 
> Linux NFS server (v4.1, on EBS, single availability zone):
> 
>              Clone                  Checkout I             Checkout II
> Sequential  208.069 s ± 2.522 s    198.610 s ± 1.979 s    54.376 s ± 1.333 s
> 32 workers  67.078 s ±  0.878 s    64.828 s ± 0.387 s     22.993 s ± 0.252 s
> Speedup     3.10 ± 0.06            3.06 ± 0.04            2.36 ± 0.06
> 
> EFS (v4.1, replicated over multiple availability zones):
> 
>              Clone                  Checkout I             Checkout II
> Sequential  1143.655 s ± 11.819 s  1277.891 s ± 10.481 s  396.891 s ± 7.505 s
> 64 workers  173.242 s ± 1.484 s    282.421 s ± 1.521 s    165.424 s ± 9.564 s
> Speedup     6.60 ± 0.09            4.52 ± 0.04            2.40 ± 0.15
> 
> Local tests were executed in an i7-7700HQ (4 cores with hyper-threading)
> running Manjaro Linux, with SSD. NFS and EFS tests were executed in an
> Amazon EC2 c5n.large instance, with 2 vCPUs. The Linux NFS server was
> running on a m6g.large instance with 1 TB, EBS GP2 volume. Before each
> timing, the linux repository was removed (or checked out back), and
> `sync && sysctl vm.drop_caches=3` was executed.
> 
> Co-authored-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>   .gitignore                 |   1 +
>   Makefile                   |   1 +
>   builtin.h                  |   1 +
>   builtin/checkout--helper.c | 135 +++++++++++++++++++++
>   entry.c                    |  13 +-
>   git.c                      |   2 +
>   parallel-checkout.c        | 237 +++++++++++++++++++++++++++++++------
>   parallel-checkout.h        |  74 +++++++++++-
>   8 files changed, 425 insertions(+), 39 deletions(-)
>   create mode 100644 builtin/checkout--helper.c
> 
> diff --git a/.gitignore b/.gitignore
> index ee509a2ad2..6c01f0a58c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -33,6 +33,7 @@
>   /git-check-mailmap
>   /git-check-ref-format
>   /git-checkout
> +/git-checkout--helper
>   /git-checkout-index
>   /git-cherry
>   /git-cherry-pick
> diff --git a/Makefile b/Makefile
> index caab8e6401..926473d484 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1049,6 +1049,7 @@ BUILTIN_OBJS += builtin/check-attr.o
>   BUILTIN_OBJS += builtin/check-ignore.o
>   BUILTIN_OBJS += builtin/check-mailmap.o
>   BUILTIN_OBJS += builtin/check-ref-format.o
> +BUILTIN_OBJS += builtin/checkout--helper.o
>   BUILTIN_OBJS += builtin/checkout-index.o
>   BUILTIN_OBJS += builtin/checkout.o
>   BUILTIN_OBJS += builtin/clean.o
> diff --git a/builtin.h b/builtin.h
> index a5ae15bfe5..5790c68750 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -122,6 +122,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix);
>   int cmd_bundle(int argc, const char **argv, const char *prefix);
>   int cmd_cat_file(int argc, const char **argv, const char *prefix);
>   int cmd_checkout(int argc, const char **argv, const char *prefix);
> +int cmd_checkout__helper(int argc, const char **argv, const char *prefix);
>   int cmd_checkout_index(int argc, const char **argv, const char *prefix);
>   int cmd_check_attr(int argc, const char **argv, const char *prefix);
>   int cmd_check_ignore(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/checkout--helper.c b/builtin/checkout--helper.c
> new file mode 100644
> index 0000000000..269cf02feb
> --- /dev/null
> +++ b/builtin/checkout--helper.c
> @@ -0,0 +1,135 @@
> +#include "builtin.h"
> +#include "config.h"
> +#include "entry.h"
> +#include "parallel-checkout.h"
> +#include "parse-options.h"
> +#include "pkt-line.h"
> +
> +static void packet_to_ci(char *line, int len, struct checkout_item *ci)
> +{
> +	struct ci_fixed_portion *fixed_portion;
> +	char *encoding, *variant;
> +
> +	if (len < sizeof(struct ci_fixed_portion))
> +		BUG("checkout worker received too short item (got %d, exp %d)",
> +		    len, (int)sizeof(struct ci_fixed_portion));
> +
> +	fixed_portion = (struct ci_fixed_portion *)line;
> +
> +	if (len - sizeof(struct ci_fixed_portion) !=
> +		fixed_portion->name_len + fixed_portion->working_tree_encoding_len)
> +		BUG("checkout worker received corrupted item");
> +
> +	variant = line + sizeof(struct ci_fixed_portion);
> +	if (fixed_portion->working_tree_encoding_len) {
> +		encoding = xmemdupz(variant,
> +				    fixed_portion->working_tree_encoding_len);
> +		variant += fixed_portion->working_tree_encoding_len;
> +	} else {
> +		encoding = NULL;
> +	}
> +
> +	memset(ci, 0, sizeof(*ci));
> +	ci->ce = make_empty_transient_cache_entry(fixed_portion->name_len);
> +	ci->ce->ce_namelen = fixed_portion->name_len;
> +	ci->ce->ce_mode = fixed_portion->ce_mode;
> +	memcpy(ci->ce->name, variant, ci->ce->ce_namelen);
> +	oidcpy(&ci->ce->oid, &fixed_portion->oid);
> +
> +	ci->id = fixed_portion->id;
> +	ci->ca.attr_action = fixed_portion->attr_action;
> +	ci->ca.crlf_action = fixed_portion->crlf_action;
> +	ci->ca.ident = fixed_portion->ident;
> +	ci->ca.working_tree_encoding = encoding;
> +}
> +
> +static void report_result(struct checkout_item *ci)
> +{
> +	struct ci_result res = { 0 };
> +	size_t size;
> +
> +	res.id = ci->id;
> +	res.status = ci->status;
> +
> +	if (ci->status == CI_SUCCESS) {
> +		res.st = ci->st;
> +		size = sizeof(res);
> +	} else {
> +		size = ci_result_base_size();
> +	}
> +
> +	packet_write(1, (const char *)&res, size);
> +}
> +
> +/* Free the worker-side malloced data, but not the ci itself. */
> +static void release_checkout_item_data(struct checkout_item *ci)
> +{
> +	free((char *)ci->ca.working_tree_encoding);
> +	discard_cache_entry(ci->ce);
> +}
> +
> +static void worker_loop(struct checkout *state)
> +{
> +	struct checkout_item *items = NULL;
> +	size_t i, nr = 0, alloc = 0;
> +
> +	while (1) {
> +		int len;
> +		char *line = packet_read_line(0, &len);
> +
> +		if (!line)
> +			break;
> +
> +		ALLOC_GROW(items, nr + 1, alloc);
> +		packet_to_ci(line, len, &items[nr++]);
> +	}
> +
> +	for (i = 0; i < nr; ++i) {
> +		struct checkout_item *ci = &items[i];
> +		write_checkout_item(state, ci);
> +		report_result(ci);
> +		release_checkout_item_data(ci);
> +	}
> +
> +	packet_flush(1);
> +
> +	free(items);
> +}
> +
> +static const char * const checkout_helper_usage[] = {
> +	N_("git checkout--helper [<options>]"),
> +	NULL
> +};
> +
> +int cmd_checkout__helper(int argc, const char **argv, const char *prefix)
> +{
> +	struct checkout state = CHECKOUT_INIT;
> +	struct option checkout_helper_options[] = {
> +		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
> +			N_("when creating files, prepend <string>")),
> +		OPT_END()
> +	};
> +
> +	if (argc == 2 && !strcmp(argv[1], "-h"))
> +		usage_with_options(checkout_helper_usage,
> +				   checkout_helper_options);
> +
> +	git_config(git_default_config, NULL);
> +	argc = parse_options(argc, argv, prefix, checkout_helper_options,
> +			     checkout_helper_usage, 0);
> +	if (argc > 0)
> +		usage_with_options(checkout_helper_usage, checkout_helper_options);
> +
> +	if (state.base_dir)
> +		state.base_dir_len = strlen(state.base_dir);
> +
> +	/*
> +	 * Setting this on worker won't actually update the index. We just need
> +	 * to pretend so to induce the checkout machinery to stat() the written
> +	 * entries.
> +	 */
> +	state.refresh_cache = 1;
> +
> +	worker_loop(&state);
> +	return 0;
> +}
> diff --git a/entry.c b/entry.c
> index 47c2c20d5a..b6c808dffa 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -427,8 +427,17 @@ static void mark_colliding_entries(const struct checkout *state,
>   	for (i = 0; i < state->istate->cache_nr; i++) {
>   		struct cache_entry *dup = state->istate->cache[i];
>   
> -		if (dup == ce)
> -			break;
> +		if (dup == ce) {
> +			/*
> +			 * Parallel checkout creates the files in a racy order.
> +			 * So the other side of the collision may appear after
> +			 * the given cache_entry in the array.
> +			 */
> +			if (parallel_checkout_status() == PC_HANDLING_RESULTS)
> +				continue;
> +			else
> +				break;
> +		}
>   
>   		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>   			continue;
> diff --git a/git.c b/git.c
> index 8bd1d7551d..78c7bd412c 100644
> --- a/git.c
> +++ b/git.c
> @@ -486,6 +486,8 @@ static struct cmd_struct commands[] = {
>   	{ "check-mailmap", cmd_check_mailmap, RUN_SETUP },
>   	{ "check-ref-format", cmd_check_ref_format, NO_PARSEOPT  },
>   	{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
> +	{ "checkout--helper", cmd_checkout__helper,
> +		RUN_SETUP | NEED_WORK_TREE | SUPPORT_SUPER_PREFIX },
>   	{ "checkout-index", cmd_checkout_index,
>   		RUN_SETUP | NEED_WORK_TREE},
>   	{ "cherry", cmd_cherry, RUN_SETUP },
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> index e3b44eeb34..ec42342bc8 100644
> --- a/parallel-checkout.c
> +++ b/parallel-checkout.c
> @@ -1,39 +1,23 @@
>   #include "cache.h"
>   #include "entry.h"
>   #include "parallel-checkout.h"
> +#include "pkt-line.h"
> +#include "run-command.h"
>   #include "streaming.h"
>   
> -enum ci_status {
> -	CI_PENDING = 0,
> -	CI_SUCCESS,
> -	CI_RETRY,
> -	CI_FAILED,
> -};
> -
> -struct checkout_item {
> -	/* pointer to a istate->cache[] entry. Not owned by us. */
> -	struct cache_entry *ce;
> -	struct conv_attrs ca;
> -	struct stat st;
> -	enum ci_status status;
> -};
> -
>   struct parallel_checkout {
>   	struct checkout_item *items;
>   	size_t nr, alloc;
>   };
>   
>   static struct parallel_checkout *parallel_checkout = NULL;
> -
> -enum pc_status {
> -	PC_UNINITIALIZED = 0,
> -	PC_ACCEPTING_ENTRIES,
> -	PC_RUNNING,
> -	PC_HANDLING_RESULTS,
> -};
> -
>   static enum pc_status pc_status = PC_UNINITIALIZED;
>   
> +enum pc_status parallel_checkout_status(void)
> +{
> +	return pc_status;
> +}
> +
>   void init_parallel_checkout(void)
>   {
>   	if (parallel_checkout)
> @@ -113,9 +97,11 @@ int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca)
>   	ALLOC_GROW(parallel_checkout->items, parallel_checkout->nr + 1,
>   		   parallel_checkout->alloc);
>   
> -	ci = &parallel_checkout->items[parallel_checkout->nr++];
> +	ci = &parallel_checkout->items[parallel_checkout->nr];
>   	ci->ce = ce;
>   	memcpy(&ci->ca, ca, sizeof(ci->ca));
> +	ci->id = parallel_checkout->nr;
> +	parallel_checkout->nr++;
>   
>   	return 0;
>   }
> @@ -200,7 +186,8 @@ static int write_checkout_item_to_fd(int fd, struct checkout *state,
>   	/*
>   	 * checkout metadata is used to give context for external process
>   	 * filters. Files requiring such filters are not eligible for parallel
> -	 * checkout, so pass NULL.
> +	 * checkout, so pass NULL. Note: if that changes, the metadata must also
> +	 * be passed from the main process to the workers.
>   	 */
>   	ret = convert_to_working_tree_ca(&ci->ca, ci->ce->name, new_blob, size,
>   					 &buf, NULL);
> @@ -241,14 +228,14 @@ static int check_leading_dirs(const char *path, int len, int prefix_len)
>   	return has_dirs_only_path(path, slash - path, prefix_len);
>   }
>   
> -static void write_checkout_item(struct checkout *state, struct checkout_item *ci)
> +void write_checkout_item(struct checkout *state, struct checkout_item *ci)
>   {
>   	unsigned int mode = (ci->ce->ce_mode & 0100) ? 0777 : 0666;
>   	int fd = -1, fstat_done = 0;
>   	struct strbuf path = STRBUF_INIT;
>   
>   	strbuf_add(&path, state->base_dir, state->base_dir_len);
> -	strbuf_add(&path, ci->ce->name, ce_namelen(ci->ce));
> +	strbuf_add(&path, ci->ce->name, ci->ce->ce_namelen);
>   
>   	/*
>   	 * At this point, leading dirs should have already been created. But if
> @@ -311,30 +298,214 @@ static void write_checkout_item(struct checkout *state, struct checkout_item *ci
>   	strbuf_release(&path);
>   }
>   
> -static int run_checkout_sequentially(struct checkout *state)
> +static void send_one_item(int fd, struct checkout_item *ci)
> +{
> +	size_t len_data;
> +	char *data, *variant;
> +	struct ci_fixed_portion *fixed_portion;
> +	const char *working_tree_encoding = ci->ca.working_tree_encoding;
> +	size_t name_len = ci->ce->ce_namelen;
> +	size_t working_tree_encoding_len = working_tree_encoding ?
> +					   strlen(working_tree_encoding) : 0;
> +
> +	len_data = sizeof(struct ci_fixed_portion) + name_len +
> +		   working_tree_encoding_len;
> +
> +	data = xcalloc(1, len_data);
> +
> +	fixed_portion = (struct ci_fixed_portion *)data;
> +	fixed_portion->id = ci->id;
> +	oidcpy(&fixed_portion->oid, &ci->ce->oid);
> +	fixed_portion->ce_mode = ci->ce->ce_mode;
> +	fixed_portion->attr_action = ci->ca.attr_action;
> +	fixed_portion->crlf_action = ci->ca.crlf_action;
> +	fixed_portion->ident = ci->ca.ident;
> +	fixed_portion->name_len = name_len;
> +	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
> +
> +	variant = data + sizeof(*fixed_portion);
> +	if (working_tree_encoding_len) {
> +		memcpy(variant, working_tree_encoding, working_tree_encoding_len);
> +		variant += working_tree_encoding_len;
> +	}
> +	memcpy(variant, ci->ce->name, name_len);
> +
> +	packet_write(fd, data, len_data);
> +
> +	free(data);
> +}
> +
> +static void send_batch(int fd, size_t start, size_t nr)
>   {
>   	size_t i;
> +	for (i = 0; i < nr; ++i)
> +		send_one_item(fd, &parallel_checkout->items[start + i]);
> +	packet_flush(fd);
> +}
>   
> -	for (i = 0; i < parallel_checkout->nr; ++i) {
> -		struct checkout_item *ci = &parallel_checkout->items[i];
> -		write_checkout_item(state, ci);
> +static struct child_process *setup_workers(struct checkout *state, int num_workers)
> +{
> +	struct child_process *workers;
> +	int i, workers_with_one_extra_item;
> +	size_t base_batch_size, next_to_assign = 0;
> +
> +	base_batch_size = parallel_checkout->nr / num_workers;
> +	workers_with_one_extra_item = parallel_checkout->nr % num_workers;
> +	ALLOC_ARRAY(workers, num_workers);
> +
> +	for (i = 0; i < num_workers; ++i) {
> +		struct child_process *cp = &workers[i];
> +		size_t batch_size = base_batch_size;
> +
> +		child_process_init(cp);
> +		cp->git_cmd = 1;
> +		cp->in = -1;
> +		cp->out = -1;
> +		strvec_push(&cp->args, "checkout--helper");
> +		if (state->base_dir_len)
> +			strvec_pushf(&cp->args, "--prefix=%s", state->base_dir);
> +		if (start_command(cp))
> +			die(_("failed to spawn checkout worker"));

We should consider splitting this loop into one to start the helpers
and another loop to later send them their assignments.  This would
better hide the process startup costs.

When comparing this version with my pc-p4-core branch on Windows,
I was seeing a delay of 0.8 seconds between each helper process
getting started.  And on my version a delay of 0.2 between them.

I was testing with a huge repo and the batch size was ~200k, so it
foreground process was stuck in send_batch() for a while before it
could start the next helper process.

It still takes the same amount of time to send each batch, but
the 2nd thru nth helpers can be starting while we are sending the
batch to the 1st helper.  (This might just be a Windows issue because
of how slow process creation is on Windows....)

We could maybe also save a little time splitting the batches
across the helpers, but that's a refinement for later...

> +
> +		/* distribute the extra work evenly */
> +		if (i < workers_with_one_extra_item)
> +			batch_size++;
> +
> +		send_batch(cp->in, next_to_assign, batch_size);
> +		next_to_assign += batch_size;
>   	}
>   
> +	return workers;
> +}
> +
> +static void finish_workers(struct child_process *workers, int num_workers)
> +{
> +	int i;
> +	for (i = 0; i < num_workers; ++i) {
> +		struct child_process *w = &workers[i];
> +		if (w->in >= 0)
> +			close(w->in);
> +		if (w->out >= 0)
> +			close(w->out);

You might also consider splitting this loop too.  The net-net here
is that the foreground process closes the handle to the child and
waits for the child to exit -- which it will because it get EOF on
its stdin.

But the foreground process is stuck in a wait() for it to do so.

You could make finish_workers() just call close() on all the child
handles and then have an atexit() handler to actually wait() and
reap them.  This would let the children exit asynchronously (while
the caller here in the foreground process is updating the index
on disk, for example).


> +		if (finish_command(w))
> +			die(_("checkout worker finished with error"));
> +	}
> +	free(workers);
> +}
> +
> +static void parse_and_save_result(const char *line, int len)
> +{
> +	struct ci_result *res;
> +	struct checkout_item *ci;
> +
> +	/*
> +	 * Worker should send either the full result struct or just the base
> +	 * (i.e. no stat data).
> +	 */
> +	if (len != ci_result_base_size() && len != sizeof(struct ci_result))
> +		BUG("received corrupted item from checkout worker");
> +
> +	res = (struct ci_result *)line;
> +
> +	if (res->id > parallel_checkout->nr)
> +		BUG("checkout worker sent unknown item id");
> +
> +	ci = &parallel_checkout->items[res->id];
> +	ci->status = res->status;
> +
> +	/*
> +	 * Worker only sends stat data on success. Otherwise, we *cannot* access
> +	 * res->st as that will be an invalid address.
> +	 */
> +	if (res->status == CI_SUCCESS)
> +		ci->st = res->st;
> +}
> +
> +static void gather_results_from_workers(struct child_process *workers,
> +					int num_workers)
> +{
> +	int i, active_workers = num_workers;
> +	struct pollfd *pfds;
> +
> +	CALLOC_ARRAY(pfds, num_workers);
> +	for (i = 0; i < num_workers; ++i) {
> +		pfds[i].fd = workers[i].out;
> +		pfds[i].events = POLLIN;
> +	}
> +
> +	while (active_workers) {
> +		int nr = poll(pfds, num_workers, -1);
> +
> +		if (nr < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			die_errno("failed to poll checkout workers");
> +		}
> +
> +		for (i = 0; i < num_workers && nr > 0; ++i) {
> +			struct pollfd *pfd = &pfds[i];
> +
> +			if (!pfd->revents)
> +				continue;
> +
> +			if (pfd->revents & POLLIN) {
> +				int len;
> +				const char *line = packet_read_line(pfd->fd, &len);
> +
> +				if (!line) {
> +					pfd->fd = -1;
> +					active_workers--;
> +				} else {
> +					parse_and_save_result(line, len);
> +				}
> +			} else if (pfd->revents & POLLHUP) {
> +				pfd->fd = -1;
> +				active_workers--;
> +			} else if (pfd->revents & (POLLNVAL | POLLERR)) {
> +				die(_("error polling from checkout worker"));
> +			}
> +
> +			nr--;
> +		}
> +	}
> +
> +	free(pfds);
> +}
> +
> +static int run_checkout_sequentially(struct checkout *state)
> +{
> +	size_t i;
> +	for (i = 0; i < parallel_checkout->nr; ++i)
> +		write_checkout_item(state, &parallel_checkout->items[i]);
>   	return handle_results(state);
>   }
>   
> +static const int workers_threshold = 0;
>   
>   int run_parallel_checkout(struct checkout *state)
>   {
> -	int ret;
> +	int num_workers = online_cpus();
> +	int ret = 0;
> +	struct child_process *workers;
>   
>   	if (!parallel_checkout)
>   		BUG("cannot run parallel checkout: not initialized yet");
>   
>   	pc_status = PC_RUNNING;
>   
> -	ret = run_checkout_sequentially(state);
> +	if (parallel_checkout->nr == 0) {
> +		goto done;
> +	} else if (parallel_checkout->nr < workers_threshold || num_workers == 1) {
> +		ret = run_checkout_sequentially(state);
> +		goto done;
> +	}
> +
> +	workers = setup_workers(state, num_workers);
> +	gather_results_from_workers(workers, num_workers);
> +	finish_workers(workers, num_workers);
> +	ret = handle_results(state);
>   
> +done:
>   	finish_parallel_checkout();
>   	return ret;
>   }
> diff --git a/parallel-checkout.h b/parallel-checkout.h
> index 8eef59ffcd..f25f2874ae 100644
> --- a/parallel-checkout.h
> +++ b/parallel-checkout.h
> @@ -1,10 +1,21 @@
>   #ifndef PARALLEL_CHECKOUT_H
>   #define PARALLEL_CHECKOUT_H
>   
> -struct cache_entry;
> -struct checkout;
> -struct conv_attrs;
> +#include "entry.h"
> +#include "convert.h"
>   
> +/****************************************************************
> + * Users of parallel checkout
> + ****************************************************************/
> +
> +enum pc_status {
> +	PC_UNINITIALIZED = 0,
> +	PC_ACCEPTING_ENTRIES,
> +	PC_RUNNING,
> +	PC_HANDLING_RESULTS,
> +};
> +
> +enum pc_status parallel_checkout_status(void);
>   void init_parallel_checkout(void);
>   
>   /*
> @@ -14,7 +25,62 @@ void init_parallel_checkout(void);
>    */
>   int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
>   
> -/* Write all the queued entries, returning 0 on success.*/
> +/* Write all the queued entries, returning 0 on success. */
>   int run_parallel_checkout(struct checkout *state);
>   
> +/****************************************************************
> + * Interface with checkout--helper
> + ****************************************************************/
> +
> +enum ci_status {
> +	CI_PENDING = 0,
> +	CI_SUCCESS,
> +	CI_RETRY,
> +	CI_FAILED,
> +};
> +
> +struct checkout_item {
> +	/*
> +	 * In main process ce points to a istate->cache[] entry. Thus, it's not
> +	 * owned by us. In workers they own the memory, which *must be* released.
> +	 */
> +	struct cache_entry *ce;
> +	struct conv_attrs ca;
> +	size_t id; /* position in parallel_checkout->items[] of main process */
> +
> +	/* Output fields, sent from workers. */
> +	enum ci_status status;
> +	struct stat st;
> +};
> +
> +/*
> + * The fixed-size portion of `struct checkout_item` that is sent to the workers.
> + * Following this will be 2 strings: ca.working_tree_encoding and ce.name; These
> + * are NOT null terminated, since we have the size in the fixed portion.
> + */
> +struct ci_fixed_portion {
> +	size_t id;
> +	struct object_id oid;
> +	unsigned int ce_mode;
> +	enum crlf_action attr_action;
> +	enum crlf_action crlf_action;
> +	int ident;
> +	size_t working_tree_encoding_len;
> +	size_t name_len;
> +};
> +
> +/*
> + * The `struct checkout_item` fields returned by the workers. The order is
> + * important here, specially stat being the last one, as it is omitted on error.
> + */
> +struct ci_result {
> +	size_t id;
> +	enum ci_status status;
> +	struct stat st;
> +};
> +
> +#define ci_result_base_size() offsetof(struct ci_result, st)
> +
> +void write_checkout_item(struct checkout *state, struct checkout_item *ci);
> +
>   #endif /* PARALLEL_CHECKOUT_H */
> 
