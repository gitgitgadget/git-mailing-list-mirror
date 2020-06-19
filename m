Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFDAC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0F321548
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bO3AIu6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbgFST2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:28:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50477 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbgFST2V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:28:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB56BC9EC7;
        Fri, 19 Jun 2020 15:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KcmSj7BKI6C8
        SB9zBZEHu8r1FBE=; b=bO3AIu6mZ+qEQ3xu+Q+IMjVO8XEKojug0GuAZXV73wIf
        ml8tBAy9NM4oPdsBax93SjYDrR7wVTKvFx253kUcvrbpGVdk5L1UPTSwsPBiCkq7
        HeWNPXH3U15DqWdn4tGrTyC7l//VWRl5/PZMtEQJ56hc92TvfLGaly3ezFIZaY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r4/V28
        ZUnUVfyfD1uQebncxdyMBQal2Bf0inVFTRIsfZVGsnaWjVcJPnqHNfEqekkzBKJo
        UyXO0wjXRU/RJkAgMYe/t5LLojqoynkz0coZBWv8SKNOvzUflkqgNnbnigBhS6/n
        bj1BfgGxuzXtCWPt7r2QoR3LOdOfPKog2Td3U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3002C9EC4;
        Fri, 19 Jun 2020 15:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2215BC9EC3;
        Fri, 19 Jun 2020 15:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v4 10/15] commit-graph: reuse existing Bloom filters during write
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
        <cc8022bdf82d0ada326ad546fdd7bb7801fc3675.1586192395.git.gitgitgadget@gmail.com>
        <20200619140230.GB22200@szeder.dev>
Date:   Fri, 19 Jun 2020 12:28:10 -0700
In-Reply-To: <20200619140230.GB22200@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 19 Jun 2020 16:02:30 +0200")
Message-ID: <xmqqmu4yhn3p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03AF01D6-B263-11EA-9BD5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Note that this is not the settings instance that eventually gets
> written to the header of the Bloom filters chunk:
> write_commit_graph_file() has its own 'struct bloom_filter_settings'
> instance, and that's the one that goes into the chunk header.
> ...
> Unfortunately, the parameters used to compute the now reused Bloom
> filters are not checked anywhere.  In fact this writing process
> entirely ignores all parameters in the header of the existing Bloom
> filters chunk, and simply replaces them with the default parameters
> hard-coded in write_commit_graph_file().  Consequently, we can end up
> with Bloom filters computed with different parameters in the same
> commit-graph file, which, in turn, can result in commits omitted from
> the output of pathspec-limited revision walks.

Yeah, the whole design seems quite broken and as you said later,
mixing other ingredients like split file would only make things
worse X-<.

