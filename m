From: John <john@puckerupgames.com>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 18 May 2010 14:50:16 -0400
Message-ID: <4BF2E168.2020706@puckerupgames.com>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> <4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 18 20:51:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OERss-0007NW-Fo
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 20:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab0ERSvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 14:51:10 -0400
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:59063 "EHLO
	postalmail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757530Ab0ERSvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 14:51:09 -0400
Received: from [10.3.1.118] (unknown [65.202.33.238])
	by postalmail-a7.g.dreamhost.com (Postfix) with ESMTP id 1E438171301;
	Tue, 18 May 2010 11:51:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <20100517231642.GB12092@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147294>

On 05/17/2010 07:16 PM, Jeff King wrote:
> On Fri, May 14, 2010 at 08:54:02AM -0400, John wrote:
>
>> Thanks so much. It's version 1.5.6.5. I compiled it 3 months ago. For
>
> By git standards, that version is ancient. You may want to try with a
> more recent version of git (at the very least, multithreaded delta
> compression has been enabled by default since then).

I just compiled the latest git. It got worse!!

$  git --version
git version 1.5.6.5
$ time git gc --aggressive
Counting objects: 2086, done.
Compressing objects: 100% (2054/2054), done.
Writing objects: 100% (2086/2086), done.
Total 2086 (delta 676), reused 0 (delta 0)

real    4m28.573s
user    3m38.650s
sys     0m5.156s
$  git --version
git version 1.7.1
$ time git gc --aggressive
Counting objects: 2086, done.
Compressing objects: 100% (2054/2054), done.
Writing objects: 100% (2086/2086), done.
Total 2086 (delta 676), reused 0 (delta 0)

real    6m16.406s
user    5m28.665s
sys     0m6.196s
$ du -hs .git
203M	.git


>
>> I packed the bare repo, then ran `gc --aggressive`.
>
> Note that "gc --aggressive" will repack from scratch, throwing away the
> previous pack.
>
>> Then I did a `git pull`, which took 35 minutes.
>
> That sounds like a long time. What was taking so long? Was delta
> compression pegging the CPU? Was it limited during the "Writing objects"
> phase, which is going to be limited by either disk I/O or network speed?

The compressing objects phase. Yes, pegging the CPU and hogging memory.


> How big is your packed repo? Given the pattern you describe below, I am
> beginning to wonder if it is simply the case that even though a single
> checkout of your repo isn't that large, the complete history of your
> project may simply be gigantic (e.g., because you are repeatedly writing
> new apparently-random versions of each file, so your repository size
> will grow quite quickly).

The packed .git dir is 203 MB. Yes, we make frequent changes to these files, and push/pull 
frequently as well. Just a normal development pattern, though. It's all manually done -- i.e., 
there's no automated bot doing excessive git operations.

>
> Remember that a git clone transfers the full history (and a pull will
> transfer all of the intermediate history). If you have rewritten those
> files many times, you may be transferring many times your working
> directory size in history.
>
>> You can simulate it all by generating a batch of 1-100 MB files from
>> /dev/urandom (since they won't compress), commit them, then do it
>> again many times to simulate edits. Every few iterates, push it
>> somewhere.
>
> I tried this script to make a 100M working directory with a 400M .git
> directory:
>
> -- >8 --
> #!/bin/sh
>
> rm -rf big-repo
> mkdir big-repo&&  cd big-repo&&  git init
>
> mark() {
>    echo "`date` $*"
> }
>
> randomize() {
>    mark randomize start
>    for i in `seq 1 100`; do
>      openssl rand $((1024*1024))>$i.rand
>    done
>    mark randomize end
> }
>
> commit() {
>    mark add start
>    git add .
>    mark add end
>    mark commit start
>    git commit -m "$1"
>    mark commit end
> }
>
> randomize; commit base
> randomize; commit one
> randomize; commit two
> randomize; commit three
> -- 8<  --
>
> Here are a few timings I noted:
>
>    - it takes about 5 seconds to generate and write the random data
>
>    - git add runs in about 13 seconds. It pegs the CPU hashing all of the
>      data.
>
>    - the first commit is nearly instantaneous, as the summary diff takes
>      no work; subsequent commits spend about 9 seconds to create the
>      summary diff.  Changing commit to "commit -q" drops that to back to
>      near-instantaneous.
>
>    - with no attributes set, "time git gc --aggressive" reports:
>
>        real    1m31.983s
>        user    2m29.621s
>        sys     0m3.732s
>
>      Note the real/user discrepancy. It's a dual-core machine, and recent
>      git will multi-thread the delta phase, which is what dominates the
>      time. This should correspond roughly to the delta-compression phase
>      of your pull time, as that was just making a pack on the fly (but
>      now that we are packed, pulls will be limited only by the time to
>      transfer the objects themselves).
>
>    - Turning off delta compression for the .rand files makes repacking
>      much faster:
>
>        $ echo '*.rand -delta'>.gitattributes
>        $ time git gc --aggressive
>        ...
>        real    0m25.354s
>        user    0m22.057s
>        sys     0m1.316s
>
>      The delta compression phase is very quick, and we spend most of our
>      time writing out the packfile to disk.
>
> So I stand by my earlier statements:
>
>    1. Use "git commit -q" to avoid wasting time on the commit diff
>       summary (we should perhaps have a commit.quiet config option for
>       repos like this where you would almost always want to suppress it).

Thanks, I will try that,

>
>    2. Make sure your upstream repo is packed so pullers do not have to
>       generate a new packfile all the time.

Got that in cron now.


>    3. Use -delta where appropriate to avoid useless delta compression.

Already in there (thanks to your previous advice).


> If things are still slow after that, you'll need to be more specific
> about your exact workload and exactly what is slow (I am still not sure
> if delta compression or network bandwidth is the limiting factor for
> your slow pulls).

It's definitely the pull/push in git. Not knowing my way around git internals at all, I don't know 
(nor do I really want to know, to be honest) which "sub-processes" of `git pull` or `git push` are 
the culprit. Yes, network bandwidth is always a factor, but I guess my expectation is that git 
shouldn't transfer too much more info than the amount of recent changes. For example, if we change 
10 files for a total of 10MB, then my admittedly naive expectation is that git will send that 10MB 
of changes, plus some small constant amount of meta info... not the whole repo every time. No?
