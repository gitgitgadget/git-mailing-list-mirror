From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] getdomainname should be usable on SunOS with -lnsl
Date: Sun, 11 Sep 2005 22:39:07 -0700
Message-ID: <7vmzmilu9w.fsf_-_@assigned-by-dhcp.cox.net>
References: <1125962642.15293.20.camel@divert>
	<25968.1126304722@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 07:40:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEh2B-0005yC-Ni
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 07:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVILFjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 01:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVILFjK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 01:39:10 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:15322 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbVILFjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 01:39:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912053908.ODBE6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 01:39:08 -0400
To: Patrick Mauritz <oxygene@studentenbude.ath.cx>
In-Reply-To: <25968.1126304722@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Fri, 09 Sep 2005 15:25:22 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8368>

Jason Riedy suggests that we should be able to use getdomainname
if we properly specify which libraries to link.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 I've tried this on an ancient Solaris machine I happened to
 have access at work and it seems to link OK.  Patrick, could
 you try this and see if it works OK for you?

 Makefile |    6 +++++-
 ident.c  |    2 --
 2 files changed, 5 insertions(+), 3 deletions(-)

2b6a27b6157c6ee472d654dbcaf380aec00d6444
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -148,7 +148,7 @@ ifeq ($(shell uname -s),Darwin)
 endif
 ifeq ($(shell uname -s),SunOS)
 	NEEDS_SOCKET = YesPlease
-	PLATFORM_DEFINES += -DNO_GETDOMAINNAME=1
+	NEEDS_NSL = YesPlease
 endif
 
 ifndef SHELL_PATH
@@ -195,6 +195,10 @@ ifdef NEEDS_SOCKET
 	LIBS += -lsocket
 	SIMPLE_LIB += -lsocket
 endif
+ifdef NEEDS_NSL
+	LIBS += -lnsl
+	SIMPLE_LIB += -lnsl
+endif
 
 DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
diff --git a/ident.c b/ident.c
--- a/ident.c
+++ b/ident.c
@@ -36,13 +36,11 @@ int setup_ident(void)
 	memcpy(real_email, pw->pw_name, len);
 	real_email[len++] = '@';
 	gethostname(real_email + len, sizeof(real_email) - len);
-#ifndef NO_GETDOMAINNAME
 	if (!strchr(real_email+len, '.')) {
 		len = strlen(real_email);
 		real_email[len++] = '.';
 		getdomainname(real_email+len, sizeof(real_email)-len);
 	}
-#endif
 	/* And set the default date */
 	datestamp(real_date, sizeof(real_date));
 	return 0;
