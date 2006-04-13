From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] shifting xdiff hunks?
Date: Wed, 12 Apr 2006 23:30:03 -0700
Message-ID: <7vmzeqyolw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 08:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTvLM-0007Cl-WD
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 08:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWDMGaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 02:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWDMGaK
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 02:30:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64973 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964786AbWDMGaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 02:30:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413063005.BRWZ24539.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 02:30:05 -0400
To: Davide Libenzi <davidel@xmailserver.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18651>

I was looking at one diff produced from my work-in-progress,
which looked like this...

    diff --git a/Documentation/git.txt b/Documentation/git.txt
    index 06b2e53..f72abfc 100644
    --- a/Documentation/git.txt
    +++ b/Documentation/git.txt
    @@ -265,6 +265,9 @@ gitlink:git-checkout[1]::
     gitlink:git-cherry-pick[1]::
            Cherry-pick the effect of an existing commit.

    +gitlink:git-clean[1]::
    +       Remove untracked files from the working tree.
    +
     gitlink:git-clone[1]::
            Clones a repository into a new directory.

    @@ -318,6 +321,9 @@ gitlink:git-resolve[1]::

     gitlink:git-revert[1]::
            Revert an existing commit.
    +
    +gitlink:git-rm[1]::
    +       Remove files from the working tree and from the index.

     gitlink:git-shortlog[1]::
            Summarizes 'git log' output.

The first hunk begins by an addition of a couple of non-blank
line followed by an addition of a blank line.  The second hunk,
while it does the same thing, is shown differently.

Now, from correctness point of view, this is not a problem at
all, but I am wondering if xdiff can help to always shift the
hunk down or up to consistently produce one way or another
(personally I feel the former is easier to read).

Here is a rough sketch of what I think I want.  When we have
additions, as long as the first line added happens to match the
first line that is common between the versions that comes after
the added hunk (that is, in the case of the second hunk above,
the empty line before "gitlink:git-rm[1]" happens to match the
empty line after the added three lines), roll the hunk down by
one, until you cannot roll it down anymore.

Just in case I get misinterpreted, I am not talking about
treating empty lines in any special way.  It is more about
"starting the hunk with actually changed line".  The first hunk
above clearly begins with something added, while the second one
does not.

Is this something easy to do with the xdiff code?
