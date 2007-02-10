From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 08:25:38 -0800
Message-ID: <7vveiaj7y5.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFv2n-0007QN-N5
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbXBJQZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXBJQZj
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:25:39 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63323 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXBJQZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:25:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070210162539.HKMD22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 10 Feb 2007 11:25:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id MsRe1W00F1kojtg0000000; Sat, 10 Feb 2007 11:25:38 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39237>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > > > > I just need to know if current working directory is clean and report
>> > > > > back to qgit user, so read-only access would be ok for me.
>>
>> [... talking about a patch to introduce --refresh to git-status ...]
>>
>> Well, I tested the patch and indeed it helps a lot ;-)
>
> Not really. The thing is, git-status does a lot more than what you need. 
> And what you need is _only_ what "git diff --name-only HEAD" does already!
>
> It _also_ checks the index, it _also_ only checks the files with different 
> stat information, but it does _not_ try to update the index and prepare a 
> message to be displayed when committing.
>
> So, what is the big problem about accepting that patching git-status for 
> one obscure use is wrong, wrong, wrong, when git-diff already does what is 
> needed???

It really depends on what Marco means by "if cwd is clean".

If by "clean" Marco means "no differences after discarding cache
cleanliness information", "git-diff" is not quite it, as it
shows the differences including the cleanliness of the cache
entry.

"git-status", as Marco found out in the message that started
this thread, loses the cache cleanliness information when it
runs [*1*].

If he cares about cache cleanliness information, "git-diff" is
the right thing to use, and using "git status" is wrong -- it
not only does more than he needs (as you pointed out), it loses
information, which may be worse, depending on why he wants to
know.

[Footnote]

*1* To achieve that, it has to write into the repository.

Is it wrong for "git-status" to be losing the cache cleanliness
information?  The intended audience of that program is those who
are about to make a commit in the repository, as they are asking
"what would I be committing?"  Up to that point, they may have
cared about the reminder they get from "git diff" that they
edited a file and then ended up reverting the whole edit they
did to that file (I find that empty diff from "git diff" often
very useful, although I felt "Huh?"  when I was new to git).
But when they ask "git status", they care more about the real
change, and at that point (since they feel they may be ready to
make a commit -- and that is the whole point of running
"git-status") they do want to lose the cache cleanliness
information.  So "git-status" to be read-write application to
discard the cache-cleanliness information is probably a good
thing.
