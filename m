Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC8ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiH3ORN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiH3ORK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:17:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F5A6C2D
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:17:06 -0700 (PDT)
Received: from host-92-14-211-167.as13285.net ([92.14.211.167] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oT236-0005cZ-E4;
        Tue, 30 Aug 2022 15:17:05 +0100
Message-ID: <96b04fc0-eadc-af01-502a-e5236a393ac4@iee.email>
Date:   Tue, 30 Aug 2022 15:17:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 1/2] notes: support fetching notes from an external
 repo
Content-Language: en-GB
To:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Cc:     Johan Herland <johan@herland.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Christian Hesse <mail@eworm.de>
References: <20220802075401.2393-1-vegard.nossum@oracle.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220802075401.2393-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for late comment.

On 02/08/2022 08:54, Vegard Nossum wrote:
> Notes are currently always fetched from the current repo. However, in
> certain situations you may want to keep notes in a separate repository
> altogether.
>
> In my specific case, I am using cgit to display notes for repositories
> that are owned by others but hosted on a shared machine, so I cannot
> really add the notes directly to their repositories.
>
> This patch makes it so that you can do:
>
>     const char *notes_repo_path = "path/to/notes.git";
>     const char *notes_ref = "refs/notes/commits";
>
>     struct repository notes_repo;
>     struct display_notes_opt notes_opt;
>
>     repo_init(&notes_repo, notes_repo_path, NULL);
>     add_to_alternates_memory(notes_repo.objects->odb->path);
>
>     init_display_notes(&notes_opt);
>     notes_opt.repo = &notes_repo;
>     notes_opt.use_default_notes = 0;
>
>     string_list_append(&notes_opt.extra_notes_refs, notes_ref);
>     load_display_notes(&notes_opt);
>
> ...and then notes will be taken from the given ref in the external
> repository.
>
> Given that the functionality is not exposed through the command line,
> there is currently no way to add regression tests for this.
>
> Cc: Johan Herland <johan@herland.net>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Christian Hesse <mail@eworm.de>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  common-main.c |  2 ++
>  notes.c       | 15 ++++++++++++---
>  notes.h       |  3 +++
>  refs.c        | 12 +++++++++---
>  refs.h        |  2 ++
>  5 files changed, 28 insertions(+), 6 deletions(-)

Where's the documentation? Without a clarity of purpose and usage then,
for me, it doesn't fly.

I feel that underlying this there may something that's interesting, but
without the 'SPIN' narrative (situation, problem, implication, and
need-payoff) I'm not sure what it's trying to do from a broad user
perspective. (Spin is just one approach to 'selling' the patches;-)

I'd agree that Notes are 'odd' in that they are out of sequence relative
to commits, and may not be common between users viewing the same repo.
I'd like to understand the issues in a wider context.
--
Philip

>
> diff --git a/common-main.c b/common-main.c
> index c531372f3f..74b69a4632 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec-cmd.h"
>  #include "attr.h"
> +#include "notes.h"
>  
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -43,6 +44,7 @@ int main(int argc, const char **argv)
>  	git_setup_gettext();
>  
>  	initialize_the_repository();
> +	init_default_notes_repository();
>  
>  	attr_start();
>  
> diff --git a/notes.c b/notes.c
> index 7452e71cc8..90ec625192 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -73,11 +73,17 @@ struct non_note {
>  #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
>  	(memcmp(key_sha1, subtree_sha1, subtree_sha1[KEY_INDEX]))
>  
> +struct repository *default_notes_repo;
>  struct notes_tree default_notes_tree;
>  
>  static struct string_list display_notes_refs = STRING_LIST_INIT_NODUP;
>  static struct notes_tree **display_notes_trees;
>  
> +void init_default_notes_repository()
> +{
> +	default_notes_repo = the_repository;
> +}
> +
>  static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
>  		struct int_node *node, unsigned int n);
>  
> @@ -940,10 +946,10 @@ void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
>  {
>  	assert(list->strdup_strings);
>  	if (has_glob_specials(glob)) {
> -		for_each_glob_ref(string_list_add_one_ref, glob, list);
> +		repo_for_each_glob_ref_in(default_notes_repo, string_list_add_one_ref, glob, NULL, list);
>  	} else {
>  		struct object_id oid;
> -		if (get_oid(glob, &oid))
> +		if (repo_get_oid(default_notes_repo, glob, &oid))
>  			warning("notes ref %s is invalid", glob);
>  		if (!unsorted_string_list_has_string(list, glob))
>  			string_list_append(list, glob);
> @@ -1019,7 +1025,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
>  	t->dirty = 0;
>  
>  	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
> -	    get_oid_treeish(notes_ref, &object_oid))
> +	    repo_get_oid_treeish(default_notes_repo, notes_ref, &object_oid))
>  		return;
>  	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
>  		die("Cannot use notes ref %s", notes_ref);
> @@ -1088,6 +1094,9 @@ void load_display_notes(struct display_notes_opt *opt)
>  
>  	assert(!display_notes_trees);
>  
> +	if (opt->repo)
> +		default_notes_repo = opt->repo;
> +
>  	if (!opt || opt->use_default_notes > 0 ||
>  	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
>  		string_list_append(&display_notes_refs, default_notes_ref());
> diff --git a/notes.h b/notes.h
> index c1682c39a9..c7aae85ea6 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -6,6 +6,8 @@
>  struct object_id;
>  struct strbuf;
>  
> +void init_default_notes_repository();
> +
>  /*
>   * Function type for combining two notes annotating the same object.
>   *
> @@ -256,6 +258,7 @@ void free_notes(struct notes_tree *t);
>  struct string_list;
>  
>  struct display_notes_opt {
> +	struct repository *repo;
>  	int use_default_notes;
>  	struct string_list extra_notes_refs;
>  };
> diff --git a/refs.c b/refs.c
> index 90bcb27168..cf0dc85872 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -468,8 +468,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
>  	strbuf_release(&normalized_pattern);
>  }
>  
> -int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> -	const char *prefix, void *cb_data)
> +int repo_for_each_glob_ref_in(struct repository *r, each_ref_fn fn,
> +	const char *pattern, const char *prefix, void *cb_data)
>  {
>  	struct strbuf real_pattern = STRBUF_INIT;
>  	struct ref_filter filter;
> @@ -492,12 +492,18 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>  	filter.prefix = prefix;
>  	filter.fn = fn;
>  	filter.cb_data = cb_data;
> -	ret = for_each_ref(filter_refs, &filter);
> +	ret = refs_for_each_ref(get_main_ref_store(r), filter_refs, &filter);
>  
>  	strbuf_release(&real_pattern);
>  	return ret;
>  }
>  
> +int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
> +	const char *prefix, void *cb_data)
> +{
> +	return repo_for_each_glob_ref_in(the_repository, fn, pattern, prefix, cb_data);
> +}
> +
>  int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
>  {
>  	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
> diff --git a/refs.h b/refs.h
> index 47cb9edbaa..1375c8531f 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -366,6 +366,8 @@ int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
>  /* iterates all refs that match the specified glob pattern. */
>  int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>  
> +int repo_for_each_glob_ref_in(struct repository *r, each_ref_fn fn, const char *pattern,
> +			 const char *prefix, void *cb_data);
>  int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>  			 const char *prefix, void *cb_data);
>  

