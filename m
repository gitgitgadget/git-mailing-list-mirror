From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sun, 04 Sep 2005 12:10:12 -0700
Message-ID: <7vvf1gejjf.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
	<20050903220355.GA1895@mars.ravnborg.org>
	<7v64thl248.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509041329340.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:11:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBzsv-00012A-Uu
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 21:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVIDTKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 15:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVIDTKT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 15:10:19 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3739 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751023AbVIDTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 15:10:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050904191014.YPMV8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 15:10:14 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509041329340.23242@iabervon.org> (Daniel
	Barkalow's message of "Sun, 4 Sep 2005 14:28:27 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8068>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think this is actually quite a regular merge, and I think we should be 
> able to offer some assistance. The situation with K is normal: case #3ALT. 
> If someone introduces a file and there's no file or directory with that 
> name in other trees, we assume that the merge should include it.

I was not particularly interested in discussing the initial
merge, which is a perfectly regular merge as you said.  I was
more focusing on reusing the tree-structure change information
we _could_ find in merge #3 when we make later merges, because
that merge is something the user did in the past and would be a
good guide for guessing what the user wants to happen to this
round.

There is no question about K in 'keeping addition' case.  It
gets interesting only when the first merge prefered 'reject
addition by them' and we would want to reuse that preference in
the second merge.  But as I tried to clarify in the "a couple of
things worth mentioning" message, there is no fundamental reason
to treat removal and addition any differently.  It is just a way
to reduce unnecessary conflicts.

> Most likely, this just means that we 
> should not commit automatically, but have the user test the result first.

No question about it again.

> Of course, read-tree is in flux at 
> the moment, so making more structural changes to it at the same time is 
> awkward.

Doing this in read-tree is a bit premature.  I'd prefer a
scripted solution first to see what we want and how well it
works in practice.

>   1
>  / \
> 0-2-3-5-7
>    \   /
>     4-6
>
> It shouldn't matter to the merge at 7 if the 2-3 reorganization was done 
> locally, by applying a patch, or by merging.

There was another problem in my message that treated #3
specially.  I did it that way primarily because I wanted to have
an algorithm that needs to look only limited (namely, one)
number of commits, more than what we currently look at.  The
problem is that the trail #0..#1..#3 (in the example in second
message, whose rename probably happened between #0 and #1) may
change the contents of the renamed file so drastically that diff
between #2 and #3 may not look like rename anymore, while we
could still detect it if we followed the whole trail and looked
for renames between each commit on it.
