From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/4] perl.mak: introduce $(GIT_ROOT_DIR) to allow inclusion from other directories
Date: Wed,  6 Feb 2013 19:11:30 +0100
Message-ID: <1360174292-14793-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 06 19:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U39Tb-0007fn-09
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 19:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab3BFSLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 13:11:44 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53950 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3BFSLn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 13:11:43 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r16IBZG8029430
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 19:11:36 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T7-0005kS-MX; Wed, 06 Feb 2013 19:11:37 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U39T7-0003rg-JD; Wed, 06 Feb 2013 19:11:37 +0100
X-Mailer: git-send-email 1.8.1.2.526.gf51a757
In-Reply-To: <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Feb 2013 19:11:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16IBZG8029430
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1360779096.95211@hVR5xAZzp0eKMIinucd/fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215607>

perl.mak uses relative path, which is OK when called from the toplevel,
but won't be anymore if one includes it from elsewhere. It is now
possible to include the file using:

GIT_ROOT_DIR=<whatever>
include $(GIT_ROOT_DIR)/perl.mak

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 perl.mak | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/perl.mak b/perl.mak
index 8bbeef3..a2b8717 100644
--- a/perl.mak
+++ b/perl.mak
@@ -1,5 +1,9 @@
 # Rules to build Git commands written in perl
 
+ifndef GIT_ROOT_DIR
+	GIT_ROOT_DIR = .
+endif
+
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -11,12 +15,11 @@ NO_PERL = NoThanks
 endif
 
 ifndef NO_PERL
-$(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
-
+$(patsubst %.perl,%,$(SCRIPT_PERL)): $(GIT_ROOT_DIR)/perl/perl.mak
 
-$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
+$(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl $(GIT_ROOT_DIR)/GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C $(GIT_ROOT_DIR)/perl -s --no-print-directory instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-- 
1.8.1.2.526.gf51a757
