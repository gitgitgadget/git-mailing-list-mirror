Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789B51F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 13:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbdKNNki convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Nov 2017 08:40:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40117 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbdKNNkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 08:40:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36F65AD06;
        Tue, 14 Nov 2017 13:40:35 +0000 (UTC)
Subject: Re: [RFC 3/3] log: add an option to generate cover letter from a
 branch tip
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
 <936c2b33-3432-f113-d84b-0623246ec673@suse.de>
 <xmqq7eut4cae.fsf@gitster.mtv.corp.google.com>
 <92c426bc-5ce9-da7c-5f10-66b5fc46825b@suse.de>
 <xmqqo9o52ep0.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <d4fec167-aae2-1990-4e24-faaf286f87f5@suse.de>
Date:   Tue, 14 Nov 2017 14:40:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9o52ep0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/11/2017 à 14:05, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de> writes:
>
>> The triple dash is so that the diffstat/shortlog as not seen as
>> part of the cover letter.  As said in the cover letter for this
>> series, it kinda breaks legacy behaviour right now.  It should
>> either be printed only for cover-at-tip, or a new separator should
>> be added.
> This reminds me of a couple of random thoughts I had, so before I
> disconnect from my terminal and forget about them...
>
> [1] format-patch and am must round-trip.
>
> I mentioned four uses cases around the "cover letter at the
> tip" in my earlier message
>
>     https://public-inbox.org/git/xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com/
>
> Specifically, (2) we should be able to run "format-patch" and record
> the log message of the empty commit at the tip to the cover letter,
> and (4) we should be able to accept such output with "am" and end up
> with the same sequence of commits as the original (modulo committer
> identity and timestamps).  So from the output we produce with this
> step, "am" should be able to split the material that came from the
> original empty commit from the surrounding cruft like shortlog and
> diffstat.  The output format of this step needs to be designed with
> that in mind.

This should be the case with the current RFC (apart from the branch description which is kept at the moment).
Things like git am --signoff will break this of course.

>
> [2] reusing cover letter material in merge may not be ideal.
>
> When people write a cover letter, they write different things in it.
> What they wanted to achieve, why they chose the approach they took,
> how the series is organized, which part of the series they find iffy
> and/orneeds special attention from the reviewers, where to find the
> previous iteration, what changed since the previous iterations, etc.
>
> All of them are to help the reviewers, many of who have already
> looked at the previous rounds, to understand and judge this round of
> the submission.
>
> The message in a merge commit as a part of the final history,
> however, cannot refer to anything from "previous rounds", as the
> previous attempts are not part of the final history readers of "git
> log" can refer to whey they are trying to understand the merge.
> What exactly goes in a merge commit and how the messages are phrased
> may be different from project to project, but for this project, I've
> been trying to write them in an end-user facing terms, i.e. they are
> designed in such a way that "git log --first-parent --merges" can be
> read as if they were entries in the release notes, summarizing fixes
> and features by describing their user-visible effects.  This is only
> one part of what people write in their cover letters (i.e. "what
> they wanted to achive").
>
> So there probably needs a convention meant to be followed by human
> users when writing cover letters, so a mechanical process can tell
> which part of the text is to be made into the merge commit without
> understanding human languages.

In the long term, I agree this would be nice.
As a first step, could we force the --edit option when using --cover-at-tip ?
The basic merge message would come from the cover letter but can/should be edited to clear the extra stuff out.

Auto-stripping those extra infos, may also conflicts with the point (3) from your previous mail.
If git merge is to keep only the relevant infos, git format-patch from this merge will not be able to access those.

The advantage of a manual edit is that it's the commiter's choice. Keep the info if the branch is to be resubmitted. Drop them once it's merged for good.

Nicolas



