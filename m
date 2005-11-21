From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Re: [PATCH] Fix git.c compilation target
Date: Tue, 22 Nov 2005 00:44:15 +0100
Message-ID: <43825BCF.8040402@op5.se>
References: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>	<81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com> <7vlkzhmwq4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 00:44:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeLKe-0002tO-PX
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 00:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVKUXoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 18:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbVKUXoR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 18:44:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:52869 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964779AbVKUXoQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 18:44:16 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 727246BCFF; Tue, 22 Nov 2005 00:44:15 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkzhmwq4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12502>

Junio C Hamano wrote:
> 
>  - make git$(X) part of PROGRAMS (probably it is a
>    SIMPLE_PROGRAM that does not link with many extra stuff, or a
>    class on its own);
> 
>  - have "install" target depend on "all".
> 

Something like this?

##########
Introduce $(ALL_PROGRAMS) for 'all:' and 'install:' to operate on.

Remove $(SIMPLE_PROGRAMS) from $(PROGRAMS) so buildrules don't have
to be overridden.

Put $(SCRIPTS) with the other target-macros so it doesn't get lonely.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

  Makefile |   22 ++++++++++++----------
  1 files changed, 12 insertions(+), 10 deletions(-)

applies-to: 339319e60db7b3f96f8c711407b135a54da7aa2e
bf68baa57babbff57761a802fde801e71e85807e
diff --git a/Makefile b/Makefile
index d6dad19..0e2f65d 100644
--- a/Makefile
+++ b/Makefile
@@ -102,6 +102,11 @@ SCRIPT_PERL = \
  SCRIPT_PYTHON = \
  	git-merge-recursive.py

+SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
+	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
+	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
+	  gitk git-cherry-pick
+
  # The ones that do not have to link with lcrypto nor lz.
  SIMPLE_PROGRAMS = \
  	git-get-tar-commit-id$X git-mailinfo$X git-mailsplit$X \
@@ -125,8 +130,10 @@ PROGRAMS = \
  	git-unpack-objects$X git-update-index$X git-update-server-info$X \
  	git-upload-pack$X git-verify-pack$X git-write-tree$X \
  	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	git-name-rev$X git-pack-redundant$X git-config-set$X git-var$X \
-	$(SIMPLE_PROGRAMS)
+	git-name-rev$X git-pack-redundant$X git-config-set$X git-var$X
+
+# what 'all' will build and 'install' will install.
+ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS) git$X

  # Backward compatibility -- to be removed after 1.0
  PROGRAMS += git-ssh-pull$X git-ssh-push$X
@@ -339,15 +346,10 @@ endif

  ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER))

-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
-	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
-	  gitk git-cherry-pick
-
  export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
  ### Build rules

-all: $(PROGRAMS) $(SCRIPTS) git
+all: $(ALL_PROGRAMS)

  all:
  	$(MAKE) -C templates
@@ -441,9 +443,9 @@ check:

  ### Installation rules

-install: $(PROGRAMS) $(SCRIPTS) git
+install: all
  	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(bindir))
-	$(INSTALL) git $(PROGRAMS) $(SCRIPTS) $(call 
shellquote,$(DESTDIR)$(bindir))
+	$(INSTALL) $(ALL_PROGRAMS) $(call shellquote,$(DESTDIR)$(bindir))
  	$(MAKE) -C templates install
  	$(INSTALL) -d -m755 $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
  	$(INSTALL) $(PYMODULES) $(call shellquote,$(DESTDIR)$(GIT_PYTHON_DIR))
---
0.99.9.GIT

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
