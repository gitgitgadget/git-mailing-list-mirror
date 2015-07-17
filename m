From: David Turner <dturner@twopensource.com>
Subject: [PATCH] unpack-trees: don't update files flagged for deletion
Date: Fri, 17 Jul 2015 15:48:52 -0400
Message-ID: <1437162532-31933-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Anatole Shaw <git-devel@omni.poc.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 21:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGBdH-0000Lf-Q0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 21:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbbGQTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 15:49:15 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33059 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbGQTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 15:49:14 -0400
Received: by qged69 with SMTP id d69so22673006qge.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 12:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y1rmFBl8w1iVP1PdLY9N6hXeILwlcQvJiFLyVuCnkGw=;
        b=N9VETqTr6iyUZoM4sshWq0hkmQVT9Te0CiruqbxLBpxcHrK567HwtgdAW8dVGDFn/A
         RvYrICC5C2eKgTymCaQxH+9gEHuoatFUGxPyZo8GqFoQG39oMaS2w9bdL/o9gP3l7IRY
         8Fs33NLhSWe1LXGRGZ54Ygd7ZZ5UpvmJVRhgPxM27noKqkZA9CH+2irits8LJqPwrH6F
         Wv+D2flcXwVL6cKjo5KEVnjrSVUqwskv4b4sxWrg8eahCAn+CZhbEG7G55lbEnuD7zhP
         UBcs1vU2Ys0IRu8f1/s0x873I5vpNrlLJBLmKwhSmqaJLwVkJdibca68MxXo5RXE1sDw
         GIVg==
X-Gm-Message-State: ALoCoQlLRWPzEESXEwJEnw8K4V4CdDA6a+kjin8jM8SJa+Sk7NcE6nyWBgc3DwZAdhFVc+BTlltR
X-Received: by 10.140.91.81 with SMTP id y75mr27864875qgd.3.1437162554115;
        Fri, 17 Jul 2015 12:49:14 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id m48sm6372093qgd.35.2015.07.17.12.49.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jul 2015 12:49:12 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274098>

Don't update files in the worktree from cache entries which are
flagged with CE_WT_REMOVE.  This is fixes merges in sparse
checkouts.

Signed-off-by: Anatole Shaw <git-devel@omni.poc.net>
Signed-off-by: David Turner <dturner@twopensource.com>
---

This patch was written by my colleague Anatole Shaw for Twitter's git;
I just rebased it on mainstream git.  Anatole has given me permission
to send this upstream.

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
