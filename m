From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] contrib/subtree: fix Makefile to respect non-configure `make`
Date: Sun,  1 Jul 2012 13:55:13 -0500
Message-ID: <1341168913-14598-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org, "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 20:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlPIr-0004AE-KO
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jul 2012 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab2GASzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jul 2012 14:55:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37034 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2GASzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2012 14:55:15 -0400
Received: by obbuo13 with SMTP id uo13so6994980obb.19
        for <git@vger.kernel.org>; Sun, 01 Jul 2012 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=ExvWqCMmC3/qkwPxduBq3g5c8BUI32ohNQKdJSWVpwQ=;
        b=YESO3rZSMO0/A6Om7ljLBIzcUHdK+6ApZzgQFBvI5DT1w+WWG/UKYTduHEjnyrKtWM
         mtcEX3nax0ZQcbQOigj+hBnv/k2+arqWjtiz0ApfwDxSzzXRJ4Nwtyw1Nzq2iIHRFvCT
         NPF5qc8icftRqqoJu2GUGgRkmmRaEj9eFmP4VK4S3JorJXPPN4Sa49YAI6s/UUMaE7s7
         tF4sE/2q2cJZu4taU4Pwi6Ws0gbzquwe8rhKL/rEowt4hKCwfiqHymVlssLwcACor13T
         zyN/itHEVvkxqWpI5TMftmYIqwa4W/Gq3lqqj/lrhTqG9b+7CEXCVIcaJXyOL6+H4oXJ
         Simw==
Received: by 10.50.236.71 with SMTP id us7mr3678382igc.16.1341168914771;
        Sun, 01 Jul 2012 11:55:14 -0700 (PDT)
Received: from localhost (205-178-102-90.c3-0.stk-ubr1.chi-stk.il.cable.rcn.com. [205.178.102.90])
        by mx.google.com with ESMTPS id gs4sm15231226igc.1.2012.07.01.11.55.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 01 Jul 2012 11:55:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200843>

* DESTDIR being defined had no effect.
* prefix was handled inconsistently.
* Unlike the top-level Makefile, this required libexecdir to be defined,
  not gitexecdir.
* The Makefile assumed the git it could use via the shell was the
  correct version, which is not true at all from a packager's
  standpoint. Don't shell out to git at all, use the standard version
  logic like Documentation/ does.

After these changes, it is actually possible to install git-subtree when
packaging git into a temporary install directory, rather than installing
it on the running system.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Packaging this tool in the git package for Arch Linux turned out to be much
more of a process than I expected. We've used the non-configure-based make
system since git has been in our repositories, and it looks like the install
process for this command was never tested with this build system.

The one thing I didn't do here was add some of the sophistication around
relative vs. absolute paths in mandir and gitexecdir that the top-level
Makefile performs. Opinions or thoughts on that? This version will support
relative paths only.

 contrib/subtree/Makefile | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 05cdd5c..919464a 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -2,12 +2,14 @@
 -include ../../config.mak
 
 prefix ?= /usr/local
-mandir ?= $(prefix)/share/man
-libexecdir ?= $(prefix)/libexec/git-core
-gitdir ?= $(shell git --exec-path)
+mandir ?= share/man
+gitexecdir ?= libexec/git-core
 man1dir ?= $(mandir)/man1
 
-gitver ?= $(word 3,$(shell git --version))
+../../GIT-VERSION-FILE: FORCE
+	$(MAKE) -C ../../ GIT-VERSION-FILE
+
+-include ../../GIT-VERSION-FILE
 
 # this should be set to a 'standard' bsd-type install program
 INSTALL ?= install
@@ -30,19 +32,19 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 doc: $(GIT_SUBTREE_DOC)
 
 install: $(GIT_SUBTREE)
-	$(INSTALL) -m 755 $(GIT_SUBTREE) $(libexecdir)
+	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(prefix)/$(gitexecdir)
 
 install-doc: install-man
 
 install-man: $(GIT_SUBTREE_DOC)
-	$(INSTALL) -m 644 $^ $(man1dir)
+	$(INSTALL) -m 644 $^ $(DESTDIR)$(prefix)/$(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
 	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
-		-agit_version=$(gitver) $^
+		-agit_version=$(GIT_VERSION) $^
 
 test:
 	$(MAKE) -C t/ test
@@ -50,3 +52,5 @@ test:
 clean:
 	rm -f *~ *.xml *.html *.1
 	rm -rf subproj mainline
+
+.PHONY: FORCE
-- 
1.7.11.1
