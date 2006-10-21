From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-merge-recursive, was Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 19:17:52 -0700
Message-ID: <7v4ptyjttb.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<200610201821.34712.jnareb@gmail.com>
	<20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	<200610202047.11291.jnareb@gmail.com>
	<Pine.LNX.4.64.0610201151130.3962@g5.osdl.org>
	<45391F1C.80100@utoronto.ca>
	<Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
	<4539318D.9040004@utoronto.ca>
	<Pine.LNX.4.64.0610201333240.3962@g5.osdl.org>
	<Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 04:17:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb6Qu-0005vA-Ri
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 04:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992785AbWJUCRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 22:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992791AbWJUCRy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 22:17:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:24229 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S2992790AbWJUCRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 22:17:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061021021753.GLYY6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 22:17:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cqHd1V00W1kojtg0000000
	Fri, 20 Oct 2006 22:17:38 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610210359040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 21 Oct 2006 04:03:18 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29577>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 20 Oct 2006, Linus Torvalds wrote:
>
>> Git just slurps in all three trees. I actually think that the current 
>> merge-recursive.c does it the stupid way (ie it expands all trees 
>> recursively, regardless of whether it's needed or not), but I should 
>> really check with Dscho, since I had nothing to do with that code.
>
> AFAIR yes, it does the dumb thing, namely it does not take advantage of 
> trees being identical when their SHA1s are identical.
>
> This will be a _tremendous_ speed-up.

While we are talking about merge-recursive, I could use some
help from somebody familiar with merge-recursive to complete the
read-tree changes Linus mentioned early this month.

The issue is that we would want to remove one verify_absent()
call in unpack-tree.c:threeway_merge().  When read-tree decides
to leave higher stages around, we do not want it to check if the
merge could clobber a working tree file, because having an
unrelated file at the same path in the working tree sometimes is
and sometimes is not a conflict, depending on the outcome of the
merge, and that part of the code does not _know_ the outcome
yet.

What this means is that we would need to have the equivalent
check in the merge strategy that uses read-tree for three-way
merge when we remove this overcautious safety check from
read-tree.  I've adjusted merge-one-file to do so, but not many
people use 'resolve' strategy these days, and we would need the
matching change in merge-recursive.

If you are interested, you can see the details in commit 0b35995.
