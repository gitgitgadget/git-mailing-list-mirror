Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE39C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 06:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486D06109D
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 06:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFPGSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 02:18:49 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:3641 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPGSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 02:18:48 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4G4ZhT3nWGz5tlJ;
        Wed, 16 Jun 2021 08:16:41 +0200 (CEST)
Subject: Re: [PATCH 0/2] RFC: implement new zdiff3 conflict style
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <55d0eb59-10a0-1dff-f195-4d660c6028e0@kdbg.org>
 <CABPp-BF2KnktDTtTfp=hRS36HN-xYC8=P1eYcqaBhJvAJcTCAw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a5267880-09be-a1ed-32bb-3b056b831fb4@kdbg.org>
Date:   Wed, 16 Jun 2021 08:16:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF2KnktDTtTfp=hRS36HN-xYC8=P1eYcqaBhJvAJcTCAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.21 um 23:45 schrieb Elijah Newren:
> On Tue, Jun 15, 2021 at 2:36 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 15.06.21 um 07:16 schrieb Elijah Newren via GitGitGadget:
>>> Implement a zealous diff3, or "zdiff3". This new mode is identical to
>>> ordinary diff3 except that it allows compaction of common lines between the
>>> two sides of history, if those common lines occur at the beginning or end of
>>> a conflict hunk.
>>
>> As a data point, I tried this series (cf9d93e547 en/zdiff3) on my
>> criss-cross merge test case that started this adventure, and it produces
>> the very same output as diff3; cf.
>> https://lore.kernel.org/git/60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org/
> 
> That's good to hear; your two sides had no common text at the
> beginning or end of the conflict hunk, so I wouldn't expect zdiff3 to
> change that particular example.
> 
> The XDL_MERGE_FAVOR_BASE idea (cf.
> https://lore.kernel.org/git/20210611190235.1970106-1-newren@gmail.com/),
> though would I think simplify the diff3 conflict markers in your
> example to
> 
> <<<<<<< HEAD
>     CClustering ComputeSSLClusters(double threshPercent, const
> CDataInfo* scale) const override;
>     void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist) const;
>     double EstimateNodeDist2() const override;
>     std::vector<double> EstimateNeighborMinDist() const override;
> ||||||| merged common ancestors
>     CClustering ComputeClusters(const double* dist, double threshold,
>         const CDataInfo* scale) const override;
>     virtual void ComputeDist(DistFunc distFunc, CDoubleArray& dist,
>         double& minDist, double& maxDist);
>     virtual void ComputeUMatrix();
>     virtual void ComputeKNearest(int K, const double*,
>         Neighborhood& result) const;
> =======
>     CClustering ComputeSSLClusters(double threshPercent,
>         const CDoubleArray& compWeights, const CDataInfo* scale) const override;
>     static void ComputeDist(const CNetNodeHolder& vecs, CDoubleArray& dist,
>         double& minDist, double& maxDist);
>>>>>>>> no-compweights-in-cnet
> 
> That seems like it might be nicer, but I don't do many criss-cross
> merges myself so it'd be nice to get opinions of others like you who
> do.

That *is* nicer as it is just the regular conflict with some base
context. Does that mean that the regular recursive merge is a bit sloppy
because it throws away too many conflicts that occur in virtual
ancestors? Even if that is the case, I couldn't tell whether that is a
disadvantage or not, as I've actually never seen nested conflicts in the
past; the diff3 test was the first time I saw one.

With the referenced patch applied (after a small tweak around needs_cr
to make it compile), my testcase does indeed produce the above conflict
under zdiff3 mode. The diff3 mode, OTOH, produces an exceedingly large
non-nested and obviously incorrect conflict (I'm not going to post it
here): our and their side are large and share a lot of text, but the
base part is identical to the above and is far too small.

-- Hannes
