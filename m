From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-helpers: generate scripts
Date: Fri, 24 May 2013 21:38:24 -0500
Message-ID: <1369449507-18269-2-git-send-email-felipe.contreras@gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:40:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4P5-00075g-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab3EYCkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:40:10 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:45231 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3EYCkK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:40:10 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so6293808obc.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oMVwcm2/0dt3i6VvzkjYjfWJ/g58e5jAWvhRbnAJ3K0=;
        b=CV5tR5zsQg4a51tM3hZd/AwfUEPxrMkS7LdcSW3bEj+WyGiFxfqt/A+Cc5mwOmtErt
         sxTVsmRklV9+2IhjBFPnDN8c6J0xInwHZQbW6Bg9dKxlcNLZW4LqwxzTsR9jSGaTSBAW
         b+fO8qoCOriOi1RgELiOGP7Tph8loGgCNwxUPoGj7+RYiO05XIXN6zpriq2B3rFMnjld
         Un7VRCxd+yEHmhVXz8ebdlm5whbDLv4EQU2iFTfb5AdkzUUJX/1Dmlpo1Wz5xg2kVP2B
         vVo3VI5zdG2UPvBa31FTyD32+0YLCpgAI14w0zIQVDmQ6ApKJSCbmF7UHpigkSaOkRXC
         6xww==
X-Received: by 10.60.144.69 with SMTP id sk5mr9215136oeb.142.1369449609364;
        Fri, 24 May 2013 19:40:09 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p3sm12123882oel.0.2013.05.24.19.40.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:40:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225464>

The same way other python scripts are generated, so the shebang is
replaced by PYTHON_PATH.

Also, cleanup the Makefile.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/.gitignore                         |  2 ++
 contrib/remote-helpers/Makefile                           | 15 ++++++++++++---
 .../remote-helpers/{git-remote-bzr => git-remote-bzr.py}  |  0
 .../remote-helpers/{git-remote-hg => git-remote-hg.py}    |  0
 4 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 contrib/remote-helpers/.gitignore
 rename contrib/remote-helpers/{git-remote-bzr => git-remote-bzr.py} (100%)
 rename contrib/remote-helpers/{git-remote-hg => git-remote-hg.py} (100%)

diff --git a/contrib/remote-helpers/.gitignore b/contrib/remote-helpers/.gitignore
new file mode 100644
index 0000000..9bf692b
--- /dev/null
+++ b/contrib/remote-helpers/.gitignore
@@ -0,0 +1,2 @@
+git-remote-bzr
+git-remote-hg
diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 239161d..d9b3515 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,14 +1,23 @@
 TESTS := $(wildcard test*.sh)
+SCRIPTS := $(wildcard git-remote-*.py)
 
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
 export PATH := $(CURDIR):$(PATH)
 export TEST_LINT := test-lint-executable test-lint-shell-syntax
 
-test:
+export SCRIPT_PYTHON := $(addprefix $(CURDIR)/,$(SCRIPTS))
+
+all: $(SCRIPTS)
+	$(MAKE) -C ../.. build-python-script
+
+install:
+	$(MAKE) -C ../.. install-python-script
+
+test: all
 	$(MAKE) -C ../../t $@
 
-$(TESTS):
+$(TESTS): all
 	$(MAKE) -C ../../t $(CURDIR)/$@
 
-.PHONY: $(TESTS)
+.PHONY: all install test $(TESTS)
diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr.py
similarity index 100%
rename from contrib/remote-helpers/git-remote-bzr
rename to contrib/remote-helpers/git-remote-bzr.py
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg.py
similarity index 100%
rename from contrib/remote-helpers/git-remote-hg
rename to contrib/remote-helpers/git-remote-hg.py
-- 
1.8.3.rc3.312.g47657de
