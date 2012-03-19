From: Andreas Ericsson <ae@op5.se>
Subject: Re: Feature request: don't require both bad and good when bisecting
Date: Mon, 19 Mar 2012 17:24:51 +0100
Message-ID: <4F675DD3.3040004@op5.se>
References: <20120318212957.GS1219@chaosreigns.com> <4F67468B.4070502@op5.se> <20120319153006.GD24848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: darxus@chaosreigns.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:25:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fOH-0000ga-6W
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162105Ab2CSQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:24:57 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42445 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162081Ab2CSQY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:24:56 -0400
Received: by lbbgm6 with SMTP id gm6so3474563lbb.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 09:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pZfRADZtXOSzc4JMBlJrjRUWtUUUOG1s28JZfnxwQds=;
        b=QBKLTtb82gJ8jwaYOOk6hyRT+7KVvyvD6Bynv3UmWTN6n3YnQxKkZvK1UFzYgT9ZIW
         DBLZezgkmgRGna9tvMXBO/KL4/B7MmW0Pc+ffsq4M/3wPiRro+fUqsVL+KD77AP3flSt
         Y4umKBe446F2mostiXlw7WaF/nT4biWljRuSK6B+2OfhYxbM2ye0uK0Orf0qQEn/gt3m
         u1+QSWZwsYOEZiNVgiief7ZHdPAE5DKXYjzh7Lm3HJbr0Ix8DeMCXBVO9dJCUJ6OcZD4
         6WMwue4esaSNRwBRSksx9/AiWZpFF4oCQNY8EvdkH9IBxejpgCPxIj+U1TzyfvsWXvPj
         t49A==
Received: by 10.152.148.234 with SMTP id tv10mr2665485lab.41.1332174294423;
        Mon, 19 Mar 2012 09:24:54 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id te8sm2672710lab.3.2012.03.19.09.24.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 09:24:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <20120319153006.GD24848@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlijWgPeUSL1RROzyl001ShG0+Eui+Xz5uoMYtY5ns2VdLxawp7t2ZPRclWS/ZNewET6NoV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193436>

On 03/19/2012 04:30 PM, Jeff King wrote:
> On Mon, Mar 19, 2012 at 03:45:31PM +0100, Andreas Ericsson wrote:
> 
>> On 03/18/2012 10:29 PM, darxus@chaosreigns.com wrote:
>>> I'd like to be able to tell get only that I know the latest commit is bad,
>>> and have it go find a good commit, then do the bisecting.  Maybe something
>>> like the opposite of a binary search, start with the last commit, then
>>> second to last, then 4th to last, 8th to last, etc., till it finds a good
>>> commit.
>>>
>>
>> Assuming the good commit is the 13'th from HEAD, you'd get the same nr
>> of attempts by just specifying a commit 100 revisions in the past and
>> doing the already implemented binary search as you would from trying 4
>> commits at a time to get at the good one.
>>
>> Binary search is a "divide and conquer" algorithm (running in O(log n)
>> time), so it handles extremely large datasets very efficiently.
> 
> Yeah. The OP's suggestion is to search backwards, increasing the stride
> exponentially. That would end up finding a good commit in O(lg n),
> though not with any great accuracy (e.g., for an old bug, you'd end up
> considering the whole first half of history as a single stride).  Since
> bisection would then narrow the result in O(lg n), I think
> asymptotically you are not any better off than you would be just
> arbitrarily checking the root commit[1], and then starting the bisection
> from there.
> 
> But both schemes run into a problem where old commits are often not very
> testable. For example, when I am bisecting in git.git, I will run into
> something like this:
> 
>    1. Some feature is introduced in v1.7.0.
> 
>    2. A bug in the feature is introduced in v1.7.2.
> 
>    3. Somebody notices and reports the bug in v1.7.5.
> 
> There is no point in testing anything prior to v1.7.0, as your test
> cannot succeed before the feature existed. And worse, it will actively
> break a bisection.

Not "break", as such, but it's naturally left to the user to discover
when the feature the bug is in existed. Usually, that leaves a short-ish
window.

It's sort of beside the point though. Using git as experiment (again),
we're looking at less than 30000 revisions and 289 non-rc tags. With only
30k revisions, you'll do *worse* testing 15 tags sequentially than you
would by just letting the bisection machinery get on with it and use
the full history as base for bisection.

Ofcourse, if the project is large (as in "huge tree"), checking out
each version will become increasingly expensive the further apart 
each version is, but the time it takes us to diminish the scope is
generally a lot quicker than the time it takes me to remember which
tag is next to try and then type the command to check it out, so
over-all, I've found it much more convenient to just give a range
I know is sufficiently large and then bisecting manually until I
get in the ballpark of the right range.

Automatic bisection is a different beast, naturally, since writing
a test-script that handles all corner cases (feature not added,
feature added but different bug found, feature added and right bug
found, etc) can be cumbersome, but that doesn't always apply, and
darxus didn't mention it. He only mentioned "let's test 4 revisions
back in history so I can find the good commit!", and I pointed out
that it's ridiculous to do so regardless of whether one has a hunch
of where the breakage is or not, since it will (almost) always be
100 times faster to just double the scanned range and let git get
on with it, even if it means doing a manual bisect first to find
when the feature was introduced and then an automated one to find
when the bug came alive.

> Pre-v1.7.0 versions will appear buggy, but it is in
> fact a _different_ bug than the one you are searching for (the bug is
> that the feature isn't there yet). This has been discussed many times on
> the list, but the short of it is that you will not get sensible
> bisection results if you have multiple bugs (or a bug that comes and
> goes throughout history).
> 
> So bisect really needs some input from the user to find a sensible
> boundary. And finding that boundary (if the user doesn't already know
> it) is generally a manual thing. Because it is usually easy for a human
> to recognize that the failure mode for points (1) and points (3) above
> are different, but hard to write a script that correctly tests for it.
> 
> IOW, my procedure for a bug like the above is usually to walk backwards
> along major tagged versions, manually interpreting the results. When I
> try v1.6.0 and my test blows up (because the feature isn't implemented),
> I recognize it, dig a little with "git log" to find where it was
> implemented, and only then write a script for automated bisection.
> 

That means you've tested 81 tags (discarding rc tags between 1.7.6 and
1.6.0). Compared to binary search, that would correspond to a history
holding 1208925819614629174706176 revisions. Discarding maint releases,
we're down to 14 tags, and you gain (at most) one search on bisection
at the expense of more typing. Truly a toss-up.

What I was getting at is that trying to be more efficient than O(log n)
is hard and usually requires a really good educated guess to succeed.
Picking a random number of jumps to go backwards certainly isn't the
right way to do it, and especially since the problems you mentioned
(feature missing) will still exist with such a solution.

I managed to use a lot of text to get to that final paragraph. Sorry.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
