From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/8] git_remote_helpers: Force rebuild if python version changes
Date: Sat, 12 Jan 2013 19:23:41 +0000
Message-ID: <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 20:25:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu6he-0001OK-NU
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 20:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab3ALTYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 14:24:55 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:55509 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab3ALTYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 14:24:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 19DA1866003;
	Sat, 12 Jan 2013 19:24:54 +0000 (GMT)
X-Quarantine-ID: <K1L1tJm6qnuH>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1L1tJm6qnuH; Sat, 12 Jan 2013 19:24:53 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 38E14866001;
	Sat, 12 Jan 2013 19:24:52 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1F15A161E559;
	Sat, 12 Jan 2013 19:24:52 +0000 (GMT)
X-Quarantine-ID: <rARstJ8QNNrq>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rARstJ8QNNrq; Sat, 12 Jan 2013 19:24:52 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 58881161E1F3;
	Sat, 12 Jan 2013 19:24:41 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
In-Reply-To: <cover.1358018078.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213304>

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
1.8.1
