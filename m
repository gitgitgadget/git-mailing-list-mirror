From: Niels Basjes <Niels@Basjes.nl>
Subject: [PATCH] Two RPM building improvements
Date: Fri, 27 Mar 2009 13:32:14 +0100
Message-ID: <1238157134-27558-1-git-send-email-Niels@Basjes.nl>
Cc: Niels Basjes <Niels@Basjes.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 14:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnBhF-00051U-EQ
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbZC0NAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZC0NAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:00:25 -0400
Received: from smtpq4.gn.mail.iss.as9143.net ([212.54.34.167]:56407 "EHLO
	smtpq4.gn.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796AbZC0NAY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Mar 2009 09:00:24 -0400
X-Greylist: delayed 1321 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2009 09:00:23 EDT
Received: from [212.54.34.132] (helo=smtp1.gn.mail.iss.as9143.net)
	by smtpq4.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <niels@hobby.basjes.nl>)
	id 1LnBKF-0008Rx-Ed; Fri, 27 Mar 2009 13:38:19 +0100
Received: from 53512e70.cable.casema.nl ([83.81.46.112] helo=hobby.basjes.nl)
	by smtp1.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <niels@hobby.basjes.nl>)
	id 1LnBKD-0004YR-Lz; Fri, 27 Mar 2009 13:38:17 +0100
Received: from hobby.basjes.nl (hobby.basjes.nl [127.0.0.1])
	by hobby.basjes.nl (8.13.8/8.13.8) with ESMTP id n2RCWEDZ027589;
	Fri, 27 Mar 2009 13:32:14 +0100
Received: (from niels@localhost)
	by hobby.basjes.nl (8.13.8/8.13.8/Submit) id n2RCWEHi027588;
	Fri, 27 Mar 2009 13:32:14 +0100
X-Mailer: git-send-email 1.6.2
X-ZiggoSMTP-MailScanner-Information: Please contact the ISP for more information
X-ZiggoSMTP-MailScanner-ID: 1LnBKD-0004YR-Lz
X-ZiggoSMTP-MailScanner: Found to be clean
X-ZiggoSMTP-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-4.322, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -2.60, TW_FN 0.08)
X-ZiggoSMTP-MailScanner-From: niels@hobby.basjes.nl
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114886>

Two RPM building improvements:
  - Building the RPMs can now be done by a non-root user.
  - The additional target all-rpms now builds the RPMs for a multitude of target platforms.

Signed-off-by: Niels Basjes <Niels@Basjes.nl>
---
 .gitignore |    1 +
 Makefile   |   26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 1c57d4c..2f2554b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -173,3 +173,4 @@ configure
 tags
 TAGS
 cscope*
+RPM_BUILDING
diff --git a/Makefile b/Makefile
index 7867eac..d9f5e04 100644
--- a/Makefile
+++ b/Makefile
@@ -1564,7 +1564,29 @@ dist: git.spec git-archive$(X) configure
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
-	$(RPMBUILD) -ta $(GIT_TARNAME).tar.gz
+	-@mkdir -p RPM_BUILDING/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz
+	-@echo ""
+	-@echo "================================================================="
+	-@echo "Generated RPMS and SRPMS:"
+	-@find `pwd`/RPM_BUILDING/ -type f -name '$(distdir)*.rpm' | xargs -n 1 -iXXX echo "- XXX"
+	-@echo "================================================================="
+	-@echo ""
+
+all-rpms: dist
+	-@mkdir -p RPM_BUILDING/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz --target i386
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz --target i686
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz --target x86_64
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz --target ia32
+	$(RPMBUILD) --define="_topdir `pwd`/RPM_BUILDING" -ta $(GIT_TARNAME).tar.gz --target ppc
+	-@echo ""
+	-@echo "================================================================="
+	-@echo "Generated RPMS and SRPMS:"
+	-@find `pwd`/RPM_BUILDING/ -type f -name '$(distdir)*.rpm' | xargs -n 1 -iXXX echo "- XXX"
+	-@echo "================================================================="
+	-@echo ""
+
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
@@ -1613,7 +1635,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
 
-.PHONY: all install clean strip
+.PHONY: all install clean strip rpm all-rpms
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
-- 
1.6.2
