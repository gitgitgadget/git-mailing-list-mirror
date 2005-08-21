From: Junio C Hamano <junkio@cox.net>
Subject: "git reset" and newly created files.
Date: Sun, 21 Aug 2005 12:31:19 -0700
Message-ID: <7vbr3rccjc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 23:27:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6xKT-0005uu-Gv
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 23:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVHUV0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVHUV0F
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 17:26:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:32459 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751124AbVHUV0E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 17:26:04 -0400
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJVn93026391
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 12:31:49 -0700
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050821193118.GCFZ8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 Aug 2005 15:31:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When you made a mistake and committed a set of incomplete
changes, the "git reset" command comes handy.

    ... Edit, compile, and test.
    $ git commit -s -m 'The perfect change.'
    ... Test again, OOPS it fails --- it was not perfect.
    $ git reset HEAD^
    foo: needs update
    bar: needs update

The commit object name for the botched commit is kept in the
$GIT_DIR/ORIG_HEAD file, the HEAD commit and the index file are
"reset" to the commit before ORIG_HEAD.  The files in the
working tree are not touched and they are the same as what are
in ORIG_HEAD.  The command tells which files in the working tree
are different from the HEAD commit.

So you would naturally be tempted to do this:

    ... Re-edit, compile, and test.  This time it is perfect.
    $ git commit -a -C ORIG_HEAD

Well, not really.  You can lose any file newly created in
ORIG_HEAD this way.  Instead, you need to do this:

    ... Re-edit, compile, and test.  This time it is perfect.
    $ git add <whatever file you have changed>
    $ git commit -a -C ORIG_HEAD

Do people find this a big problem?

Technically, what "git reset" does is correct, because its
definition says the index file is reset to what was in HEAD,
which did not know about the files added by the ORIG_HEAD, and
there is no way for it to keep an eye on the file you wanted to
add in the botched ORIG_HEAD commit.

But it does not _feel_ right.

This relates to the fact that there currently is no way to
record "intent to add" (aka "please keep an eye on") in the
index file.  I think we could solve this with something like
this:

    $ git-update-cache --add-maybe foo
    $ git status
    # Changed but not updated:
    #   (use git-update-cache to mark for commit)
    #
    #       new file: foo
    $ git-update-cache --refresh
    foo: needs update
    $ git-update-cache foo
    $ git status
    # Updated but not checked in:
    #   (will commit)
    #
    #       new file: foo

The "git reset" command should be able to detect the paths found
in ORIG_HEAD but lacking in HEAD, reset the index to HEAD and
say "git-update-cache --add-maybe" for such paths.

Hmm?
