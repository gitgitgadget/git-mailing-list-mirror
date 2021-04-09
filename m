Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D53C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7AF600D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 15:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhDIPAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 11:00:45 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:14767 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhDIPAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 11:00:43 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lUscV-0006qf-FD; Fri, 09 Apr 2021 16:00:28 +0100
Subject: Re: [PATCH v3 8/8] rev-list: allow filtering of provided items
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover.1615813673.git.ps@pks.im> <cover.1617967252.git.ps@pks.im>
 <796606f32b3ffc286a3157312d00ee0ee3e5600c.1617967252.git.ps@pks.im>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <8788dbca-3caf-e9d6-7995-b09e276d1609@iee.email>
Date:   Fri, 9 Apr 2021 16:00:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <796606f32b3ffc286a3157312d00ee0ee3e5600c.1617967252.git.ps@pks.im>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

typo nit.
On 09/04/2021 12:28, Patrick Steinhardt wrote:
> When providing an object filter, it is currently impossible to also
> filter provided items. E.g. when executing `git rev-list HEAD` , the
> commit this reference points to will be treated as user-provided and is
> thus excluded from the filtering mechanism. This makes it harder than
> necessary to properly use the new `--filter=object:type` filter given
> that even if the user wants to only see blobs, he'll still see commits
> of provided references.
>
> Improve this by introducing a new `--filter-provided` option to the
s/--filter-provided/--filter-provided-revisions/

Also in some tests - I presume the option should be spelled out in full.

