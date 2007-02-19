From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebasing a branch that contains merges
Date: Mon, 19 Feb 2007 01:36:07 -0800
Message-ID: <7vmz3a8p6g.fsf@assigned-by-dhcp.cox.net>
References: <200702190912.24067.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 19 10:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ4wY-0003Rl-1R
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbXBSJgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbXBSJgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:36:09 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37300 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXBSJgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:36:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219093608.OORT21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Feb 2007 04:36:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RMc71W00e1kojtg0000000; Mon, 19 Feb 2007 04:36:08 -0500
In-Reply-To: <200702190912.24067.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 19 Feb 2007 09:12:22 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40108>

Andy Parkins <andyparkins@gmail.com> writes:

> This is an unreasonable thing to expect a version control
> system to be able to do ...

I do not necessarily think so.  If you have this:

       o---X
      /
  ---a---o---o---o
          \       \ 
          -o---o---M---Y

it is perfectly reasonable to want to have this:

       o---X---o---o---o
      /         \       \ 
  ---a           o---o---M'--Y'

when you say "rebase --onto X a Y".

However, you have to be careful.  The thing is, you do not want
to 'rebase' a merge if the other branch came from somewhere not
under your control.  If 'a', 'o', 'X', 'Y' and 'M' are under
your control, and 'x' are from somebody else's tree in the
following picture:

       o---X
      /
  ---a---o---o---o
      \           \
       x---x---x---M---Y

and if you say "rebase --onto X a Y", it is not useful to rebase
'x' when you want to rewrite your history.  They are somebody
else's history, and other people might have got it already, too.
Even if you _could_ rebase them, you would rather not.

And this is true even if 'x' are your own.  You might have
pushed out these 'x' to public repo although you haven't pushed
out 'M', 'Y', 'o' nor 'X', and would want to rebase the
still-private part to clean up the history before publishing.
In such a case, you would want to end up with something like
this:

       o---X---o---o---o
      /                 \
  ---a           .-------M'--Y'
      \         /
       x---x---x

This kind of rebase should be doable but you would need to tell
the tool which parents of merges you would want to rebase and
which ones you do not want to touch but recreate the merge by
merging with your rebased branches again.  In the above 'ideal',
picture, three 'o's have been rebased, and then merge 'M' was
recreated from the rebased rightmost 'o' and the rightmost 'x'
in the original picture.
