From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A question about git-rev-list
Date: Mon, 16 Jul 2007 21:33:49 -0700
Message-ID: <7v8x9fbqdu.fsf@assigned-by-dhcp.cox.net>
References: <86wsx0wwvs.fsf@lola.quinscape.zz>
	<alpine.LFD.0.999.0707161258560.20061@woody.linux-foundation.org>
	<85bqecm4mn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 06:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAel2-0006F2-Bw
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 06:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbXGQEdw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 00:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXGQEdw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 00:33:52 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50276 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXGQEdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 00:33:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717043351.YBRT1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 00:33:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QUZp1X00F1kojtg0000000; Tue, 17 Jul 2007 00:33:50 -0400
In-Reply-To: <85bqecm4mn.fsf@lola.goethe.zz> (David Kastrup's message of "Mon,
	16 Jul 2007 23:16:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52738>

David Kastrup <dak@gnu.org> writes:

> ...  The problem I have
> with that is that "somefile.c" renders commits uninteresting, but
> not if they have interesting parents (what do their parents have to do
> with it?).  So if I have
>
> A -> B -> B1 -> C -> HEAD
>
> where somefile.c does not change between B and B1, then
> git-rev-list HEAD --not B -- somefile.c
> spews out
> HEAD
> C
> and that's it.  Quite as expected.  However, 
> git-rev-list HEAD --not B --parents -- somefile.c
> spews out
> HEAD C
> C B1
> B1 B
>
> and look and behold, B1 became interesting because of its unlisted
> parent B.
>
> There is something wrong with that.

There indeed is, and that is not what I am seeing.

Running this script in an empty directory gives me:

    #!/bin/sh

    GIT_AUTHOR_NAME='A U Thor'
    GIT_AUTHOR_EMAIL=a.u.thor@example.xz
    GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
    GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
    GIT_AUTHOR_DATE='2007-07-16 00:00:00 +0000'
    GIT_COMMITTER_DATE='2007-07-16 00:00:00 +0000'

    export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL \
            GIT_AUTHOR_DATE GIT_COMMITTER_DATE

    rm -fr .git
    git init
    echo A >somefile.c; git add somefile.c; git commit -m 'A'; git tag A
    echo B >somefile.c; git add somefile.c; git commit -m 'B'; git tag B
    echo B1 >another; git add another; git commit -m 'B1'; git tag B1
    echo C >somefile.c; git add somefile.c; git commit -m 'C'; git tag C
    echo H >somefile.c; git add somefile.c; git commit -m 'H'; git tag H

    git rev-list --parents HEAD --not B -- somefile.c |
    git name-rev --tags --stdin

$ sh t000.sh
Initialized empty Git repository in .git/
Created initial commit 7a13cf5: A
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 somefile.c
Created commit b66d40b: B
 1 files changed, 1 insertions(+), 1 deletions(-)
Created commit 5530c91: B1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 another
Created commit 7ee2b7e: C
 1 files changed, 1 insertions(+), 1 deletions(-)
Created commit 71fafc0: H
 1 files changed, 1 insertions(+), 1 deletions(-)
71fafc0f49ffb82b123c09ec0857f9f458ed32c4 (tags/H) 7ee2b7ed072190c56a2eedda3130f6bb729d0da1 (tags/C)
7ee2b7ed072190c56a2eedda3130f6bb729d0da1 (tags/C) b66d40bd7ed6d7403c16d8e37e6e410852598247 (tags/B)


The commit listed are H and then C; their (rewritten) parents
are C and B, respectively.
