From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/7] remote-bzr: set author if available
Date: Fri,  5 Apr 2013 21:49:19 -0600
Message-ID: <1365220163-13581-4-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Engster <deng@randomsample.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSE-0001b9-0q
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163191Ab3DFDvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:51:38 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36640 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162359Ab3DFDvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:51:38 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so3324277obc.18
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oIRC7yv27cZDWRZBQ45Mv6bCi6h5zTtKdnRof+2DZoc=;
        b=bFfxoAh9YzxvKvWY445bzl22nAbIID1xXhoj4T4P+tnYuGg3wXYOEbGI0uCfmc0mVd
         KLMLPb8yvJf3XRhBAtR07ua5tA/M1svzrtgfQbzwedzL3v5Pqt0Gbcga0PxyisnNY+8r
         MU4BvGi3enU42toCnaS2rm99jiGhQ2fjb+udiHO/j4NQonVEvefU+mcmepfP6X7npiRc
         Yq08iWq1POUU/qGLg8S8Qg9j+i3WsWwTkoPJdE9QdacBvBilwmr92296/sihrFQy8zKF
         tauGowCQ4GlFEqoKHit21QBaWX9tLrSrMActiZ9VSjdH+LDMieMzHeRj5Nytdxbe4Pu0
         l61g==
X-Received: by 10.182.72.5 with SMTP id z5mr9937080obu.24.1365220297834;
        Fri, 05 Apr 2013 20:51:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ka6sm14675022obb.3.2013.04.05.20.51.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:51:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220223>

From: David Engster <deng@randomsample.de>

[fc: added tests]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  7 ++++++-
 contrib/remote-helpers/test-bzr.sh    | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index f818e93..a99a924 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -266,7 +266,12 @@ def export_branch(branch, name):
         tz = rev.timezone
         committer = rev.committer.encode('utf-8')
         committer = "%s %u %s" % (fixup_user(committer), time, gittz(tz))
-        author = committer
+        authors = rev.get_apparent_authors()
+        if authors:
+            author = authors[0].encode('utf-8')
+            author = "%s %u %s" % (fixup_user(author), time, gittz(tz))
+        else:
+            author = committer
         msg = rev.message.encode('utf-8')
 
         msg += '\n'
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index d26e5c7..68105fc 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -150,4 +150,19 @@ test_expect_success 'moving directory' '
   test_cmp expected actual
 '
 
+test_expect_success 'different authors' '
+  (cd bzrrepo &&
+  echo john >> content &&
+  bzr commit -m john \
+    --author "Jane Rey <jrey@example.com>" \
+    --author "John Doe <jdoe@example.com>") &&
+
+  (cd gitrepo &&
+  git pull &&
+  git show --format="%an <%ae>, %cn <%ce>" --quiet > ../actual) &&
+
+  echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > expected &&
+  test_cmp expected actual
+'
+
 test_done
-- 
1.8.2
