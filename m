From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Wed, 23 Sep 2015 08:28:02 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9DC@mail.accesssoftek.com>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
 <20150923001350.GA22266@dcvr.yhbt.net>,<20150923003516.GA6086@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 23 17:28:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zely2-0006gJ-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 17:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbbIWP2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 11:28:13 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:49466 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbIWP2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 11:28:12 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Wed, 23 Sep 2015 08:28:03 -0700
Thread-Topic: [PATCH] git-svn: make batch mode optional for git-cat-file
Thread-Index: AdD1l7jtB8sigWGxTxOBIPHyb8+HogAbfl4i
In-Reply-To: <20150923003516.GA6086@dcvr.yhbt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278489>

Hello Eric, thanks for looking into it.

>> git-cat-file has outgrown the parent perl process several times
>> (git-cat-file - ~3-4Gb, perl - 400Mb).

> Ugh, that sucks.
> Even the 400Mb size of Perl annoys me greatly and I'd work
> on fixing it if I had more time.

I was going to look at this problem also, but first I'd like to improve the situation with cat-file as on large repos it is larger problem. By the way, what direction would you suggest to begin with?

> A few more questions:

> * What is the largest file that existed in that repo?

About 2.5M

> * Did you try "MALLOC_MMAP_THRESHOLD_" with glibc?

Have just tried it on a smaller repo (which takes about 1 hour to clone and RSS grows from 4M to 40M during the process. Unfortunately there is no much of an effect: max RSS is 41M with default settings and 38M with MALLOC_MMAP_THRESHOLD_=131072.

> If alloc.c is the culprit, I would consider to transparently restart
"cat-file --batch" once it grows to a certain size or after a certain
number of requests are made to it.

alloc.c interface is not used in cat-file at all, only direct calls to xmalloc and xrealloc from wrapper.c, and also xmmap() from sha1_file.c.

> > git-cat-file has outgrown the parent perl process several times
> > (git-cat-file - ~3-4Gb, perl - 400Mb).

> How much of that is anonymous memory, though?

Haven't measured on this particular repo: didn't redo the 2 week experiment =) However I checked on a smaller test repo and anon memory is about 12M out of 40M total. Most of memory is really taken by mmaped *.pack and *idx files.

Actually I accidentally found out that if I export GIT_MALLOC_LIMIT variable set to several megabytes it has the following effect:
 * git-svn.perl launches git-gc
 * git-gc can't allocate enough memory and thus doesn't create any pack files
 * git-cat-file works only with pure blob object, not packs, and it's memory usage doesn't grow larger than 4-5M

It gave me a thought that maybe we could get rid of "git gc" calls after each commit in perl code and just perform one large gc operation at the end. It will cost disk space during clone but save us memory. What do you think?

As for your suggestion regarding periodic restart of batch process inside git-cat-file, I think we could give it a try, I can prepare a patch and run some tests.

--
Best Regards,
Victor
________________________________________
From: Eric Wong [normalperson@yhbt.net]
Sent: Tuesday, September 22, 2015 5:35 PM
To: Victor Leschuk
Cc: Junio C Hamano; git@vger.kernel.org
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file

Eric Wong <normalperson@yhbt.net> wrote:
> Victor Leschuk <vleschuk@accesssoftek.com> wrote:
> > The thing is that git-cat-file keeps growing during work when running
> > in "batch" mode. See the figure attached: it is for cloning a rather
> > small repo (1 hour to clone about ~14000 revisions). However the clone
> > of a large repo (~280000 revisions) took about 2 weeks and
> > git-cat-file has outgrown the parent perl process several times
> > (git-cat-file - ~3-4Gb, perl - 400Mb).

How much of that is anonymous memory, though?
(pmap $PID_OF_GIT_CAT_FILE)

Running the following on the Linux kernel tree I had lying around:

(for i in $(seq 100 200); do git ls-files | sed -e "s/^/HEAD~$i:/"; done)|\
  git cat-file --batch >/dev/null

Reveals about 510M RSS in top, but pmap says less than 20M of that
is anonymous.  So the rest are mmap-ed packfiles; that RSS gets
transparently released back to the kernel under memory pressure.
