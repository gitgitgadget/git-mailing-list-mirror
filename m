From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 3/8] git_remote_helpers: Force rebuild if python version changes
Date: Sun, 20 Jan 2013 13:15:33 +0000
Message-ID: <9a8644116bebf81cc15c0e63056bb2054dd17ebc.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:16:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwulR-000368-2T
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 14:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030Ab3ATNQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 08:16:22 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:51782 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab3ATNQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 08:16:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id BF2846064D3;
	Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
X-Quarantine-ID: <DLSeNBGtAT3j>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DLSeNBGtAT3j; Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 542126064D2;
	Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4B3C8161E509;
	Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
X-Quarantine-ID: <IPUvb-duOv0W>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IPUvb-duOv0W; Sun, 20 Jan 2013 13:16:20 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 45891161E480;
	Sun, 20 Jan 2013 13:16:13 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
In-Reply-To: <cover.1358686905.git.john@keeping.me.uk>
References: <cover.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214013>

When different version of python are used to build via distutils, the
behaviour can change.  Detect changes in version and pass --force in
this case.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git_remote_helpers/.gitignore | 1 +
 git_remote_helpers/Makefile   | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git_remote_helpers/.gitignore b/git_remote_helpers/.gitignore
index 2247d5f..06c664f 100644
--- a/git_remote_helpers/.gitignore
+++ b/git_remote_helpers/.gitignore
@@ -1,2 +1,3 @@
+/GIT-PYTHON_VERSION
 /build
 /dist
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index f65f064..91f458f 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -25,8 +25,14 @@ PYLIBDIR=$(shell $(PYTHON_PATH) -c \
 	 "import sys; \
 	 print('lib/python%i.%i/site-packages' % sys.version_info[:2])")
 
+py_version=$(shell $(PYTHON_PATH) -c \
+	'import sys; print("%i.%i" % sys.version_info[:2])')
+
 all: $(pysetupfile)
-	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+	$(QUIET)test "$$(cat GIT-PYTHON_VERSION 2>/dev/null)" = "$(py_version)" || \
+	flags=--force; \
+	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
+	$(QUIET)echo "$(py_version)" >GIT-PYTHON_VERSION
 
 install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
-- 
1.8.1.353.gc992d5a.dirty
