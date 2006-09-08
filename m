From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 01:33:28 -0700
Message-ID: <7v4pvikbaf.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	<7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
	<46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>
	<7vac5ancvo.fsf@assigned-by-dhcp.cox.net>
	<46a038f90609080015u56daae78u9d78584edae7fb72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:33:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbnV-00072h-OZ
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWIHIdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWIHIdK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:33:10 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:911 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751029AbWIHIdI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 04:33:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908083307.HXJE12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 04:33:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KkYz1V00S1kojtg0000000
	Fri, 08 Sep 2006 04:33:00 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609080015u56daae78u9d78584edae7fb72@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 8 Sep 2006 19:15:53 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26684>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> As far as I can see, this would not need any change to the upload-pack
> protocol.

That I have to disagree.  Take your earlier example of "I have X
and I learned you have A B C D".  Now the fetch that got X was a
commit-only one (but you have full tree for X), but you got X
from somebody else, not the uploader you are talking with right
now.  There is a common ancestor Y somewhere behind X, but
between Y and X you lack trees and blobs.

How would the current protocol work (I am explaining that it
won't be "not need any change")?  After you express interest for
A, B, C, D with "want" messages, you start telling "have X",
"have X~1", have "X~2",... to the uploader (X, X~1 etc. are
object names not symbolic).  Eventually the uploader would
recognize Y that is an ancestor of X that it has and will Ack
it, you stop traversing the ancestor of an acked one and say
"done".  So now we have a common ancestor and the upload side
knows it can omit commits behind  that common commit Y, trees
and blobs contained in Y.

See an Oops here?  You do NOT have trees and blobs associated
with commit Y.

I am not saying we should not change the protocol.  I am just
trying to explain that the problem is not something you can
fudge without changing the protocol.

As a first level approximation, we could in addition to the
commit object name have a bit that says "do I have trees and
blobs associated with the commit" bit on each "have" message (by
the way, this is _expensive_.  You have to traverse down the
tree contained in each commit using has_sha1_file() recursively
to see if you have anything missing from _each_ commit you send
to the other).  Alternatively, you can say "I have this commit,
but I do not have this tree and I do not even know if I have
blobs needed to complete that tree because I do not know what
that tree I am missing contains -- I may have them, I may not. I
truly do not know" to convey the same information.

Think about it a bit -- saying "I know I am missing this tree"
is one thing, but if we end up saying "I do not even know what I
am missing", it is like saying "don't care what I say, just send
everything to me".  Are we gaining much by having only commit
objects on our end?

Once you end up sending a full tree, it is like doing an initial
checkout over CVS when you think you are incrementally fetching,
and you are already lost.  For example, a recent kernel tarball
compressed with gzip is around 50MB; the history for 34k commits
since 2.6.12-rc2 fully packed is slightly less than 150MB.
