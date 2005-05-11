From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-checkout-cache -f -a" failure
Date: Tue, 10 May 2005 22:16:22 -0700
Message-ID: <7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed May 11 07:09:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVjTG-0000X7-OW
	for gcvg-git@gmane.org; Wed, 11 May 2005 07:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEKFQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 01:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKFQg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 01:16:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37555 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261877AbVEKFQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 01:16:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511051622.KHHH7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 01:16:22 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050510230357.GF26384@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 11 May 2005 01:03:58 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> What if you have some files not tracked by git in the subdirectory?
PB> Either you need to check for this and deal with it (Cogito's approach
PB> would be to remove the git-tracked files and rename the subdirectory),
PB> or not do it at all.

Let me understand you correctly.  You "rename the subdirectory"
because the cache you want to check out records a non-directory
there.  Is this correct?  When do you "remove the git-tracked
files"?  Do you mean "if a file that is not tracked (in the
user's mind) is there in the filesystem, and the cache to be
checked out has a file there, the file on the filesystem is
removed"?  What happens if an existing non-directory interferes
with a directory to be checked out from the cache?

I think the right thing for the core GIT layer to do, when the
end user is using the Plumbing tools directly and says "really
please" by specifying an '-f', is to make the checkout succeed
by removing conflicting stuff, as my fixed patch does.

If the Porcelain runs checkout-cache on the user's behalf, the
story is a bit different.  Porcelain would have some idea of
what GIT tree the files in the working directory originated from
("the last commit", or "my head before the read-tree -m merge")
before the user started working in it.  When the user wants to
update the work tree to match a cache (which may be quite
different from "the last commit", if it is coming from cg-seek
or result of a merge), the Porcelain knows:

 - the set of non git-tracked (from the point of view from "the
   last commit") files that are in the work tree;

 - among those, the set of files that would be overwritten by
   this checkout.  This includes, but not limited to, the files
   that would otherwise interfere because of file-directory
   conflicts.

And then you can set aside those "to-be-overwritten" files,
remove them from the filesystem, and run your checkout.

The determination of which files to set aside should not be done
based on whether they cause file-directory conflicts.  If the
user has a non-tracked file which happens to be registered as a
tracked file in the cache to be checked out (e.g. after a
three-way merge), that file is as valuable as a non-tracked file
that is in a subdirectory that the new cache happens to have as
a non-directory.  Losing the former is as harmful as losing the
latter.  From what you say above, it sounds like you are saving
the latter but not the former, but my readins of what you wrote
above may be mistaken.

