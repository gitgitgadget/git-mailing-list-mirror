Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5410020357
	for <e@80x24.org>; Wed, 12 Jul 2017 22:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbdGLWOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 18:14:06 -0400
Received: from 5.itsy.de ([188.40.84.14]:33852 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdGLWOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 18:14:05 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 04FF6648E3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 00:14:02 +0200 (CEST)
Subject: Re: Mirroring for offline use - best practices?
To:     Git Mailing List <git@vger.kernel.org>
References: <81052ff7-cece-400d-1742-e13693fae7e3@durchholz.org>
 <CAGZ79ka59qkekqGCSmVHb0=H--4HtjC7Ts9eXj_hb6f2cRQ4ww@mail.gmail.com>
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <42f0df64-5747-c2d2-832f-10d921fa2efa@durchholz.org>
Date:   Thu, 13 Jul 2017 00:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka59qkekqGCSmVHb0=H--4HtjC7Ts9eXj_hb6f2cRQ4ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.07.2017 um 19:40 schrieb Stefan Beller:

Thanks for the feedback - it's been very, very useful to me!

 > Yes, a local path implies --local in git-clone, which (a) uses hardlinks
 > and (b) avoids some other protocol overhead.

I guess (a) is the most important one for repositories large enough to 
make this kind of stuff matter.
I had gathered so much, but I wasn't sure - my own repos aren't large 
enough to take any measurements.

 >> Ramification 1:
 >>
 >> I'm not sure how best to prepare patches for push-to-upstream.
 >> Is there value in collecting them locally into a push-to-upstream 
repo, or
 >> is it better to just push from each local clone individually?
 >
 > It depends on a lot of things:
 > * How critical is the latency in the desired workflow?
 >
 >    Say you have this setup on a cruise ship and only push once when
 >    you are in a harbor, then (a) you want to make sure you pushed 
everything
 >    and (b) you care less about latency. Hence you would prefer to collect
 >    everything in one repo so nothing gets lost.

Yeah, that's the kind of scenario I'm having.
Less cruise ship (I wish!) and more on-train work during commutes, but 
it's similar.

But I think the "make sure nothing gets lost" aspect is the most 
important one. It's so easy to forget to push some sideline branch, 
particularly if you're in a workflow that uses many branches.

So... an "outbox" repository would be the Right Thing for me.
Not sure how generally applicable this is - what do other people think?

 >    Say you are in a fast paced environment, where you want instant 
feedback
 >    on your patches as they are mostly exploratory designs. Then you 
want to
 >    push directly from the local clone individually to minimize 
latency, I would
 >    imagine.

That's for online work I think.

Of course, there's the situation where you're sometimes offline and 
sometimes online.
I'm not sure how to best handle that - have a script that switches 
configurations? Just stick with that outbox workflow because switching 
workflows would invite error?

One thing that's specific to me is that I tend to be active in multiple 
projects, so I might get home and have queued up pushes in multiple repos.
I'm not sure how to best make sure that I don't forget a push.
OTOH maybe I'm overly optimistic about for how many repositories I might 
be working on a day, and it's a non-issue.

 > * Does a local clone have any value for having the work from
 >    another local clone available? In that case you may want to
 >    have all your changes accumulated into the mirror.

Yeah, definitely.
A repository I work on might be used as a submodule, and I might want to 
check the ramifications.

 > When a submodule gets deleted (git rm <submodule> && git commit),
 > then all entries for that submodule in the .gitmodules file are also 
removed.
 > That seems ok, but in an ideal world we may have a tombstone in there
 > (e.g. the submodule.NAME.path still set) that would help for tasks 
like finding
 > all submodules in the future.

I wouldn't want to use tombstone entries actually, because the content 
of .gitconfig and .gitmodules might have been modified for any number of 
reasons.

The incantations that I'm using for my own "gitmirror" script are:
1. Get all commits that touch .gitmodules via
   git rev-list --all --full-history -- .gitmodules
2. Get a list of all module names mentioned in that .gitmodules version via
   git config \
   --blob "${commit}:.gitmodules" \
   --name-only \
   --get-regexp "^submodule\..*\.path$"
3. Given the module name, extract path and url via
   git config \
     --blob "${commit}:.gitmodules" \
     --get "submodule.${module_name}.path"
resp.
     --get "submodule.${module_name}.url" \

It's not the most efficient way conceivable, but it's using git's 
configuration parser, and it won't get put off by manual edits in 
configuration files .

It's nothing you'd do on the command line, hence the scripting :-)

 >> I'm seeing the --recurse-submodules option for git fetch, so this 
might (or
 >> might not) be the Right Thing.
 >
 > That only works for currently initialized (active) submodules. The 
submodules
 > of the past and those which you do not have, are not fetched.

Aww.
Ah well.

 > Without the submodule ramifications, I would have advised to have
 > have the local mirror a 'bare' repo.
I'm currently steering towards having a cache for all repositories I 
ever downloaded, which would live in ~/.cache/gitmirror.

I can turn this script into a public, maintained project if there's 
interest.
Current state is two files, the script itself and a unit test script. 
It's still in a state of flux so sharing would be for the code reviews 
at this time, general usefulness would come later.

Regards,
Jo
