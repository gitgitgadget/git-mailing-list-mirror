Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2458D1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 10:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756927AbcH2KrC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:47:02 -0400
Received: from [195.159.176.226] ([195.159.176.226]:39299 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1756775AbcH2Kq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:46:59 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1beK5T-0004z4-0L
        for git@vger.kernel.org; Mon, 29 Aug 2016 12:46:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: Reducing CPU load on git server
Date:   Mon, 29 Aug 2016 12:46:27 +0200
Message-ID: <c1778c9b-2dd1-9cef-0330-204fe9d08d39@gmail.com>
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
 <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
Cc:     git@vger.kernel.org
In-Reply-To: <20160829054725.r6pqf3xlusxi7ibq@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 07:47, Jeff King pisze:
> On Sun, Aug 28, 2016 at 12:42:52PM -0700, W. David Jarvis wrote:
> 
>> The actual replication process works as follows:
>>
>> 1. The primary git server receives a push and sends a webhook with the
>> details of the push (repo, ref, sha, some metadata) to a "publisher"
>> box
>>
>> 2. The publisher enqueues the details of the webhook into a queue
>>
>> 3. A fleet of "subscriber" (replica) boxes each reads the payload of
>> the enqueued message. Each of these then tries to either clone the
>> repository if they don't already have it, or they run `git fetch`.
> 
> So your load is probably really spiky, as you get thundering herds of
> fetchers after every push (the spikes may have a long flatline at the
> top, as it takes time to process the whole herd).

One solution I have heard about, in the context of web cache, to reduce
the thundering herd problem (there caused by cache expiring at the same
time in many clients) was to add some random or quasi-random distribution
to expiration time.  In your situation adding a random delay with some
specified deviation could help.

Note however that it is, I think, incompatible (to some extent) with
"caching" solution, where the 'thundering herd' get served the same
packfile.  Or at least one solution can reduce the positive effect
of the other.

>> 1. We currently run a blanket `git fetch` rather than specifically
>> fetching the ref that was pushed. My understanding from poking around
>> the git source code is that this causes the replication server to send
>> a list of all of its ref tips to the primary server, and the primary
>> server then has to verify and compare each of these tips to the ref
>> tips residing on the server.

[...]
> There's nothing in upstream git to help smooth these loads, but since
> you mentioned GitHub Enterprise, I happen to know that it does have a
> system for coalescing multiple fetches into a single pack-objects. I
> _think_ it's in GHE 2.5, so you might check which version you're
> running (and possibly also talk to GitHub Support, who might have more
> advice; there are also tools for finding out which git processes are
> generating the most load, etc).

I wonder if this system for coalescing multiple fetches is something
generic, or is it something specific to GitHub / GitHub Enterprise
architecture?  If it is the former, would it be considered for
upstreaming, and if so, when it would be in Git itself?


One thing to note: if you have repositories which are to have the
same contents, you can distribute the pack-file to them and update
references without going through Git.  It can be done on push
(push to master, distribute to mirrors), or as part of fetch
(master fetches from central repository, distributes to mirrors).
I think; I have never managed large set of replicated Git repositories.

If mirrors can get out of sync, you would need to ensure that the
repository doing the actual fetch / receiving the actual push is
a least common denominator, that it it looks like lagging behind
all other mirrors in set.  There is no problem if repository gets
packfile with more objects than it needs.

>> In other words, let's imagine a world in which we ditch our current
>> repo-level locking mechanism entirely. Let's also presume we move to
>> fetching specific refs rather than using blanket fetches. Does that
>> mean that if a fetch for ref A and a fetch for ref B are issued at
>> roughly the exact same time, the two will be able to be executed at
>> once without running into some git-internal locking mechanism on a
>> granularity coarser than the ref? i.e. are fetch A and fetch B going
>> to be blocked on the other's completion in any way? (let's presume
>> that ref A and ref B are not parents of each other).
> 
> Generally no, they should not conflict. Writes into the object database
> can happen simultaneously. Ref updates take a per-ref lock, so you
> should generally be able to write two unrelated refs at once. The big
> exception is that ref deletion required taking a repo-wide lock, but
> that presumably wouldn't be a problem for your case.

Doesn't Git avoid taking locks, and use lockless synchronization
mechanisms (though possibly equivalent to locks)?  I think it takes
lockfile to update reflog together with reference, but if reflogs
are turned off (and I think they are off for bare repositories by
default), ref update uses "atomic file write" (write + rename)
and compare-and-swap primitive.  Updating repository is lock-free:
first update repository object database, then reference.

That said, it might be that per-repository global lock that you
use is beneficial, limiting the amount of concurrent access; but
it could be detrimental, that global-lock contention is the cause
of stalls and latency.

>> The ultimate goal for us is just figuring out how we can best reduce
>> the CPU load on the primary instance so that we don't find ourselves
>> in a situation where we're not able to run basic git operations
>> anymore.
> 
> I suspect there's room for improvement and tuning of the primary. But
> barring that, one option would be to have a hierarchy of replicas. Have
> "k" first-tier replicas fetch from the primary, then "k" second-tier
> replicas fetch from them, and so on. Trade propagation delay for
> distributing the load. :)

I guess that trying to replicate DGit approach that GitHub uses, see
"Introducing DGit" (http://githubengineering.com/introducing-dgit)
is currently out of question?

I wonder if you can propagate pushes, instead of fetches...

Best regards,
-- 
Jakub Narębski
 


