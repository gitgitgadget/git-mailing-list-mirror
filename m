From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rebase: Allow merge strategies to be used when rebasing
Date: Mon, 19 Jun 2006 14:55:28 -0700
Message-ID: <7vbqso95f3.fsf@assigned-by-dhcp.cox.net>
References: <1150599735483-git-send-email-normalperson@yhbt.net>
	<7vd5d63k7f.fsf@assigned-by-dhcp.cox.net>
	<20060619213951.GA6987@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 23:56:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsRiY-0004j5-1Z
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 23:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWFSVza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWFSVza
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 17:55:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31464 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964923AbWFSVz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 17:55:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619215529.LIWP15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 17:55:29 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060619213951.GA6987@hand.yhbt.net> (Eric Wong's message of
	"Mon, 19 Jun 2006 14:39:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22141>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>>  - You kept the original "format-patch piped to am" workflow
>>    optionally working.
>
> I left it as the default, too.  I figured that it's best not
> to change the default (and most likely faster) behavior of
> something people rely on.

I should have said: "You kept ... working, which is good".

>> I think the three-way merge you would want here is not between B
>> and G using E as the pivot, but between B and G using A as the
>> pivot.  That's how cherry-pick and revert works.  I would
>> leverage the interface that is one level lower for this -- the
>> strategy modules themselves.
>> 
>> 	git-merge-$strategy $cmt^ -- HEAD $cmt
>
> Changing the 'git-merge $strategy_args "rebase-merge: $cmt" HEAD "$cmt"'
> line in call_merge() to this seems to have broken more tests.

Oh, that is to be expected if you changed git-merge -s recursive
with git-merge-recursive without other changes.  The former
makes a commit (which your original patch later used to create a
separate commit chain and discarded); the latter does not make a
commit but expects the caller to create a commit out of the
resulting index file.

> I'm not an expert at merging strategies by any measure, I've just
> trusted merge-recursive to Do The Right Thing(TM) more often than not,
> and use rerere to avoid repeating work.

I was originally hoping that rebasing would just be a matter of
listing sequence of commits to be ported onto a new base and
running "git-cherry-pick" on each of them in sequence.  Now
cherry-pick does not use merge machinery (hence does not use
git-merge-recursive), but if we change that then updating rebase
would be pretty much straightforward.  It just needs a UI layer
to guide the user through recovery process when the merge does
not resolve cleanly in the middle, no?
