From: Junio C Hamano <junkio@cox.net>
Subject: Re: print errors from git-update-ref
Date: Sun, 23 Jul 2006 23:06:25 -0700
Message-ID: <7vk663h6zi.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 24 08:06:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4taY-0000qY-SV
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 08:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWGXGG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 02:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWGXGG2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 02:06:28 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26096 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751407AbWGXGG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 02:06:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724060627.UQAE554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 02:06:27 -0400
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com>
	(Alex Riesen's message of "Tue, 18 Jul 2006 15:13:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24115>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> ...otherwise it not clear what happened when update-ref fails.
>
> E.g., git checkout -b a/b/c HEAD would print nothing if refs/heads/a
> exists and is a directory (it does return 1, so scripts checking for
> return code should be ok).
>
> I'm attaching two patches, because I'm not quite sure where it should
> be done: git-checkout is the least intrusive, but only builtin-update-ref.c
> has enough info to help user to resolve the problem (errno is ENOTDIR,
> which is selfexplanatory). And I happen to use git-update-ref directly
> sometimes.

My gut feeling is that complaining from update-ref is fine, but
I am still tired after a long week and not thinking straight, so
I will not be applying this tonight.

git-applypatch, git-am, and git-branch would be helped by
update-ref complaining.

Porcelains?

BTW, I wonder what happens when .git/logs/refs/a is a directory
(by mistake or malice), .git/refs/a does not exist, and the user
does "git checkout -b a/b/c HEAD".  Or when .git/logs/refs/a/b/c
does exist but is not writable.  My preference is just warn but
do not interrupt the primary operation, since ref-log is just an
optional part of the system, but that would probably lead to
confusion, so we might be better off erroring the caller out in
such a case.  Opinions?

git-resolve does not check exit value from update-ref, which is
*BAD*, but we should be deprecating it anyway.

git-reset has the same problem of not checking the exit status
from update ref.  Worse yet, it calls update-ref with wrong
parameter ($@ in its parameter should be $*).

Patches to fix these two and half problems should be trivial but
I won't be doing that myself tonight.
