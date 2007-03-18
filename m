From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 13:23:18 -0700
Message-ID: <7v8xdul2rt.fsf@assigned-by-dhcp.cox.net>
References: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>
	<20070318121810.GA17807@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 21:23:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT1uU-00016m-Da
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbXCRUXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbXCRUXU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:23:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:62607 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbXCRUXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:23:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318202320.DVKT748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 16:23:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cLPJ1W00S1kojtg0000000; Sun, 18 Mar 2007 16:23:18 -0400
In-Reply-To: <20070318121810.GA17807@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 18 Mar 2007 13:18:10 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42516>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> A	B	Outcome
>> ----------------------------------------------------------------
>> D	D	No problem.
>> 
>> D	F	This should result in refusal when there are
>>                 local modification to paths in "foo" directory,
>> 		or there are untracked (but unignored) paths in
>>                 "foo/".
>
> What about ignored configuration files like config.mak?
> Let's say there is an ignored configuration file in a subdirectory.
> If this subdirectory is replaced by a file git would delete the
> ignored configuration file?

You certainly could argue that way.  At that point switching
from branch A to branch B would become impossible after building
in A ("foo/hello.o" is built but that is ignored) without
running "make clean" first, but I do not think it is a big deal.

Anyway, my Request For Help was not about such details about
what to do with untracked working tree files.  It was about a
more fundamental issue, the confused behaviour of unpack-trees
engine (switching branches, and performing tree-level 3-way
merges), which is used by both read-tree and merge-recursive.
It's so central in everyday git operation, that leaving it buggy
in the presense of D/F conflict is an more serious issue, and
compared to that what we may end up doing to untracked working
tree files is secondary.  We'll get to it eventually but we need
to deal with bigger issue first, as its resolution would change
how the code to deal with the untracked files will be
implemented.

In any case, the reason why for full two years this switching
between branches that have "foo/" and "foo" never surfaced as an
issue is that people are saner than doing that in practice (and
I think people coming from CVS couldn't do that before so they
may not even think about doing so).

For example, if you are writing a paper, it may start out as a
small single file, paper.txt (or paper.tex), then as it grows
you might split it and give it its own subdirectory. You would
not create paper.txt directory and have its chapters in separate
files paper.txt/ch01.txt, paper.txt/ch02.txt, etc. when you do
so in practice. Your directory would most likely be named just
"paper", and the chapters are in paper/ch01.txt, paper/ch02.txt.

So in that sense, switching branches with D/F conflict is much
lower priority item in the real world sense than others cooking
right now.  But I hate leaving known bugs in such a core piece
like unpack-trees, and that was why I sent out my RFH.

By the way, setting Mail-Followup-To: to me is rude.  Please
don't.  The person who wants to talk to you about _your_ message
may not be interested in bothering me.
