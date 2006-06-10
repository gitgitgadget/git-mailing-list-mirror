From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/RFC] Retire SIMPLE_*** stuff.
Date: Fri, 09 Jun 2006 17:35:45 -0700
Message-ID: <7v3bedn8ym.fsf_-_@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
	<7virnam435.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 02:36:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ForSK-0003fi-Sk
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 02:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWFJAfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 20:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWFJAfr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 20:35:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:28395 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030287AbWFJAfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 20:35:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610003546.TBRF15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 20:35:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7virnam435.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 09 Jun 2006 14:06:22 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21573>

It used to be a good idea to keep simple stuff without linking with git
library, but more and more programs are using the config mechanism, and
yet more things are becoming internal.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 5226fa1..d65fc71 100644
--- a/Makefile
+++ b/Makefile
@@ -142,12 +142,7 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-cherry-pick git-status
 
-# The ones that do not have to link with lcrypto, lz nor xdiff.
-SIMPLE_PROGRAMS = \
-	git-get-tar-commit-id$X git-mailsplit$X \
-	git-stripspace$X git-daemon$X
-
-# ... and all the rest that could be moved out of bindir to gitexecdir
+# Programs could be moved out of bindir to gitexecdir
 PROGRAMS = \
 	git-checkout-index$X git-clone-pack$X \
 	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
@@ -162,7 +157,9 @@ PROGRAMS = \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X \
 	git-name-rev$X git-pack-redundant$X git-repo-config$X git-var$X \
-	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
+	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X \
+	git-get-tar-commit-id$X git-mailsplit$X \
+	git-stripspace$X git-daemon$X
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
@@ -175,7 +172,7 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-diff-index$X git-diff-stages$X git-diff-tree$X git-cat-file$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
-ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
+ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
@@ -386,11 +383,9 @@ else
 endif
 ifdef NEEDS_SOCKET
 	LIBS += -lsocket
-	SIMPLE_LIB += -lsocket
 endif
 ifdef NEEDS_NSL
 	LIBS += -lnsl
-	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_D_TYPE_IN_DIRENT
 	ALL_CFLAGS += -DNO_D_TYPE_IN_DIRENT
@@ -428,6 +428,8 @@ endif
 
 ifdef NO_ICONV
 	ALL_CFLAGS += -DNO_ICONV
+else
+	LIBS += $(LIB_4_ICONV)
 endif
 
 ifdef PPC_SHA1

@@ -559,15 +554,6 @@ endif
 git-%$X: %.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-$(SIMPLE_PROGRAMS) : $(LIB_FILE)
-$(SIMPLE_PROGRAMS) : git-%$X : %.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIB_FILE) $(SIMPLE_LIB)
-
-git-mailinfo$X: mailinfo.o $(LIB_FILE)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIB_FILE) $(SIMPLE_LIB) $(LIB_4_ICONV)
-
 git-local-fetch$X: fetch.o
 git-ssh-fetch$X: rsh.o fetch.o
 git-ssh-upload$X: rsh.o
-- 
1.4.0.rc2.g55be
