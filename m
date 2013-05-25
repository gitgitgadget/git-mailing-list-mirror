From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-helpers: add exec-path links
Date: Fri, 24 May 2013 21:38:27 -0500
Message-ID: <1369449507-18269-5-git-send-email-felipe.contreras@gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:40:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4PH-0007DR-D4
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab3EYCkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:40:22 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57920 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab3EYCkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:40:18 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so6959889oah.35
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OGXuIJvWpQhCSDcPOy+BZv0VmZiEVw658dP1pmvyGtw=;
        b=H1IC+492VR7n6BnSrwjsNjbvkbipt3mD9KMQpSKimiQiX0murk+krEAtGmah4s/zI+
         97mH3CbbWwWMK1fX3zT8nTDgMKqqVPzbUjyntbvF9CxxY3eTfKg2S/O39o93jEtdeQo/
         NAeXgYaZmrVrgRSrUaP3rAkukh/T0g0qHtYg/xCOUGv4WiKgxAsoevyYuWzDYJe9rugU
         NqRNPgSvJAchHToMKsbSIvcZvy+V8Sep2/FBilPp2Qodx1SgeEtrqwJOXrWhBfsJzuAB
         5xUhQQkBMISEl/zn229qnKo9qPNdgJthDKaeHh6D+gsWssTy/8T/ywZsYDlRQEvksf/i
         H97w==
X-Received: by 10.182.86.6 with SMTP id l6mr13387928obz.6.1369449618427;
        Fri, 24 May 2013 19:40:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm20036107obb.14.2013.05.24.19.40.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225466>

This way we don't have to modify the PATH ourselves and it's easier to
test without 'make'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                      |  2 ++
 contrib/remote-helpers/Makefile | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/.gitignore b/.gitignore
index 10aee94..a79b412 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,11 +119,13 @@
 /git-reflog
 /git-relink
 /git-remote
+/git-remote-bzr
 /git-remote-http
 /git-remote-https
 /git-remote-ftp
 /git-remote-ftps
 /git-remote-fd
+/git-remote-hg
 /git-remote-ext
 /git-remote-testgit
 /git-remote-testpy
diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 55abf0b..98150b4 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,9 +1,9 @@
 TESTS := $(wildcard test-*.t)
 SCRIPTS := $(wildcard git-remote-*.py)
+LINKS := $(addprefix ../../,$(patsubst %.py,%,$(SCRIPTS)))
 
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
-export PATH := $(CURDIR):$(PATH)
 export TEST_LINT := test-lint-executable test-lint-shell-syntax
 export TEST_DIRECTORY := $(CURDIR)/../../t
 
@@ -15,10 +15,15 @@ all: $(SCRIPTS)
 install:
 	$(MAKE) -C ../.. install-python-script
 
-test: all
+links: all $(LINKS)
+
+test: links
 	$(MAKE) -C ../../t $@
 
-$(TESTS): all
+$(LINKS):
+	ln -sf contrib/remote-helpers/$(notdir $@) ../..
+
+$(TESTS): links
 	$(MAKE) -C ../../t $(CURDIR)/$@
 
-.PHONY: all install test $(TESTS)
+.PHONY: all install test links $(TESTS)
-- 
1.8.3.rc3.312.g47657de
