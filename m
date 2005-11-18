From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch --tags doesn't quite do what I expect
Date: Fri, 18 Nov 2005 12:06:29 -0800
Message-ID: <7v1x1diuuy.fsf@assigned-by-dhcp.cox.net>
References: <12c511ca0511181114jf4ca3c0p195a128fa541b8f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:06:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCVH-0003qm-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVKRUGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbVKRUGb
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:06:31 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:24272 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161155AbVKRUGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:06:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118200631.TMIV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 15:06:31 -0500
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca0511181114jf4ca3c0p195a128fa541b8f2@mail.gmail.com>
	(Tony Luck's message of "Fri, 18 Nov 2005 11:14:16 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12251>

Tony Luck <tony.luck@gmail.com> writes:

> Is this intended behaivour?  If so, the "--tags" entry on the
> git-fetch(1) man page needs a little extra text to say that
> --tags limits the fetch to only commits reachable from the
> tags.

I think both Linus (who did the initial implementation of "git
fetch --tags") and I are in "tags do not matter until you care"
camp, and the expected usage pattern is that you frequently do
"git fetch" or "git pull", but "git fetch --tags" is done only
every once in a while, just to give you known anchors to compare
against or specify a known bottom for log, whatchanged and
friends.  The branch heads are necessary for your day to day
work, the tags are less essential.  That is what I mean by "tags
do not matter until you care".

A tag usually points at somewhere in the commit chain leading to
branch heads [*1*], and if your branch heads are up to date,
"git fetch --tags" does not download anything other than the
tags themselves, finds the commits they point at are already
available and complete, and stops there.

Now it happens that "git fetch --tags" slurps commits you do not
yet have _if_ your branch heads are behind, because git barebone
Porcelain is designed to keep your object database complete
(i.e. it does not just fetch and store tags under refs/tags/
without making sure you have everything they connect to).  What
you saw that is a side effect of the above design assumption.

I am not good at documenting things, so I'd appreciate if
somebody paraphrased the above and send it back to me in a patch
form to update the document ;-).


[Footnote]

*1* This is not necessarily true; tags can point at anything,
and indeed v1.0rc3 tag point at another tag and junio-gpg-tag
points at a freestanding blob.  Even a tag pointing at a commit,
as Daniel suggested in

	<Pine.LNX.4.64.0511041745480.25300@iabervon.org>

I could do the "pu" branch as a tag without exposing the actual
branch.  Then that tag would point at a chain of commits not
connected to any branch head.
