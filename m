Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C421F461
	for <e@80x24.org>; Mon, 13 May 2019 03:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfEMDNX (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 23:13:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54655 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEMDNX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 23:13:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAF936578E;
        Sun, 12 May 2019 23:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsXo3kZaVgKS5+gVaWquCO4Qung=; b=k3Ls2x
        ZwQinoq6/fnI+09E32xAK/jqUQ0b6eK/XmlU050IBh1e++4x9iIpTYTDBHv/DSz6
        KWq4u/+jBL/5jtMRg8qNRM3ScblGUJbuDjH0QN7uzts+BVvvTaSsjKMXpZEB9SFS
        O2k3tf+kDwZBfFKYzcFwPMS178RL/zYcxoZ44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uBfq89IojDSt2MHqI4J1huM3hINS0BrR
        Nr4l29FCNcYfbX/TNM2yVRYzhY8OpbGZ/wmN9vHNlz7428TErtYRFsiVexIXkvtZ
        3pjfomcBBPTf/GVavMP53NCNdxacp7i+PcIW2f6qovcCF3ScD3Rvj7NqbbYxCuCu
        tmDGb/GDfqk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D37526578D;
        Sun, 12 May 2019 23:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0BA156578A;
        Sun, 12 May 2019 23:13:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 02/11] commit-graph: return with errors during write
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
        <a4082b827eb1999f6e46780b4147962d6dd87975.1557411749.git.gitgitgadget@gmail.com>
Date:   Mon, 13 May 2019 12:13:15 +0900
In-Reply-To: <a4082b827eb1999f6e46780b4147962d6dd87975.1557411749.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 09 May 2019
        07:22:32 -0700 (PDT)")
Message-ID: <xmqq36ljdp2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E04240A-752D-11E9-B97D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The write_commit_graph() method uses die() to report failure and
> exit when confronted with an unexpected condition. This use of
> die() in a library function is incorrect and is now replaced by
> error() statements and an int return type.

OK.

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 537fdfd0f0..2e86251f02 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -141,6 +141,7 @@ static int graph_write(int argc, const char **argv)
>  	struct string_list *pack_indexes = NULL;
>  	struct string_list *commit_hex = NULL;
>  	struct string_list lines;
> +	int result;
>  
>  	static struct option builtin_commit_graph_write_options[] = {
>  		OPT_STRING(0, "object-dir", &opts.obj_dir,
> @@ -168,10 +169,8 @@ static int graph_write(int argc, const char **argv)
>  
>  	read_replace_refs = 0;
>  
> -	if (opts.reachable) {
> -		write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
> -		return 0;
> -	}
> +	if (opts.reachable)
> +		return write_commit_graph_reachable(opts.obj_dir, opts.append, 1);
>  
>  	string_list_init(&lines, 0);
>  	if (opts.stdin_packs || opts.stdin_commits) {
> @@ -188,14 +187,14 @@ static int graph_write(int argc, const char **argv)
>  		UNLEAK(buf);
>  	}
>  
> -	write_commit_graph(opts.obj_dir,
> -			   pack_indexes,
> -			   commit_hex,
> -			   opts.append,
> -			   1);
> +	result = write_commit_graph(opts.obj_dir,
> +				    pack_indexes,
> +				    commit_hex,
> +				    opts.append,
> +				    1);
>  
>  	UNLEAK(lines);
> -	return 0;
> +	return result;
>  }

What were the error values this function used to return?  I am
wondering if the callers of this function are prepraed to see the
returned values from write_commit_graph() this function stores in
'result' (which presumably are small negative value like our usual
internal API convention)?


> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2986553d5f..b9ea7222fa 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1669,8 +1669,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		      "new_index file. Check that disk is not full and quota is\n"
>  		      "not exceeded, and then \"git reset HEAD\" to recover."));
>  
> -	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
> -		write_commit_graph_reachable(get_object_directory(), 0, 0);
> +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
> +	    write_commit_graph_reachable(get_object_directory(), 0, 0))
> +		return 1;

This is good.  An error signalled as a small negative integer would
not seep thru to the exit status but is explicitly turned into 1
with this change.

> +	if (gc_write_commit_graph &&
> +	    write_commit_graph_reachable(get_object_directory(), 0,
> +					 !quiet && !daemonized))
> +		return 1;

Ditto.

> +int write_commit_graph_reachable(const char *obj_dir, int append,
> +				 int report_progress)
>  {
>  	struct string_list list = STRING_LIST_INIT_DUP;
> +	int result;
>  
>  	for_each_ref(add_ref_to_list, &list);
> -	write_commit_graph(obj_dir, NULL, &list, append, report_progress);
> +	result = write_commit_graph(obj_dir, NULL, &list,
> +				    append, report_progress);
>  
>  	string_list_clear(&list, 0);
> +	return result;
>  }

