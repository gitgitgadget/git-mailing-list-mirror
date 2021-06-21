Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D73C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B38F60200
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFUSnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:43:53 -0400
Received: from siwi.pair.com ([209.68.5.199]:13147 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230057AbhFUSnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:43:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BE2653F4096;
        Mon, 21 Jun 2021 14:41:37 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 841083F404F;
        Mon, 21 Jun 2021 14:41:37 -0400 (EDT)
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     Tao Klerks <tao@klerks.biz>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet>
 <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com>
Date:   Mon, 21 Jun 2021 14:41:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/21/21 8:50 AM, Tao Klerks wrote:
> Hi Johannes,
> 
> Thanks for the detailed reply!
> 
> My apologies for the subsequent delay - I've been trying to understand
> the behavior so that I can describe it in more detail, and that
> required me to learn a little C along the way :)
> 
> On Fri, Jun 11, 2021 at 11:49 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> _sometimes_, the mtime of a directory seems not to
>> be updated immediately after an item in it was modified/added/deleted. And
>> that mtime is precisely what the untracked cache depends on.
>>
>> The funny thing is: while the output of `git status` will therefore at
>> first fail to pick up on, say, a new untracked file, running `git status`
>> _immediately_ afterwards _will succeed_ to see that untracked file.
> 
> (I have nothing to add here - I don't understand what
> synchronous-acknowledgement or ordering guarantees we rely on to
> determine when we *expect* a change to be available to the fsmonitor,
> nor to I have any familiarity with the underlying APIs we use)
> 
>> On Thu, 10 Jun 2021, Tao Klerks wrote:
>>>   - There is also a lingering "problem" with "git status -uall", with
>>> both "core.useBuiltinFSMonitor" and "core.fsmonitor", but that seems
>>> far less trivial to address
>>
>> Interesting. I guess the untracked cache might become too clunky with many
>> untracked files? Or is there something else going on?
> 
> I think I understand this now, but I don't think I can explain it
> particularly well/succinctly.
> 
> I've attached a sort of "truth table" of performance data for a
> particular repository, running *warm* git status calls (no cold-cache
> testing at all) with various config and command-line options, and
> reporting the durations of various phases/processes captured using
> GIT_TRACE2_PERF=1.
> 
> The claimed "problem" with "git status -uall", when both
> "core.useBuiltinFSMonitor" and "core.fsmonitor" are enabled, only
> exists from the perspective of someone who's got core.fscache enabled
> all the time:
> * core.fscache works (in the Windows port only) by doing slightly more
> expensive work up-front on first directory query within a
> request/process lifetime, and then intercepting subsequent filesystem
> "queries"/operations
> * The context within which most of this more-expensive work typically
> occurs, in a "git status" request, is an explicitly and intentionally
> multi-threaded filesystem "lstat"-checking process in preload-index.c
> (always 20 threads, for a large repo)
> * There are two sets of filesystem-iteration in a simple/naive git
> status call with core.preloadindex enabled as by default - the
> lstat-checking multithreaded loops for files in the index, and the
> recursive directory scanning for untracked files that happens later
> * That second (not-multithreaded) set of work, with fscache enabled,
> gets to reuse a bunch of cached fs data from the first one. A walk
> that cost 7s without fscache now costs only 2.5s, for example.
> * With fsmonitor enabled (and warm), the first walk simply doesn't
> happen, so fscache stops making any difference to that
> untracked-file-searching directory walk; it goes back to taking 7s;
> every directory is queried once in series, so fscache has no impact at
> all.
> * Because the preload-index lstat-querying loop is parallelized, with
> fscache the initial cache population happens fast-ish - the total time
> taken for git status is eg 5s (2.5s of parallelized & accelerated
> lstat-querying and 2.5s of
> untracked-folder-iterating-and-processing-from-fscache)
> * So, with fscache enabled, turning on fsmonitor actually makes "git
> status" *slower* - it changes the "lstat + untracked" time from "2.5s
> + 2.5s" to "0s + 7s"
> * We can hide/mitigate that by enabling the untracked cache - but that
> "fails out" in all sorts of conditions specified in dir.c
> validate_untracked_cache(), including specifying "-uall"/"-u" to "git
> status
> * -> it is only in the context of fscache being enabled, and already
> speeding up the filesystem work, that fsmonitor can make things worse
> by making the first directory-querying loop happen in a non-parallel
> area of code, and thereby cancel fscache's impact.
> * -> fsmonitor never makes things worse on linux, since there is no
> fscache and so untracked folder iteration never benefits from any
> multithreading
> * -> when the untracked cache does apply, fsmonitor can *help* it,
> avoiding the need for any sort of directory walk at all, on the basis
> that "nothing in the filesystem appears to have changed"
> 
> Based on this understanding, it looks like there are at least three
> possible directions to be explored:
> 
> 1. Making the untracked cache less sensitive to configuration in
> dir.c#validate_untracked_cache(), at the cost of doing more work in
> the cold cases & saving more data in the index file (specific
> untracked files, and .git folder names or something)
>   ** This would result in peak performance, with no
> filesystem-iterating at all in the ideal case
>   ** This would apply / add substantial value in Windows and Linux
>   ** This is probably the most complex change - dir.c is not easy to
> understand/navigate
> 
> 2. Making the untracked directory-search happen in a multithreaded way
>   ** This would raise the performance with "-uall" to approximately the
> same as it was before fsmonitor was introduced on windows, and speed
> it up slightly on linux
>   ** This change would probably not be worthwhile, - its impact would
> not be huge except in very specific cases, and it would still
> introduce non-trivial complexity
> 
> 3. Forcing preload-index to actually "do its multithreaded work", even
> when fsmonitor is there, if we know that the untracked cached cannot
> be used and fsmonitor is enabled
>   ** This would raise the performance with "-uall" to approximately the
> same as it was before fsmonitor was introduced on windows
>   ** This change would probably be pretty easy - the main challenge is
> how to get untracked-cache-applicability information at preload-index
> time, since these happen in completely different parts of the codebase
> 
> I mocked up a local hack for the third option, and confirmed that
> forcing preload-index to ignore it does indeed bring "git status
> -uall"  performance back to the same level as before enabling
> fsmonitor.
> 
>>> I just started testing the new "core.useBuiltinFSMonitor" option in
>>> the new installer, and it's amazing, thanks Ben, Alex, Johannes and
>>> Kevin!
>>
>> Not to forget Jeff Hostetler, who essentially spent the past half year on
>> it on his own.
> 
> Argh, thank you for the correction, and thank you Jeff also for all
> your work on this.
> 
>>> For context, this is in a repo with 200,000 or so files, within 40,000
>>> folders (avg path depth 4 I think?), with a reasonably-intricate set
>>> of .gitignore patterns.
> 
>> My `.gitignore` consists of only ~40 heavily commented lines (containing
>> five lines with wildcards), but I do have a `.git/info/exclude` that
>> contains a set of generated file/directory lists, i.e. without any
>> wildcards. This `exclude` file is ~26k lines long.
>>
>> My guess is that the amount of work to match the untracked vs ignored
>> files is dominating the entire operation, by a lot.
> 
> In my case, as per the "truth table" referenced above, there are two
> kinds of things in play:
> 1. Filesystem operations are the main thing that matters in Windows
> 2. Some smaller amount of overhead (0.5-1s in my case) is associated
> with other work (pattern-matching etc) during untracked file
> detection, even with untracked cache enabled. The only way to avoid
> that work altogether is to have fsmonitor *and* untracked cache
> working, so that untracked cache can "trust" the fsmonitor results to
> avoid having to do any work at all. In this ideal situation fscache
> makes no difference, as there is no fs iteration.
> 
>>> I don't know whether this is the right place to report Windows-centric
>>> concerns, if not, my apologies.
>>
>> I would not necessarily call them "Windows-centric", even if yes, at the
>> moment the built-in FSMonitor is most easily enabled on Windows (because I
>> added that experimental option in Git for Windows' installer, after
>> integrating the experimental feature).
> 
> Right - now that I understand the situation better, there are three
> specific ways in which I consider these to be windows-centric
> concerns:
> * In my experience / in my context at least, the "naive" impact of
> file operation performance differences results in a more than 10X "git
> status" reduction in performance for large repos (over linux); various
> optional and/or windows-specific strategies significantly close that
> gap
> * core.fscache is a windows-specific strategy for dealing with this,
> and interacts with other features/strategies in potentially-surprising
> ways
> * The built-in FSMonitor is still only *easily* available in Windows
> 
> But, to your point, most of the *solutions* need not be
> windows-centric at all. The "best" one, making untracked cache a
> little more forgiving, would definitely have tangible performance
> benefits on linux (and presumably OSX).
> 
> Thanks,
> Tao
> 

Nice summary.  Thanks!

We're currently looking at a problem that we believe is in the
untracked-cache code.  This is causing some of our Scalar tests
to fail on Windows when the untracked-cache is turned on.  This
is independent of whether FSMonitor or FSCache is turned on.
We're still tracking this down.

And yes, the best possible solution is to turn on FSMonitor *and*
the untracked-cache, so that the "untracked" status code doesn't
have to do anything.  So I want to look at tracking down the above
problem before doing anything else.

Thanks
Jeff



