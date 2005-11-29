From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 11:31:57 +0100
Message-ID: <20051129103157.GW22159@pasky.or.cz>
References: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net> <20051129080529.20705.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 14:11:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh3Cb-0000Qf-HA
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 11:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVK2K6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 05:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVK2K6Y
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 05:58:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:11216 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751178AbVK2K6X (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 05:58:23 -0500
Received: (qmail 28129 invoked by uid 2001); 29 Nov 2005 11:31:57 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20051129080529.20705.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12937>

Dear diary, on Tue, Nov 29, 2005 at 09:05:29AM CET, I got a letter
where linux@horizon.com said that...
> > *2* Cogito (things that start with cg-*) seems to try to be
> > cleverer.  Pasky might want to brag about the rules in Cogito
> > land.

> In fact, he might want to explain what the difference is between cogito
> and git.  Most particularly, are there any restrictions on mixing cg-*
> and git-* operations from within the same directory?

  Nope, except:

Cogito vs. other GIT tools
~~~~~~~~~~~~~~~~~~~~~~~~~~

You can *MOSTLY* use Cogito in parallel with other GIT frontends (e.g.
StGIT), as well as the GIT plumbing and core GIT tools - the tools only
need to keep HEAD in place and follow the standardized `refs/`
hierarchy. The only notable exception is that you should stick with a
single toolkit during a merge.

	(-- Cogito README)

  So exactly during a merge, things might not blend well, since Cogito
does things a bit differently. It knows of no MERGE_HEAD, MERGE_MSG and
such, and instead passes stuff over different channels or computes/asks
it at different times. Historically, cg-merge and git-merge evolution
has been almost entirely separate.


  From the user POV, the main difference between Cogito and GIT merging
is that:

  (i) Cogito tries to never leave the index "dirty" (i.e. containing
unmerged entries), and instead all conflicts should propagate to the
working tree, so that the user can resolve them without any further
special tools. (What is lacking here is that Cogito won't proofcheck
that you really resolved them all during a commit. That's a big TODO.
But core GIT won't you warn about committing the classical << >> ==
conflicts either.)

  (ii) Cogito will handle trees with some local modifications better -
basically any local modifications git-read-tree -m won't care about.
I didn't read the whole conversation, so to reiterate: git-read-tree
will complain when the index does not match the HEAD, but won't
complain about modified files in the working tree if the merge is not
going to touch them. Now, let's say you do this (output is visually
only roughly or not at all resembling what would real tools tell you):

	$ ls
	a b c
	$ echo 'somelocalhack' >>a
	$ git merge "blah" HEAD remotehead
	File-level merge of 'b' and 'c'...
	Oops, 'b' contained local conflicts.
	Automatic merge aborted, fix up by hand.
	$ fixup b
	$ git commit
	Committed files 'a', 'b', 'c'.

Oops. It grabbed your local hack and committed it along the merge.
Cogito won't do this, it will hold 'a' back when doing the merge commit
(if it works right; in the past, there were several bugs related to
this, but hopefully they are all fixed by now):

	$ ls
	a b c
	$ echo 'somelocalhack' >>a
	$ cg-merge remotehead
	... Merging c
	... Merging b
	Conflicts during merge of 'b'.

		Fix up the conflicts, then kindly do cg-commit.
	$ fixup b
	$ cg-commit -m"blah"
	Committed files 'b', 'c'.

Also note that the cg-merge usage is simpler and you give the "blah"
message only to cg-commit, when it's for sure you are going to use it.

  (iii) Cogito does not support the smart recursive merging strategy.
That means it won't follow renames, and in case of multiple merge bases,
it will not merge them recursively, but it will just ask you to choose
one manually, or suggest you the most conservative merge base (where you
should get no false clean merges, but you will probably have to deal
with a lot of conflicts).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
