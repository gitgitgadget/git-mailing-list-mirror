From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on empty commit
Date: Mon, 16 Jan 2006 15:32:07 -0800
Message-ID: <7v8xtfn408.fsf@assigned-by-dhcp.cox.net>
References: <20060116215856.6618.qmail@web31805.mail.mud.yahoo.com>
	<20060116225749.90052.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:32:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eydpp-0003XQ-ET
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 00:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWAPXcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAPXcM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 18:32:12 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:40624 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751286AbWAPXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 18:32:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116232934.GGGP17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 18:29:34 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20060116225749.90052.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 16 Jan 2006 14:57:49 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14766>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Ok, so what I'm seeing is that git history records what the _user did_
> as opposed to _what happened to the code_.
>
> Is it possible to have an env var to control this "feature".  I.e. if
> the result is 0 lines 0 files changed, then do not update the index and/or
> the git database.

Good question.  We could go stronger than that, and say it would
make more sense not to make that commit by default, except when
the merge was done with "ours" strategy (it explicitly asks for
an empty commit to make it stand out that trees were in sync at
that point), or the merge was manually resolved and the result
happens to match what treeB already had.

Why?

          treeB ---------o--o--o--*--o--o---*--o..?
                                 /         /     .
                                /         /     .
          common upstream ---- / --o--o--o--o  .
                              /           \   . 
                             /             \ .
          treeA ------o--o--o---------------*
                                    ^
                                    |
                     No commit on this segment.

                o are commits, * are merge commits.

At point '?' we can choose not to make a merge.  You could,
after seeing such an empty merge, emulate this behaviour by
doing "git reset --hard HEAD^" yourself.  Then some time later,
when treeA truly has something new to offer treeB, the next
merge attempt will create a true merge commit at '!':

          treeB ---------o--o--o--*--o--o---*--o--?--o--o--!
                                 /         /     .        /
                                /         /     .        /
          common upstream ---- / --o--o--o--o  .        /
                              /           \   .        /
                             /             \ .        / 
          treeA ------o--o--o---------------*--o--o--o

When we have the last two 'o' commits on treeB development
track, creating '?' merge _might_ have some value, because we
can clearly see that those two new 'o' commits on treeB are
compatible with the '*' merge commit on treeA track.  Without
the merge at '?' we would not be able to tell that, so in that
sense it is a small plus to have '?' merge commit, and it may
even help bisection bug hunting.  But in practice it may not
matter and just clutter your history.

Especially if we did not have the last two 'o' commits on treeB
line, making an empty merge commit at '?' would mostly be
pointless.


          treeB ---------o--o--o--*--o--o---*--o--?--------!
                                 /         /     .        /
                                /         /     .        /
          common upstream ---- / --o--o--o--o  .        /
                              /           \   .        /
                             /             \ .        / 
          treeA ------o--o--o---------------*--o--o--o

But unfortunately we cannot tell if we are going to build on top
of '?' before we merge with treeA again next time at '!', when
we are at point '?', so we could have an option or environment
variable to control this "feature", but unless you can predict
the future at point '?', deciding whether to use that option
would be rather difficult.
