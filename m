Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C8F207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbdFZSGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 14:06:18 -0400
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:33273 "EHLO
        smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751376AbdFZSGQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Jun 2017 14:06:16 -0400
Received: from smtp18.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id D032125933;
        Mon, 26 Jun 2017 14:06:15 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9CDE625342;
        Mon, 26 Jun 2017 14:06:15 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 26 Jun 2017 14:06:15 -0400
Subject: Re: [RFC PATCH] proposal for refs/tracking/* hierarchy
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20170623135230.10534-1-jacob.e.keller@intel.com>
 <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <aa8a7ff6-2068-645d-061e-3142760a4b2a@xiplink.com>
Date:   Mon, 26 Jun 2017 14:06:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqvanmctmb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-06-23 04:54 PM, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
>> Instead, lets add support for a new refs/tracking/* hierarchy which is
>> laid out in such a way to avoid this inconsistency. All refs in
>> "refs/tracking/<remote>/*" will include the complete ref, such that
>> dropping the "tracking/<remote>" part will give the exact ref name as it
>> is found in the upstream. Thus, we can track any ref here by simply
>> fetching it into refs/tracking/<remote>/*.
> 
> I do think this overall is a good goal to aim for wrt "tracking",
> i.e.  keeping a pristine copy of what we observed from the outside
> world.  In addition to what you listed as "undecided" below,
> however, I expect that this will highlight a lot of trouble in
> "working together", i.e. reconciling the differences of various
> world views and moving the project forward, in two orthogonal axes:
> 
>   - Things pointed at by some refs (e.g. notes/, but I think the
>     ".gitmodules equivalent that is not tied to any particular commit
>     in the superproject" Jonathan Nieder and friends advocate falls
>     into the same category) do not correspond to the working tree
>     contents, and merging their contents will always pose challenge
>     when we need to prepare for conflict resolution.

OTOH, we shouldn't need to do any conflict resolution on these 
"tracking" refs:  The remote side should update the refs properly. 
Nobody should make local changes to these refs.

I guess I'm advocating that git should only allow "tracking" refs to be 
updated by a fetch, or a successful push of a local, non-"tracking" ref.

		M.


>   - Things pointed at by some other refs (e.g. tags/) do not make
>     sense to be merged.  You may locally call a commit with a tag
>     "wip", while your friends may use the same "wip" tag to point at
>     a different one.  Both are valid, and more importantly, there is
>     no point even trying to reconcile what the "wip" tag means in the
>     project globally.
> 
> For the former, I expect that merging these non-working tree
> contents will all have to require some specific tool that is
> tailored for the meaning each hierarchy has, just like "git notes
> merge" gives a solution that is very specific to the notes refs (I
> do not know how well "notes merge" works in practice, though).
> 
> For the latter, having a separate tracking hierarchy is a strict
> improvement from "tracking" point of view, but I think "working
> together" also needs a well designed set of new look-up rules, and a
> new convention.  For example, some tags may not want to be shared
> (e.g. "wip" example above) even though they should be easy to access
> by those who already have them (e.g. "git log ..wip" should work
> without having to say "git log ..refs/local-tags/wip", even if we
> decide to implement the "some tags may not want to be shared"
> segregation by introducing a new hierarchy).  And also a shared tag
> that is copied to "refs/tracking/origin/tags/v1.0" would need a way
> better than "git log tracking/origin/tags/v1.0" for this mechanism
> to be useful in everyday workflow.
> 
> Thanks.
> 
