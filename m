Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C419BBA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823654; cv=none; b=svtTlSWwWvLIyc8YPjMtGL49+L04xscpbw1/c4yP9+dAJJF2zvrMkuBDwPWJTlZraOFgDHIVdoDVMsQ5rY/xBOTPUbzVTFZNJqF3kLwqFahDU4EdOMUqSRQeSl4Vzv1OT8olomWadeoxUCQ15G6v1SxIJtXSI209oOarN7DKFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823654; c=relaxed/simple;
	bh=bs1gkyPkUfDNeLh45zXl4dcXDQ809hJu4bxdlyHU8uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBr6IDN/G0NZoHon9mKHPOoEMgKnGSelQDe8lT5iE/KM/bixIS2caaXKCJ44GzJh3TbpgNoCcqZrM2v1qfGifZoynOfoHXSi9wlt7x8sQA9bXrfh0LgUxvQOP5ASXj9b0+gnYoyLzyW3IqL8Cmn7qV0j4Z6z4u4qG7dc7AVJE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=uJKtcrQV; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="uJKtcrQV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzv5Ko9hQst6aa/WKkKw4GXaTzJEI0Kmorzo5IwTop4=;
	b=uJKtcrQV8Jt8H/ltFrICmatDzY1Xt2lzmH/yeo1PdFq9NHdjz4+/PDfDIxd/o3z2Z/sG7k
	FlvfTYtos73TuRbZP+Vtfo9HdAquIp0dad/PFJYtv2YXJG0R3ZfkgUSeulCVkIegb3vSLT
	r8/363Bq4aGOnElQZ3G/IO/5xTrqCAA=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:33 +0100
Subject: [PATCH v7 5/7] clone: introduce struct clone_opts in
 builtin/clone.c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-5-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
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
 builtin/clone.c | 44 +++++++++++++++++++++++++++++---------------
 remote.c        |  2 +-
 remote.h        |  5 +++++
 3 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index ef4af1f3e6bf0a33c13ed874587b35aba14fe43c..1d421c8f758e37a7219d2da680c7ef8699016171 100644
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
@@ -429,23 +436,24 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
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
+		if (option_single_branch)
 			refs = to_free = guess_remote_head(head, refs, 0);
-		else {
-			free_one_ref(head);
-			local_refs = head = NULL;
-			tail = &local_refs;
-			refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
-		}
+	} else if (option_single_branch) {
+		local_refs = NULL;
+		tail = &local_refs;
+		refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
 	}
 
 	for (size_t i = 0; i < refspec->nr; i++)
@@ -893,6 +901,8 @@ int cmd_clone(int argc,
 	struct string_list server_options = STRING_LIST_INIT_NODUP;
 	const char *bundle_uri = NULL;
 
+	struct clone_opts opts = CLONE_OPTS_INIT;
+
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
@@ -1343,9 +1353,13 @@ int cmd_clone(int argc,
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
@@ -1454,7 +1468,7 @@ int cmd_clone(int argc,
 	}
 
 	if (refs)
-		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
+		mapped_refs = wanted_peer_refs(&opts, refs, &remote->fetch);
 
 	if (mapped_refs) {
 		/*
diff --git a/remote.c b/remote.c
index 1779f0e7bbb8b88965f2fedf407e50ed20ea7a13..69d8c43ea694f1b9a7699e5d5a49bfc169058b8e 100644
--- a/remote.c
+++ b/remote.c
@@ -1260,7 +1260,7 @@ int count_refspec_match(const char *pattern,
 	}
 }
 
-static void tail_link_ref(struct ref *ref, struct ref ***tail)
+void tail_link_ref(struct ref *ref, struct ref ***tail)
 {
 	**tail = ref;
 	while (ref->next)
diff --git a/remote.h b/remote.h
index a19353f68999f5440db7bf5f91dd4be8bcc1d8a5..ce3e7c8512981d0ac5db2da508c4fbe64cede961 100644
--- a/remote.h
+++ b/remote.h
@@ -221,6 +221,11 @@ struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
+/*
+ * Put a ref in the tail and prepare tail for adding another one.
+ * *tail is the pointer to the tail of the list of refs.
+ */
+void tail_link_ref(struct ref *ref, struct ref ***tail);
 
 int check_ref_type(const struct ref *ref, int flags);
 

-- 
2.48.1.447.gc0086e9015

