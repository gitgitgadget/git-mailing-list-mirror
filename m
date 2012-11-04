From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] remote-bzr: add simple tests
Date: Sun,  4 Nov 2012 03:22:03 +0100
Message-ID: <1351995723-20396-4-git-send-email-felipe.contreras@gmail.com>
References: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUprF-0000ke-L4
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab2KDCW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:22:27 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45078 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2KDCWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:22:25 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1658012bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G5WTmEWZGGzXd5ppI3huWB1c2q6eUZsrtJku8K20bOY=;
        b=fxzz8V8G76XMnPrz9+3dE82A+Bv6OSCvsHJYStemypDY+P1WojbubJL+v7AeG4yPqy
         ci7R9Afvb0dyLp/2xuQVoeH1hMO/55co6hZwXoHxxhdzprZY/HQQg4IfztkTTq5iUwV0
         496QQCsMZV5myaBcRG7yfiN88vYEjXvOKKS4lK54AxhQz9C+taDeZt2nVfwSjr9qSv2q
         4h7XxGQFy7eAjxDLWJZ0Y+TkgLQgmOACk08q55qJ1tDdLGTkNGM0FzDkedb6yr4HUBeV
         VeWr+5hg+bStwh4cJs+O/f2IycIU2DpekK7rO+pzCPY/XWc5pV1frglHwDBWYA3SY/og
         qTCg==
Received: by 10.204.129.211 with SMTP id p19mr1445457bks.94.1351995743814;
        Sat, 03 Nov 2012 19:22:23 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id r15sm7944622bkw.9.2012.11.03.19.22.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:22:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995723-20396-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209007>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 111 +++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100755 contrib/remote-helpers/test-bzr.sh

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
new file mode 100755
index 0000000..8594ffc
--- /dev/null
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -0,0 +1,111 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Felipe Contreras
+#
+
+test_description='Test remote-bzr'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PYTHON; then
+	skip_all='skipping remote-bzr tests; python not available'
+	test_done
+fi
+
+if ! "$PYTHON_PATH" -c 'import bzrlib'; then
+	skip_all='skipping remote-bzr tests; bzr not available'
+	test_done
+fi
+
+cmd=<<EOF
+import bzrlib
+bzrlib.initialize()
+import bzrlib.plugin
+bzrlib.plugin.load_plugins()
+import bzrlib.plugins.fastimport
+EOF
+
+if ! "$PYTHON_PATH" -c "$cmd"; then
+	echo "consider setting BZR_PLUGIN_PATH=$HOME/.bazaar/plugins" 1>&2
+	skip_all='skipping remote-bzr tests; bzr-fastimport not available'
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
+bzr whoami "A U Thor <author@example.com>"
+
+test_expect_success 'cloning' '
+  (bzr init bzrrepo &&
+  cd bzrrepo &&
+  echo one > content &&
+  bzr add content &&
+  bzr commit -m one
+  ) &&
+
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+  check gitrepo one master
+'
+
+test_expect_success 'pulling' '
+  (cd bzrrepo &&
+  echo two > content &&
+  bzr commit -m two
+  ) &&
+
+  (cd gitrepo && git pull) &&
+
+  check gitrepo two master
+'
+
+test_expect_success 'pushing' '
+  (cd gitrepo &&
+  echo three > content &&
+  git commit -a -m three &&
+  git push
+  ) &&
+
+  echo three > expected &&
+  cat bzrrepo/content > actual &&
+  test_cmp expected actual
+'
+
+test_expect_success 'roundtrip' '
+  (cd gitrepo &&
+  git pull &&
+  git log --format="%s" -1 origin/master > actual) &&
+  echo three > expected &&
+  test_cmp expected actual &&
+
+  (cd gitrepo && git push && git pull) &&
+
+  (cd bzrrepo &&
+  echo four > content &&
+  bzr commit -m four
+  ) &&
+
+  (cd gitrepo && git pull && git push) &&
+
+  check gitrepo four master &&
+
+  (cd gitrepo &&
+  echo five > content &&
+  git commit -a -m five &&
+  git push && git pull
+  ) &&
+
+  (cd bzrrepo && bzr revert) &&
+
+  echo five > expected &&
+  cat bzrrepo/content > actual &&
+  test_cmp expected actual
+'
+
+test_done
-- 
1.8.0
