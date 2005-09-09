From: Junio C Hamano <junkio@cox.net>
Subject: Re: Multi-ancestor read-tree notes
Date: Fri, 09 Sep 2005 10:29:27 -0700
Message-ID: <7vy866i1zc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 19:31:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDmh6-0002ud-2a
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 19:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVIIR33 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Sep 2005 13:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVIIR33
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Sep 2005 13:29:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:65506 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030276AbVIIR33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2005 13:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050909172928.ENTK20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Sep 2005 13:29:28 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509050049030.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 5 Sep 2005 01:41:36 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8247>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In case #16, I'm not sure what I should produce. I think the best thing 
> might be to not leave anything in stage 1. The desired end effect is that 
> the user is given a file with a section like:
>
>   {
>     *t = NULL;
>     *m = 0;
> <<<<<<<<
>     return Z_DATA_ERROR;
> ========
>     return Z_OK;
>>>>>>>>>
>   }

I was thinking a bit more about this.  Let's rephrase case #16.
I'll call merge bases O1, O2,... and merge heads A and B, and we
are interested in one path.

If O1 and O2, the path has quite different contents.  A has the
same contents as O1 and B has the same contents as O2.  We
should not just pick one or the other and do two-file merge
between the version in A and B (we could prototype by massaging
'diff A B' output to produce what is common between A and B and
run (RCS) merge of A and B pretending that the common contents
is the original to produce something like the above).

If A has slight changes since O1 but B did not change since O2,
ideally I think we would want the same thing to happen.  Let's
call it case #16+.

What does the current implementation do?  It is not case #16
because A and O1 does not exactly match.  I suspect the result
will be skewed because B has an exact match with O2.  The
situation becomes more interesting if both A and B has slight
changes since O1 and O2 respectively.  They do not exactly match
with their bases, but I think ideally we would like something
very similar to case #16 resolution to happen.

One way to solve this would be to try doing things entirely in
read-tree by doing not just exact matches but also checking the
amount of changes -- if each heads has similar but different
base call it case #16 and try two-file merge between the heads
disregarding the bases.

But I am a bit reluctant to suggest this.  My gut feeling tells
me that these 'interesting' cases are easier if scripted outside
read-tree machinery to later enhance and improve the heuristics.

Of course, the current case #16 detected by the exact match rule
should be something we can automatically handle, but to make
things safer to use I think we should have a way to detect case
#16+ situlation and avoid mistakenly favoring A over B (or vice
versa) only because one has slight modification while the other
does not.
