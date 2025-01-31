Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4601E3DFF
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337495; cv=none; b=F6wS9DEiIqaZLKsAVXbFtf5JWke569Xvpk8dVwLY3uHKM00VIMqD49WHrqWBzU7nWrV0Xilx4E1f+GbzZzKk8I2lISXvVRVSzl6/a0DIS2vM7UxJAWSWPhVjr7Y9AaW2jZwSeGn0u/gR1eFU6AalpgCEm3/Oi2Cu/6NwUbZ1G2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337495; c=relaxed/simple;
	bh=bARrXPX11EMJxdl3Nis3YaQNhzpkTb83GqzeriQ+Qxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z24qnGbmJf6ixGdDprwR9lXFi9ZcobtbO9/ZbM6hqzweQWVKX33gTCUSd5Aux4H6D9GiHtAX/O2JB+Kkxq8jG0+5tu3RHcj3aRVPr+Fx7bj9sQztkMmQowrexr+gqj5VKRfAfbpAtO/9WBXh086pB9k+RQuTc4cd7nhg5fzQask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2xCTiEZ6; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2xCTiEZ6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738337486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZF/bNTiH3NxcDmKdNxBCU8t2JC1mX0prcIwym/3fhc=;
	b=2xCTiEZ6m8TQa8hkhoUsEKy4rH1sxILZLbj1qYS2v3RHS9dHq6VAfdTEdUyq68qVbaOEKL
	5zKytAx5TkFRxJXuyA6rS3X7nWEmOsHDtcX63iWZhIEXa1NBT9buu+VmttuGnQveMXNyg5
	t69RyQtgNhYZAf+m0V1ZRgwUq9vTG1g=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 31 Jan 2025 16:30:33 +0100
Subject: [PATCH v4 5/6] clone: introduce struct clone_opts in
 builtin/clone.c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-toon-clone-refs-v4-5-2a4ff851498f@iotcl.com>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
In-Reply-To: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

There is a lot of state stored in global variables in builtin/clone.c.
In the long run we'd like to remove many of those.

Introduce `struct clone_opts` in this file. This struct will be used to
contain all details needed to perform the clone. The struct object can
be thrown around to all the functions that need these details.

The first field we're adding is `wants_head`. In some scenarios
(specifically when both `--single-branch` and `--branch` are given) we
are not interested in `HEAD` on the remote. The field `wants_head` in
`struct clone_opts` will hold this information. We could have put
`option_branch` and `option_single_branch` into that struct instead, but
in a following commit we'll be using `wants_head` as well.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 47 ++++++++++++++++++++++++++++++++---------------
 remote.c        |  2 +-
 remote.h        |  1 +
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 7ab156ac00240de89baca6533ed2541839286fc4..f92017c751dd31cb25a3ba31667b015d5766ce84 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -57,6 +57,13 @@
  *
  */
 
+struct clone_opts {
+	int wants_head;
+};
+#define CLONE_OPTS_INIT { \
+	.wants_head = 1 /* default enabled */ \
+}
+
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_tags = 1; /* default enabled */
@@ -429,23 +436,27 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 	return ref;
 }
 
-static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+static struct ref *wanted_peer_refs(struct clone_opts *opts,
+				    const struct ref *refs,
+				    struct refspec *refspec)
 {
-	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
-	struct ref *local_refs = head;
-	struct ref **tail = local_refs ? &local_refs->next : &local_refs;
+	struct ref *local_refs = NULL;
+	struct ref **tail = &local_refs;
 	struct ref *to_free = NULL;
 
-	if (option_single_branch) {
-		if (!option_branch)
+	if (opts->wants_head) {
+		struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
+		if (head)
+			tail_link_ref(head, &tail);
+
+		if (option_single_branch)
 			refs = to_free = guess_remote_head(head, refs, 0);
-		else {
-			free_one_ref(head);
-			local_refs = head = NULL;
-			tail = &local_refs;
-			refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
-		}
+	}
+
+	else if (option_single_branch) {
+		local_refs = NULL;
+		tail = &local_refs;
+		refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
 	}
 
 	for (int i = 0; i < refspec->nr; i++)
@@ -893,6 +904,8 @@ int cmd_clone(int argc,
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
 
+	struct clone_opts opts = CLONE_OPTS_INIT;
+
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
@@ -1343,9 +1356,13 @@ int cmd_clone(int argc,
 	if (option_not.nr)
 		transport_set_option(transport, TRANS_OPT_DEEPEN_NOT,
 				     (const char *)&option_not);
-	if (option_single_branch)
+	if (option_single_branch) {
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
+		if (option_branch)
+			opts.wants_head = 0;
+	}
+
 	if (option_upload_pack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
@@ -1450,7 +1467,7 @@ int cmd_clone(int argc,
 	}
 
 	if (refs)
-		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
+		mapped_refs = wanted_peer_refs(&opts, refs, &remote->fetch);
 
 	if (mapped_refs) {
 		/*
diff --git a/remote.c b/remote.c
index 0f6fba85625b523122e50e28a0f64b6e143cd9fb..cf823764826222bab84d27ae665f7292da44edc6 100644
--- a/remote.c
+++ b/remote.c
@@ -1234,7 +1234,7 @@ int count_refspec_match(const char *pattern,
 	}
 }
 
-static void tail_link_ref(struct ref *ref, struct ref ***tail)
+void tail_link_ref(struct ref *ref, struct ref ***tail)
 {
 	**tail = ref;
 	while (ref->next)
diff --git a/remote.h b/remote.h
index bda10dd5c85ffd8988a6c3d39583e7b9701278b8..65d2de2c2051cf28def8b43fcca3fd5e1c86a0d8 100644
--- a/remote.h
+++ b/remote.h
@@ -219,6 +219,7 @@ struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
+void tail_link_ref(struct ref *ref, struct ref ***tail);
 
 int check_ref_type(const struct ref *ref, int flags);
 

-- 
2.48.1.164.g9a5474a648.dirty

