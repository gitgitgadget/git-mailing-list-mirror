From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Wed, 23 Sep 2015 19:22:12 +0000
Message-ID: <20150923192212.GA8577@dcvr.yhbt.net>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
 <20150923001350.GA22266@dcvr.yhbt.net>
 <20150923003516.GA6086@dcvr.yhbt.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9DC@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:22:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZepcQ-0004ep-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbbIWTWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:22:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59871 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694AbbIWTWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:22:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C6B1FE1C;
	Wed, 23 Sep 2015 19:22:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9DC@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278506>

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
