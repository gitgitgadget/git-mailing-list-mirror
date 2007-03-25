From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge strategy request
Date: Sun, 25 Mar 2007 16:44:52 -0700
Message-ID: <7vejnc28i3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
	<Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
	<7v648paj14.fsf@assigned-by-dhcp.cox.net>
	<46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Lang" <david.lang@digitalinsight.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:44:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcOP-0005HX-TT
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966AbXCYXoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932975AbXCYXoy
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:44:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42467 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966AbXCYXoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:44:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325234455.XEXA1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 25 Mar 2007 19:44:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fBks1W00W1kojtg0000000; Sun, 25 Mar 2007 19:44:53 -0400
In-Reply-To: <46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 26 Mar 2007 11:34:29 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43098>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Would it be possible to have an env var (GIT_MERGE) that can be used
> to call an arbitrary script with merge/diff3 semantics instead of
> using the internal 3-way merge? That way we could do syntax-specific
> merges (ignore comments/whitespace, for example).

I do not think such a patch is hard, as calling external merge
for file-level merge is what we used to do.  It's just a matter
of resurrecting the code we threw away and making it be called
conditionally.

But a more interesting point is "under what condition".  If the
condition is "when GIT_MERGE environment is defined", it is not
much better than what Dscho suggested, as the external merger
would be called for all paths.  We would want a mechanism to
decide use of such a specialized merge backend for special
cases, which is where gitattributes comes into the picture.
Especially because there would be one specialized to merge xml
documents, one to merge gimp xcf files, and another to merge
gentoo configuration files (or whatever the original thread
starter wanted).

> i would surely have a use for it, as sometimes my internal team is not
> _that_ good about trimming whitespace, and we have merges that succeed
> except for their whitespace conflicts.

I know Linus does not like applying patches with whitespace
fuzziness, but I personally think a merge that ignores
whitespace changes would be a useful thing to have, without
having to call an external specialized merge backend. In other
words, I do not think it is so special a thing to want to, but
it is rather an unfortunate norm.  I am not opposed to give
git-merge-recursive a command line option to tell it to merge
ignoring the whitespace-only changes, when it does the 3-way
file-level merge internally.

There is a small detail of how to pass such a command line
option to git-merge-$strategy backends, though.
