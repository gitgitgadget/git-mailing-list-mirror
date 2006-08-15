From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] On Solaris nanosleep() is not in libc but in librt
Date: Tue, 15 Aug 2006 03:35:01 -0700
Message-ID: <7vzme670dm.fsf@assigned-by-dhcp.cox.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
	<20060815090129.5223.17174.stgit@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 12:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCwGX-0007gj-92
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 12:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbWHOKfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 06:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965373AbWHOKfF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 06:35:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23534 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965371AbWHOKfC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 06:35:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815103501.GIFI27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Aug 2006 06:35:01 -0400
To: Dennis Stosberg <dennis@stosberg.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25454>

Dennis Stosberg <dennis@stosberg.net> writes:

> -# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
> -# Patrick Mauritz).
> +# Define NEEDS_SOCKET if linking with libc is not enough for socket()
> +# (SunOS, Patrick Mauritz).
> +#
> +# Define NEEDS_RT if linking with libc is not enough for nanosleep() (SunOS)

Ah, nanosleep(2) was my fault, and we should be able to just use
straight sleep(3) there.  The purpose of the loop is to wait
until the next filesystem timestamp granularity, and the code
uses subsecond sleep in the hope that it can shorten the delay
to 0.5 seconds on average instead of a full second.

How exotic is -lrt on SunOS?  I suspect it is not worth
depending on it only for that single use in read-cache.c

We might want to yank out the whole "racy-git avoidance is
costly later so let's delay writing the index out" codepath
later, but that is a separate issue and needs some testing on
large trees to figure it out.  After playing with the kernel
tree, I have a feeling that the whole thing may not be worth
it.

In any case, an obvious tentative patch is here.

diff --git a/read-cache.c b/read-cache.c
index b18f9f7..ec4dd5a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,7 +5,6 @@
  */
 #include "cache.h"
 #include "cache-tree.h"
-#include <time.h>
 
 /* Index extensions.
  *
@@ -1033,11 +1032,8 @@ #if 0
 			fprintf(stderr, "now        %lu\n", now);
 #endif
 			while (!fstat(newfd, &st) && st.st_mtime <= now) {
-				struct timespec rq, rm;
 				off_t where = lseek(newfd, 0, SEEK_CUR);
-				rq.tv_sec = 0;
-				rq.tv_nsec = 250000000;
-				nanosleep(&rq, &rm);
+				sleep(1);
 				if ((where == (off_t) -1) ||
 				    (write(newfd, "", 1) != 1) ||
 				    (lseek(newfd, -1, SEEK_CUR) != where) ||
