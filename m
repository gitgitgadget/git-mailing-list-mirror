From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] git-run-with-user-path
Date: Sun, 15 May 2005 13:27:47 -0700
Message-ID: <7vu0l4s08s.fsf_-_@assigned-by-dhcp.cox.net>
References: <4283CAF8.3050304@dgreaves.com>
	<20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
	<7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net>
	<20050514142421.GG3905@pasky.ji.cz> <42861584.6020601@dgreaves.com>
	<20050514153027.GN3905@pasky.ji.cz>
	<7vsm0py8vz.fsf@assigned-by-dhcp.cox.net>
	<2cfc4032050514181127c02e43@mail.gmail.com>
	<7v4qd5vxao.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:28:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXPiR-0002Ek-4y
	for gcvg-git@gmane.org; Sun, 15 May 2005 22:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEOU2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 16:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEOU2J
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 16:28:09 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37837 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261230AbVEOU1v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 16:27:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515202749.LPBU7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 16:27:49 -0400
To: Petr Baudis <pasky@ucw.cz>, torvalds@osdl.org
In-Reply-To: <7v4qd5vxao.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 14 May 2005 23:05:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr, I have not written the implementation yet, but do you
think Cogito would find something like this useful?  I've seen
some patch to add running from subdirectory support to cg-add in
the mailing list and I assume Cogito is in the process of being
enhanced in this area.

JIT has been supporting running from the subdirectory from the
day one, but has been using a bit different mechanism.  If we
can agree on a core-ish helper (I consider this just as non-core
as git-diff-helper is), I would want to switch to use something
like this one.

This _deliberately_ conflates the user-path canonicalization
with the ignore-list processing discussed recently on the list.
When you think about it, they are very closely related and
handling them at the same place makes more sense than having
them separately.  It is a way to munge paths given by users and
"find -print0 | xargs -0" into a form appropriate for core GIT
consumption. Similar reasoning with which you accepted the use
of cg-Xignore by David Greaves in cg-commit.

Linus, and everybody else, suggestions and comments?

------------

git-run-with-user-path(1)
=========================
v0.1, May 2005

NAME
----
git-run-with-user-path - Run command from the top after canonicalizing paths.


SYNOPSIS
--------
'git-run-with-user-path' [options] <command> <argument>... '--' <path>...

DESCRIPTION
-----------
This command takes a <command>, zero or more <argument> and zero
or more <path> arguments.  <path> arguments name objects on the
filesystem, <command> is typically a core GIT command, and
<argument> are the initial arguments to the <command>.

It first finds the project top directory (the directory that
corresponds to the top of the tree structure GIT_INDEX_FILE
describes), and canonicalizes the given <path> to be relative to
the project top.  It then chdir(2)'s to the project top
directory and runs the given <command>, with <argument> and
these canonicalized <path> arguments.

This is useful for the Porcelain layer to run core GIT commands
from subdirectories.  For example, if linux-2.6.git tree is
checked out in /usr/src/linux, you can do:

    $ cd /usr/src/linux/fs
    $ ... work in fs directory making changes ...
    $ git-run-with-user-path git-diff-tree -r HEAD -- ext? ../include/linux
    $ find ext? ! -type d -print0 |
      xargs -0 git-run-with-user-path git-update-cache --add -- --

The above is roughly equivalent to:

    $ cd /usr/src/linux
    $ git-diff-tree -r HEAD fs/ext? include/linux
    $ find fs/ext? include/linux ! -type d -print0 |
      xargs git-update-cache --add --

OPTIONS
-------
--no-ignore::

	By default, the path arguments are filtered with the
	same ignore rules Porcelain layers use.  With
	--no-ignore flag, there is no such filtering done.

Author
------
Written by Junio C Hamano <junkio@cox.net>

Documentation
--------------
Documentation by Junio C Hamano.

GIT
---
Part of the link:git.html[git] suite


