From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] embedded TAB and LF in pathnames
Date: Sat, 08 Oct 2005 02:10:37 -0700
Message-ID: <7vachks7aq.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 11:12:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOAjr-0006X7-1x
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 11:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVJHJKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 05:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVJHJKk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 05:10:40 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48597 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750817AbVJHJKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 05:10:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051008091027.NOIQ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Oct 2005 05:10:27 -0400
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9836>

Alex Riesen <raa.lkml@gmail.com> writes:

          Quote  nongraphic  characters in file names using alphabetic and
          octal backslash sequences like those used in C. This  option  is
          the  same as -Q except that filenames are not surrounded by dou-
          ble-quotes.

If you have a file whose name is 'foo' + LF + 'bar', and if you
use backslash convention, your diff would start like this:

    diff --git a/foo\nbar b/foo\nbar
    @@ 1,2 3,4 @@
     context
    -deleted
    ...

which looks quite natural.

I would, however, prefer this kind of funny pathnames to *stand*
*out* more than usual, to make it really obvious that there is
something really funky going on.  In that sense, the above is a
bit too innocuous-looking to my taste.

But this "embedded LF and TAB" is a corner case.  I would not be
using such paths that would trigger the quoting myself anyway,
and I do not particularly care as long as the tools do the right
thing -- any quoting rule would do, as long as the generating
side (git-diff) is consistent with accepting side (git-apply),
and as long as there is no new ambiguity introduced.

The backslash proposal is introducing a small ambiguity.  You
cannot tell if the file had an embedded LF between 'foo' and
'bar' (and generated with your git-diff) or had an embedded
backslash between 'foo' and 'nbar' (and generated with existing
git-diff).  Since we never had a version of git-diff that
outputs double-slashes '//' in paths, there is no ambiguity if
we use it as a quoting mechanism.

Just as a concrete demonstration, here is how the git-status
output and git-diff output would look like for a file 'pqr' in a
directory whose name is 'def' + LF + 'ghi' that uses the version
of git-diff from the proposed updates branch:

        # Changed but not updated:
        #   (use git-update-index to mark for commit)
        #
        #	modified: def//{LF}//ghi/pqr

        diff --git a/def//{LF}//ghi/pqr b/def//{LF}//ghi/pqr
        index 9ee055c..47dbc3f 100644
        --- a/def//{LF}//ghi/pqr
        +++ b/def//{LF}//ghi/pqr
        @@ -1 +1,2 @@
         Fri Oct  7 23:19:04 PDT 2005
        +foo

I am not married to this quoting syntax -- I think it *is* ugly,
but as I said before, I'd prefer to have something ugly here.

I would easily be persuaded otherwise, though.  A working patch
would probably be the most effective way of persuasion, but a
mock output without the code to produce and/or parse it would
also be fine as a starting point for discussion.
