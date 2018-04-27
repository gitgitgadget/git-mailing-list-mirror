Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DCC91F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759275AbeD0VIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:08:14 -0400
Received: from smtp114.ord1c.emailsrvr.com ([108.166.43.114]:57551 "EHLO
        smtp114.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759077AbeD0VIN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Apr 2018 17:08:13 -0400
Received: from smtp15.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp15.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 6DB9620382
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 17:08:12 -0400 (EDT)
Received: from smtp66.ord1d.emailsrvr.com (relay.ord1c.rsapps.net [172.28.255.120])
        by smtp15.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id 68CA720378
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 17:08:12 -0400 (EDT)
Received: from smtp9.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp9.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 5F8C3C0090;
        Fri, 27 Apr 2018 17:08:11 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0AE94C0083;
        Fri, 27 Apr 2018 17:08:11 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 27 Apr 2018 17:08:11 -0400
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     Duy Nguyen <pclouds@gmail.com>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
 <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
 <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <38e961ca-e354-6390-982d-4d0c9c9e55da@xiplink.com>
Date:   Fri, 27 Apr 2018 17:08:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8AVTkqDomQW7Np5opnK+bMk53pcMtCQRBr-=QXEXs8Nqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-27 01:03 PM, Duy Nguyen wrote:
> On Wed, Apr 25, 2018 at 5:18 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>>> The best approach to do so is to have those people do the "touch"
>>> thing in their own post-checkout hook.  People who use Git as the
>>> source control system won't have to pay runtime cost of doing the
>>> touch thing, and we do not have to maintain such a hook script.
>>> Only those who use the "feature" would.
>>
>>
>> The post-checkout hook approach is not exactly straightforward.
> 
> I am revisiting this because I'm not even happy with my
> post-checkout-modified hook suggestion, so..
> 
>>
>> Naively, it's simply
>>
>>          for F in `git diff --name-only $1 $2`; do touch "$F"; done
>>
>> But consider:
>>
>> * Symlinks can cause the wrong file to be touched.  (Granted, Michał's
>> proposed patch also doesn't deal with symlinks.)  Let's assume that a hook
>> can be crafted will all possible sophistication.  There are still some
>> fundamental problems:
> 
> OK so this one could be tricky to get right, but it's possible.
> 
>>
>> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
>> identical so the above loop does nothing.  Offhand I'm not even sure how a
>> hook might get the right files in this case.
> 
> This is a limitation of the current post-checkout hook. $3==0 from the
> hook lets us know this is not a branch switch, but it does not really
> tell you the affected paths. If it somehow passes all the given
> pathspec to you, then you should be able to do "git ls-files --
> $pathspec" which gives you the exact same set of paths that
> git-checkout updates. We could do this by setting $4 to "--" and put
> all the pathspecs in $5+ [1] e.g. "HEAD@{1} HEAD 0 -- path/to/file" in
> the above example.
> 
> There is  third case here, if you do "git checkout <tree-ish> --
> path/to/file" then it cannot be covered by the current design. I guess
> we could set $3 to '2' (retrieve from a tree) to indicate this in
> addition to 0 (from index) and 1 (from switching branch) and then $1
> could be the tree in question (pathspecs are passed the same way
> above)
> 
> [1] I wonder if we could have a more generic approach to pass
> pathspecs via environment, which could work for more than just this
> one hook. Not sure if it's a good idea though.

I think there needs to be something other than listing all the paths in 
the command is viable, because it's too easy to hit some 
command-line-length limit.  It would also be good if hook authors didn't 
have to re-invent the wheel of determining the changed paths for every 
corner-case.

My first instinct is to write them one-per-line on the hook's stdin. 
That's probably not generic enough for most hooks, but it seems like a 
good approach for this proposal.

Throwing them into a temporary file with a known name is also good --- 
better, I think, than stuffing them into an environment variable.

		M.

>> * The hook has to be set up in every repo and submodule (at least until
>> something like Ævar's experiments come to fruition).
> 
> Either --template or core.hooksPath would solve this, or I'll try to
> get my "hooks.* config" patch in. I think that one is a good thing to
> do anyway because it allows more flexible hook management (and it
> could allow multiple hooks of the same name too). With this, we could
> avoid adding more command-specific config like core.fsmonitor or
> uploadpack.packObjectsHook which to me are hooks.
> 
> Another option is extend core.hooksPath for searching multiple places
> instead of just one like AEvar suggested.



>> * A fresh clone can't run the hook.  This is especially important when
>> dealing with submodules.  (In one case where we were bit by this, make
>> though that half of a fresh submodule clone's files were stale, and decided
>> to re-autoconf the entire thing.)
> 
> Both --template and config-based hooks should let you handle this case.
> 
> So, I think if we improve the hook system to give more information
> (which is something we definitely should do), we could do this without
> adding special cases in git. I'm not saying that we should never add
> special cases, but at least this lets us play with different kinds of
> post-checkout activities before we decide which one would be best
> implemented in git.
> 
