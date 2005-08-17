From: Matt Draisey <mattdraisey@sympatico.ca>
Subject: Re: symlinked directories in refs are now unreachable
Date: Tue, 16 Aug 2005 20:53:05 -0400
Message-ID: <1124171194.762.74.camel@della.draisey.ca>
References: <1124073677.27393.15.camel@della.draisey.ca>
	 <7v64u7941c.fsf@assigned-by-dhcp.cox.net>
	 <1124089116.749.39.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 17 04:39:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Dp7-0008So-Io
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 04:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVHQCiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 22:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVHQCiS
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 22:38:18 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:29832 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750789AbVHQCiS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 22:38:18 -0400
Received: from Peterborough-ppp280797.sympatico.ca ([206.172.237.178])
          by tomts13-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050817023810.NFFI25800.tomts13-srv.bellnexxia.net@Peterborough-ppp280797.sympatico.ca>
          for <git@vger.kernel.org>; Tue, 16 Aug 2005 22:38:10 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1124089116.749.39.camel@della.draisey.ca>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-08-14 at 22:12 -0700, Junio C Hamano wrote:
> I would like to know
> a use case or two to illustrate why there are symlinks pointing
> at real files outside .git/refs/ hierarchy, and how that
> arrangement is useful.

I've clearly laid out my case very badly.

Here is the patch via sed

$ sed -i -e '49s/lstat/stat/' refs.c

It changes the do_for_each_ref function to follow symlinks blindly in
both the pulling and fscking code.

The usage I have is simple.  I want to use git to give me a personal
versioned filesystem of all my current working data.  My problems are
twofold.  First, it is not obvious where the divisions between projects
should be --- for the most part, this is not distributable software, but
a haphazard collection of one-time code, and various other material that
still benefits from version control.  An all inclusive, time-based
commit of the entire directory structure turns out to be quite useful.
Obviously this use will never be anything but a personal store of data.

Secondly, I have ambitions for some of the software I put together.
These invariably are small projects that may or may not ever become
distributable.  Clearly they require their own commit history, yet given
their immature state it seems hard to justify their own objects
directory with its 256 directories for a few kilobytes of code.  Given
the existence of the GIT_OBJECT_DIRECTORY environment variable, it is a
natural step to sharing a single object store amongst the small
tightly-focused projects and the all-encompassing but unmanaged
outermost directory which already is tracking the contents of the
contained projects but knows nothing of their commit history.

Implementing a commit tool to do this is actually very easy.  All you
need do is walk up the chain of parent directories from your working
directory, noting the .git directories, until you reach one that has
an .git/objects directory then set up the environment appropriately.

The only catch is the necessity of maintaining the common object
directory.  The outermost .git directory needs refs to the contained
subprojects commit histories that it honours in fsck-cache if it is not
to silently delete them the next time you prune the repository.
Symlinking in the refs/heads directories of all subprojects is the most
straightforward way to achieve this as it automatically does the right
thing with very little maintainance.  It also keeps the real refs/heads
of the subprojects' commit histories properly localized in the
subprojects where they belong.  It seems to me that having created the
GIT_OBJECT_DIRECTORY hook, it only makes sense to follow symlinks in the
refs directories.

Matt --- http://free.draisey.ca

P.S.
This email is a bit long-winded so I didn't CC it to the mailing list.
