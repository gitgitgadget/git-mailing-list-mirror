From: "Barry Silverman" <barry@disus.com>
Subject: Question about git process model
Date: Thu, 14 Apr 2005 21:07:25 -0400
Message-ID: <002201c54157$80d32a90$6400a8c0@gandalf>
References: <7vfyxtose8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Petr Baudis'" <pasky@ucw.cz>,
	"'Linus Torvalds'" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 03:04:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMFG4-0007wH-KL
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 03:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDOBHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 21:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVDOBHw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 21:07:52 -0400
Received: from borg.disus.com ([199.243.199.210]:21766 "EHLO borg.disus.com")
	by vger.kernel.org with ESMTP id S261702AbVDOBHd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 21:07:33 -0400
Received: from gandalf (vpn2000m.secdisus.com [199.246.34.132])
	by borg.disus.com (8.11.6/8.11.6) with ESMTP id j3F07Sf17754;
	Thu, 14 Apr 2005 20:07:28 -0400
To: "'Junio C Hamano'" <junkio@cox.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <7vfyxtose8.fsf@assigned-by-dhcp.cox.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

JH->Junio Hamano, LT->Linus Torvalds

JH>>I just have this fuzzy feeling that, when doing this merge:

                     A-1 --- A-2 --- A-3
                    /                   \ 
    Common Ancestor                      Merge Result
                    \                   /
                     B-1 --- B-2 --- B-3

JH>>looking at diff(Common Ancestor, A-1), diff(Common Ancestor,
JH>>B-1), diff(A-1, A-2), ... might give you richer context than
JH>>just merging 3-way using Common Ancestor, A-3, and B-3 to derive
JH>>the Merge Result.  It might not.  I honestly do not know.

In the distributed git model, with lots of parallel development, and
lots of merging - Is it important at the "business process" level that
intermediate history (and content) be present for any forks off the
mainline (in particular, forks maintained by someone else)?

Git has the property that it is NOT delta based. In Junio's example
above, if branch A were your mainline, and branch B were imported
changes from elsewhere, Is it necessary to have B1, B2 available to you,
when all that was required for you to merge successfully was B3?

Which leads me to....

LT>>In particular, if you ever find yourself wanting to graft together
two LT>>different commit histories, that almost certainly is what you'd
want to LT>>do. Somebody might have arrived at the exact same tree some
other way, LT>>starting with a 2.6.12 tar.ball or something, and I think
we should at LT>>least support the notion of saying "these two totally
unrelated commits LT>>actually have the same base tree, so let's merge
them in "space" (ie LT>>data) even if we can't really sanely join them
in "time" (ie "commits").

So in the case of only merging B3 - we would write into the commit
record of
Merge-Result, that it was parented by A1, and another new commit record
-> B3-Prime.

B3-Prime is space-wise identical to B3, but "time-wise" different.

B3-Prime would be different than B3 because it would necessarily not
have the same SHA1 as B3. Why? B3 has B2 as a parent, B3-Prime has the
Common Ancestor as a parent - thus the Commit record is different, and
so is the SHA1. 

We would need a facility to recognize that B3 and B3-Prime were
space-wise the same, (and maybe have the SHA for B3 kept in somewhere in
the SCM portion of B3-Prime's commit record???)

Linus, is that what you were saying?



