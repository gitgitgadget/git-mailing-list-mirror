Received: from mta0.migadu.com (out-131.mta0.migadu.com [91.218.175.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA76477E51
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254986; cv=none; b=k44TcXXyzBi8rxKrwpkP36/Ej9bzz5wt+dJUX3ueG8NKPML+V3hP6v9Toj9GmkD2FERdz+vtG4elY4rnrIE3T5/UZCNq5VkIBgq8OoEfIMvti2sGlgoHjxkPOHhgi2SOkJBDMwzgKgNL2vDP9gfuhLFgT+wu1W2SB0lM6V+SSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254986; c=relaxed/simple;
	bh=V8oj8Oz4PQlw04y8kLsJEBMEvYZRdVzIwGTROasen4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmxK607YgiXnW4CL7l6B8wOSPB22j25uqZNCOUsYk1D/QEMh40DCxJh1FCmARIhFefOBP8vdiuYHKHRSW7rr8YcSuWwhQP/kneHrVdSWKj5GBhv/fvf5dU8aOtWppdRQI/czwVAtYeKf5A86vYOxZFPnaRd0AlBt1ke+/pQwIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hdxl/Vxd; arc=none smtp.client-ip=91.218.175.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hdxl/Vxd"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=V8oj8Oz4PQlw04y8kLsJEBMEvYZRdVzIwGTROasen4Y=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788254981; v=1; x=1788859781;
 b=hdxl/VxdvUJRX3M3m7SpK+g0fCtVa/XaWBxSyRyPiaGqL9qJhqQ5kHWys7MZOPU9LKElfiG/
 v9FwcDGJlKV/2LoNFXHCHcDeBNN6nmCtoAKVu19B01UMuMOAwoL2SG7jPsPi5U6Noq0iCCPEZxG
 Q9jqyGSPJ3saxJPw3N2/EMZg=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9f4987f3f3de5804;
	Tue, 01 Sep 2026 09:29:41 +0000
X-Mizu-Trace-ID: 9f4987f3f3de5804
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
Date: Tue, 01 Sep 2026 11:10:24 +0200
Subject: [PATCH v4 4/6] revision: add Bloom check that includes parent
 directories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-toon-speed-up-last-modified-v4-4-a09949800404@iotcl.com>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.16-dev-9febb

revs_maybe_changed_in_bloom() reports whether a commit may have changed
any of the paths in the pathspec. It uses bloom_filter_contains_vec(),
which requires all keys of a path's key vector to be present, so it only
answers for the paths themselves.

A caller may track more than those paths. git-last-modified(1) with
--show-trees reports the last modifying commit for the tree entries
containing the paths as well, up to the root. For a pathspec "a/b/c/"
that means it reports "a" and "a/b" next to "a/b/c" and its entries, and
those can each resolve to a different commit. A commit that only changed
"a/top" is the answer for "a", even though it touched nothing under
"a/b".

Such a caller needs to know whether the path, or any of the directories
leading up to it, may have changed. Add
revs_maybe_changed_in_bloom_with_parents(), which asks that question by
using bloom_filter_contains_any_vec() instead. A key vector holds a key
for the path and one for each of its leading directories, so looking up
any of them answers it.

There are no callers yet, one is added in a subsequent commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 revision.c | 15 +++++++++++++++
 revision.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/revision.c b/revision.c
index ed46b90b00..a560146b4d 100644
--- a/revision.c
+++ b/revision.c
@@ -789,6 +789,21 @@ bool revs_maybe_changed_in_bloom(struct rev_info *revs,
 	return false;
 }
 
+bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
+					      struct bloom_filter *filter)
+{
+	if (!revs->bloom_keyvecs_nr || !filter)
+		return true;
+
+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
+		if (bloom_filter_contains_any_vec(filter,
+						  revs->bloom_keyvecs[nr],
+						  revs->bloom_filter_settings))
+			return true;
+
+	return false;
+}
+
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit, int nth_parent)
 {
diff --git a/revision.h b/revision.h
index 67778558e1..192001ff79 100644
--- a/revision.h
+++ b/revision.h
@@ -507,6 +507,14 @@ int prepare_revision_walk(struct rev_info *revs);
 bool revs_maybe_changed_in_bloom(struct rev_info *revs,
 				 struct bloom_filter *filter);
 
+/**
+ * Same as revs_maybe_changed_in_bloom(), but a change to any of the directories
+ * leading up to a path counts as well. Callers that track the tree entries
+ * containing the paths, and not just the paths themselves, need this.
+ */
+bool revs_maybe_changed_in_bloom_with_parents(struct rev_info *revs,
+					      struct bloom_filter *filter);
+
 /* Drain the commits linked list into the priority queue. */
 void rev_info_commit_list_to_queue(struct rev_info *revs);
 /**

-- 
2.55.0.679.g6767b8d81c

