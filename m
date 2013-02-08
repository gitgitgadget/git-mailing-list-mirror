From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] Makefile: make script-related rules usable from subdirectories
Date: Fri,  8 Feb 2013 18:31:16 +0100
Message-ID: <1360344677-5962-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq4nhmbusp.fsf@grenoble-inp.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 08 18:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3roZ-00040L-AH
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946796Ab3BHRcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:32:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51150 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946774Ab3BHRcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:32:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r18HVM63028802
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2013 18:31:22 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U3rnI-0002v5-6X; Fri, 08 Feb 2013 18:31:24 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U3rnI-0001Yq-1r; Fri, 08 Feb 2013 18:31:24 +0100
X-Mailer: git-send-email 1.8.1.2.530.g3cc16e4.dirty
In-Reply-To: <vpq4nhmbusp.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Feb 2013 18:31:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r18HVM63028802
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360949485.51553@C7JCGLvOnZxaB3fjVUqZyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215785>

Git's Makefile provides a few nice features for script build and
installation (substitute the first line with the right path, hardcode the
path to Git library, ...).

The Makefile already knows how to process files outside the toplevel
directory with e.g.

  make SCRIPT_PERL=path/to/file.perl path/to/file

but we can make it simpler for callers by exposing build, install and
clean rules as .PHONY targets.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
The goal of this series is to use perl, but it is as easy to do it
with sh and python too, so I did it for them too. I tested a manual
"make -C ../../" in contrib/subtree and contrib/hg-to-git/ to check that
it actually works.

 Makefile | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5a2e02d..b4af30d 100644
--- a/Makefile
+++ b/Makefile
@@ -480,9 +480,38 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
-	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
-	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
+# Generated files for scripts
+SCRIPT_SH_GEN = $(patsubst %.sh,%,$(SCRIPT_SH))
+SCRIPT_PERL_GEN = $(patsubst %.perl,%,$(SCRIPT_PERL))
+SCRIPT_PYTHON_GEN = $(patsubst %.py,%,$(SCRIPT_PYTHON))
+
+# Individual rules to allow e.g.
+# "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
+# from subdirectories like contrib/*/
+.PHONY: build-perl-script build-sh-script build-python-script
+build-perl-script: $(SCRIPT_PERL_GEN)
+build-sh-script: $(SCRIPT_SH_GEN)
+build-python-script: $(SCRIPT_PYTHON_GEN)
+
+.PHONY: install-perl-script install-sh-script install-python-script
+install-sh-script: $(SCRIPT_SH_GEN)
+	$(INSTALL) $(SCRIPT_SH_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-perl-script: $(SCRIPT_PERL_GEN)
+	$(INSTALL) $(SCRIPT_PERL_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-python-script: $(SCRIPT_PYTHON_GEN)
+	$(INSTALL) $(SCRIPT_PYTHON_GEN) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+
+.PHONY: clean-perl-script clean-sh-script clean-python-script
+clean-sh-script:
+	$(RM) $(SCRIPT_SH_GEN)
+clean-perl-script:
+	$(RM) $(SCRIPT_PERL_GEN)
+clean-python-script:
+	$(RM) $(SCRIPT_PYTHON_GEN)
+
+SCRIPTS = $(SCRIPT_SH_GEN) \
+	  $(SCRIPT_PERL_GEN) \
+	  $(SCRIPT_PYTHON_GEN) \
 	  git-instaweb
 
 ETAGS_TARGET = TAGS
-- 
1.8.1.2.530.g3cc16e4.dirty
