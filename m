Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037381F40E
	for <e@80x24.org>; Thu,  4 Aug 2016 00:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbcHDAgf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:36:35 -0400
Received: from us-hpatc-esg-02.alcatel-lucent.com ([135.245.18.28]:37192 "EHLO
	smtp-us.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754467AbcHDAgd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 20:36:33 -0400
Received: from us70tumx2.dmz.alcatel-lucent.com (unknown [135.245.18.14])
	by Websense Email Security Gateway with ESMTPS id AC416CD05E16E;
	Thu,  4 Aug 2016 00:35:06 +0000 (GMT)
Received: from us70tusmtp2.zam.alcatel-lucent.com (us70tusmtp2.zam.alcatel-lucent.com [135.5.2.64])
	by us70tumx2.dmz.alcatel-lucent.com (GMO) with ESMTP id u740Z9St028031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 4 Aug 2016 00:35:09 GMT
Received: from US70UWXCHHUB02.zam.alcatel-lucent.com (us70uwxchhub02.zam.alcatel-lucent.com [135.5.2.49])
	by us70tusmtp2.zam.alcatel-lucent.com (GMO) with ESMTP id u740Z8fx010529
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 4 Aug 2016 00:35:09 GMT
Received: from [135.121.197.20] (135.5.27.17) by
 US70UWXCHHUB02.zam.alcatel-lucent.com (135.5.2.49) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 3 Aug 2016 20:35:08 -0400
Subject: Re: Client exit whilst running pre-receive hook : commit accepted but
 no post-receive hook ran
To:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <5795EB1C.1080102@nokia.com>
 <20160725222201.GC13589@sigill.intra.peff.net>
 <a3f64a09-3094-eee1-0050-9960f0674036@nokia.com>
 <20160803193018.ydhmxntikhyowmjz@sigill.intra.peff.net>
 <xmqqlh0d8w6v.fsf@gitster.mtv.corp.google.com>
CC:	Jan Smets <jan.smets@nokia.com>, <git@vger.kernel.org>
From:	Stephen Morton <stephen.morton@nokia.com>
Organization: Nokia ION
Message-ID: <3f8fa2e0-9604-2bc9-338e-9977ea23135d@nokia.com>
Date:	Wed, 3 Aug 2016 20:35:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqlh0d8w6v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [135.5.27.17]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-03 3:54 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> I agree it would be a good property to have. I think it's hard to do
>> atomically, though. Certainly we can wait to tell the other side "your
>> push has been recorded" until after the hook is run. But we would
>> already have updated the refs locally at that point (and we must -- that
>> is part of the interface to the post-receive hooks, that the refs are
>> already in place). So would we roll-back the ref update then? Even that
>> suffers from power failures, etc.
>>
>> So I'm not sure if making it truly atomic is all the feasible.
> As long as the requirement is that post- hook must see the updated
> ref in place, I do not think it is feasible to give "the hook always
> runs once" guarantee, without cooperation by other parts of the flow
> (think: pulling the power at an arbitrary point in the process).
>
> A receiving repository can implement it all in the userland, I would
> think, though:
>
>   * A pre-receive hook records the intention to update a ref (from
>     what old commit to what new commit), and does not return until
>     that record is securely in a database;
>
>   * A post-receive hook checks the entry in the database above (it
>     _must_ find one), and atomically does its thing and marks the
>     entry "done";
>
>   * A separate sweeper scans the database for entries not yet marked
>     as "done", sees if the ref has been already updated, and
>     atomically does its thing and marks the entry "done" (the same
>     can be done as part of a post-receive for previously pushed
>     commit that pre-receive recorded but did not manage to run
>     post-receive before the power was pulled or the user did \C-c).
>
> As you originally described, the non-atomicity is not new; as long
> as we have necessary hooks in place on the git-core side for
> repositories that want a stronger guarantee, I do not think there is
> any more thing we need to do on this topic.  If we can narrow the
> window in a non-intrusive way, that would be a good thing to do,
> though.
> <snip>

I certainly understand not being able to make it atomic when faced with 
say "pulling the power at an arbitrary point in the process". That seems 
to me almost along the lines of disaster recovery contingency plans. But 
could we not guarantee that if there is no problem on the receiving end, 
that "IF a commit is received and the ref updated, THEN the post-receive 
hook is guaranteed to run".

The not-so-uncommon situation where I saw this was where a user had 
second-thoughts and hit Ctrl-C in the middle of a push. The push went 
through --the ref was updated-- but the post-receive hooks were not run.

Steve