OK.  The callers of write_commit_graph_reachable() can be careful
about its return values to the same degree as the callers of
write_commit_graph().

These functions perhaps deserves
/*
 * returns X when ....
 */
in front (or in *.h)?

> +int write_commit_graph(const char *obj_dir,
> +		       struct string_list *pack_indexes,
> +		       struct string_list *commit_hex,
> +		       int append, int report_progress)
>  {
>  	struct packed_oid_list oids;
>  	struct packed_commit_list commits;
>  	struct hashfile *f;
>  	uint32_t i, count_distinct = 0;
> -	char *graph_name;
> +	char *graph_name = NULL;
>  	struct lock_file lk = LOCK_INIT;
>  	uint32_t chunk_ids[5];
>  	uint64_t chunk_offsets[5];
> @@ -883,15 +886,17 @@ void write_commit_graph(const char *obj_dir,
>  	uint64_t progress_cnt = 0;
>  	struct strbuf progress_title = STRBUF_INIT;
>  	unsigned long approx_nr_objects;
> +	int res = 0;
>  
>  	if (!commit_graph_compatible(the_repository))
> -		return;
> +		return 0;

OK.  I tend to find "return 0" easier to read/follow than "return
res" here.

>  	oids.nr = 0;
>  	approx_nr_objects = approximate_object_count();
>  	oids.alloc = approx_nr_objects / 32;
>  	oids.progress = NULL;
>  	oids.progress_done = 0;
> +	commits.list = NULL;
>  
>  	if (append) {
>  		prepare_commit_graph_one(the_repository, obj_dir);
> @@ -932,10 +937,16 @@ void write_commit_graph(const char *obj_dir,
>  			strbuf_setlen(&packname, dirlen);
>  			strbuf_addstr(&packname, pack_indexes->items[i].string);
>  			p = add_packed_git(packname.buf, packname.len, 1);
> -			if (!p)
> -				die(_("error adding pack %s"), packname.buf);
> -			if (open_pack_index(p))
> -				die(_("error opening index for %s"), packname.buf);
> +			if (!p) {
> +				error(_("error adding pack %s"), packname.buf);
> +				res = 1;
> +				goto cleanup;
> +			}
> +			if (open_pack_index(p)) {
> +				error(_("error opening index for %s"), packname.buf);
> +				res = 1;
> +				goto cleanup;
> +			}

Hmph, is this signal an error by returning a positive "1"?  That's a
bit unusual.

> @@ -1006,8 +1017,11 @@ void write_commit_graph(const char *obj_dir,
>  	}
>  	stop_progress(&progress);
>  
> -	if (count_distinct >= GRAPH_EDGE_LAST_MASK)
> -		die(_("the commit graph format cannot write %d commits"), count_distinct);
> +	if (count_distinct >= GRAPH_EDGE_LAST_MASK) {
> +		error(_("the commit graph format cannot write %d commits"), count_distinct);
> +		res = 1;
> +		goto cleanup;
> +	}
>  
>  	commits.nr = 0;
>  	commits.alloc = count_distinct;
> @@ -1039,16 +1053,21 @@ void write_commit_graph(const char *obj_dir,
>  	num_chunks = num_extra_edges ? 4 : 3;
>  	stop_progress(&progress);
>  
> -	if (commits.nr >= GRAPH_EDGE_LAST_MASK)
> -		die(_("too many commits to write graph"));
> +	if (commits.nr >= GRAPH_EDGE_LAST_MASK) {
> +		error(_("too many commits to write graph"));
> +		res = 1;
> +		goto cleanup;
> +	}
>  
>  	compute_generation_numbers(&commits, report_progress);
>  
>  	graph_name = get_commit_graph_filename(obj_dir);
>  	if (safe_create_leading_directories(graph_name)) {
>  		UNLEAK(graph_name);
> -		die_errno(_("unable to create leading directories of %s"),
> -			  graph_name);
> +		error(_("unable to create leading directories of %s"),
> +			graph_name);
> +		res = errno;
> +		goto cleanup;
>  	}

Hmph.  Do we know errno==0 means no error everywhere?  Do we know
errno==1 is not used by anybody as a meaningful value?

What I am getting at is if a hardcoded "1" we saw above as "error
exists but we are not telling the caller what kind of system-level
error led to it by returning errno" (and a hardcoded "0" as "there
is no error") are consistent with this use of "res" where "the
callers are allowed to learn what system-level error led to this
error return from this function by sending the return value of this
function to strerror() or comparing with EWHATEVER".  I do not think
this is a good design.

