From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Allow INSTALL, bindir, mandir to be set in main Makefile
Date: Thu, 29 Jun 2006 18:35:51 +0200
Message-ID: <200606291835.53788.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606291536.18667.jnareb@gmail.com> <200606291704.27677.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jun 29 18:36:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvzUk-0005oO-74
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 18:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWF2Qfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 12:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWF2Qfz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 12:35:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:49839 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750849AbWF2Qfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 12:35:54 -0400
Received: by nf-out-0910.google.com with SMTP id a4so102433nfc
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 09:35:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M1hjlVNLNAxZ5/btREAP07XxKK7DC/81fYCButEu7zjMwzVj3abnNNBkNeFvy1aOeQlkd6FMQHNottJq+/5e6RVXxzltRRxIi7mxx6tEA+Bln4wc0cjNkmRAtcDJkfYt+wcI6VYCx71kX3Ub9o+M0KWz9+F945XbqfrsIcGADnQ=
Received: by 10.49.90.8 with SMTP id s8mr526959nfl;
        Thu, 29 Jun 2006 09:35:53 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id k9sm730007nfc.2006.06.29.09.35.52;
        Thu, 29 Jun 2006 09:35:53 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606291704.27677.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22873>

Makefiles in subdirectories now use existing value of INSTALL, bindir,
mandir if it is set, allowing those to be set in main Makefile or in
config.mak.  Main Makefile exports variables which it sets.

Renames man1 and man7 variables to man1dir and man7dir, according to
"Makefile Conventions: Variables for Installation Directories" in
make.info of GNU Make.  Renames bin to bindir (unused, perhaps to be
removed).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Part of autoconf series, but independent.

Should probably be split into two patches:
 * first with export + '?='
 * second renaming man1 and man7 to man1dir and man7dir

 Documentation/Makefile   |   14 +++++++-------
 Makefile                 |    2 ++
 contrib/emacs/Makefile   |    4 ++--
 contrib/git-svn/Makefile |    8 ++++----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2b0efe7..cc83610 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,10 +25,10 @@ DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT
 DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
 
 prefix?=$(HOME)
-bin=$(prefix)/bin
-mandir=$(prefix)/man
-man1=$(mandir)/man1
-man7=$(mandir)/man7
+bindir?=$(prefix)/bin
+mandir?=$(prefix)/man
+man1dir=$(mandir)/man1
+man7dir=$(mandir)/man7
 # DESTDIR=
 
 INSTALL?=install
@@ -52,9 +52,9 @@ man1: $(DOC_MAN1)
 man7: $(DOC_MAN7)
 
 install: man
-	$(INSTALL) -d -m755 $(DESTDIR)$(man1) $(DESTDIR)$(man7)
-	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1)
-	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7)
+	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man7dir)
+	$(INSTALL) $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 
 #
diff --git a/Makefile b/Makefile
index cde619c..b8fe669 100644
--- a/Makefile
+++ b/Makefile
@@ -100,6 +100,8 @@ template_dir = $(prefix)/share/git-core/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
 
+export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
+
 CC = gcc
 AR = ar
 TAR = tar
diff --git a/contrib/emacs/Makefile b/contrib/emacs/Makefile
index d3619db..350846d 100644
--- a/contrib/emacs/Makefile
+++ b/contrib/emacs/Makefile
@@ -3,9 +3,9 @@ ## Build and install stuff
 EMACS = emacs
 
 ELC = git.elc vc-git.elc
-INSTALL = install
+INSTALL ?= install
 INSTALL_ELC = $(INSTALL) -m 644
-prefix = $(HOME)
+prefix ?= $(HOME)
 emacsdir = $(prefix)/share/emacs/site-lisp
 
 all: $(ELC)
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index 7c20946..8cac688 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -1,9 +1,9 @@
 all: git-svn
 
 prefix?=$(HOME)
-bindir=$(prefix)/bin
-mandir=$(prefix)/man
-man1=$(mandir)/man1
+bindir?=$(prefix)/bin
+mandir?=$(prefix)/man
+man1dir=$(mandir)/man1
 INSTALL?=install
 doc_conf=../../Documentation/asciidoc.conf
 -include ../../config.mak
@@ -17,7 +17,7 @@ install: all
 	$(INSTALL) git-svn $(DESTDIR)$(bindir)
 
 install-doc: doc
-	$(INSTALL) git-svn.1 $(DESTDIR)$(man1)
+	$(INSTALL) git-svn.1 $(DESTDIR)$(man1dir)
 
 doc: git-svn.1
 git-svn.1 : git-svn.xml
-- 
1.4.0
