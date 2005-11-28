From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git commit' ignoring args?
Date: Mon, 28 Nov 2005 11:05:00 -0800
Message-ID: <7vzmnotwyr.fsf@assigned-by-dhcp.cox.net>
References: <438B2F40.6070801@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 20:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgoJJ-0000Nq-SO
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 20:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVK1TFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVK1TFG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 14:05:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11179 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932178AbVK1TFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 14:05:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128190358.LLRV17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 14:03:58 -0500
To: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12897>

Jeff Garzik <jgarzik@pobox.com> writes:

> With the latest git as of this writing, executing
>
> 	git commit Makefile stylesheet.xsl
>
> results in an attempt to commit the above files, and also another file 
> book.xml.  book.xml is modified, but I do not wish to check it in at 
> this time, so I did not list it as an argument to 'git commit'.
>
> The only commit in the repository is the initial commit.
>
> #
> # Updated but not checked in:
> #   (will commit)
> #
> #       modified: Makefile
> #       modified: book.xml
> #       new file: stylesheet.xsl
> #
> #
> # Untracked files:
> #   (use "git add" to add to commit)
> #
> #       book.pdf
>
> Expected behavior is that Makefile and stylesheet.xsl would be checked 
> in, but not book.xml.

It should work that way, you are right.  And it worried me so
much that I tried to reproduce, but I couldn't.

The status output says it will _commit_ book.xml by listing it
in "Updated but not checked in" section, without listing it also
in "Changed but not updated".  Which means that when the
git-status was run (that is immediately after 'git-commit'
processed your command line and did git-update-index on Makefile
stylesheet.xsl for you), the index file had book.xml in sync
with your modified version in your working tree.

Could it be that at some point after touching book.xml before
running git commit you did update-index on it?


-- >8 --
Here is what I did to reproduce.

Start afresh.

        $ cd /var/tmp/
        $ rm -fr jg
        $ mkdir jg
        $ cd jg
        $ git-init-db
        defaulting to local storage area

Prepare two files and make initial commit.

        $ date >Makefile
        $ date >book.xml
        $ git add Makefile book.xml
        $ git commit -m 'Initial'
        Committing initial tree 4a7017a5ec4870d44c340943c66a7f0c1cf4885d

There are two files.

        $ git ls-tree HEAD
        100644 blob c803676f9cab3249b5b1d225e53b6d14c8545a5e	Makefile
        100644 blob 6f3b56bbff37d24d9faa78c3e0566cdab4dce8e9	book.xml

Modify two, add one.

        $ date >>book.xml
        $ date >>Makefile
        $ date >stylesheet.xsl
        $ git add stylesheet.xsl

See what happened.  The index file knows only about addition; we
have not told git about changes we did to book.xml and Makefile
yet.

        $ git diff --name-status --cached HEAD
        A	stylesheet.xsl

The working tree has three changes since the last commit.

        $ git diff --name-status HEAD
        M	Makefile
        M	book.xml
        A	stylesheet.xsl

The working tree is different from the index file in two paths.

        $ git diff --name-status
        M	Makefile
        M	book.xml

Do a partial commit, naming two files.

        $ git commit -m 'commit two' Makefile stylesheet.xsl

What's different between the working tree and what we just
committed?

        $ git diff --name-status HEAD
        M	book.xml

We should not have committed changes to book.xml; we haven't.

        $ git diff-tree --name-status HEAD
        1d3ed9f438aa705fd8433bc23400814468a1a353
        M	Makefile
        A	stylesheet.xsl
        $ exit
