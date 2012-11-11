From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/7] remote-bzr: add simple tests
Date: Sun, 11 Nov 2012 15:19:56 +0100
Message-ID: <1352643598-8500-6-git-send-email-felipe.contreras@gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXYOy-0007nI-OZ
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867Ab2KKOUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:20:33 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47320 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2KKOUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:20:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2064575bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G5WTmEWZGGzXd5ppI3huWB1c2q6eUZsrtJku8K20bOY=;
        b=JJz4sIFpKgk0DcB4YnP5W5T9qZSkn9TLPHl8wPTQW0axR1U5xOfIDvv/lcYPL6jQBm
         cPAzCELzOJ8bSO3KFZ9yzVcIOPc+CiA9PYpac3a/dta7igU1C8zYVSt27W5gdgRP9etC
         HdoxWw9uwIG2oIKmERq6O9pJcrJ9ktGwUYEplfYb8wtccfnxNRDfenRsQR1iHlpkBZ2t
         bnWRZsnM/D3zS9MUv9uBgRZN86le3N41t3KftNd6pmplGB3AexPsJbGzzpP/n2cxd6mC
         8Zazg6tEoZDpgmCiiJfbXulAkUnei01NKmXCOjy5Hfqyz4Fr3AmErifG0ixfMf0tTIa2
         qP0w==
Received: by 10.204.157.144 with SMTP id b16mr5917612bkx.19.1352643630589;
        Sun, 11 Nov 2012 06:20:30 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id go4sm1162594bkc.15.2012.11.11.06.20.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:20:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209377>

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
