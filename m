From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 3/8] git_remote_helpers: force rebuild if python version changes
Date: Thu, 17 Jan 2013 18:53:56 +0000
Message-ID: <3dd93f736c6e78b9ac9e902cc2321209d0a78fd5.1358448207.git.john@keeping.me.uk>
References: <cover.1358448207.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:56:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvudL-0004Zg-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 19:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab3AQSzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 13:55:54 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:35916 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab3AQSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 13:55:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id BB625606545;
	Thu, 17 Jan 2013 18:55:53 +0000 (GMT)
X-Quarantine-ID: <KUOmztxUSzXV>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUOmztxUSzXV; Thu, 17 Jan 2013 18:55:53 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 694C0198074;
	Thu, 17 Jan 2013 18:55:53 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 4572A276E00;
	Thu, 17 Jan 2013 18:55:53 +0000 (GMT)
X-Quarantine-ID: <YzbUJmJu1f-i>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YzbUJmJu1f-i; Thu, 17 Jan 2013 18:55:53 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id C0B06276DFB;
	Thu, 17 Jan 2013 18:55:40 +0000 (GMT)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
In-Reply-To: <cover.1358448207.git.john@keeping.me.uk>
References: <cover.1358018078.git.john@keeping.me.uk> <cover.1358448207.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213865>

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
1.8.1.1.260.g99b33f4.dirty
