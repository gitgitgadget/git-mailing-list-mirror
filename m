Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC83BC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1812085B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tiI6Qrfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIRAwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:52:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62333 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIRAwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:52:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59FAE6B052;
        Thu, 17 Sep 2020 20:52:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=snZIv9IOQu+MQ6dj9B0TXFX4uzQ=; b=tiI6Qr
        frqsCcpbTJmJ/+pzqoSN5vSRUZktn0ODaxpEa2HxmeeANcdvKQUA4DbH70BusGMt
        a3pWbSR0fIkM2CO6CTmLWr6bTFyoDf58lDJkgb0Lc44doytA8lOdDSfGN6ucEVlv
        pna9BtiAcpcL/jbL0X/nDJV+1CztP7SM/y4fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YqkJvlHzGReSWJGU9sBG44B6GWX3Uqjw
        TXwrQ1VCAzNWrg3oNjkgnPVJsnM1F4fzBsD4Q0kIlDaksUDBe0vtBxAyhSOQe1QT
        sVvmZomXYgCBZQvMxAWdtCXkXxSoHEIlVgB8JDIDV6oDkFBgDEFI4FCOUxuqWXgm
        K3hufiZ5N9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 520ED6B051;
        Thu, 17 Sep 2020 20:52:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4B2A6B050;
        Thu, 17 Sep 2020 20:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH v2 10/13] bloom: encode out-of-bounds filters as non-empty
References: <cover.1599664389.git.me@ttaylorr.com>
        <cover.1600279373.git.me@ttaylorr.com>
        <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
        <20200917221302.GC23146@szeder.dev>
        <20200917231344.GA1591704@nand.local>
Date:   Thu, 17 Sep 2020 17:52:11 -0700
In-Reply-To: <20200917231344.GA1591704@nand.local> (Taylor Blau's message of
        "Thu, 17 Sep 2020 19:13:44 -0400")
Message-ID: <xmqqo8m3oqis.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30672BE0-F949-11EA-B252-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> > In practice, these boundary commits likely occupy a small proportion of
>> > the overall number of commits, and so the size penalty is likely smaller
>> > than storing a bitmap for all commits.
>>
>>                  |      Percentage of
>>                  |    commits modifying
>>                  |   0 path   |  >= 512 paths
>>   ---------------+------------+----------------
>>   android-base   |   13.20%   |   0.13%
>>   cmssw          |    0.15%   |   0.23%
>>   cpython        |    3.07%   |   0.01%
>>   elasticsearch  |    0.70%   |   1.00%
>>   gcc            |    0.00%   |   0.08%
>>   gecko-dev      |    0.14%   |   0.64%
>>   git            |    0.11%   |   0.02%
>>   glibc          |    0.02%   |   0.10%
>>   go             |    0.00%   |   0.07%
>>   homebrew-cask  |    0.40%   |   0.02%
>>   homebrew-core  |    0.01%   |   0.01%
>>   jdk            |    0.26%   |   5.64%
>>   linux          |    0.01%   |   0.51%
>>   llvm-project   |    0.12%   |   0.03%
>>   rails          |    0.10%   |   0.10%
>>   rust           |    0.07%   |   0.17%
>>   tensorflow     |    0.09%   |   1.02%
>>   webkit         |    0.05%   |   0.31%
>
> This is very useful information to have! Without the total number of
> commits, it's impossible to know whether or not this is a win over the
> BFXL chunk. But, since the number of commits is probably "large" versus
> the percentage of boundary commits which is "small", it's almost
> certainly an advantage.

Do you want to include it in either the log message in one of the
commits, in code comment, or a technical doc?

> So, I think that if it's truly misleading, we could revisit this after
> the topic is merged. But, I'm not planning on changing anything at this
> point.

If you do not want to help us go the last-mile to completion, that
is sad, but I do not want to see a basically good patch stall like
that, so let's find somebody else who can do the helping ;-)

Here is what my trial rebase produced.  I'll queue it to 'seen' (if
you prefer I can send a full v3 patch, but I expect that you know
how to fetch from 'seen' and review locally) after checking if the
result passes the tests locally; an extra set of eyeballs to verify
the result is pretty much appreciated.

Thanks.


