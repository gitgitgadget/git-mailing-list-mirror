From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sun, 30 Apr 2006 23:58:30 -0700
Message-ID: <7vlktms02x.fsf@assigned-by-dhcp.cox.net>
References: <20060429165151.2570.qmail@science.horizon.com>
	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>
	<7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net>
	<7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>
	<4455638A.3070802@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 01 08:58:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaSMe-00008a-L1
	for gcvg-git@gmane.org; Mon, 01 May 2006 08:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWEAG6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 02:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWEAG6e
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 02:58:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50127 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751289AbWEAG6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 02:58:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501065832.NOV27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 02:58:32 -0400
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <4455638A.3070802@vilain.net> (Sam Vilain's message of "Mon, 01
	May 2006 13:25:30 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19373>

Sam Vilain <sam@vilain.net> writes:

> Junio C Hamano wrote:
>
>>To David, the commits he has in the chain between 6b426e to
>>18118c obviously suited the purpose of his tree better, and that
>>was why these commits were made.  And the fact Linus fast
>>forwarded to the tip of David is an implicit statement by Linus
>>that that results suits the purpose of Linus tree better as well
>>compared to his old tip, presumably 6b426e.
>
> Aha, now I see reason in the madness. So, the "prior" head is not stored
> in the trees, and tracking the progress of actual head transitions is
> loosely defined / a research topic. But demonstrably derivable. That
> works for me.

I do not think there is any madness involved here, but I should
point out that the above example happens to work only because
Linus and David are two different people.  If Linus did the
David's work in a separate repository, or even in the same
repository but on a separate branch, people following the Linus
tip might still want to know about the fast-forward, but that is
something you cannot truly tell by the digging like what I did
in the previous message.

That is why I earlier said this:

    *1* IOW, we _are_ losing some information by not recording the
    fact that fast-forward was done while doing so.  

    That record should _not_ be in the commit chain.  At the
    mechanical level, recording that in the commit chain means two
    criss-crossing branches never converge at the commit chain
    level, which is already bad.  At the philosophical level, the
    commit chain is a mesh of many possible "global" histories, and
    the record that somebody (a particular branch in a particular
    repository) was at what point in the mesh at given time does not
    belong there.

    But from the repository-owner's point of view, that _might_ be a
    useful information to keep.  I am just saying this preemptively
    so that if somebody wants to record it, that should not be
    recorded in the commit object.

I do not think the commit object is the place to record it, even
with a purely-comment field like "note prior".  The commit
ancestry DAG is global in nature, and the information under
discussion, "before pointing at this commit, the branch that
made this commit happened to point at this other commit", is
not.  That information describes only one-branch's view of the
world, and would not work in the fast-forward case because no
new commit is created.  An important property of a fast-forward
is that we do not create an extra commit object that makes it
impossible for two criss-crossing branches to ever converge.

On the other hand, a "note" field that records on which branch
of which repository each commit was made (you need to give each
repository-branch an UUID) when you do create a new commit would
be a sensible thing to have if somebody cares deeply enough.  It
is an information that is global in nature, and with that, you
could do the digging like I did without relying on the committer
identity, but instead using the branch identity.
