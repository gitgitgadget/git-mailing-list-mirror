Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DDC4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A0C20759
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbgKEOFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 09:05:35 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:42461 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbgKEOFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 09:05:34 -0500
Received: from host-89-243-187-160.as13285.net ([89.243.187.160] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kafsx-0002Wj-AI; Thu, 05 Nov 2020 14:05:08 +0000
Subject: Re: [PATCH v4 06/10] commit-graph: implement corrected commit date
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
 <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
 <85pn4tnk8u.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
Date:   Thu, 5 Nov 2020 14:05:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <85pn4tnk8u.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

On 04/11/2020 16:45, Jakub Narębski wrote:
> Hello Abhishek,
>
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>> On Tue, Oct 27, 2020 at 07:53:23PM +0100, Jakub Narębski wrote:
>>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>>> ...
>>>> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>> Somewhere in the commit message we should also describe that this commit
>>> changes how commit-graph is verified: from checking that the generation
>>> number agrees with _topological level definition_, that is that for a
>>> given commit it is 1 more than maximum of its parents (with the caveat
>>> that we need to handle GENERATION_NUMBER_V1_MAX values correctly), to
>>> checking that slightly weaker condition fulfilled by both topological
>>> levels (generation number v1) and by corrected commit date (generation
>>> number v2) that for a given commit its generation number is 1 more than
>>> maximum of its parents or larger.
>> Sure, that makes sense. Will add.
> Actually this description should match whatever we decide about
> mechanism for verifying correctness of generation numbers (see below).
> Because we have to choose one.

This may be not part of the the main project, but could you consider, if
time permits, also adding some entries into the Git Glossary (`git help
glossary`) for the various terms we are using here and elsewhere, e.g.
'topological levels', 'generation number', 'corrected commit date' (and
its fancy technical name for the use of date heuristics e.g. the
'chronological ordering';).

The glossary can provide a reference, once the issues are resolved. The
History Simplification and Commit Ordering section of git-log maybe a
useful guide to some of the terms that would link to the glossary.
--
Philip

>>> But, as far as I understand it, current code does not handle correctly
>>> GENERATION_NUMBER_V1_MAX case (if we use generation number v1).
>>>
>>> On the other hand we could have simpy use functional check, that
>>> generation number used (which can be v1 or v2, or any similar other)
>>> fulfills the reachability condition for each edge, which can be
>>> simplified to checking that generation(parents) <= generation(commit).
>>> If the reachability condition is true for each edge, then it is true for
>>> each path, and for each commit.
> See below.
>
>>>> ---
>>>>  commit-graph.c | 43 +++++++++++++++++++++++--------------------
>>>>  1 file changed, 23 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/commit-graph.c b/commit-graph.c
>>>> index cedd311024..03948adfce 100644
>>>> --- a/commit-graph.c
>>>> +++ b/commit-graph.c
>>>> @@ -154,11 +154,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
>>>>  	else if (generation_a > generation_b)
>>>>  		return 1;
>>>>  
>>>> -	/* use date as a heuristic when generations are equal */
>>>> -	if (a->date < b->date)
>>>> -		return -1;
>>>> -	else if (a->date > b->date)
>>>> -		return 1;
>>> Why this change?  It is not described in the commit message.
>>>
>>> Note that while this tie-breaking fallback doesn't make much sense for
>>> corrected committer date generation number v2, this tie-breaking helps
>>> if we have to use topological levels (generation number v2).
>>>
>> Right, I should have mentioned this change (and it's not something that
>> makes a difference either way).
>>
>> We call commit_gen_cmp() only when we are sorting commits by generation
>> to speed up computation of Bloom filters i.e. while writing a commit
>> graph (either split commit-graph or a simple commit-graph).
>>
>> Since we are always computing and storing corrected commit date when we
>> are writing (whether we write a GDAT chunk or not), using date as
>> heuristic is longer required.
> Thanks.  This description really should be added to the commit message,
> because (yet again?) I was confused by this change.
>
> Sidenote: it is not obvious at least to me that this function is used
> only for sorting commits to speed up computation of Bloom filters while
> writing the commit-graph (`git commit-graph write --changed-paths [other
> options]`).
>
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -1357,10 +1352,14 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>>>>  					ctx->commits.nr);
>>>>  	for (i = 0; i < ctx->commits.nr; i++) {
>>>>  		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
>>> Sidenote: I haven't noticed it earlier, but here 'uint32_t' might be
>>> enough; no need for 'timestamp_t' for 'level' variable.
>>>
>>>> +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
>>>>
>> We need the 'timestamp_t' as we are comparing level with the now 64-bits
>> GENERATION_NUMBER_INFINITY. I thought uint32_t would be promoted to
>> timestamp_t. I have a hunch that since we are explicitly using a fixed
>> width data type, compiler is unwilling to type coerce into broader data
>> types.
>>
>> Advice on this appreciated.
> All right, so the wider type is used because of comparison with
> wide-uint GENERATION_NUMBER_INFINITY.  I stand corrected.
>
> [...]
>>>> @@ -2485,17 +2496,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
>>>>  		if (generation_zero == GENERATION_ZERO_EXISTS)
>>>>  			continue;
>>>>  
>>>> -		/*
>>>> -		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
>>>> -		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
>>>> -		 * extra logic in the following condition.
>>>> -		 */
>>>> -		if (max_generation == GENERATION_NUMBER_V1_MAX)
>>>> -			max_generation--;
>>>> -
>>> Perhaps in the future we should check that both topological levels, and
>>> also corrected committer date (if it exists) for correctness according
>>> to their definition.  Then the above removed part would be restored (but
>>> with s/max_generation/max_level/).
>>>
>>>>  		generation = commit_graph_generation(graph_commit);
>>>> -		if (generation != max_generation + 1)
>>>> -			graph_report(_("commit-graph generation for commit %s is %u != %u"),
>>>> +		if (generation < max_generation + 1)
>>>> +			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
>>> All right, so we relaxed the check so that it will be fulfilled by
>>> generation number v2 (and also by generation number v1, as it implies
>>> the more strict check for v1).
>>>
>>> What would happen however if generation holds topological levels, and it
>>> is GENERATION_NUMBER_V1_MAX for at least one parent, which means it is
>>> GENERATION_NUMBER_V1_MAX for a commit?  As you can check, the condition
>>> would be true: GENERATION_NUMBER_V1_MAX < GENERATION_NUMBER_V1_MAX + 1,
>>> so the `git commit-graph verify` would incorrectly say that there is
>>> a problem with generation number, while there isn't one (false positive
>>> detection of error).
>> Alright, so the above block still makes sense if we are working with
>> topological levels but not with corrected commit dates. Instead of
>> removing it, I will modify the condition to check that one of our parents
>> has GENERATION_NUMBER_V1_MAX and the graph uses topological levels.
> That is one of the 3 possible solutions I can think of.
>
>
> I. First solution is to switch from checking that generation number
> matches its definition to checking that the [weaker] reachability
> condition for the generation number is true, that is:
>
>  	if (generation < max_generation)
>  		graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
>
> The [weaker] reachability condition for generation numbers states that
>
>    A reachable from B    =>    gen(A) <= gen(B)
>
> This condition is true even if one or more generation numbers is
> GENERATION_NUMBER_ZERO (uninitialized or written by old git version),
> GENERATION_NUMBER_V1_MAX (we hit storage limitations, can happen only
> for generation number v1), or GENERATION_NUMBER_INFINITY (for commits
> outside of the serialized commit-graph, doesn't matter and cannot happen
> during verification of the commit-graph data by definition).
>
> This means that if P* is the parent of C with the maximal generation
> number, and gen(C) < gen(P*) is true (while gen(P*) <= gen(C) should be
> true), then there is a problem with generation number.
>
> This is why I thought you were going for, and what I have proposed.
>
> Advantages:
> - we are testing what actually matters for speeding up reachability
>   queries, namely that the reachability property holds true
> - the test works for generation number v1, generation number v2,
>   and any possible future use-compatibile generation number
>   (not that I think we would need any)
> - least complicated solution
>
> Disadvantages:
> - weaker test that we have had for generation number v1 (topological
>   levels), and weaker that possible test for generation number v2
>   that we could have (see below)
>
>
> II. Verify corrected committed date (generation number v2) if available,
> and verify topological levels (generation number v1) otherwise, checking
> that it matches the definition of it -- using version-specific checks.
>
> This would probably mean adding a conditional around the code verifying
> that given generation number is correct, possibly:
>
>   if (g->read_generation_data) {
>   	/* verify corrected commit date */
>   } else {
>   	/* current code for verifying topological levels */
>   }
>
> II.a. For topological levels (generation number v1) we would continue
> checking that it matches the definition, that is that the following
> condition holds:
>
>   gen(C) = max_{P: P ∈ parents(C)} gen(P) + 1
>
> This includes code for handling the case where `max_generation`, holding 
> max_{P: P ∈ parents(C)} gen(P), is GENERATION_NUMBER_V1_MAX.
>
> II.b. For corrected commiter dates (generation number v2) we can use the
> code proposed by this revision of this commit, namely we check if the
> following condition holds:
>
>   gen(P) + 1 <= gen(C)   for each P \in parents(C)
>
> or, in other words:
>
>   max_{P: P ∈ parents(C)} { gen(P) } + 1  <=  gen(C)
>
> Which could be checked using the following code (i.e. current state
> after this revision of this patch):
>
> 	if (generation < max_generation + 1)
> 		graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
>
> This is what I think you are proposing now.
>
> Additionally, theoretically we could also check that the following
> condition holds for corrected commiter date:
>
>    committer_date(C) <= gen_v2(C)
>
> but this is automatically fufilled because we use non-negative offsets
> to store corrected committed date info.
>
> Alternatively we can check for compliance with the definition of the
> corrected committer date:
>
>   if (max_generation + 1 <= graph_commit->date) {
>   	/* commit date does not need correction */
>   	if (generation != graph_commit->date)
>     	graph_report(_("commit-graph corrected commit date for commit %s "
>   		               "is %"PRItime" != %"PRItime" commit date"),
>                      ...);
>   } else {
>   	if (generation != max_generation + 1)
>   		graph_report(_("commit-graph generation v2 for commit %s is %"PRItime" != %"PRItime),
>                      ...);
>   }
>
> Though I think it might be overkill.
>
> Advantages:
> - more strict tests, checking generation numbers (v2 if present, v1
>   otherwise) against their definition
> - if there is no GDAT chunk, verify works just like it did before
>
> Disadvantages:
> - more complicated code
> - possibly measurable performance degradation due to extra conditional
>
>
> III. Like II., but if there is generation numbers chunk (GDAT chunk), we
> verify *both* topological levels (v1) and corrected commit date (v2)
> against their definition.  If GDAT chunk is not present, it reduces to
> current code (before this patch series).
>
> Advantages:
> - if there is no GDAT chunk, verify works just like it did before
> - most strict tests, verifying all the data: both generation number v1
>   and generation number v2 -- if possible
>
> Disadvantages:
> - most complex code; we need to somehow extract topological levels
>   if the GDAT chunk is present (they are not on graph data slab in this
>   case); I have not even started to think how it could be done
> - slower verification
>
>> Suprised that no test breaks by this change.
> I don't whink we have any test that created commit graph with
> topological levels greater than GENERATION_NUMBER_V1_MAX; this would be
> expensive and have to be of course protected by GIT_TEST_LONG aka
> EXPENSIVE prerequisite.
>
>   # GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 is here to force verification of topological levels
>   test_expect_success EXPENSIVE 'verify handles topological levels > GENERATION_NUMBER_V1_MAX' '
>   	rm -rf long_chain &&
>   	git init long_chain &&
>   	test_commit_bulk -C long_chain 1073741824 &&
>     (
>   		cd long_chain &&
>   		GIT_TEST_COMMIT_GRAPH_NO_GDAT=1 git commit-graph write &&
>   		git commit-graph verify
>     )
>   '
>
> This however lies slightly outside the scope of this patch series,
> though if you could add this test (in a separate patch), after testing
> it, it would be very nice.
>
>> I have also moved changes in the verify function to the next patch, as
>> we cannot write or read corrected commit dates yet - so little sense in
>> modifying verify.
> I think putting changes to the verify function in a separate patch, be
> it before or after this one (depending on the choice of the algorithm
> for verification, see above) would be a good idea.
>
>>> Sidenote: I think we don't have to worry about having to introduce
>>> GENERATION_NUMBER_V2_MAX, as the in-memory size (of reconstructed from
>>> disck representation) corrected commiter date is the same as of commiter
>>> date itself, plus some, and I don't see us coming close to 64-bit limit
>>> of timestamp_t for commit dates.
>>>
>>>>  				     oid_to_hex(&cur_oid),
>>>>  				     generation,
>>>>  				     max_generation + 1);
> Best,

