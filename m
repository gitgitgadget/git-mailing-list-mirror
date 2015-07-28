From: David Turner <dturner@twopensource.com>
Subject: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 15:30:40 -0400
Message-ID: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Brian Degenhardt <bmd@bmdhacks.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 21:31:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAaq-0000ur-4j
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbG1TbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:31:11 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34381 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbbG1TbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:31:10 -0400
Received: by qkfc129 with SMTP id c129so55834005qkf.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rb1l31UqI1+ix2javAs2uLfsoWoyCwpuMo6ibzlsquQ=;
        b=QFhbbxC8zA8CkSKtNcnlK7o1oXg7xXdoTit92XCMq4JG9SzKpAiCsrIIXdijh4TtZ7
         VAiZxtXcWY4Vm8pyyIhDaoIW1ggT2o2h/2vunBHPzz+85Tjfcu0SFui4y30xJ8t35KKx
         9cVEXfrD0KZcqHKEfnsbswD/qGY4rhU6/ImgCWhmMOYKWZk6ivEcXhtyMWRprY0aI2bX
         g8stoRteHzTJWB7u7ad0/s7US028QyZroYI/iX6qvAQtw97eZzE1fYoTb/tEODC2XUAd
         woJNZ5oHvHY8bP1004oajQtJxsmBzVURhGlOdowwsepRqKSKeKVYFRnOy+nNiJNtP0ut
         43cA==
X-Gm-Message-State: ALoCoQnIhKIS9r/wfiFSaujEOETJj3bvTN7eaIhEN0jFJjpVHs7sWMAUmm9k0U8jk/mGYrC023MM
X-Received: by 10.55.15.23 with SMTP id z23mr50928960qkg.47.1438111869640;
        Tue, 28 Jul 2015 12:31:09 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id a5sm11806989qga.39.2015.07.28.12.31.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 12:31:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274819>

When we unpack trees into an existing index, we discard the old index
and replace it with the new, merged index.  Ensure that this index has
its cache-tree populated.  This will make subsequent git status and
commit commands faster.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Brian Degenhardt <bmd@bmdhacks.com>
---

This patch is by my colleague, Brian Degenhardt (as part of his work
on git at Twitter).  I'm sending it with his and Twitter's approval.

---
 t/t0090-cache-tree.sh | 24 ++++++++++++++++++++++++
 unpack-trees.c        |  7 +++++++
 2 files changed, 31 insertions(+)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 601d02d..055cc19 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -199,6 +199,30 @@ test_expect_success 'checkout -B gives cache-tree' '
 	test_cache_tree
 '
 
+test_expect_success 'merge --ff-only maintains cache-tree' '
+	git checkout current &&
+	git checkout -b changes &&
+	test_commit llamas &&
+	test_commit pachyderm &&
+	test_cache_tree &&
+	git checkout current &&
+	test_cache_tree &&
+	git merge --ff-only changes &&
+	test_cache_tree
+'
+
+test_expect_success 'merge maintains cache-tree' '
+	git checkout current &&
+	git checkout -b changes2 &&
+	test_commit alpacas &&
+	test_cache_tree &&
+	git checkout current &&
+	test_commit struthio &&
+	test_cache_tree &&
+	git merge changes2 &&
+	test_cache_tree
+'
+
 test_expect_success 'partial commit gives cache-tree' '
 	git checkout -b partial no-children &&
 	test_commit one &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 2927660..befc247 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1156,6 +1156,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
+		if (!o->result.cache_tree)
+			o->result.cache_tree = cache_tree();
+
+		if (!cache_tree_fully_valid(o->result.cache_tree)) {
+			cache_tree_update(&o->result, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		}
+
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.0.4.315.gad8727a-twtrsrc