> git-rev-parse(1) command. If given, then all user-provided references
> will be subject to filtering.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/rev-list-options.txt  |  5 ++++
>  builtin/pack-objects.c              |  2 +-
>  builtin/rev-list.c                  | 36 +++++++++++++++++++++--------
>  pack-bitmap.c                       |  6 +++--
>  pack-bitmap.h                       |  3 ++-
>  reachable.c                         |  2 +-
>  t/t6112-rev-list-filters-objects.sh | 28 ++++++++++++++++++++++
>  t/t6113-rev-list-bitmap-filters.sh  | 36 +++++++++++++++++++++++++++++
>  8 files changed, 104 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 3afa8fffbd..7fa18fc6e6 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -933,6 +933,11 @@ equivalent.
>  --no-filter::
>  	Turn off any previous `--filter=` argument.
>  
> +--filter-provided-revisions::
> +	Filter the list of explicitly provided revisions, which would otherwise
> +	always be printed even if they did not match any of the filters. Only
> +	useful with `--filter=`.
> +
>  --filter-print-omitted::
>  	Only useful with `--filter=`; prints a list of the objects omitted
>  	by the filter.  Object IDs are prefixed with a ``~'' character.
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 525c2d8552..2f2026dc87 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3516,7 +3516,7 @@ static int pack_options_allow_reuse(void)
>  
>  static int get_object_list_from_bitmap(struct rev_info *revs)
>  {
> -	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options)))
> +	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
>  		return -1;
>  
>  	if (pack_options_allow_reuse() &&
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index b4d8ea0a35..13f0ff3f8d 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -398,7 +398,8 @@ static inline int parse_missing_action_value(const char *value)
>  }
>  
>  static int try_bitmap_count(struct rev_info *revs,
> -			    struct list_objects_filter_options *filter)
> +			    struct list_objects_filter_options *filter,
> +			    int filter_provided_revs)
>  {
>  	uint32_t commit_count = 0,
>  		 tag_count = 0,
> @@ -433,7 +434,7 @@ static int try_bitmap_count(struct rev_info *revs,
>  	 */
>  	max_count = revs->max_count;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, filter);
> +	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_revs);
>  	if (!bitmap_git)
>  		return -1;
>  
> @@ -450,7 +451,8 @@ static int try_bitmap_count(struct rev_info *revs,
>  }
>  
>  static int try_bitmap_traversal(struct rev_info *revs,
> -				struct list_objects_filter_options *filter)
> +				struct list_objects_filter_options *filter,
> +				int filter_provided_revs)
>  {
>  	struct bitmap_index *bitmap_git;
>  
> @@ -461,7 +463,7 @@ static int try_bitmap_traversal(struct rev_info *revs,
>  	if (revs->max_count >= 0)
>  		return -1;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, filter);
> +	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_revs);
>  	if (!bitmap_git)
>  		return -1;
>  
> @@ -471,14 +473,15 @@ static int try_bitmap_traversal(struct rev_info *revs,
>  }
>  
>  static int try_bitmap_disk_usage(struct rev_info *revs,
> -				 struct list_objects_filter_options *filter)
> +				 struct list_objects_filter_options *filter,
> +				 int filter_provided_revs)
>  {
>  	struct bitmap_index *bitmap_git;
>  
>  	if (!show_disk_usage)
>  		return -1;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, filter);
> +	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_revs);
>  	if (!bitmap_git)
>  		return -1;
>  
> @@ -499,6 +502,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	int bisect_show_vars = 0;
>  	int bisect_find_all = 0;
>  	int use_bitmap_index = 0;
> +	int filter_provided_revs = 0;
>  	const char *show_progress = NULL;
>  
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
> @@ -599,6 +603,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			list_objects_filter_set_no_filter(&filter_options);
>  			continue;
>  		}
> +		if (!strcmp(arg, "--filter-provided-revisions")) {
> +			filter_provided_revs = 1;
> +			continue;
> +		}
>  		if (!strcmp(arg, "--filter-print-omitted")) {
>  			arg_print_omitted = 1;
>  			continue;
> @@ -665,11 +673,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		progress = start_delayed_progress(show_progress, 0);
>  
>  	if (use_bitmap_index) {
> -		if (!try_bitmap_count(&revs, &filter_options))
> +		if (!try_bitmap_count(&revs, &filter_options, filter_provided_revs))
>  			return 0;
> -		if (!try_bitmap_disk_usage(&revs, &filter_options))
> +		if (!try_bitmap_disk_usage(&revs, &filter_options, filter_provided_revs))
>  			return 0;
> -		if (!try_bitmap_traversal(&revs, &filter_options))
> +		if (!try_bitmap_traversal(&revs, &filter_options, filter_provided_revs))
>  			return 0;
>  	}
>  
> @@ -694,6 +702,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			return show_bisect_vars(&info, reaches, all);
>  	}
>  
> +	if (filter_provided_revs) {
> +		struct commit_list *c;
> +		for (i = 0; i < revs.pending.nr; i++) {
> +			struct object_array_entry *pending = revs.pending.objects + i;
> +			pending->item->flags |= NOT_USER_GIVEN;
> +		}
> +		for (c = revs.commits; c; c = c->next)
> +			c->item->object.flags |= NOT_USER_GIVEN;
> +	}
> +
>  	if (arg_print_omitted)
>  		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
>  	if (arg_missing_action == MA_PRINT)
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 4385f15828..0576a19a28 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1009,7 +1009,8 @@ static int can_filter_bitmap(struct list_objects_filter_options *filter)
>  }
>  
>  struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
> -					 struct list_objects_filter_options *filter)
> +					 struct list_objects_filter_options *filter,
> +					 int filter_provided_revs)
>  {
>  	unsigned int i;
>  
> @@ -1104,7 +1105,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  	if (haves_bitmap)
>  		bitmap_and_not(wants_bitmap, haves_bitmap);
>  
> -	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
> +	filter_bitmap(bitmap_git, (filter && filter_provided_revs) ? NULL : wants,
> +		      wants_bitmap, filter);
>  
>  	bitmap_git->result = wants_bitmap;
>  	bitmap_git->haves = haves_bitmap;
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 36d99930d8..5d8ae3b590 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -50,7 +50,8 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
>  				 show_reachable_fn show_reachable);
>  void test_bitmap_walk(struct rev_info *revs);
>  struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
> -					 struct list_objects_filter_options *filter);
> +					 struct list_objects_filter_options *filter,
> +					 int filter_provided_revs);
>  int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
>  				       struct packed_git **packfile,
>  				       uint32_t *entries,
> diff --git a/reachable.c b/reachable.c
> index 77a60c70a5..fc833cae43 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -223,7 +223,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  	cp.progress = progress;
>  	cp.count = 0;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, NULL);
> +	bitmap_git = prepare_bitmap_walk(revs, NULL, 0);
>  	if (bitmap_git) {
>  		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
>  		free_bitmap_index(bitmap_git);
> diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
> index c79ec04060..47c558ab0e 100755
> --- a/t/t6112-rev-list-filters-objects.sh
> +++ b/t/t6112-rev-list-filters-objects.sh
> @@ -207,6 +207,34 @@ test_expect_success 'verify object:type=tag prints tag' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'verify object:type=blob prints only blob with --filter-provided' '
> +	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >expected &&
> +	git -C object-type rev-list --objects \
> +		--filter=object:type=blob --filter-provided HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'verify object:type=tree prints only tree with --filter-provided' '
> +	printf "%s \n" $(git -C object-type rev-parse HEAD^{tree}) >expected &&
> +	git -C object-type rev-list --objects \
> +		--filter=object:type=tree HEAD --filter-provided >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'verify object:type=commit prints only commit with --filter-provided' '
> +	git -C object-type rev-parse HEAD >expected &&
> +	git -C object-type rev-list --objects \
> +		--filter=object:type=commit --filter-provided HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'verify object:type=tag prints only tag with --filter-provided' '
> +	printf "%s tag\n" $(git -C object-type rev-parse tag) >expected &&
> +	git -C object-type rev-list --objects \
> +		--filter=object:type=tag --filter-provided tag >actual &&
> +	test_cmp expected actual
> +'
> +
>  # Test sparse:path=<path> filter.
>  # !!!!
>  # NOTE: sparse:path filter support has been dropped for security reasons,
> diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
> index cb9db7df6f..9053ac5059 100755
> --- a/t/t6113-rev-list-bitmap-filters.sh
> +++ b/t/t6113-rev-list-bitmap-filters.sh
> @@ -98,6 +98,28 @@ test_expect_success 'object:type filter' '
>  	test_bitmap_traversal expect actual
>  '
>  
> +test_expect_success 'object:type filter with --filter-provided' '
> +	git rev-list --objects --filter-provided --filter=object:type=tag tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter-provided --filter=object:type=tag tag >actual &&
> +	test_cmp expect actual &&
> +
> +	git rev-list --objects --filter-provided --filter=object:type=commit tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter-provided --filter=object:type=commit tag >actual &&
> +	test_bitmap_traversal expect actual &&
> +
> +	git rev-list --objects --filter-provided --filter=object:type=tree tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter-provided --filter=object:type=tree tag >actual &&
> +	test_bitmap_traversal expect actual &&
> +
> +	git rev-list --objects --filter-provided --filter=object:type=blob tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter-provided --filter=object:type=blob tag >actual &&
> +	test_bitmap_traversal expect actual
> +'
> +
>  test_expect_success 'combine filter' '
>  	git rev-list --objects --filter=blob:limit=1000 --filter=object:type=blob tag >expect &&
>  	git rev-list --use-bitmap-index \
> @@ -105,4 +127,18 @@ test_expect_success 'combine filter' '
>  	test_bitmap_traversal expect actual
>  '
>  
> +test_expect_success 'combine filter with --filter-provided' '
> +	git rev-list --objects --filter-provided --filter=blob:limit=1000 --filter=object:type=blob tag >expect &&
> +	git rev-list --use-bitmap-index \
> +		     --objects --filter-provided --filter=blob:limit=1000 --filter=object:type=blob tag >actual &&
> +	test_bitmap_traversal expect actual &&
> +
> +	git cat-file --batch-check="%(objecttype) %(objectsize)" <actual >objects &&
> +	while read objecttype objectsize
> +	do
> +		test "$objecttype" = blob || return 1
> +		test "$objectsize" -le 1000 || return 1
> +	done <objects
> +'
> +
>  test_done

