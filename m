From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build the script
Date: Wed,  6 Feb 2013 19:11:32 +0100
Message-ID: <1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 06 19:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39Ug-000085-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab3BFSMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:12:44 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46787 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab3BFSMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:12:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16IBcpt007467
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:11:38 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39TA-0005l2-6j; Wed, 06 Feb 2013 19:11:40 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39TA-0003rm-3T; Wed, 06 Feb 2013 19:11:40 +0100
X-Mailer: git-send-email 1.8.1.2.526.gf51a757
In-Reply-To: <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 19:11:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IBcpt007467
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360779100.29532@rWoAUF+UgJ5iCS0vUtXjYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215611>

The configuration of the install directory is not reused from the
toplevel Makefile: we assume Git is already built, hence just call
"git --exec-path". This avoids too much surgery in the toplevel Makefile.

git-remote-mediawiki.perl can now "use Git;".

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/.gitignore                       |  1 +
 contrib/mw-to-git/Makefile                         | 45 ++++++++++++++--------
 ...-remote-mediawiki => git-remote-mediawiki.perl} |  0
 3 files changed, 30 insertions(+), 16 deletions(-)
 create mode 100644 contrib/mw-to-git/.gitignore
 rename contrib/mw-to-git/{git-remote-mediawiki => git-remote-mediawiki.perl} (100%)

diff --git a/contrib/mw-to-git/.gitignore b/contrib/mw-to-git/.gitignore
new file mode 100644
index 0000000..b919655
--- /dev/null
+++ b/contrib/mw-to-git/.gitignore
@@ -0,0 +1 @@
+git-remote-mediawiki
diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index 3ed728b..ed8073b 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -8,40 +8,53 @@
 #
 ## Build git-remote-mediawiki
 
--include ../../config.mak.autogen
--include ../../config.mak
+all:
+
+GIT_ROOT_DIR=../../
+include $(GIT_ROOT_DIR)/default-config.mak
+-include $(GIT_ROOT_DIR)/config.mak.autogen
+-include $(GIT_ROOT_DIR)/config.mak
+-include $(GIT_ROOT_DIR)/GIT-VERSION-FILE
+
+
+SCRIPT_PERL = git-remote-mediawiki.perl
+ALL_PROGRAMS = $(patsubst %.perl,%,$(SCRIPT_PERL))
+
+include $(GIT_ROOT_DIR)/perl.mak
 
-ifndef PERL_PATH
-	PERL_PATH = /usr/bin/perl
-endif
 ifndef gitexecdir
 	gitexecdir = $(shell git --exec-path)
 endif
 
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
-SCRIPT = git-remote-mediawiki
+ifneq ($(filter /%,$(firstword $(gitexecdir))),)
+gitexec_instdir = $(gitexecdir)
+else
+gitexec_instdir = $(prefix)/$(gitexecdir)
+endif
+gitexec_instdir_SQ = $(subst ','\'',$(gitexec_instdir))
 
 .PHONY: install help doc test clean
 
 help:
 	@echo 'This is the help target of the Makefile. Current configuration:'
-	@echo '  gitexecdir = $(gitexecdir_SQ)'
+	@echo '  gitexec_instdir = $(gitexec_instdir_SQ)'
 	@echo '  PERL_PATH = $(PERL_PATH_SQ)'
-	@echo 'Run "$(MAKE) install" to install $(SCRIPT) in gitexecdir'
+	@echo 'Run "$(MAKE) all" to build the script'
+	@echo 'Run "$(MAKE) install" to install $(ALL_PROGRAMS) in gitexec_instdir'
 	@echo 'Run "$(MAKE) test" to run the testsuite'
 
-install:
-	sed -e '1s|#!.*/perl|#!$(PERL_PATH_SQ)|' $(SCRIPT) \
-		> '$(gitexecdir_SQ)/$(SCRIPT)'
-	chmod +x '$(gitexecdir)/$(SCRIPT)'
+all: $(ALL_PROGRAMS)
+
+install: $(ALL_PROGRAMS)
+	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 doc:
-	@echo 'Sorry, "make doc" is not implemented yet for $(SCRIPT)'
+	@echo 'Sorry, "make doc" is not implemented yet for $(ALL_PROGRAMS)'
 
 test:
 	$(MAKE) -C t/ test
 
 clean:
-	$(RM) '$(gitexecdir)/$(SCRIPT)'
+	$(RM) $(ALL_PROGRAMS)
+	$(RM) $(patsubst %,$(gitexec_instdir)/%,/$(ALL_PROGRAMS))
 	$(MAKE) -C t/ clean
diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki.perl
similarity index 100%
rename from contrib/mw-to-git/git-remote-mediawiki
rename to contrib/mw-to-git/git-remote-mediawiki.perl
-- 
1.8.1.2.526.gf51a757
