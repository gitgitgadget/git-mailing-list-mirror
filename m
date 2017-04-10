Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889A320960
	for <e@80x24.org>; Mon, 10 Apr 2017 18:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdDJSTn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 14:19:43 -0400
Received: from 5.itsy.de ([188.40.84.14]:59087 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbdDJSTm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 14:19:42 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 738F064E81
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 20:19:40 +0200 (CEST)
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
References: <20170409191117.25175-3-avarab@gmail.com>
 <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
 <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
 <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
 <64121361-6f91-5988-b5e2-9278cc84067f@durchholz.org>
 <20170410165727.4lqtit5hkcxh32ew@sigill.intra.peff.net>
From:   Joachim Durchholz <jo@durchholz.org>
To:     Git Mailing List <git@vger.kernel.org>
Message-ID: <d1a71326-06bc-4133-de2b-7d42f525f7a4@durchholz.org>
Date:   Mon, 10 Apr 2017 20:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170410165727.4lqtit5hkcxh32ew@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2017 um 18:57 schrieb Jeff King:
>>> If there are security bugs where a malicious input can cause us
>>> to do something bad, that's something to care about. But that's very
>>> different than asking "do these tests run to completion with a funny
>>> input".
>>
>> If the tests do not complete, git is doing something unexpected.
>
> I very much disagree with that. Git's test operate under a set of
> assumptions, and if you violate those assumptions, then the failures are
> not meaningful.

In that case the tests do not validate that git can properly work with 
special characters.
That's a pretty big coverage gap.

> Take alternates, for instance. The on-disk storage format cannot
> represent paths with newlines in them. If a test does:
>
>   git clone -s "$(pwd)" parent.git child &&
>   test -d child
>
> then that test is going to fail if the test directory has a newline in
> it. But that doesn't tell us anything meaningful. Maybe there is a bug
> and maybe there isn't, but we cannot know because the thing being tested
> cannot possibly work under the test environment given.

Sure. Not all tests are meaningful in all environments.
That doesn't mean that the tests are generally meaningless.

Also, we're talking about two pretty different things here: gits 
interaction with the file system, and git's interaction with whatever 
shell its scripts are using.
In an ideal world, these two aspects would be orthogonal and could be 
tested independently of each other. Since in practice we do have 
correlations and dependencies, this isn't always possible, but it's what 
we should aim for.

> You can rewrite all the tests to say "skip this test if there's a
> newline in the test directory". But to what end? It's work to write and
> to maintain, and we haven't gained new information.

Not on that "alternates" thing (whatever that is), but we have a test 
that will work and provide information on systems that do allow newlines.

>> That in itself is not a security hole, but there's a pretty good chance that
>> at least one of these ~230 unexpected things can be turned into one, given
>> enough time and motivation. The risk multiplies as this is shell scripting,
>> where the path from "string is misinterpreted" to "string is run as a
>> command" is considerably shorter than in other languages.
>
> Sure, and I'd encourage people who are interested to dig through the
> results and see if they can find a real problem. I looked at several and
> didn't find anything that wasn't an example of the "test assumptions"
> thing above.

Don't assume that there's no risk just because you didn't find anything.

Also, git might not be the actual hole, but other software that relies 
on git not doing anything awkward might fail that assumption and expose 
the actual breach of security.
You could argue that it's not a problem in git, but it is. Unless and 
until the git docs clearly state that things may break if "funny 
characters" are being used, and where.

> But again, I'm happy to be proven wrong.

With security, you need to be confident about the absence of /any/ type 
of hole, not the absence of a /specific/ type of hole such as a shell 
injection.
So the way forward isn't proving you wrong by providing a specific 
exploit, it's making sure that no exploit with URLs and file names can 
possibly exist.

Now if I'm reading things like "heuristics" and "git uses URL-specific 
code even after it has determined it's not a URL"... well, that's the 
exact opposite of reassuring messages.

 > I just don't think
> plastering control characters into the test directory names all the time
> is a good way of finding those problems (and doesn't balance out the
> cost).

Fair enough.