1:  ca6c060171 ! 1:  9b294a0c66 bloom: encode out-of-bounds filters as non-empty
    @@ Commit message
         efficient than storing a bitmap for which commits haven't computed their
         Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
         whereas storing explicit filters as above incurs a penalty of one byte
    -    per too-large or too-small commit.
    +    per too-large or empty commit.
     
         In practice, these boundary commits likely occupy a small proportion of
         the overall number of commits, and so the size penalty is likely smaller
    @@ bloom.c: struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
      		filter->len = (hashmap_get_size(&pathmap) * settings->bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
     +		if (!filter->len) {
     +			if (computed)
    -+				*computed |= BLOOM_TRUNC_SMALL;
    ++				*computed |= BLOOM_TRUNC_EMPTY;
     +			filter->len = 1;
     +		}
      		filter->data = xcalloc(filter->len, sizeof(unsigned char));
    @@ bloom.h: enum bloom_filter_computed {
      	BLOOM_NOT_COMPUTED = (1 << 0),
      	BLOOM_COMPUTED     = (1 << 1),
      	BLOOM_TRUNC_LARGE  = (1 << 2),
    -+	BLOOM_TRUNC_SMALL  = (1 << 3),
    ++	BLOOM_TRUNC_EMPTY  = (1 << 3),
      };
      
      struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
    @@ commit-graph.c: struct write_commit_graph_context {
      
      	int count_bloom_filter_computed;
      	int count_bloom_filter_not_computed;
    -+	int count_bloom_filter_trunc_small;
    ++	int count_bloom_filter_trunc_empty;
      	int count_bloom_filter_trunc_large;
      };
      
    @@ commit-graph.c: static void trace2_bloom_filter_write_statistics(struct write_co
      			   ctx->count_bloom_filter_computed);
      	trace2_data_intmax("commit-graph", ctx->r, "filter-not-computed",
      			   ctx->count_bloom_filter_not_computed);
    -+	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-small",
    -+			   ctx->count_bloom_filter_trunc_small);
    ++	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-empty",
    ++			   ctx->count_bloom_filter_trunc_empty);
      	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
      			   ctx->count_bloom_filter_trunc_large);
      }
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
      			&computed);
      		if (computed & BLOOM_COMPUTED) {
      			ctx->count_bloom_filter_computed++;
    -+			if (computed & BLOOM_TRUNC_SMALL)
    -+				ctx->count_bloom_filter_trunc_small++;
    ++			if (computed & BLOOM_TRUNC_EMPTY)
    ++				ctx->count_bloom_filter_trunc_empty++;
      			if (computed & BLOOM_TRUNC_LARGE)
      				ctx->count_bloom_filter_trunc_large++;
      		} else if (computed & BLOOM_NOT_COMPUTED)
    @@ t/t4216-log-bloom.sh: test_max_changed_paths () {
      	grep "\"key\":\"filter-computed\",\"value\":\"$1\"" $2
      }
      
    -+test_filter_trunc_small () {
    -+	grep "\"key\":\"filter-trunc-small\",\"value\":\"$1\"" $2
    ++test_filter_trunc_empty () {
    ++	grep "\"key\":\"filter-trunc-empty\",\"value\":\"$1\"" $2
     +}
     +
      test_filter_trunc_large () {
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report changes over limit'
      '
      
     +test_expect_success 'correctly report commits with no changed paths' '
    -+	git init small &&
    -+	test_when_finished "rm -fr small" &&
    ++	git init empty &&
    ++	test_when_finished "rm -fr empty" &&
     +	(
    -+		cd small &&
    ++		cd empty &&
     +
     +		git commit --allow-empty -m "initial commit" &&
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report changes over limit'
     +			git commit-graph write --reachable --changed-paths &&
     +		test_filter_computed 1 trace.event &&
     +		test_filter_not_computed 0 trace.event &&
    -+		test_filter_trunc_small 1 trace.event &&
    ++		test_filter_trunc_empty 1 trace.event &&
     +		test_filter_trunc_large 0 trace.event
     +	)
     +'
2:  11db600d51 = 2:  1b4c861e68 commit-graph: rename 'split_commit_graph_opts'
3:  cf49598137 ! 3:  d6c1bd395e builtin/commit-graph.c: introduce '--max-new-filters=<n>'
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report commits with no chan
     +
     +		test_filter_computed 2 trace.event &&
     +		test_filter_not_computed 3 trace.event &&
    -+		test_filter_trunc_small 0 trace.event &&
    ++		test_filter_trunc_empty 0 trace.event &&
     +		test_filter_trunc_large 0 trace.event
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report commits with no chan
     +				--split=replace --max-new-filters=1 &&
     +		test_filter_computed 1 trace.event &&
     +		test_filter_not_computed 4 trace.event &&
    -+		test_filter_trunc_small 0 trace.event &&
    ++		test_filter_trunc_empty 0 trace.event &&
     +		test_filter_trunc_large 0 trace.event
     +	)
     +'
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report commits with no chan
     +					--changed-paths --max-new-filters=2 &&
     +			test_filter_computed 2 trace.event &&
     +			test_filter_not_computed 4 trace.event &&
    -+			test_filter_trunc_small 2 trace.event &&
    ++			test_filter_trunc_empty 2 trace.event &&
     +			test_filter_trunc_large 0 trace.event
     +		done &&
     +
    @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report commits with no chan
     +				--changed-paths --max-new-filters=2 &&
     +		test_filter_computed 0 trace.event &&
     +		test_filter_not_computed 6 trace.event &&
    -+		test_filter_trunc_small 0 trace.event &&
    ++		test_filter_trunc_empty 0 trace.event &&
     +		test_filter_trunc_large 0 trace.event
     +	)
     +'
4:  1bc82cd008 ! 4:  b0d51fb04a commit-graph: introduce 'commitGraph.maxNewFilters'
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation is limited by --max-
     +				--split=replace &&
      		test_filter_computed 1 trace.event &&
      		test_filter_not_computed 4 trace.event &&
    - 		test_filter_trunc_small 0 trace.event &&
    + 		test_filter_trunc_empty 0 trace.event &&
     @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills previously-skipped filters' '
      	)
      '
    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backfills previously
     +				--max-new-filters=1 &&
     +		test_filter_computed 1 trace.event &&
     +		test_filter_not_computed 1 trace.event &&
    -+		test_filter_trunc_small 0 trace.event &&
    ++		test_filter_trunc_empty 0 trace.event &&
     +		test_filter_trunc_large 0 trace.event
     +	)
     +'
