From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Sun, 11 Oct 2015 05:31:57 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E7@mail.accesssoftek.com>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
 <20150923001350.GA22266@dcvr.yhbt.net> <20150923003516.GA6086@dcvr.yhbt.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9DC@mail.accesssoftek.com>,<20150923192212.GA8577@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"vleschuk@gmail.com" <vleschuk@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 14:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlFnJ-00041A-EW
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 14:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbJKMcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 08:32:00 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:47947 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbJKMb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2015 08:31:59 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Sun, 11 Oct 2015 05:31:57 -0700
Thread-Topic: [PATCH] git-svn: make batch mode optional for git-cat-file
Thread-Index: AdD2NSc0lOq7ADl5TEuOhQQ9roiAkAN4VEps
In-Reply-To: <20150923192212.GA8577@dcvr.yhbt.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279335>

Hello Eric,

Thanks for all the advices. I have played with several repositories (both on 32bit and 64bit machines). You were correct most of the memory if used by mapped files and yes it doesn't cause any problems, even a 32bit machine with 500Mb of memory works normally with a heavy loaded git-cat-file.

Thanks also for the advice to use git gc config options, I tested gc.auto=0 and it lead to the same behavior as my setting MALLOC_LIMIT, however it is more correct way to get this effect =)

I agree that we shouldn't worry about mapped files.

--
Best Regards,
Victor
________________________________________
From: Eric Wong [normalperson@yhbt.net]
Sent: Wednesday, September 23, 2015 12:22 PM
To: Victor Leschuk
Cc: Junio C Hamano; git@vger.kernel.org
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file

Victor Leschuk <vleschuk@accesssoftek.com> wrote:
> Hello Eric, thanks for looking into it.
>
> >> git-cat-file has outgrown the parent perl process several times
> >> (git-cat-file - ~3-4Gb, perl - 400Mb).
>
> > Ugh, that sucks.
> > Even the 400Mb size of Perl annoys me greatly and I'd work
> > on fixing it if I had more time.
>
> I was going to look at this problem also, but first I'd like to improve the situation with cat-file as on large repos it is larger problem. By the way, what direction would you suggest to begin with?

See below :)

<snip anonymous memory stuff, it doesn't seem to be a culprit>

> > > git-cat-file has outgrown the parent perl process several times
> > > (git-cat-file - ~3-4Gb, perl - 400Mb).
>
> > How much of that is anonymous memory, though?
>
> Haven't measured on this particular repo: didn't redo the 2 week
> experiment =) However I checked on a smaller test repo and anon memory
> is about 12M out of 40M total. Most of memory is really taken by
> mmaped *.pack and *idx files.

If it's mmap-ed files, that physical memory is only used on-demand
and can be dropped at any time because it's backed by disk.

In other words, I would not worry about any file-backed mmap at all
(unless you're on 32-bit, but I think git has workarounds for that)

Do you still have that giant repo around?

Are the combined size of the pack + idx files are at least 3-4 GB?

This should cat all the blobs in history without re-running git-svn:

        git log --all --raw -r --no-abbrev | \
          awk '/^:/ {print $3; print $4}' | git cat-file --batch

git log actually keeps growing, but the cat-file process shouldn't
use anonymous memory much if you inspect it with pmap.

> Actually I accidentally found out that if I export GIT_MALLOC_LIMIT
> variable set to several megabytes it has the following effect:

>  * git-svn.perl launches git-gc
>  * git-gc can't allocate enough memory and thus doesn't create any pack files
>  * git-cat-file works only with pure blob object, not packs, and it's
> memory usage doesn't grow larger than 4-5M
>
> It gave me a thought that maybe we could get rid of "git gc" calls
> after each commit in perl code and just perform one large gc operation
> at the end. It will cost disk space during clone but save us memory.
> What do you think?

You can set gc.auto to zero in your $GIT_CONFIG to disable gc.
The "git gc" calls were added because unpacked repos were growing
too large and caused problems for other people.

Perhaps play with some other pack* options documented in
Documentation/config to limit maximum pack size/depth.

Is this a 32-bit or 64-bit system?

> As for your suggestion regarding periodic restart of batch process
> inside git-cat-file, I think we could give it a try, I can prepare a
> patch and run some tests.

I am not sure if we need it for git-svn.

In another project, the only reason I've found to restart
"cat-file --batch" is in case the repo got repacked and old packs
got unlinked, cat-file would hold a reference onto the old file
and suck up space.   It might be better if "cat-file --batch" learned
to detect unlinked files and then munmap + close them.
