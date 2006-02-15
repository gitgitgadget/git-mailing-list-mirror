From: Sam Vilain <sam@vilain.net>
Subject: Re: Handling large files with GIT
Date: Wed, 15 Feb 2006 17:03:52 +1300
Message-ID: <43F2A828.2050102@vilain.net>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com>	<87slqty2c8.fsf@mid.deneb.enyo.de>	<46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>	<Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>	<Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>	<Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>	<Pine.LNX.4.64.0602122058260.3691@g5.osdl.org>	<43F113A5.2080506@f2s.com>	<Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0602141108050.3691@g5.osdl.org>	<43F249F7.5060008@vilain.net>	<Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>	<7vy80dpo9g.fsf@assigned-by-dhcp.cox.net> <43F27878.50701@vilain.net> <7vslqlo0wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 05:04:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9Dtr-0001cv-FZ
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 05:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbWBOEEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 23:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWBOEEL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 23:04:11 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:24224 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1422675AbWBOEEK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 23:04:10 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id AAA074C73; Wed, 15 Feb 2006 17:04:04 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 5B1D94C4A;
	Wed, 15 Feb 2006 17:03:56 +1300 (NZDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslqlo0wo.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16208>

Junio C Hamano wrote:
> So I think the order of questions you should be asking is:
> 
>   1 - what operations are you trying to help?

Primarily, tracing history when dealing with history/changeset based
revision systems like SVN or darcs, and doing this in a manner that we
can make guarantees about behaving in the same way as those systems
would.

>   2 - what information you would need to achieve those operations
>       better?

Minimally, this tuple:

   ( merge|copy, source_path, source_tree|source_commit,
     destination_path, destination_commit )

It makes sense to record this with commits, as conceptually it is a part
of the intended commit history along with the change comment.

>   3 - among the second one, what will be necessary to be set in
>       stone (IOW, cannot be computed later), and what are
>       computable but expensive to recompute every time?

The only operation you cannot automatically and with certainty detect a 
rename and change content without inserting a dummy commit between the 
name change and the content change.  But in a sense this is the same as
my suggestion - using the commit object history to record information
that normally doesn't matter when you are doing content-keyed
operations.

> I am getting an impression that you are doing only the first
> half of (2) without other parts, which somewhat bothers me.

Well, thank you for spending so much time to reply to me given that was
your assessment.  I think the best direction from here would be to start
molding some porcelain, then I can cross this bridge when I come to it
rather than simply speculating and hand-waving.

Besides, I can always prototype it for discussion using the commit
description as a surrogate container for the information.

Sam.

ps I also responded to the rest of your e-mail, but decided that the 
answers to the above questions were more important.

 >>  2. forensic - extra stuff at the end of the commit object?
 > (except "extra at the end of commit", which does not make it out
 > of the tree).

It is a part of the repository, but more a property of the commit itself
- like the commit description.  Like somebody writing "I renamed this
file to that file and changed its contents", but in a parsable form
that can _optionally_ be used to prevent the relevant git-core tools
from having to do content comparison, or perhaps something subtler like
increasing the score of the recorded history branch when scoring
alternatives looking for history.

 >>     eg
 >>        Copied: /new/path from /old/path:commit:c0bb171d..
 >>          (for SVN case where history matters)
 >>        Copied: /new/path from blob:b10b1d..
 >>          (for general pre-caching case)
 >>        Merged: /new/path from /old/path:commit:C0bb171d..
 >>          (for an SVK clone, so we know that subsequent merges on
 >>           /new/path need only merge from /old/path starting at commit
 >>           C0bb171d..)
 > I am not sure if recording the bare SVN ``copied'' is very
 > useful.  You would need to infer things from what SVN did to
 > tell if the copy is a tree copy inside a project (e.g. cp -r
 > i386 x86_64), tagging (e.g. svn-cp rHEAD trunk tags/v1.2), or
 > branching, wouldn't you?  SVK merge ticket is a bit more useful
 > in that sense.

In the SVN model there really is no difference between these cases.  Of
course the actual representation of these in the object does not matter;
the above is the what, not the how.  But in general, SVN only records
copying; it has no repository concept of merge, branch, tag, rename.
SVK adds merging to the picture.

Representing an SVN tree copy as a new sub-tree in a git repository
should still be a "cheap copy", it's just that all the tools will not
(and probably should not) see it as a branch but a copy.

 > So far, git philosophy is to record things you _know_ about and
 > defer such guesswork to the future, so limiting what you record
 > to what you can actually see from the foreign SCM would be more
 > in line with it.

Yes, and if I am mirroring an SVN repository, then I only know that in
that repository, the history /was recorded/ as such.  Not the history
/is/ as such, that's a different question, and is the guesswork worth
being defered to the future.

 > For the same reason, if you are talking about
 > maildir managed under git, you should not have record anything
 > other than what git already records: "we used to have these
 > files, now we have these instead".

Ok.  As Martin pointed out, the Maildir situation is actually a simple
case.  In a sense, I hijacked a vaguely related thread to resolve my
Warnock dilemma :)

 > But I thought you were talking about caching what earlier
 > inference declared what happened, so that you do not have to do
 > the same inference every time.  If that is the case, SVN level
 > "Copied:" is probably not what you would want to record, I
 > suspect.  You would do some inference with the given information
 > ("SVN says it copied this tree to that tree, what was it that it
 > really wanted to do?  Was it a copy, or was it to create a
 > branch which was implemented as a copy?"), and record that,
 > hoping that information would help your other operations this
 > time and later.

Well, this is already guesswork defered to the future that the
Subversion authors inflict on the users of Subversion repositories.  If
you read the Subversion manual you will find recommendations to
studiously record this information and to use a standard repository
layout so that other people will understand what your copies were
intended to be.
