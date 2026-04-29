Received: from enterprise.fim.uni-passau.de (enterprise.fim.uni-passau.de [132.231.8.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AD282F15
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.231.8.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472416; cv=none; b=ggHLNXPZ2WiPoqn2lGn4F8ROEHVnFAAlHHZqenGMFidEIDAVB1anKixJaTbB8yUm3vrlLtoC9pV9JeVIJXaeeHrIuDQEI/WXsM/eZvkEFKHu63pMkx8G+zNvcfDoapYZmHjCh28E2g16+WPlk0+OtBpYhXzoYLy1gqOeAQYv+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472416; c=relaxed/simple;
	bh=uiRX8CJOsHMq5ox7vF16wL94wJrLEslPz9ZuynCKsaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvQ4ldVfj1d+6CBWzZud2xaLTKyS/S8qktuFGT0RpUyUoT8PyBjM6ebUclUqYCGVd/+mOtVP2buu3WYWnIARQW9LG0j74ncq6PPt0pVvym/WhEDzyR9Vq9UOTmz+ELGTqMddCXSK2CDAks0sKFxnewxBgvmWjnRCEII6w0NACOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wendland.dev; spf=none smtp.mailfrom=enterprise.fim.uni-passau.de; arc=none smtp.client-ip=132.231.8.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wendland.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=enterprise.fim.uni-passau.de
Received: from enterprise.fim.uni-passau.de (localhost [127.0.0.1])
	by enterprise.fim.uni-passau.de (8.18.1/8.18.1/Debian-6) with ESMTP id 63TEHXPf167257;
	Wed, 29 Apr 2026 16:17:33 +0200
Received: (from eric@localhost)
	by enterprise.fim.uni-passau.de (8.18.1/8.18.1/Submit) id 63TEHW80167256;
	Wed, 29 Apr 2026 16:17:32 +0200
From: Eric Wendland <eric@wendland.dev>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ask+git@howdoi.land, levraiphilippeblain@gmail.com,
        ps@pks.im, l.s.r@web.de, Eric Wendland <eric@wendland.dev>
Subject: [PATCH] subtree: allow duplicate cache entries with same value
Date: Wed, 29 Apr 2026 16:15:51 +0200
Message-ID: <20260429141550.167194-2-eric@wendland.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a subtree is added, removed, and later re-added at the same path,
'git subtree split' fails with:

    fatal: cache for <hash> already exists!

This happens because 'find_existing_splits()' scans history and calls
'cache_set()' for each prior split. When the same subtree commit was
added twice at different mainline commits, both map to the same subtree
commit. The second 'cache_set()' call tries to write the same mapping
again, but the old code treated any existing cache entry as a fatal error.

Fix 'cache_set()' to silently succeed when the existing cache entry
already contains the same value we're trying to write.

Add a regression test for this scenario.

Signed-off-by: Eric Wendland <eric@wendland.dev>
Closes: <1d8fa22c-eb13-4cdb-8499-e19f0dea6b42@tionis.dev>
---
 contrib/subtree/git-subtree.sh     |  5 +++++
 contrib/subtree/t/t7900-subtree.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 791fd8260c..f0f2a47d53 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -343,6 +343,11 @@ cache_set () {
 		test "$oldrev" != "latest_new" &&
 		test -e "$cachedir/$oldrev"
 	then
+		read oldcache <"$cachedir/$oldrev"
+		if test "$oldcache" = "$newrev"
+		then
+			return
+		fi
 		die "fatal: cache for $oldrev already exists!"
 	fi
 	echo "$newrev" >"$cachedir/$oldrev"
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 18d2b56448..85fe4362fb 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -528,6 +528,35 @@ do
 	'
 done
 
+test_expect_success 'split after add, remove, and re-add at same path' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/sub proj" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/sub proj" sub1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub1 &&
+	(
+		cd "$test_count" &&
+		git rm -rf "sub dir" &&
+		git commit -m "remove sub dir"
+	) &&
+	(
+		cd "$test_count" &&
+		git fetch ./"sub proj" HEAD &&
+		git subtree add --prefix="sub dir" FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" "sub dir"/main-sub2 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix="sub dir" --branch=subproj-br &&
+		test "$(git rev-parse --verify subproj-br)"
+	)
+'
+
 # Usually,
 #
 #    git subtree merge -P subA --squash f00...
-- 
2.47.3

