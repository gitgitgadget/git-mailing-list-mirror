From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 16:21:26 -0700
Message-ID: <7vwtbgbsax.fsf@assigned-by-dhcp.cox.net>
References: <20060616171251.GA29820@suse.de> <4492E8F9.4000106@shlrm.org>
	<7v7j3gdc7t.fsf@assigned-by-dhcp.cox.net>
	<1150494975.DBA8A55@be12.dngr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 01:21:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrNd7-00021a-2k
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 01:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWFPXV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWFPXV3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 19:21:29 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:33767 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932472AbWFPXV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 19:21:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060616232127.SNHB19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Jun 2006 19:21:27 -0400
To: David Kowis <dkowis@shlrm.org>
In-Reply-To: <1150494975.DBA8A55@be12.dngr.org> (David Kowis's message of
	"Fri, 16 Jun 2006 16:56:12 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21987>

David Kowis <dkowis@shlrm.org> writes:

>>>  commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
>>>  Author: David Kowis <dkowis@kain.org>
>>>  Date:   Fri Jun 16 12:20:08 2006 -0500
>>>
>>>      this is a multi
>>>
>>>      line comment
>>>      with three lines
>>>
>>>
>>>  I'm using git 1.4.0. It added a blank line in there...
>>
>> Actually, this is an odd but intended behaviour ;-).
>
> Why is this behaviour intended? Just because I'm curoius. :)

You are not alone; sorry for the terse and confusing initial
response (I am just back from a long flight, finished
unpacking and quite tired).

At the lowest level of git that defines the object format, a
commit object consists of structural header in fixed format,
followed by any binary blob you feed git-commit-tree from the
standard input.  I do not recall the details of the
implementation offhand, but we _might_ chomp at the first NUL
and if we did so I may say it is a bug -- commit-tree should not
care what "the log message" part consists of.

It is however quite a different story when it comes to the
higher level tools that come with git.  The log summarize
facilities to let humans interact with the commits expect that a
commit log message consists of a one-line "summary", a blank
line, and then the body of the message.  These "log listers" are:

 . git log --pretty=oneline
 . gitk
 . gitweb
 . gitview
 . git shortlog

The "one-line summary plus body of the message" has a strong
correlation with how we communicate patches via e-mail.  You do
not start a sentence on the "Subject: " header and continue on
to the body of the message, starting the body halfway of the
sentence.  Instead, you try to make sure you write something
sensible by itself on the "Subject: " header to help the
recipient when later scanning for it among bunch of messages,
and you write a full paragraph that you can understand without
reading the subject line first.  The following commands that
deal with e-mailed patches expect you to follow that convention:

 . git am
 . git applymbox
 . git format-patch

Now, answer to your question why rebase bahaves that way are
because:

 (1) I was lazy and reused the e-mailed patch machinery to
     implement it, although rebase is something that _should_
     work at a level closer to the core level than the human
     level (e.g. it should be able to commute a patch that
     affects binary content changes -- which it does).

 (2) The user should be following the convention to make the
     output from the log listers reasonable anyway, so the only
     people who are harmed by reusing the e-mailed patch
     machinery were people who did not finish a short-and-sweet
     summary sentence on the first line, and it is better to
     train users to do so anyway.

Having said that, I would say it is a bug.  We should be able to
rebase, cherry-pick and/or rebase a patch with an arbitrary
binary garbage in the commit log message (I think the latter two
command do).  But because of the reason (2) above, it is very
low on my priority to change it.
