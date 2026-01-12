Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE252D8DD4
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234683; cv=none; b=Ztqayp+TepNE/dh3dobvDIUeoD9o1Dwj6epXZOnkEavOfMObsjiSMia0upBOg4NwNW6qgwOIMUrVo7rqRcJNSLXR/ZZPGshPI66gmSbXQVeDlYj8es83BdJG3yX1OFL7z0VhHivwfBLOPYZXd9jHZA5iaSaQKBIg/+tyIT6+6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234683; c=relaxed/simple;
	bh=E+V1xBYC2jcXxl6LHrWrhiUJkfEchQZm7Xe2gSXah3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tSUdbEAtK1zUrRGjDJ3c8HU8oXHcgOQOJhcgOC5LXLoCKHZJF4MQSK0YdiWOnoVcadAPlpbl1Pd0InXdkAMNJX/QLHH/gbFHV1rOXtDEK+RIk48TBP3YvOi2spUWb4scwpIoU8emCvLpVdI2WQKFeERaPMh0kGBscmPLCnmivuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qGTpDOeT; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qGTpDOeT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768234678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hl7j2rM+vK3FbDcsqF1/4qdzm3U33j/AWB014F7IkO8=;
	b=qGTpDOeTRFgw8bES8OG2x/vc+/XHEFa8Wl4caDCvVmMurXgbty2Wf+7YDl68bTOKK6bJuv
	4jKsfgZupXt+4b+TLi0PXRDg+C9h9asldPoKtrPp397WHRzD7UyetSrLBAlH77CM4Y8v6F
	Jy5KPelleyMDcIEQn1FC3baIaNeuUnk=
From: Toon Claes <toon@iotcl.com>
Date: Mon, 12 Jan 2026 17:17:41 +0100
Subject: [PATCH] last-modified: verify revision argument is a commit-ish
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-toon-last-modified-tree-v1-1-ecbc78341f76@iotcl.com>
X-B4-Tracking: v=1; b=H4sIAKQeZWkC/yXMQQrCMBBG4auUWTvQZFHRq4iLtPlHRzSRTCpC6
 d2b6vJbvLeQoSiMzt1CBR81zanBHTqa7iHdwBqbyfd+6J3zXHNO/AxW+ZWjiiJyLQBLjKdh9II
 gR2r1u0D0+ztfrn/bPD4w1X1H67oBlsYkdXsAAAA=
X-Change-ID: 20260112-toon-last-modified-tree-fdd96b2feaf7
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Gusted <gusted@codeberg.org>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Passing a tree OID to git-last-modified(1) would trigger BUG behavior.

    git last-modified HEAD^{tree}
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified

Fix this error by verifying the parsed revision is peels to a
commit-ish.

While at it, also fix a memory leak in populate_paths_from_revs().

Reported-by: Gusted <gusted@codeberg.org>
Signed-off-by: Toon Claes <toon@iotcl.com>
---
Recently there was a bug reported[1] passing a tree OID triggers a BUG:

    $ git last-modified fb06ce04173d47aaaa498385621cba8b8dfd7584
    BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
    [1]    690163 IOT instruction (core dumped)  git last-modified

    `fb06ce04173d47aaaa498385621cba8b8dfd7584` is the tree commit id of web_src. I
    suppose this should've returned a nice error message or blank output.

Fix this bug by checking the revision argument.

[1]: https://lore.kernel.org/git/03f96860-29fc-42a7-a220-c3ec65eb8516@codeberg.org/
---
 builtin/last-modified.c  | 15 +++++++++++----
 t/t8020-last-modified.sh |  5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..cac94e384d 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -123,7 +123,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 static int populate_paths_from_revs(struct last_modified *lm)
 {
-	int num_interesting = 0;
+	int num_interesting = 0, ret = 0;
 	struct diff_options diffopt;
 
 	/*
@@ -145,8 +145,15 @@ static int populate_paths_from_revs(struct last_modified *lm)
 		if (obj->item->flags & UNINTERESTING)
 			continue;
 
-		if (num_interesting++)
-			return error(_("last-modified can only operate on one tree at a time"));
+		if (num_interesting++) {
+			ret = error(_("last-modified can only operate on one tree at a time"));
+			break;
+		}
+
+		if (!repo_peel_to_type(lm->rev.repo, obj->path, 0, obj->item, OBJ_COMMIT)) {
+			ret = error(_("revision argument is not a commit-ish"));
+			break;
+		}
 
 		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
 			      &obj->item->oid, "", &diffopt);
@@ -154,7 +161,7 @@ static int populate_paths_from_revs(struct last_modified *lm)
 	}
 	clear_pathspec(&diffopt.pathspec);
 
-	return 0;
+	return ret;
 }
 
 static void last_modified_emit(struct last_modified *lm,
diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index 50f4312f71..d0d52add05 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -235,4 +235,9 @@ test_expect_success 'last-modified complains about unknown arguments' '
 	grep "unknown last-modified argument: --foo" err
 '
 
+test_expect_success 'last-modified expects commit-ish' '
+	test_must_fail git last-modified HEAD^{tree} 2>err &&
+	grep "revision argument is not a commit-ish" err
+'
+
 test_done

---
base-commit: d529f3a197364881746f558e5652f0236131eb86
change-id: 20260112-toon-last-modified-tree-fdd96b2feaf7

