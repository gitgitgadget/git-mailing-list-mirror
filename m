From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make batch mode optional for git-cat-file
Date: Wed, 23 Sep 2015 00:13:50 +0000
Message-ID: <20150923001350.GA22266@dcvr.yhbt.net>
References: <1442843498-22908-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqeghraauu.fsf@gitster.mtv.corp.google.com>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:13:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeXh6-0003Jz-3N
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 02:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935076AbbIWANv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 20:13:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47274 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934802AbbIWANu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 20:13:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4368A1FE1C;
	Wed, 23 Sep 2015 00:13:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D6@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278448>

Victor Leschuk <vleschuk@accesssoftek.com> wrote:
> The thing is that git-cat-file keeps growing during work when running
> in "batch" mode. See the figure attached: it is for cloning a rather
> small repo (1 hour to clone about ~14000 revisions). However the clone
> of a large repo (~280000 revisions) took about 2 weeks and
> git-cat-file has outgrown the parent perl process several times
> (git-cat-file - ~3-4Gb, perl - 400Mb).

Ugh, that sucks.
Even the 400Mb size of Perl annoys me greatly and I'd work
on fixing it if I had more time.

But I'm completely against adding this parameter to git-svn.
git-svn is not the only "cat-file --batch" user, so this option is
only hiding problems.

The best choice is to figure out why cat-file is wasting memory.

Disclaimer: I'm no expert on parts of git written in C,
but perhaps the alloc.c interface is why memory keeps growing.

> What was done:
>  * I have run it under valgrind and mtrace and haven't found any memory leaks
>  * Found the source of most number of memory reallocations (batch_object_write() function (strbuf_expand -> realloc)) - tried to make the streambuf object static and avoid reallocs - didn't help
>  * Tried preloading other allocators than standard glibc - no significant difference

A few more questions:

* What is the largest file that existed in that repo?

* Did you try "MALLOC_MMAP_THRESHOLD_" with glibc?

  Perhaps setting that to 131072 will help, that'll force releasing
  larger chunks than that; but it might be moot if alloc.c is
  getting in the way.

If alloc.c is the culprit, I would consider to transparently restart
"cat-file --batch" once it grows to a certain size or after a certain
number of requests are made to it.

We can probably do this inside "git cat-file" itself without
changing any callers by calling execve.
