From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 10/16] remote-hg: add basic tests
Date: Sun,  4 Nov 2012 03:13:32 +0100
Message-ID: <1351995218-19889-11-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjf-0002j1-32
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2KDCOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644Ab2KDCO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:27 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NWS/Vo2oGoBRPkbPLL50CO3BS4pHli92H4+QbrsKeFU=;
        b=oQGIrb1ePOnEnoHP5wSK2Au5G5E03MSXTu2yAkobrJXFHtHEeZWs499I6r0gyvyANy
         vm0KXo72FWK/kUhGHcadFUfo7Q8u1xPDhimiQlHE/lMSa8Jz60VkdT7jjZMHkLFHZriQ
         HKGcHY1bcoQAevxrAo6ybTZoon6rxLMCnIL5eoKDdzYkd57iuFqKZdWC60P+1JHg183m
         785B2fgROBCuXM3clW+ZFZ6//9R7LoUEwkcnjg4mi3rLfViLX0YkYDEj/54dkzRYiv/l
         4jfAzdYo0+GqfssZ2n+Whl0hipyAWCJfhsIurcRj05LpjoC0oXX8p0EtSqfcbDd+bdB9
         vpmw==
Received: by 10.204.9.149 with SMTP id l21mr1437862bkl.57.1351995266814;
        Sat, 03 Nov 2012 19:14:26 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id 9sm7946519bkq.13.2012.11.03.19.14.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208998>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile   |  13 +++++
 contrib/remote-helpers/test-hg.sh | 112 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 contrib/remote-helpers/Makefile
 create mode 100755 contrib/remote-helpers/test-hg.sh

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
new file mode 100644
index 0000000..9a76575
--- /dev/null
+++ b/contrib/remote-helpers/Makefile
@@ -0,0 +1,13 @@
+TESTS := $(wildcard test*.sh)
+
+export T := $(addprefix $(CURDIR)/,$(TESTS))
+export MAKE := $(MAKE) -e
+export PATH := $(CURDIR):$(PATH)
+
+test:
+	$(MAKE) -C ../../t $@
+
+$(TESTS):
+	$(MAKE) -C ../../t $(CURDIR)/$@
+
+.PHONY: $(TESTS)
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
new file mode 100755
index 0000000..40e6e3c
--- /dev/null
+++ b/contrib/remote-helpers/test-hg.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+# Base commands from hg-git tests:
+# https://bitbucket.org/durin42/hg-git/src
+#
+
+test_description='Test remote-hg'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all='skipping remote-hg tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import mercurial'; then
+	skip_all='skipping remote-hg tests; mercurial not available'
+	test_done
+fi
+
+check () {
+	(cd $1 &&
+	git log --format='%s' -1 &&
+	git symbolic-ref HEAD) > actual &&
+	(echo $2 &&
+	echo "refs/heads/$3") > expected &&
+	test_cmp expected actual
+}
+
+test_expect_success 'cloning' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  hg init hgrepo &&
+  cd hgrepo &&
+  echo zero > content &&
+  hg add content &&
+  hg commit -m zero
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo zero master
+'
+
+test_expect_success 'cloning with branches' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg branch next &&
+  echo next > content &&
+  hg commit -m next
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo next next &&
+
+  (cd hgrepo && hg checkout default) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo2 &&
+  check gitrepo2 zero master
+'
+
+test_expect_success 'cloning with bookmarks' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg bookmark feature-a &&
+  echo feature-a > content &&
+  hg commit -m feature-a
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo feature-a feature-a
+'
+
+test_expect_success 'cloning with detached head' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg update -r 0
+  ) &&
+
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  check gitrepo zero master
+'
+
+test_expect_success 'update bookmark' '
+  test_when_finished "rm -rf gitrepo*" &&
+
+  (
+  cd hgrepo &&
+  hg bookmark devel
+  ) &&
+
+  (
+  git clone "hg::$PWD/hgrepo" gitrepo &&
+  cd gitrepo &&
+  git checkout devel &&
+  echo devel > content &&
+  git commit -a -m devel &&
+  git push
+  ) &&
+
+  hg -R hgrepo bookmarks | grep "devel\s\+3:"
+'
+
+test_done
-- 
1.8.0