> The makeshift (there is no way to override those hard-coded defaults)
> tests below demonstrate this issue.
>
> This issue raises a good couple of questions:
>
>   - What should we do when updating a commit-graph that was written
>     with different Bloom filter parameters than our hardcoded
>     defaults?
>
>     Reusing the exising Bloom filters is clearly wrong.  Throwing away
>     all existing Bloom filters and recomputing them with our defaults
>     parameters doesn't seem to be good option, because that's a
>     considerable amount of work, and the user might have a reason to
>     chose those parameters.
>
>   - What should we do when updating a commit-graph that was written
>     with different Bloom filter parameters than specified by the user
>     on the command line or in the config?
>
>     Wipe out the old Bloom filters and recompute with new parameters,
>     spending considerable time in bigger repositories?  Or stop with a
>     warning about the different parameters (maybe it's just a typo),
>     and require '--force'?
>    =20
>     Dunno, and we don't have such options and configuration yet
>     anyway.
>
>   - What about split commit-graphs?
>
>     When split commit-graphs were introduced there was not a single
>     chunk that had its own header.  Now the Bloom filters chunk does
>     have a header, which leads to other questions:
>
>     - Should that Bloom filters header be included in every split
>       commit-graph?
>
>       Not sure, but I suppose that having a header in each split
>       commit-graph file would make loading and parsing that chunk a
>       bit simpler, because all of them should be parsed the same way.
>       Anyway, I think the specs should be explicit about it.  But...:
>
>     - Should we allow different parameters in the Bloom filter chunks
>       in each split commit-graph?
>
>       The point of split commit-graphs is to avoid the overhead of
>       re-writing the whole commit-graph file every time new commits
>       are added, and it's crucial that both writing and merging split
>       commit-graph files are cheap.  However, split commit-graph files
>       using different Bloom filter parameters can't be merged without
>       recomputing those Bloom filters, making merging quite expensive.
>
>       So I don't think that it's a good idea to allow different Bloom
>       filter parameters in split commit-graphs.  But then perhaps it
>       would be better not to have a Bloom filter chunk header in all
>       split commit-graph files after all.
>
>     In any case, the last test below shows that the Bloom filter
>     parameters are only read from the header of the most recent split
>     commit-graph file.
>
>
>   ---  >8  ---
>
> #!/bin/sh
>
> test_description=3D'test'
>
> . ./test-lib.sh
>
> test_expect_success 'yuckiest setup ever!' '
> 	(
> 		cd "$GIT_BUILD_DIR" &&
>
> 		# The number of hashes per path cannot be configured
> 		# at runtime, so build a dedicated git binary that
> 		# writes Bloom filters using only 6 hashes per path.
> 		sed -i -e "/DEFAULT_BLOOM_FILTER_SETTINGS/ s/7/6/" bloom.h &&
> 		make -j4 git &&
> 		cp git git6 &&
>
> 		# Revert, rebuild.
> 		sed -i -e "/DEFAULT_BLOOM_FILTER_SETTINGS/ s/6/7/" bloom.h &&
> 		make -j4 git
> 	) &&
> 	git6=3D"$GIT_BUILD_DIR"/git6
> '
>
> test_expect_success 'setup' '
> 	# We need a filename whose 7th hash maps to a different bit
> 	# position than any of its first 6 hashes in a 2-byte Bloom
> 	# filter.
> 	file=3DFile &&
>
> 	test_tick &&
> 	git commit --allow-empty -m initial &&
> 	echo 1 >$file &&
> 	git add $file &&
> 	git commit -m one $file &&
> 	echo 2 >$file &&
> 	git commit -m two $file &&
>
> 	git log --oneline -- $file >expect
> '
>
> test_expect_success 'can read Bloom filters with different parameters' =
'
> 	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&
>
> 	# Write a commit-graph with Bloom filters using only 6 hashes
> 	# per path.
> 	"$git6" commit-graph write --reachable --changed-paths &&
>
> 	# Try pathspec-limited revision walk with the git binary writing
> 	# Bloom filters using 7 hashes: it still works, because no matter
> 	# how many hashes it would use when writing the commit-graph, the
> 	# reader part respects the nr of hashes stored in the
> 	# commit-graph file.  So far so good.
> 	git log --oneline $file >actual &&
> 	test_cmp expect actual
> '
>
> test_expect_failure 'commit-graph write does not reuse Bloom filters wi=
th different parameters' '
> 	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&
>
> 	# Write a commit-graph with Bloom filters using only 6 hashes
> 	# per path for a subset of commits.
> 	git rev-parse HEAD^ |
> 	"$git6" commit-graph write --stdin-commits --changed-paths &&
>
> 	# Add the rest of the commits to the commit-graph containing Bloom
> 	# filters using 6 hashes with a git version that writes Bloom
> 	# filters using 7 hashes.
> 	# Does it reuse the existing Bloom filters with 6 hashes?
> 	git commit-graph write --reachable --changed-paths &&
>
> 	# Yes, it does, because these report different filter data,
> 	# even though both commits modified the same file.
> 	test-tool bloom get_filter_for_commit $(git rev-parse HEAD^) &&
> 	test-tool bloom get_filter_for_commit $(git rev-parse HEAD) &&
>
> 	# Furthermore, it updated the Bloom filter chunk header as well,
> 	# which now stores that all Bloom filters use 7 hashes.
> 	# Consequently, the first commit whose Bloom filter was written
> 	# with only 6 hashes falls victim of a false negative, and is
> 	# omitted from the output.
> 	git log --oneline $file >actual &&
> 	test_cmp expect actual
> '
>
> test_expect_failure 'split commit-graphs and Bloom filters with differe=
nt parameters' '
> 	test_when_finished "rm -rfv .git/objects/info/commit-graph*" &&
>
> 	git rev-parse HEAD^ |
> 	"$git6" commit-graph write --stdin-commits --changed-paths --split &&
>
> 	git commit-graph write --reachable --changed-paths --split=3Dno-merge =
&&
>
> 	# To make sure that I test what I want, i.e. two commit-graphs
> 	# with one commit in each.  (Though "test-tool read-graph" is
> 	# utterly oblivious to split commit graphs...)
> 	test_line_count =3D 2 .git/objects/info/commit-graphs/commit-graph-cha=
in &&
> 	verbose test "$(test-tool read-graph |sed -n -e "s/^num_commits: //p")=
" =3D 1 &&
>
> 	test-tool bloom get_filter_for_commit $(git rev-parse HEAD^) &&
> 	test-tool bloom get_filter_for_commit $(git rev-parse HEAD) &&
>
> 	git log --oneline $file >actual &&
> 	test_cmp expect actual
> '
>
> test_done
>
>   ---  8<  ---
>
>> +	if (filter->data || !compute_if_not_present)
>> +		return filter;
>> +
>>  	repo_diff_setup(r, &diffopt);
>>  	diffopt.flags.recursive =3D 1;
>>  	diffopt.max_changes =3D max_changes;
>> diff --git a/bloom.h b/bloom.h
>> index 85ab8e9423d..760d7122374 100644
>> --- a/bloom.h
>> +++ b/bloom.h
>> @@ -32,6 +32,7 @@ struct bloom_filter_settings {
>> =20
>>  #define DEFAULT_BLOOM_FILTER_SETTINGS { 1, 7, 10 }
>>  #define BITS_PER_WORD 8
>> +#define BLOOMDATA_CHUNK_HEADER_SIZE 3 * sizeof(uint32_t)
>> =20
>>  /*
>>   * A bloom_filter struct represents a data segment to
>> @@ -79,6 +80,7 @@ void add_key_to_filter(const struct bloom_key *key,
>>  void init_bloom_filters(void);
>> =20
>>  struct bloom_filter *get_bloom_filter(struct repository *r,
>> -				      struct commit *c);
>> +				      struct commit *c,
>> +				      int compute_if_not_present);
>> =20
>>  #endif
>> \ No newline at end of file
>> diff --git a/commit-graph.c b/commit-graph.c
>> index a8b6b5cca5d..77668629e27 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -1086,7 +1086,7 @@ static void write_graph_chunk_bloom_indexes(stru=
ct hashfile *f,
>>  			ctx->commits.nr);
>> =20
>>  	while (list < last) {
>> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
>> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
>>  		cur_pos +=3D filter->len;
>>  		display_progress(progress, ++i);
>>  		hashwrite_be32(f, cur_pos);
>> @@ -1115,7 +1115,7 @@ static void write_graph_chunk_bloom_data(struct =
hashfile *f,
>>  	hashwrite_be32(f, settings->bits_per_entry);
>> =20
>>  	while (list < last) {
>> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list);
>> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, *list, 0);
>>  		display_progress(progress, ++i);
>>  		hashwrite(f, filter->data, filter->len * sizeof(unsigned char));
>>  		list++;
>> @@ -1296,7 +1296,7 @@ static void compute_bloom_filters(struct write_c=
ommit_graph_context *ctx)
>> =20
>>  	for (i =3D 0; i < ctx->commits.nr; i++) {
>>  		struct commit *c =3D sorted_commits[i];
>> -		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c);
>> +		struct bloom_filter *filter =3D get_bloom_filter(ctx->r, c, 1);
>>  		ctx->total_bloom_filter_data_size +=3D sizeof(unsigned char) * filt=
er->len;
>>  		display_progress(progress, i + 1);
>>  	}
>> diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
>> index f18d1b722e1..ce412664ba9 100644
>> --- a/t/helper/test-bloom.c
>> +++ b/t/helper/test-bloom.c
>> @@ -39,7 +39,7 @@ static void get_bloom_filter_for_commit(const struct=
 object_id *commit_oid)
>>  	struct bloom_filter *filter;
>>  	setup_git_directory();
>>  	c =3D lookup_commit(the_repository, commit_oid);
>> -	filter =3D get_bloom_filter(the_repository, c);
>> +	filter =3D get_bloom_filter(the_repository, c, 1);
>>  	print_bloom_filter(filter);
>>  }
>> =20
>> --=20
>> gitgitgadget
