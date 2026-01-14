Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EF534CFD3
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386307; cv=none; b=NQjSkBaPd0znNme7e66lxVPoR6w7FU5chq5Movf32DPzll0sB7wh7eQxtebLa2Ge4qp4zK9erjIgvfg6lYhNBKf1NActIo5FzZ5uvsOKBH0l+FwrbyRVU6MUsxQouZonDeFqe5ZIzNg+KrzmO/Gczl9/a1OwbZJbFke2XORPYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386307; c=relaxed/simple;
	bh=osf6qd+2Dww9VAW9RHbkp1Skicyx25TB3olWq/sZ4Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPJevFYQiBEp24mPrZLN7/+Ud6uwAw90W06WxL4QEqNgw7FTXdHK8md1H48NreTxrOKXe3UPIVFuNXZQqLAYXEPcDpk5tXSBx8pwIRK+eADJHlc8d2krPQoQ4qTUFruzx+uU1Ns0KvptlBC8hOVVizaHxnoIn4WUsbGBwUOjFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=5BXTPnYf; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="5BXTPnYf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768386301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p29O/B8KDFYScnyIDsPbPSJ1vWOSfzirl62Vrkcbrbc=;
	b=5BXTPnYfLscBnO+/3U9Up+eyfSDO9Y5ZMUjd807h8EHKr/qMSawZqesFePOTSfRU3drqvk
	a/wJqKt7u7Yhnbbxq+3OmLYAj4kNxcR7F7lIw+HGwTuejRs6Uo/a6RbyN86knd8tJt7wjW
	mNjUKvWuQLkWaXaRR2dh1xcP6Cch6oI=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 14 Jan 2026 11:24:45 +0100
Subject: [PATCH v2 1/3] last-modified: rewrite error message when more than
 one revision given
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
In-Reply-To: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

When more than one revision is passed to the git-last-modified(1)
command, this error message was printed:

    error: last-modified can only operate on one tree at a time

Calling these a "tree" is technically not correct. git-last-modified(1)
expects revisions that peel to a commit.

Rephrase the error message to:

    error: last-modified can only operate on one revision at a time

While at it, also fix a memory leak that remained uncovered so far.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c  | 12 ++++++++----
 t/t8020-last-modified.sh |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..06e3f79aec 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -123,7 +123,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 static int populate_paths_from_revs(struct last_modified *lm)
 {
-	int num_interesting = 0;
+	int num_interesting = 0, ret = 0;
 	struct diff_options diffopt;
 
 	/*
@@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
 		if (obj->item->flags & UNINTERESTING)
 			continue;
 
-		if (num_interesting++)
-			return error(_("last-modified can only operate on one tree at a time"));
+		if (num_interesting++) {
+			ret = error(_("last-modified can only operate on one revision at a time"));
+			goto out;
+		}
 
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
 		diff_flush(&diffopt);
 	}
+
+out:
 	clear_pathspec(&diffopt.pathspec);
 
-	return 0;
+	return ret;
 }
 
 static void last_modified_emit(struct last_modified *lm,
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 50f4312f71..1183ae667b 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '
 	test_commit 3 a/b/file
 '
 
-test_expect_success 'cannot run last-modified on two trees' '
+test_expect_success 'cannot run last-modified on two revision' '
 	test_must_fail git last-modified HEAD HEAD~1
 '
 

-- 
2.52.0

