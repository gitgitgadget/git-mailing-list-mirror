From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Set _ALL_SOURCE for AIX, but avoid its struct list.
Date: Mon, 15 Jan 2007 19:11:49 -0800
Message-ID: <7vbqkzzmve.fsf@assigned-by-dhcp.cox.net>
References: <17466.1168911289@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6ejq-0006do-2f
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAPDLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXAPDLw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:11:52 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39125 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXAPDLv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:11:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070116031150.NREM7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 15 Jan 2007 22:11:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BfAx1W00B1kojtg0000000; Mon, 15 Jan 2007 22:10:57 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <17466.1168911289@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Mon, 15 Jan 2007 17:34:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36917>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> AIX 5.3 seems to need _ALL_SOURCE for struct addrinfo, but that
> introduces a struct list in grp.h.

Yuck.

What the h**k is _ALL_SOURCE?  What are the valid other
possibilities, _ALL_BINARY???

I am wondering if we want to do "#ifdef _AIX" around truly yucky
parts.

I notice that I did not heed Linus's suggestion to define these
to 1 to make them behave identically as "cc -D_GNU_SOURCE", by
the way...

Also I wonder if we do _ALL_SOURCE before any of the system
header files on AIX, if we still need "_XOPEN_SOURCE_EXTENDED 1"
which we specifically added for AIX.


diff --git a/git-compat-util.h b/git-compat-util.h
index 8781e8e..75f8bc3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -13,10 +13,10 @@
 
 #if !defined(__APPLE__) && !defined(__FreeBSD__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-#define _GNU_SOURCE
-#define _BSD_SOURCE
+#define _GNU_SOURCE 1
+#define _BSD_SOURCE 1
+#define _ALL_SOURCE 1 /* AIX */
 
 #include <unistd.h>
 #include <stdio.h>
@@ -45,7 +45,11 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+
+/* AIX 5.3L defines a struct list with _ALL_SOURCE. */
+#undef _ALL_SOURCE
 #include <grp.h>
+#define _ALL_SOURCE 1
 
 #ifndef NO_ICONV
 #include <iconv.h>
