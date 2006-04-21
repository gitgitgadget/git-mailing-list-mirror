From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log produces no output
Date: Fri, 21 Apr 2006 13:05:58 -0700
Message-ID: <7vpsjasnh5.fsf@assigned-by-dhcp.cox.net>
References: <20060421184815.22939.qmail@web60319.mail.yahoo.com>
	<Pine.LNX.4.64.0604211214560.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604211223561.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 22:06:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FX1tH-0008HD-GH
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 22:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWDUUGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 16:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDUUGD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 16:06:03 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57278 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932384AbWDUUGB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Apr 2006 16:06:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060421200600.YDTU24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Apr 2006 16:06:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604211223561.3701@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 21 Apr 2006 12:25:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19030>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 21 Apr 2006, Linus Torvalds wrote:
>> 
>> This patch would have made things a lot more obvious.
>
> Actually, scratch that one, and use this one instead. Much better, and 
> actually allows Bob's crazy PAGER environment variable to work, rather 
> than just reporting an error about it.

Agreed, this is much better than just punting.  Sign-off?

BTW: The extended extended SHA1 is a great addition.  I do not
usually have contrib/colordiff checked out (it is in "pu", not
in "next"), but I can easily do:

	git tar-tree pu:contrib/colordiff colordiff | tar xf -

Of course "git tar-tree pu | tar xf - contrib/colordiff" would
work for this particular case, but that is besides the point.

BTW: Allow me to try "git fmt-patch -1" ;-).

-- >8 --
From 34fd1c9ac5845d541e3196983df7f993e751b544  Thu Apr 7 15:13:13 2005
From: Linus Torvalds <torvalds@osdl.org>
Date: Fri Apr 21 12:25:13 2006 -0700
Subject: git-log produces no output

When $PAGER is set to 'less -i', we used to fail because we
assumed the $PAGER is a command and simply exec'ed it.

Try exec first, and then run it through shell if it fails.  This
allows even funkier PAGERs like these ;-):

	PAGER='sed -e "s/^/`date`: /" | more'
	PAGER='contrib/colordiff.perl | less -RS'

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 pager.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/pager.c b/pager.c
index e5ba273..f7b8e78 100644
--- a/pager.c
+++ b/pager.c
@@ -8,6 +8,7 @@ #include "cache.h"
 static void run_pager(const char *pager)
 {
 	execlp(pager, pager, NULL);
+	execl("/bin/sh", "sh", "-c", pager, NULL);
 }
 
 void setup_pager(void)
@@ -47,5 +48,6 @@ void setup_pager(void)
 
 	setenv("LESS", "-S", 0);
 	run_pager(pager);
+	die("unable to execute pager '%s'", pager);
 	exit(255);
 }
-- 
1.3.0.gd1e3
