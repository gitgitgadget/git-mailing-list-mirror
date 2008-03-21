From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Switching branches without committing changes
Date: Thu, 20 Mar 2008 21:42:56 -0700
Message-ID: <7vod98u1pr.fsf@gitster.siamese.dyndns.org>
References: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
 <20080321040647.GE8410@spearce.org>
 <20080321041013.GA2502@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZ6h-0008Mn-6Q
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbYCUEnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbYCUEnO
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:43:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYCUEnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:43:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E51F2499;
	Fri, 21 Mar 2008 00:43:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 43A312498; Fri, 21 Mar 2008 00:43:05 -0400 (EDT)
In-Reply-To: <20080321041013.GA2502@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 21 Mar 2008 00:10:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77708>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 21, 2008 at 12:06:47AM -0400, Shawn O. Pearce wrote:
>
>> Use `git checkout -m` to switch the branch anyway.  However, if
>> there is a merge conflict while you are trying to carry the changes
>> to the other branch you may be faced with a merge conflict you are
>> not prepared to resolve, or simply cannot resolve in a reasonable
>> period of time.
>
> Ah, for some reason I didn't think of '-m' in the advice I gave (I guess
> I have just never used it). It is almost certainly simpler than using a
> 'stash' at this point (but I do think stashing _beforehand_ still has
> advantages).

The thing is, that -m is really to mollify people who are _too_ accustomed
to CVS/SVN update behaviour.  Over there, "scm update" does not give you
any choice other than having to merge.

With git, stashing or creating Park commits are very cheap operation and
unless you are reasonably sure that your local changes do not conflict
with the branch you are switching to, there is no strong reason to prefer
"checkout -m".

Switching branches with dirty state can have three scenarios:

 (1) you are getting interrupted and your current local changes do not
     belong to what you are going to commit after switching (e.g. "the
     boss says fix that right away").

     recommendation: stash, or Park commit

 (2) you have started working but realized what you are working on belongs
     to a new topic.

     recommendation: checkout -b

 (3) you have started working but realized what you are working on belongs
     to an existing topic.

     recommendation: checkout -m

In case (1), if the change is small, trivial or independent from what you
are switching branches to work on, you can "git checkout" (if the change
is about an unrelated thing, hopefully there won't be any overlap at the
file level) or "git checkout -m" (again, if the change is about an
unrelated thing, the merge hopefully would be trivial) to switch branches,
perform the unrelated change and commit only that unrelated change, and
"git checkout" (or "git checkout -m") to come back to where you started.
But if you had to use "-m" when switching branches, that means the change
you need to commit in the switched branch may have to include some changes
you will do to that modified file, and you would need per-hunk commit with
"git add -i" to exclude existing changes.  In such a case, stashing the
local changes away before branch switching would be much easier workflow.

In case (2), the solution is always "checkout -b".  There is no other
choice.

In case (3), the solution is always "checkout -m".  Stashing, switching
and then unstashing will give the same conflicts as "checkout -m" would
give you, and the change you were working on has to be done on that
switched to branch, so there is no escaping from conflict resolution,
unless you are willing to redo your change on the breanch you switched to
again.
