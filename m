From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Delete ref $frotz by moving ref file to "deleted-$frotz~ref".
Date: Sat, 14 Oct 2006 11:47:40 -0700
Message-ID: <7vr6xa91kj.fsf@assigned-by-dhcp.cox.net>
References: <20061014153949.2994a114.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 20:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYoY2-0006SY-7g
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 20:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWJNSrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 14:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422803AbWJNSrm
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 14:47:42 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:4288 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422801AbWJNSrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 14:47:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061014184741.NFOI22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Oct 2006 14:47:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aJnk1V0081kojtg0000000
	Sat, 14 Oct 2006 14:47:44 -0400
To: Christian Couder <chriscool@tuxfamily.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28886>

Christian Couder <chriscool@tuxfamily.org> writes:

> The idea is that moving:
>
> $GIT_DIR/refs/<refpath>/frotz
>
> to:
>
> $GIT_DIR/deleted-refs/<refpath>/frotz~ref
>
> maybe cheaper and safer than repacking the refs without the
> deleted one.

Before actually implementing delete_ref(), we discussed this
"deleted-refs/" idea. but I do not think it is a direction we
would want to go.

Ref deletion is an operation that happens far far rarer than
updates and lookups, and I deliberately chose to optimize for
the latter.

There are valid reasons to delete refs, and one most frequent
one would be to discard throw-away temporary branches you may
have needed to switch to when your work was interrupted.  But
even counting that kind of deletion, I imagine that you would
not be creating and removing more than one branch per every 10
commits you would create, and I also imagine you would be
invoking not less than 5 operations that inspect project
history, such as git-log and git-diff, between commits you make.

An operation to build a new commit itself needs at least two
lookups (one to see what's current upfront, and another to see
nobody touched it upon lockless update).  Most history-related
operations at least need to look at one (typically, HEAD), and
any refname you use to spell the name of an object or revision
range (e.g. "v2.6.17..v2.6.18~10" needs to look at tags/v2.6.17
and tags/v2.6.18).  Optimizing for deletion path at the expense
of giving even a tiny penalty to lookup path is optimizing for a
wrong case, and that is why I rejected deleted-refs/ idea when I
originally did the delete_ref() implementation.

Having said that, I would definitely think there still are rooms
for optimization in the current implementation.  For example, I
do not recall offhand if I made the code to unconditionally
repack without the deleted one, or only repack when we know the
ref being deleted exists in the packed refs file.  The latter
obviously would be more efficient and if we currently do not do
that, making it do so is a very welcomed change.  Especially,
given that the latest code does not pack branch heads by
default, when a temporary throw-away branch is discarded, it is
far more likely that it is not packed and we do not need to
repack.

Independent from this topic of "removing deleted from packed" vs
"using deleted-refs/", I think we still do not handle .git/logs/
hierarchy correctly in the current code when ref deletion is
involved.  We already made it to correctly unlink/rmdir/mkdir
on-demand for .git/refs/ hierarchy and I think we need to have
code that parallels that for the .git/logs/ side.
