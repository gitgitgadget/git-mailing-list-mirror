From: Jason Riedy <ejr@cs.berkeley.edu>
Subject: Re: [PATCH] Set _ALL_SOURCE for AIX, but avoid its struct list.
Date: Mon, 15 Jan 2007 19:46:58 -0800
Message-ID: <19211.1168919218@lotus.CS.Berkeley.EDU>
References: <7vbqkzzmve.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 04:47:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6fHt-0005rv-S7
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 04:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXAPDrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 22:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAPDrB
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 22:47:01 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45245 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbXAPDrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 22:47:00 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G3kxSH019252;
	Mon, 15 Jan 2007 19:46:59 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G3kxtC019249;
	Mon, 15 Jan 2007 19:46:59 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vbqkzzmve.fsf@assigned-by-dhcp.cox.net>
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36920>

And Junio C Hamano writes:
> Yuck.

Yuck, thy name is AIX.

> What the h**k is _ALL_SOURCE?  What are the valid other
> possibilities, _ALL_BINARY???

There's no equivalent to features.h...  And while this includes
a few repeats:
 bash-3.2$ find /usr/include/ -name \*.h|xargs fgrep -h \#ifdef|sort|uniq|wc -l
      402

> I am wondering if we want to do "#ifdef _AIX" around truly yucky
> parts.

Sure.

> I notice that I did not heed Linus's suggestion to define these
> to 1 to make them behave identically as "cc -D_GNU_SOURCE", by
> the way...

I missed the suggestion altogether.  Sounds like the right thing
to do.

> Also I wonder if we do _ALL_SOURCE before any of the system
> header files on AIX, if we still need "_XOPEN_SOURCE_EXTENDED 1"
> which we specifically added for AIX.

The #ifdef _ALL_SOURCE in netdb.h comes right after the #endif of
#ifdef _XOPEN_SOURCE_EXTENDED.  So all doesn't really mean all,
just kinda sorta maybe some.

Yeah, AIX is a joy.  And thanks to DARPA and the DOE, it ain't
going away.  The following seems to work for me on Solaris 5.8
and AIX 5.3.

Jason, wishing they would all just see the light...

diff --git a/git-compat-util.h b/git-compat-util.h
index 8781e8e..edafb8e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -13,10 +13,15 @@
 
 #if !defined(__APPLE__) && !defined(__FreeBSD__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
-#define _GNU_SOURCE
-#define _BSD_SOURCE
+#define _GNU_SOURCE 1
+#define _BSD_SOURCE 1
+
+#if defined(_AIX)
+/* For AIX 5.3L, at the very least. */
+#define _ALL_SOURCE 1
+#define _XOPEN_SOURCE_EXTENDED 1
+#endif
 
 #include <unistd.h>
 #include <stdio.h>
@@ -45,7 +50,15 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
+
+#if defined(_AIX)
+/* AIX 5.3L defines a struct list with _ALL_SOURCE. */
+#undef _ALL_SOURCE
+#endif
 #include <grp.h>
+#if defined(_AIX)
+#define _ALL_SOURCE 1
+#endif
 
 #ifndef NO_ICONV
 #include <iconv.h>
