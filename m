From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 17:39:51 -0800
Message-ID: <7vslqlo0wo.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>
	<87slqty2c8.fsf@mid.deneb.enyo.de>
	<46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
	<Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
	<Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
	<Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>
	<43F113A5.2080506@f2s.com>
	<Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>
	<43F249F7.5060008@vilain.net>
	<Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>
	<7vy80dpo9g.fsf@assigned-by-dhcp.cox.net> <43F27878.50701@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 02:39:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Be8-0006A5-PQ
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 02:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBOBjy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 20:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWBOBjy
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 20:39:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62631 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932376AbWBOBjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 20:39:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215013842.VBAX15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 20:38:42 -0500
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43F27878.50701@vilain.net> (Sam Vilain's message of "Wed, 15 Feb
	2006 13:40:24 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16202>

Sam Vilain <sam@vilain.net> writes:

> ...  Clearly, it needs to be out of the "tree".

OK.

>   2. forensic - extra stuff at the end of the commit object?

(except "extra at the end of commit", which does not make it out
of the tree).

>      eg
>         Copied: /new/path from /old/path:commit:c0bb171d..
>           (for SVN case where history matters)
>         Copied: /new/path from blob:b10b1d..
>           (for general pre-caching case)
>         Merged: /new/path from /old/path:commit:C0bb171d..
>           (for an SVK clone, so we know that subsequent merges on
>            /new/path need only merge from /old/path starting at commit
>            C0bb171d..)

I am not sure if recording the bare SVN ``copied'' is very
useful.  You would need to infer things from what SVN did to
tell if the copy is a tree copy inside a project (e.g. cp -r
i386 x86_64), tagging (e.g. svn-cp rHEAD trunk tags/v1.2), or
branching, wouldn't you?  SVK merge ticket is a bit more useful
in that sense.

So far, git philosophy is to record things you _know_ about and
defer such guesswork to the future, so limiting what you record
to what you can actually see from the foreign SCM would be more
in line with it.  For the same reason, if you are talking about
maildir managed under git, you should not have record anything
other than what git already records: "we used to have these
files, now we have these instead".

But I thought you were talking about caching what earlier
inference declared what happened, so that you do not have to do
the same inference every time.  If that is the case, SVN level
"Copied:" is probably not what you would want to record, I
suspect.  You would do some inference with the given information
("SVN says it copied this tree to that tree, what was it that it
really wanted to do?  Was it a copy, or was it to create a
branch which was implemented as a copy?"), and record that,
hoping that information would help your other operations this
time and later.

So I think the order of questions you should be asking is:

   - what operations are you trying to help?

   - what information you would need to achieve those operations
     better?

   - among the second one, what will be necessary to be set in
     stone (IOW, cannot be computed later), and what are
     computable but expensive to recompute every time?

An example from an ancient thread.

With criss-cross merge between renamed trees, it was conjectured
that recording renames detected earlier would help later merges.
I think you should arrive at the list of "what we should record"
by thinking things in this order:

 (1) currently criss-cross merge between renamed trees does not
     work well (realization of the status quo);

 (2) if we had this kind of information it would work better,
     here are the things we need to record when a new commit is
     made, and here is how to compute other information that can
     be inferred, and here is how to use that information to
     make the merge work better (solution without caching);

 (3) but it is expensive to recompute information we said
     computable in (2) if we were to do so every time.  Let's
     cache it.

I am getting an impression that you are doing only the first
half of (2) without other parts, which somewhat bothers me.
