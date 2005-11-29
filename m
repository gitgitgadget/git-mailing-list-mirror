From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 10:46:20 -0800
Message-ID: <7vhd9vgumb.fsf@assigned-by-dhcp.cox.net>
References: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
	<20051129080529.20705.qmail@science.horizon.com>
	<20051129103157.GW22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 19:47:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhAUk-00064V-K2
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 19:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVK2SqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 13:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVK2SqX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 13:46:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48044 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932342AbVK2SqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 13:46:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129184541.ZRIY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 13:45:41 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12951>

Petr Baudis <pasky@suse.cz> writes:

>   (ii) Cogito will handle trees with some local modifications better -
> basically any local modifications git-read-tree -m won't care about.
> I didn't read the whole conversation, so to reiterate: git-read-tree
> will complain when the index does not match the HEAD, but won't
> complain about modified files in the working tree if the merge is not
> going to touch them. Now, let's say you do this (output is visually
> only roughly or not at all resembling what would real tools tell you):
>
> 	$ ls
> 	a b c
> 	$ echo 'somelocalhack' >>a
> 	$ git merge "blah" HEAD remotehead
> 	File-level merge of 'b' and 'c'...
> 	Oops, 'b' contained local conflicts.
> 	Automatic merge aborted, fix up by hand.
> 	$ fixup b
> 	$ git commit
> 	Committed files 'a', 'b', 'c'.
>
> Oops. It grabbed your local hack and committed it along the merge.

Are you sure about this?

In the above sequence, after you touch a with 'somelocalhack',
there is no 'git update-index a', until you say 'git commit'
there, so I do not think that mixup is possible.

The "fixup b" step is actually two commands, so after merge
command, you would do:

        $ edit b
	$ git update-index b ;# mark that you are dealt with it
	$ git commit ;# commits what is in index

After the above steps, "git diff" (that is working tree against
index) still reports your local change to "a", which were _not_
committed.

Maybe you were mistaken because Cogito tries to be nice to its
users and always does a moral equivalent of "git commit -a"
(unless the user tells you to commit only specific paths), but
you needed to special case merge resolution commit to make sure
that you exclude "a" in the above example?  "git commit" does
not do "-a" by default, and it will stay that way, so I do not
think we do not have the "Oops" you described above.

"Oops" would happen only if you did "git commit -a" instead at
the last step.
