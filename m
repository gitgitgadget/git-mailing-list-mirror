From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE set
Date: Fri, 17 Jul 2015 17:19:27 -0400
Message-ID: <1437167967-5933-1-git-send-email-dturner@twopensource.com>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
Cc: David Turner <dturner@twopensource.com>,
	Anatole Shaw <git-devel@omni.poc.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 23:20:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGD34-0000wx-6t
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbbGQVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:19:52 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35057 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbGQVTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:19:50 -0400
Received: by qgii95 with SMTP id i95so21956117qgi.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 14:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zp3ixchjx7qGQcwr7qkJ9BxWmK4bwfjlwDYbgPxICIM=;
        b=l5UjILcFxDhRBOEMZqGBMYLNKKF8UGjymGEdtIEXFeGDqxR7iYrpeHQkaraMVJOSds
         MyyOZ7ky9qs2GfjcpUP8R3Ny6XBEIrHbM0ppSfgx9NzbyCoSir3RlR1e6KHBdzCoWvtl
         di4B19IbNUFgAWfyi4x/4LGK9JLyLwfyNlbZitoG4pxQ42cW9L55hxBm01hsllWlVxdH
         0RgvlU+bUmHdbzrTTIOHZKFfCjdHDOq07rxZJYJw5eaQfQf4cAyeRaVHYPujUbFtIG1S
         HespnxlehrUY0a1S5vJQzHR3gfWzCOGtohHx8/MKE8oGjP9IpWVfsGvq+aTxrh3qceKY
         gDHg==
X-Gm-Message-State: ALoCoQkHcfSxWwDmAt7yhj6Ap446Kp4il0W/S0uCUrSNeVp6Z2qoIuB5ol5kB+g3Z5oshHlVURXH
X-Received: by 10.55.43.95 with SMTP id r92mr28174196qkh.67.1437167990211;
        Fri, 17 Jul 2015 14:19:50 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o25sm6505275qkh.25.2015.07.17.14.19.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 14:19:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274104>

Don't update files in the worktree from cache entries which are
flagged with CE_WT_REMOVE.

When a user does a sparse checkout, git removes files that are marked
with CE_WT_REMOVE (because they are out-of-scope for the sparse
checkout). If those files are also marked CE_UPDATE (for instance,
because they differ in the branch that is being checked out and the
outgoing branch), git would previously recreate them.  This patch
prevents them from being recreated.

These erroneously-created files would also interfere with merges,
causing pre-merge revisions of out-of-scope files to appear in the
worktree.

Signed-off-by: Anatole Shaw <git-devel@omni.poc.net>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t1090-sparse-checkout-scope.sh | 52 ++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c                   |  2 +-
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100755 t/t1090-sparse-checkout-scope.sh

diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
new file mode 100755
index 0000000..1f61eb3
--- /dev/null
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='sparse checkout scope tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "initial" >a &&
+	echo "initial" >b &&
+	echo "initial" >c &&
+	git add a b c &&
+	git commit -m "initial commit"
+'
+
+test_expect_success 'create feature branch' '
+	git checkout -b feature &&
+	echo "modified" >b &&
+	echo "modified" >c &&
+	git add b c &&
+	git commit -m "modification"
+'
+
+test_expect_success 'perform sparse checkout of master' '
+	git config --local --bool core.sparsecheckout true &&
+	echo "!/*" >.git/info/sparse-checkout &&
+	echo "/a" >>.git/info/sparse-checkout &&
+	echo "/c" >>.git/info/sparse-checkout &&
+	git checkout master &&
+	test_path_is_file a &&
+	test_path_is_missing b &&
+	test_path_is_file c
+'
+
+test_expect_success 'merge feature branch into sparse checkout of master' '
+	git merge feature &&
+	test_path_is_file a &&
+	test_path_is_missing b &&
+	test_path_is_file c &&
+	test "$(cat c)" = "modified"
+'
+
+test_expect_success 'return to full checkout of master' '
+	git checkout feature &&
+	echo "/*" >.git/info/sparse-checkout &&
+	git checkout master &&
+	test_path_is_file a &&
+	test_path_is_file b &&
+	test_path_is_file c &&
+	test "$(cat b)" = "modified"
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 2927660..11a5300 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -223,7 +223,7 @@ static int check_updates(struct unpack_trees_options *o)
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
-		if (ce->ce_flags & CE_UPDATE) {
+		if (ce->ce_flags & CE_UPDATE && !(ce->ce_flags & CE_WT_REMOVE)) {
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-- 
2.0.4.315.gad8727a-twtrsrc
