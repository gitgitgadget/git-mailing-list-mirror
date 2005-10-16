From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git repository
Date: Sat, 15 Oct 2005 19:20:10 -0700
Message-ID: <7vpsq6fbj9.fsf@assigned-by-dhcp.cox.net>
References: <7vwtkfpbyk.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510142340r2fe24ce6j5d0d96535fbb2517@mail.gmail.com>
	<7vr7amjqa1.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510151734k141f218crc2ccfbb78769e518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 04:21:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQy8J-0003W6-Sy
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 04:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVJPCUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 22:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbVJPCUN
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 22:20:13 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64251 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751272AbVJPCUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 22:20:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016021949.WCKL29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 22:19:49 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510151734k141f218crc2ccfbb78769e518@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 16 Oct 2005 13:34:38 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10153>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> One thought I had this morning is that given that the
> tree->commit->tagobj relation is unique and stable, it'd be a valid
> strategy to have files in .git/refs/tags/ optionally contain the 3
> identifiers. It is plainly safe to cache this permamently, the only
> pain now is to deal with teaching all the porcelains about it.
>
> What do you think?

Many ref readers read just the first 40 bytes and ignore the
rest, so storing "tag-SHA1 followed by optional information"
there would not hurt them that much.  But the question now is
what optional information to place there?

Obviously, we could do:

        echo '5dc01c59... tree=c39ae07f...' >.git/refs/tags/v2.6.11
        echo '26791a8b... commit=9ee1c9... tree=e4660ac...' >.git/refs/tags/v2.6.12
	echo '0918385d... blob=b92c9c0...' >.git/refs/tags/junio-gpg-pub

But, then we could also do:

	(
        	echo '5dc01c59...'
                git-cat-file tag v2.6.11
	) >.git/refs/tags/v2.6.11

There is no need to read 'tag' object separately -- it is all
there.  The same thing can be said for a tag that refers to
another tag that refers to a commit that contains a tree.  So
the question becomes "where to stop?".

I suspect the answer to that question is "it depends".  And I
also suspect "sed -e '...' <.git/refs/tags/v2.6.11" after we add
minimum optional information (not tag text but only commit and
perhaps tree object name) to these files would not be that much
cheaper than doing "git-cat-file commit v2.6.11 | sed -e '...'".
In other words, my gut feeling tells me that it would not buy us
that much.

I've also thought about showing v2.6.12^{tree} in addition to
v2.6.12^{} from ls-remote, and showing v2.6.12^{commit} instead
of v2.6.12^{}, to make the type of what it dereferences to more
explicit.  I did not do things that way because I was not quite
sure how much the additional complexity and additional output
from ls-remote would buy us.
