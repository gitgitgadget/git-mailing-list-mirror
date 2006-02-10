From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH 3/3] Use active CPIO, FIND, and XARGS to set built-in defaults.
Date: Fri, 10 Feb 2006 15:36:42 -0800
Message-ID: <1112.1139614602@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 11 00:36:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7hok-0007Zv-37
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 00:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBJXgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 18:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWBJXgn
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 18:36:43 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:51106 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932251AbWBJXgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 18:36:42 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k1ANagxZ001114
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:36:42 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k1ANagAe001113
	for <git@vger.kernel.org>; Fri, 10 Feb 2006 15:36:42 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15905>

Move the sed program in the % : %.sh pattern into the shellsedprog
variable.  Add clauses to change the CPIO, FIND, and XARGS built-in
defaults if those variables are set.  With appropriate settings, all
the current tests pass on Solaris 8 with my personal bizarre setup.
I'll try on a modules-based AIX once the machine's back next week.

I don't really like how I build the sed program, but I can't think of
an easier / better way.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>

---

 Makefile |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

e512a44ccd488fec29af59e95b35741d4454b118
diff --git a/Makefile b/Makefile
index f240e45..edf785c 100644
--- a/Makefile
+++ b/Makefile
@@ -415,11 +415,21 @@ git$X: git.c $(LIB_FILE)
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(CFLAGS) $(COMPAT_CFLAGS) -o $@ $(filter %.c,$^) $(LIB_FILE)
 
+shellsedprog=-e '1s|\#!.*/sh|\#!$(call shq,$(SHELL_PATH))|;'
+shellsedprog+= -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g;'
+ifdef CPIO
+	shellsedprog+= -e 's@^: \$${CPIO:=cpio}@: \$${CPIO:=$(CPIO)}@;'
+endif
+ifdef FIND
+	shellsedprog+= -e 's@^: \$${FIND:=find}@: \$${FIND:=$(FIND)}@;'
+endif
+ifdef XARGS
+	shellsedprog+= -e 's@^: \$${XARGS:=xargs}@: \$${XARGS:=$(XARGS)}@;'
+endif
+
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	rm -f $@
-	sed -e '1s|#!.*/sh|#!$(call shq,$(SHELL_PATH))|' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.sh >$@
+	sed $(shellsedprog) $@.sh >$@
 	chmod +x $@
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
-- 
1.1.6.g0d39d
