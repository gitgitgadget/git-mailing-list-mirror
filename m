From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 16:32:49 -0800
Message-ID: <7v8xsezsni.fsf@assigned-by-dhcp.cox.net>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
	<7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
	<20060213021917.742b2b10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 01:34:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8o8w-0008SO-Tz
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 01:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWBNAdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 19:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWBNAdx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 19:33:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12691 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030305AbWBNAdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 19:33:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214003120.QYOH6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 19:31:20 -0500
To: Andrew Morton <akpm@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16092>

Andrew Morton <akpm@osdl.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>> > My current theory is that I was bisecting Linus's tree all along.
>> 
>> Sorry, I did not realize that was _not_ what you were doing.
>> Your log started by saying 2.6.16-rc1 is good but 2.6.16-rc2 was
>> not, so I just assumed your bug was between those two.
>
> So how am I supposed to find this bug in Jeff's tree?

Sorry, this question is what I do not quite understand.

Here is my understanding of the situation.

 - Betweeen 2.6.16-rc1 and 2.6.16-rc2 a bug you are chasing was
   introduced.  You know rc1 works fine but rc2 is bad.

 - You suspect that changes introduced by merging Jeff's tree
   at some point between -rc1 and -rc2 may be causing this.

Am I totally misunderstanding the situation?

Bisecting, starting from -rc1 and -rc2 marked good and bad would
find the bug provided if the symptom is caused by a single bug
(that is, before that commit things work but after that things
stop working) that is in any commit that was not present in -rc1
but in -rc2.  That includes what was merged from Jeff's tree, so
even if you were "bisecting Linus' tree all along", if -rc1 was
good and -rc2 was bad, that would have found the bug in Jeff's
tree (if it was what introduced the bug).  As long as that was
merged between these two -- but otherwise breakage in -rc2 would
not have anything to do with Jeff's tree, so that is one reason
I am confused by your emphasis on "in Jeff's tree" part.


              good                     bad
              -rc1                     -rc2
    ---o---o---o---*---*---*---*---*---*
        \           \     /   /
         \           *---*   /
          \                 / 
           *---*---*---*---*
                Jeff's       

Your bisection that starts with good -rc1 and bad -rc2 would try
to bisect commits that are not reachable from good ones (that
is, parents before good ones are assumed to be good, since
bisect is only good to look for a single regression), so at the
beginning, all '*' commits are suspects.  bisection picks one of
them and after testing it, depending on it is good or bad, mark
about the half of the remaining graph "unsuspected".  So even if
you start out with two commits on Linus' tree, you will wander
into Jeff's tree, if the suspect commit is in there.  I am
confused by your emphasis on "in Jeff's tree" part.

Maybe you are saying that you _know_ what broke was from Jeff's
tree, and felt bisecting other parts of Linus' tree was
wasteful?

If so, you can use gitk to visualize the graph, find the merge
Linus' did to merge from Jeff (and I presume you already did so
and that is why you are suspecting Jeff's tree).  Mark that as
bad, not -rc2.  Also if you know the commit on Linus' tree
before that merge was good (and I presume you already did so
and that is why you are suspecting Jeff's tree), mark that as
good, not -rc1.

              -rc1      good  bad     -rc2
    ---o---o---o---o---o---o---*---o---o
        \           \     /   /
         \           o---o   /
          \                 / 
           *---*---*---*---*
                Jeff's       

Then your bisect will walk over commits on Jeff's tree.

Is this helpful, or am I still completely useless?
