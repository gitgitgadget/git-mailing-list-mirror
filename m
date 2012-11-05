From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/5] remote-bzr: add simple tests
Date: Mon,  5 Nov 2012 16:56:17 +0100
Message-ID: <1352130980-3998-3-git-send-email-felipe.contreras@gmail.com>
References: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:57:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVP2s-0007CB-3v
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab2KEP4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:56:49 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38101 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2KEP4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:56:43 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2063229bkc.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G5WTmEWZGGzXd5ppI3huWB1c2q6eUZsrtJku8K20bOY=;
        b=OTi/Zi/d4UiHmQzjp+qm1cA7qC1ch22zqJrxcM2mzLEp9p393TR3P4xUQwJpnzCSG5
         t0lijHZBS9JWfMfWe7YKTgE+1Wh27+SYLh4nOEwTi6jfaYd2/zEQ5HfihjYwTFHjRTeO
         +ehfeALmgG9rDnURHJ0jNDwfEIZ+YL4JCk7LkD6uvRoabW8Q7njdKjREzuow5GL97NYA
         ei55/GX/n44eUje2A1BgdG8y2UXJ710jWSaN9zjIv0Ws9ZvT7mt+JXO5gYuIzWWDXz6W
         cR41LlLTBNH58i7O7RuXgAcvRiwAjA28ZCdCLeU3YqAyWUcdmRbBHeulZn/RXu/Qc5fS
         RJXQ==
Received: by 10.204.128.89 with SMTP id j25mr2461301bks.23.1352131002692;
        Mon, 05 Nov 2012 07:56:42 -0800 (PST)
Received: from localhost (ip-109-43-0-76.web.vodafone.de. [109.43.0.76])
        by mx.google.com with ESMTPS id g8sm10139393bkv.6.2012.11.05.07.56.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 07:56:41 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352130980-3998-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209069>

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
