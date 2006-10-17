From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Delete ref $frotz by moving ref file to "deleted-$frotz~ref".
Date: Mon, 16 Oct 2006 21:41:45 -0700
Message-ID: <7v4pu3tuye.fsf@assigned-by-dhcp.cox.net>
References: <20061014153949.2994a114.chriscool@tuxfamily.org>
	<7vr6xa91kj.fsf@assigned-by-dhcp.cox.net>
	<200610170626.25654.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 06:41:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZgly-0001tB-P0
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 06:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423036AbWJQEls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 00:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423040AbWJQEls
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 00:41:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7887 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1423036AbWJQElr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 00:41:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017044146.BSFE6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 00:41:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bGhY1V00l1kojtg0000000
	Tue, 17 Oct 2006 00:41:34 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200610170626.25654.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 17 Oct 2006 06:26:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29017>

Christian Couder <chriscool@tuxfamily.org> writes:

> For example, when git becomes a major SCM, there may be people working on 
> big projects that want to create a new branch for each new bug and then 
> delete the branch when the code on the bug branch has been integrated into 
> a new release and the bug is closed.

I would say that is a very valid way to work with git,
regardless of the size of project.  Now, how often would you
create such a per-bug branch and delete one, compared to the
number of operations that would require ref lookups?  Your
example actually supports what I've said -- optimizing for
deletion at the cost of more expensive lookups is wrong.

> The operations that inspect project history may use a ref cache or something 
> so that a lookup on the disk may not be needed. So only the ref creation or 
> update rate versus delete rate may matter.

Stop and think about what you are saying.  What's a ref cache?
We do not have such a beast today (unless you equate it with
packed-refs file), and you would need to design and implement
it, but think about how you make that operate.  You would need
to invalidate it when you delete a ref using the deleted-ref/
approach; that's not much different from repacking packed-refs
file without the ref you just deleted, no?

Of course you can argue that instead of repacking you always
stat deleted-ref/ hierarchy; in other words, you can argue that
you can make deletion path faster by penalizing the lookup path.

So I do not think using "ref cache" (whatever it is, and however
it operates) does not change the situation a bit.

> If there are thousand of refs and a heavy I/O load, rewritting the packed 
> ref file for each deletion means writing on disk something that may not fit 
> in the disk cache. It may be very bad.

If the goal is to optimize for deletion path, then that is
true.  My point is that we do not want to optimize for deletion
path at the expense of more costly lookup path.
