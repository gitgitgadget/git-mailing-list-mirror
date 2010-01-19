From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Makefile: honor NO_CURL when setting REMOTE_CURL_* variables
Date: Tue, 19 Jan 2010 16:39:12 +0100
Message-ID: <1263915552-32537-1-git-send-email-j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 16:39:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXGB2-0001Ug-O8
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 16:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab0ASPj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 10:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733Ab0ASPj1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 10:39:27 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13652 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750783Ab0ASPj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 10:39:26 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NXGAs-0005uk-Sc; Tue, 19 Jan 2010 16:39:23 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by theia.linz.viscovery (Postfix) with ESMTP id 9A7B71660F;
	Tue, 19 Jan 2010 16:39:22 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 3CBC7FA49; Tue, 19 Jan 2010 16:39:22 +0100 (CET)
X-Mailer: git-send-email 1.6.6.283.g42b20a
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137465>

Previously, these variables were set before there was a chance to set
NO_CURL.

This made a difference only during 'make install', because by installing
$(REMOTE_CURL_ALIASES), the rule  tries to access $(REMOTE_CURL_PRIMARY),
which was never installed. On Windows, this fails; on Unix, stale symbolic
links are created.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 8ed07cf..43fd686 100644
--- a/Makefile
+++ b/Makefile
@@ -423,18 +423,8 @@ BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
 
-ifdef NO_CURL
-REMOTE_CURL_PRIMARY =
-REMOTE_CURL_ALIASES =
-REMOTE_CURL_NAMES =
-else
-REMOTE_CURL_PRIMARY = git-remote-http$X
-REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
-REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
-endif
-
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
@@ -1108,16 +1098,22 @@ ifdef NO_LIBGEN_H
 endif
 
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
+	REMOTE_CURL_PRIMARY =
+	REMOTE_CURL_ALIASES =
+	REMOTE_CURL_NAMES =
 else
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
 	else
 		CURL_LIBCURL = -lcurl
 	endif
+	REMOTE_CURL_PRIMARY = git-remote-http$X
+	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
+	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
 	PROGRAMS += $(REMOTE_CURL_NAMES) git-http-fetch$X
 	curl_check := $(shell (echo 070908; curl-config --vernum) | sort -r | sed -ne 2p)
 	ifeq "$(curl_check)" "070908"
 		ifndef NO_EXPAT
-- 
1.6.6.283.g42b20a
