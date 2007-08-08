From: Eran Tromer <git2eran@tromer.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during check-out
Date: Tue, 07 Aug 2007 21:41:34 -0400
Message-ID: <46B91F4E.8050008@tromer.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org> <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net> <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org> <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org> <20070805144632.GB999MdfPADPa@greensroom.kotnet.org> <46B76B8C.9050905@tromer.org> <20070806190344.GF999MdfPADPa@greensroom.kotnet.org> <46B7E5FE.7050006@tromer.org> <20070807085149.GH999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed Aug 08 03:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIaYi-0001jc-Ar
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 03:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652AbXHHBl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 21:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762109AbXHHBl5
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 21:41:57 -0400
Received: from forum2.org ([198.65.45.153]:1253 "EHLO forum2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756947AbXHHBl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 21:41:56 -0400
X-F2-Envelope-From: git2eran@tromer.org
X-F2-Envelope-To: git@vger.kernel.org
Received: from moby.tromer.org (c-66-30-26-80.hsd1.ma.comcast.net [66.30.26.80])
	(authenticated bits=0)
	by forum2.org (8.13.6.20060614/8.13.6) with ESMTP id l781fmnH068098;
	Wed, 8 Aug 2007 01:41:48 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <20070807085149.GH999MdfPADPa@greensroom.kotnet.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55292>

On 2007-08-07 04:51, Sven Verdoolaege wrote:
> Surely this is a lot worse than occasionally committing something you
> didn't plan to commit, and only if you are performing a known "dangerous"
> operation.
> 
Are you saying that
$ git reset --hard HEAD && vi foo && git commit -a
is a "known dangerous" operation that can record corrupted content even
though you didn't touch it? This is very bad news indeed! I don't see
any such warnings in the documentation.

So, when I'm sure all the edits I did in the work tree are fine, how
*do* I safely make a commit without manually inspecting the changed
files list, or manually listing the changed files for "git add", or
manually running "git submodule update", or manually checking whether
there happens to be some submodules in this project, some other such
cumbersome measure?


> You may have done several supermodule checkouts since you last changed
> the submodule.

True, that approach won't work. I can imagine some logic to
conditionally update ORIG_HEAD, but it gets messy and fragile. Looks
like brokenness is just inevitable when you let the state get stale and
then merrily read it out as if it's fresh.


So.... Maybe we can tackle this head-on? Let index entries be explicitly
marked as "adrift", meaning we just don't touch the work tree for these
entries -- neither reads nor writes. It's used when the piece of
content, say a submodule, is allowed to drift arbitrarily in the work
tree in a way that doesn't represent meaningful edits that should be
reflected in commits, diffs, etc.

For example:
- "git checkout" sets the "adrift" flag on all (modified?) submodules
- "git submodule update" undrifts ("moores?") the submodules
- "git commit -a" skips files that are adrift, and likewise "git add .",
  "git diff" etc. (perhaps with some warning?)
- "git add <path>" undrifts <path> and proceeds as usual
- "git status" reports drifting files as such and doesn't bother to
  check them in the work tree
- When merging into the work tree, drifting files are left as such

And why stop at submodules? If there's a large blob you don't want to
check out, just "git drift <path>" it. To set whole *directories*
adrift, we can piggybacking on the empty-directory support (i.e., add a
directory entry to the index and set it adrift). So this could be the
basis of partial-checkout support.

Does this sound reasonable?

  Eran
