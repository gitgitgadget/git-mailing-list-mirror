From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/7] remote-bzr: set author if available
Date: Mon,  8 Apr 2013 12:27:12 -0500
Message-ID: <1365442036-25732-4-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Engster <deng@randomsample.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFrt-0001Hy-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934645Ab3DHR21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:28:27 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:45626 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447Ab3DHR20 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:26 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so3873060obc.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=oIRC7yv27cZDWRZBQ45Mv6bCi6h5zTtKdnRof+2DZoc=;
        b=w8VrlcjmCKGg6xwZkg1KOCCl2KUGIvyJsAIhBGkzWB225AytR0fkIK11qBoMXDy/rS
         EThcFyf1sLOCsNJqSRvEiXUWSDcTcY43y9AUrgfBcj055KtCx7VVW3OY29dPDRowO2GF
         /H5AlZDZqa6lsuIfIL9d4OiyKGatAUAsRE94fjtbeimMorpV+cm+spDPkkK0+JUiKDN+
         w3ZTo+4gUeIxdJNLBSpKJEONghWx9/smqSGlGDwQ/84FEH+Iilyx6JSU4dAGcYDbQyxC
         OowzmfHn7V532Lc2NaVFZ+WNvEFlU4GMH9VRdHizFv48k3h2PJ1UApqQiKHXYSWqgc00
         8QaQ==
X-Received: by 10.182.49.102 with SMTP id t6mr15953863obn.75.1365442105997;
        Mon, 08 Apr 2013 10:28:25 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id do4sm22036279oeb.0.2013.04.08.10.28.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220467>

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
