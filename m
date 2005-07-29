From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 8/2] Build commands through object files
Date: Fri, 29 Jul 2005 19:21:53 +0200
Message-ID: <20050729172153.GM21909@pasky.ji.cz>
References: <20050729085819.GL24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 19:31:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1DyYiF-0007Lx-00
	for <gcvg-git@gmane.org>; Fri, 29 Jul 2005 19:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVG2RXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVG2RXm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 13:23:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30483 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262680AbVG2RV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 13:21:57 -0400
Received: (qmail 20580 invoked by uid 2001); 29 Jul 2005 17:21:53 -0000
To: junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20050729085819.GL24895@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Separate the process of building the commands to compilation and
linkage. This makes it more consistent with the library objects, is the
traditional thing to do, and significantly speeds up the subsequent
rebuilds, especially for us the people who develop git on 300MHz
notebooks.

Ported from Cogito.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 02074521a74483bec941ceacea35f92b485ebd48
tree b08deb01bab982b846b5757943571d0c39b9ba76
parent cd2182ac0e0635faeca6467b68decf8ab9625f4c
author Petr Baudis <pasky@suse.cz> Fri, 29 Jul 2005 19:20:28 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Fri, 29 Jul 2005 19:20:28 +0200

 Makefile |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -133,13 +133,14 @@ CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
 all: $(PROG)
 
 
-git-%: %.c $(LIB_FILE)
-	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
-
-git-http-pull: pull.c
-git-local-pull: pull.c
-git-ssh-pull: rsh.c pull.c
-git-ssh-push: rsh.c
+.PRECIOUS: %.o
+git-%: %.o $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+
+git-http-pull: pull.o
+git-local-pull: pull.o
+git-ssh-pull: rsh.o pull.o
+git-ssh-push: rsh.o
 
 git-http-pull: LIBS += -lcurl
 git-rev-list: LIBS += -lssl
