From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection for single file
Date: Tue, 18 Oct 2005 19:45:03 -0700
Message-ID: <7virvujkcw.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
	<7vu0fepn0x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 04:47:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES3x8-0002QB-Vv
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 04:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVJSCpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 22:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVJSCpH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 22:45:07 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38910 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932165AbVJSCpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 22:45:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019024441.QSOY29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 22:44:41 -0400
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <7vu0fepn0x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 18 Oct 2005 13:50:54 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10259>

Junio C Hamano <junkio@cox.net> writes:

> David Ho <davidkwho@gmail.com> writes:
>
>> I have a small suggestion to make the diff of a renamed file a bit
>> more meaningful.  I have a file that is renamed-edited and commited. 
>> git-diff-tree -M -p <commit> shows one result and git-diff-tree -M -p
>> <commit> <filename> shows another.  If they both show a rename
>> occurred then I think the single file git-diff-tree will be more
>> useful.
>
> Sorry, this was vetoed by Linus long time ago.  The <filename>
> restricts the paths being passed to the diff machinery upfront,
> so once you say <filename>, the rename detection will see only
> that path and nothing else to compare and guess which other file
> that file in question is a copy of.

Having said that, I think we *could* introduce a new flag to
git-diff-* brothers, --late-pathspec, that makes them apply the
paths restriction on the output side instead.  For obvious
reasons, using this flag would not make any sense unless you are
using one of -M, -C, or --pickaxe-all.

A related thing I have long longed for is a rename following
"git-diff-tree --stdin".

    git-rev-list HEAD | git-diff-tree --stdin -M git-commit.sh

This command line, as everybody hopefully knows, is how "git
whatchanged" is implemented internally.  If git-diff-tree were
taught to follow the rename history, when it hits the boundary
that git-commit-script was renamed to git-commit.sh, it could
start acting as if the pathspec given were git-commit-script
from that point.  To see that rename it needs --late-pathspec;
the current pathspec filters the input so the above command line
would not even care what git-commit-script looked like when the
rename happend.  It would just tell git-commit.sh appeared from
nowhere.

If implemented naively, this rename-following would have funny
interactions when it hits a merge commit, so it may probably be
harder than it sounds, but this would be a good way to do
annotate as well.
