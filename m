From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 11:48:44 -0800
Message-ID: <7vmys36d7n.fsf@gitster.siamese.dyndns.org>
References: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
	<2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5nsE-00069k-4N
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 20:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbXLUTsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbXLUTsy
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 14:48:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbXLUTsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 14:48:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D80F520E;
	Fri, 21 Dec 2007 14:48:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B31EB520A;
	Fri, 21 Dec 2007 14:48:47 -0500 (EST)
In-Reply-To: <2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com> (Steven
	Grimm's message of "Fri, 21 Dec 2007 09:23:47 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69087>

Steven Grimm <koreth@midwinter.com> writes:

> On Dec 21, 2007, at 2:22 AM, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=
=AA=E3=81=AA=E3=81=93 wrote:
>
>> "git stash" without argument originally created an unnamed
>> stash, but some people felt this can be confusing to new
>> users.  This introduces per-user config variable stash.quick to
>> control this behavior.
>
> This whole thing smells of indecision to me.

If you want to force me to decide, you know what the decision it
would be.  Here are the guiding principles and decisions based
on them.

 (1) A tool should be optimized for people who know what it does
     and how to use it.

     While forbidding "git stash" without argument and forcing
     people who want to have a quick stash to type "git stash
     save" may appear not to be adding too many keystrokes, it
     actually is a regression.  Because "git stash save" without
     arguments make a much less descriptive stash than the
     current quickie "git stash", doing so slows them down by
     forcing them to think of what message to give.

     The decision would be to keep "git stash" quickie stash
     creation.  An alternative decision could be to do nothing
     when "git stash" is given, and make "git stash save" (and
     "git stash create") without the actual message to come up
     with a better default message.

 (2) A tool should not change its behaviour too drastically
     depending on who the user is.

     Otherwise it makes it harder for people with mid-level
     experience to teach less experienced people.  The decision
     would be that "stash.quick=3Dask" and "stash.quick=3Dno" are
     unacceptable.

 (3) A tool should support safety for a mistaken use by who know
     the tool (even they can make mistakes).

     I listed this mostly because we made "git clean" to violate
     principle (2) above.  Even when you know what that command
     does, it is easy to mean "make clean" and type "git clean"
     by mistake.  And "git clean" is very destructive --- there
     is no "oops, I take it back".  This principle has led us to
     introduce clean.requireforce that defaults to true.

     For "git stash", there is no "make stash" or "xyzzy stash"
     that can easily induce mistyping.  Even if it were typed by
     mistake, there is no such destructive "oops, I cannot take
     it back" problem with "git stash", either.  "git stash
     apply" will get you back to where you were.  The decision
     would again be that "stash.quick=3Dno" is unwanted.

 (4) A tool should support safety for clueless people when it is
     reasonable.

     Even though "I did not know what command foo does, so I
     tried running it and it did something unexpected" is a
     silly excuse to rob quickie "git stash" from people who
     know better, we cannot avoid the fact that there are
     clueless people.  I think checking stash.iknowwhatitdoes to
     detect first-time users, and explaining what it does to
     them, may make sense.  And we can take hints from the patch
     that started this thread how to do this.

     The decision here is that I am open to a change that
     implements the one-time safety instruction.

Note that in the above guiding principles, I used "should" in
RFC2119/BCP0014 sense: there may exist valid reasons in
particular circumstances to ignore a particular item, but the
full implications must be understood and carefully weighed
before choosing a different course.
