From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-files and fakeroot
Date: Mon, 16 Jan 2006 18:33:22 -0800
Message-ID: <7v7j8zlh1p.fsf@assigned-by-dhcp.cox.net>
References: <43CC5231.3090005@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 03:34:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyggE-0000k4-4s
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 03:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWAQCdZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 21:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWAQCdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 21:33:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45983 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751090AbWAQCdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 21:33:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117023125.NLUM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 21:31:25 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43CC5231.3090005@michonline.com> (Ryan Anderson's message of
	"Mon, 16 Jan 2006 21:10:57 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14771>

Ryan Anderson <ryan@michonline.com> writes:

> Oddly, running "git status" seems to correct things.
>
> Running "fakeroot git-diff-files" gives me lines like this:
>
> :100644 100644 f866059f24bacd314fa4a979334a9893dbfc19ba 0000000000000000000000000000000000000000 M      write-tree.c
>
> Looking at strace output, I can't see a difference that appears meaningful,

How does fakeroot keep track of fake ownerships?

That is, I suspect:

	$ date >foo
	$ ls -l foo
	-rw-rw-r--  1 junio junio 29 Jan 16 18:29 foo
	$ fakeroot sh -i
        # ls -l foo
	-rw-rw-r--  1 root root 29 Jan 16 18:29 foo

which means that under fakeroot, stat would give file ownerships
for *my* files as if they are owned by root.

And of course .git/index records the as me and fakeroot has no
way of knowing me maps to root in that fake environment.

"git status" includes "git update-index --refresh", which reads
from the stat bits and ownerships, notices that file contents have
not changed, and writes a new index file that records these stat
bits (so git thinks they are now owned by root).

If you come out of the fakeroot environment, I am reasonably
sure that you would find all the index entries are dirty again,
for exactly the same reason.  index thinks things are owned by
root, the files are owned by you, so without looking at file
contents, it says "these things might have changed".




	
