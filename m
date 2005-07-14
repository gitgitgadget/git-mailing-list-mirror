From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Is cogito really this inefficient
Date: Thu, 14 Jul 2005 10:59:38 +0100
Message-ID: <20050714105938.A31383@flint.arm.linux.org.uk>
References: <20050713135052.C6791@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk> <tnxu0ixoiuo.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 12:00:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt0WQ-0000iM-JP
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 12:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbVGNJ7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 05:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVGNJ7x
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 05:59:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262998AbVGNJ7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 05:59:46 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Dt0VI-0005ek-ID; Thu, 14 Jul 2005 10:59:41 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1Dt0VG-0008VJ-VZ; Thu, 14 Jul 2005 10:59:39 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <tnxu0ixoiuo.fsf@arm.com>; from catalin.marinas@gmail.com on Thu, Jul 14, 2005 at 10:08:31AM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 14, 2005 at 10:08:31AM +0100, Catalin Marinas wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> > it appears that cg-diff does a
> >
> > 	git-update-cache --refresh >/dev/null
> >
> > each time it's run, which is taking the bulk of the time.  Also note
> > that curiously, it exits with status 1.
> 
> Does git-ls-files --unmerged show any files?

No, and it returns fairly quickly:

$ /usr/bin/time git-ls-files --unmerged
0.29user 0.03system 0:00.43elapsed 73%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+655minor)pagefaults 0swaps

Actually, I should've left the sh -x /usr/bin/cg-diff drivers/serial/8250.c
running a little longer.  It's not the git-update-cache command which
is taking the time, it's git-diff-cache.

Running the diff several times, both with and without changes to
drivers/serial/8250.c, it seems that sometimes it's faster.  I guess
it has to do with dentry invalidation...

However, the point is - I've only asked for _one_ file.  Why do we need
to look at _every_ file in the tree?

I could understand this behaviour if I'd asked for a diff across the
whole tree, but I didn't.

Internally, the sha1 of the unmodified drivers/serial/8250.c should be
known, so should be trivial to unpack that and generate a diff.  Given
the cache, this should be something which should be lightning fast
when the requested fileset to diff is already known.

-- 
Russell King
