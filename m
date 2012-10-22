From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-testgit: properly check for errors
Date: Mon, 22 Oct 2012 22:56:34 +0200
Message-ID: <1350939394-21622-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 22:57:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQP3Q-0006tl-AP
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab2JVU4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 16:56:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65476 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab2JVU4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 16:56:39 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1257098bkc.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Cu3yp42KEWvMwIamLTZD01IEsUhuiCY/BH9fwoxTxa0=;
        b=o/9TcVy+oIREXk5beDmxZkf1KNJhnGYvOtb0Zf6+lynXSxrP+uI94+uJrNiIlJXEh2
         eDXXxjqybf2yLBx6F3mDOgyhp0HD7VhKPP8gkhhXnnyH4KMu11W2nU25j+Ur6XejeGV9
         dpCdtFfVEsw2WpGkr0Ayv+4NsdpGjPIMlt6puoLnJzXJJhsWKhGeaKSESxBn20Rad4tC
         ZPy4NoYW1sEJMeUqRpxFpeKvWO7pGLJIWJ47svNgosfdJzbWn7UDVqyR+A86V0z7yaAZ
         WxZ9HKwZNrSv2/4XiXvWHcpvExpj5vzpIweRN5hfxI/ZRWSs07EZ/fnmzWggCta0/eU6
         2kvg==
Received: by 10.204.12.205 with SMTP id y13mr3199491bky.46.1350939398182;
        Mon, 22 Oct 2012 13:56:38 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id fm5sm4537806bkc.5.2012.10.22.13.56.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 13:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208202>

'feature done' was missing, which allowed fast-import exit properly, and
transport-helper to continue checking for refs and what not when in fact
the remote-helper died.

Let's enable that, and make sure the error paths are triggered.

Now transport-helper correctly detects the errors from fast-import,
unfortunately, not from fast-export because it might finish before
detecting a SIGPIPE. This means transport-helper will quit silently and
the user will not see any errors, which is bad. Hopefully the helper
will print the error before dying anyway, so not all is lost.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit.py     |  8 ++++++++
 t/t5800-remote-helpers.sh | 21 +++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..b8707e6 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -159,6 +159,11 @@ def do_import(repo, args):
         ref = line[7:].strip()
         refs.append(ref)
 
+    print "feature done"
+
+    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
+        die('Told to fail')
+
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)
 
@@ -172,6 +177,9 @@ def do_export(repo, args):
     if not repo.gitdir:
         die("Need gitdir to export")
 
+    if os.environ.get("GIT_REMOTE_TESTGIT_FAILURE"):
+        die('Told to fail')
+
     update_local_repo(repo)
     changed = repo.importer.do_import(repo.gitdir)
 
diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..446cc8e 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -145,4 +145,25 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs clone HEAD server refs/heads/new-refspec
 '
 
+test_expect_success 'proper failure checks for fetching' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd localclone &&
+	test_must_fail git fetch 2>&1 | \
+		grep "Error while running fast-import"
+	)
+'
+
+# We sleep to give fast-export a chance to catch the SIGPIPE
+test_expect_failure 'proper failure checks for pushing' '
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	GIT_REMOTE_TESTGIT_SLEEPY=1 &&
+	export GIT_REMOTE_TESTGIT_SLEEPY &&
+	cd localclone &&
+	test_must_fail git push --all 2>&1 | \
+		grep "Error while running fast-export"
+	)
+'
+
 test_done
-- 
1.8.0
