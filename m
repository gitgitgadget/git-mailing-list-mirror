From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RCF/PATCH] Makefile: move 'ifdef DEVELOPER' after config.mak* inclusion
Date: Tue, 31 May 2016 15:24:43 +0200
Message-ID: <20160531132443.5033-1-Matthieu.Moy@imag.fr>
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 15:25:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7jfK-0000Iy-A2
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 15:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbcEaNYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 09:24:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42992 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbcEaNYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 09:24:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4VDOkZp025308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 31 May 2016 15:24:46 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4VDOl1I029924;
	Tue, 31 May 2016 15:24:47 +0200
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 31 May 2016 15:24:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4VDOkZp025308
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1465305886.90872@5J5l4XIc3u08dxHZGEy+Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295976>

The DEVELOPER knob was introduced in 658df95 (add DEVELOPER makefile
knob to check for acknowledged warnings, 2016-02-25), and works well
when used as "make DEVELOPER=1", and when the configure script was not
used.

However, the advice given in CodingGuidelines to add DEVELOPER=1 to
config.mak does not: config.mak is included after testing for
DEVELOPER in the Makefile, and at least GNU Make's manual specifies
"Conditional directives are parsed immediately", hence the config.mak
declaration is not visible at the time the conditional is evaluated.

Also, when using the configure script to generate a
config.mak.autogen, the later file contained a "CFLAGS = <flags>"
initialization, which overrode the "CFLAGS += -W..." triggered by
DEVELOPER.

This patch fixes both issues.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I'm surprised that no one noticed the issue. Probably because the
Makefile is silent by default. Did I miss anything obvious?

 Makefile | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 15fcd57..2226319 100644
--- a/Makefile
+++ b/Makefile
@@ -380,18 +380,6 @@ ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
-ifdef DEVELOPER
-CFLAGS += -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
-endif
-
 # Create as necessary, replace existing, make ranlib unneeded.
 ARFLAGS = rcs
 
@@ -952,6 +940,18 @@ include config.mak.uname
 -include config.mak.autogen
 -include config.mak
 
+ifdef DEVELOPER
+CFLAGS += -Werror \
+	-Wdeclaration-after-statement \
+	-Wno-format-zero-length \
+	-Wold-style-definition \
+	-Woverflow \
+	-Wpointer-arith \
+	-Wstrict-prototypes \
+	-Wunused \
+	-Wvla
+endif
+
 ifndef sysconfdir
 ifeq ($(prefix),/usr)
 sysconfdir = /etc
-- 
2.8.2.397.gbe91ebf.dirty
