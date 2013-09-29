From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] build: fix installation of scripts
Date: Sun, 29 Sep 2013 11:53:06 -0500
Message-ID: <1380473586-4245-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 18:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQKKp-0006a6-62
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 18:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab3I2Q6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 12:58:51 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:41619 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3I2Q6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 12:58:49 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so3306625oah.2
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ThZ/+o+XItFlHw6Kw56VvhCGz+bE1DLA/w3RU2dNnHE=;
        b=VwYEgEZxaqFG+Lf74y4VOoYDVou5AaB1boHIkM9nk0GextP2cscR8ooyOaH+jNoo5G
         86n1OV1EWCY0RPlwD+Km4zSTSGRjfH9PSCefHTj082clcJWTQc+vXqyi4fLYiuRctHDJ
         eQJy2PKePcSSTpzUz19HxlC4Tt8lEE8b9WugFxE+yVKMlFL6QxHfphoaeutw/Y6Kgupp
         oXF+Dea6G4CzR5r3Qfu97hy969PK3h0Zucv31nUlkZvpJLPWGUAkyykx2eAUh4OeoLA3
         WYngOg+QV+AxxcvgsjNdBvNVeu57T9tNPYWXIs03CSlqIlOe18yjZPgQKAFWAbW7/9FL
         3VCQ==
X-Received: by 10.60.65.227 with SMTP id a3mr15816288oet.13.1380473929232;
        Sun, 29 Sep 2013 09:58:49 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm31054319oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 09:58:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235601>

They need the gitexecdir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Otherwise this makes it difficult to package contrib scripts in certain
distributions.

For example, if you have a proper Makefile in contrib:

---
TESTS := $(wildcard test*.sh)
SCRIPTS := $(wildcard git-remote-*.py)

export T := $(addprefix $(CURDIR)/,$(TESTS))
export MAKE := $(MAKE) -e
export PATH := $(CURDIR):$(PATH)
export TEST_LINT := test-lint-executable test-lint-shell-syntax

export SCRIPT_PYTHON := $(addprefix $(CURDIR)/,$(SCRIPTS))

all: $(SCRIPTS)
	$(MAKE) -C ../.. build-python-script

install:
	$(MAKE) -C ../.. install-python-script

test: all
	$(MAKE) -C ../../t $@

$(TESTS): all
	$(MAKE) -C ../../t $(CURDIR)/$@

.PHONY: all install test $(TESTS)
---

A packager might create a git-bzr package that does this:

% make -C contrib/remote-helpers install

But that would fail, unless this patch is applied.

Distributions like Arch Linux don't have a concept of multiple binary packages
from a single source package, so there would need to be a separate PKGBUILD
(akin to spec file) for git-bzr. In addition this package might not be
official, but part of the user maintained AUR. Similarly, other distributions
might want to package git-bzr separetly, for example from launchpad.

 Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3588ca1..e51b92e 100644
--- a/Makefile
+++ b/Makefile
@@ -511,12 +511,14 @@ build-perl-script: $(SCRIPT_PERL_GEN)
 build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
-.PHONY: install-perl-script install-sh-script install-python-script
-install-sh-script: $(SCRIPT_SH_INS)
+.PHONY: install-gitexecdir install-perl-script install-sh-script install-python-script
+install-gitexecdir:
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-sh-script: $(SCRIPT_SH_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-perl-script: $(SCRIPT_PERL_INS)
+install-perl-script: $(SCRIPT_PERL_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-python-script: $(SCRIPT_PYTHON_INS)
+install-python-script: $(SCRIPT_PYTHON_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
-- 
1.8.4-fc
