From: Junio C Hamano <junkio@cox.net>
Subject: Re: git full diff output issues..
Date: Sun, 05 Jun 2005 01:46:45 -0700
Message-ID: <7vu0kd42dm.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
	<Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org>
	<7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 10:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Deqj6-0004sM-OJ
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 10:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVFEIqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 04:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVFEIqw
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 04:46:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52469 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261353AbVFEIqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 04:46:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605084645.VFPR20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 04:46:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v64x5bt9n.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 26 May 2005 13:56:52 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> This means, btw, that the "git --diff" format must _not_ do

LT> diff --git a/file /dev/null
LT> deleted file mode 100644

JCH> I just checked, and both built-in and git-external-diff-script
JCH> should be safe about this issue.

Sorry, I spoke too soon about a week and half ago X-<, and I am
bugging you about this because this clearly belongs to "fix"
category not "new stuff".

The case you mentioned (i.e. /dev/null) is fine but rename/copy
is "broken" according to the definition by git-apply.

What do you want the diff-patch format to say for this one?

    :100644 100644 SHA1-OLD SHA1-NEW R frotz.c nitfol.c

Currently I am saying:

    diff --git a/frotz.c b/nitfol.c
    similarity index 89%
    rename old frotz.c
    rename new nitfol.c
    --- a/frotz.c
    +++ b/nitfol.c
    @@ ...

and this makes git-apply barf, because a/ and b/ names are
different.  Is the following what you want?  That is, do you
always want p->two->path (name in the right hand side tree)?

    diff --git a/nitfol.c b/nitfol.c
    similarity index 89%
    rename old frotz.c
    rename new nitfol.c
    --- a/frotz.c
    +++ b/nitfol.c
    @@ ...

According to the current apply.c, git_header_name() does not
care as long as a/ and b/ names are the same (that is, I could
even say "diff --git a/junkio b/junkio" to make it grok the
above example, as long as I have the correct "rename old" and
"rename new" in the extended header part).  In that sense, it
all boils down to which name you, as a human consumer of the
patch, would want to see on the header, if we go the route of
making a/ and b/ name always the same.  However I suspect that
this slightly breaks patch reversibility.

If we do care about patch reversibility, having a/ and b/ names
to show the pre- and post- paths like my current output does
(which _does_ break the current apply.c name checking) is
probably the most sensible thing to keep things symmetric.  I am
not sure if it is worth it to make the name checking logic in
apply.c more complicated only to support this rename symmetry,
though.

Another possibility; since "diff --git" is a git-specific header
format anyway, we could quote things to help apply.c parsing it,
without introducing too much clutter for ordinary cases.  How
about taking advantage of the fact that most pathnames do not
contain spaces nor backslashes, and if we see them we simply
quote, like this?

    # no need for quote
    diff --git a/frotz.c b/nitfol.c
    rename old frotz.c
    rename new nitfol.c
    
    # patch for "frotz and nitfol.c"
    diff --git a/frotz\ and\ nitfol.c b/frotz\ and\ nitfol.c

    # rename but filename has spaces and a backslash
    diff --git a/old\ name\\with\ bs b/new\ name\\with\ bs
    rename old old name\with bs
    rename new new name\with bs

