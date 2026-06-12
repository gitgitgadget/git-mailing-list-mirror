Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E333939BD
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244014; cv=none; b=GtRGHxGy+LHFl7YVi+KHVbP+NFfZ5NGTO0B1SCNQHAxnynNx2Cxdk/WNx32kHASpkRb2/BIzNufq0umJqtuuMbcVQxU+voMMlShSqr2u8wO5JLzfIMfyUmH20eb42uEDYXrdgNm8i9nTwhEIt9ZWvc7M5S/KU2Mz7pNyTnfg5lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244014; c=relaxed/simple;
	bh=G72C4jjGerqyahu55rO8vDH/dV2jUr3qX8BQraPooJo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etfDtDA2KDW5OazmvWdGB9Sa0t+oBCntOb7iOW679PQt2ZFkv5K7bHPCyAIlNYblEtby56VpAa/0XH+SDN1kVnIyorluNvDFI0MxXQt7AG/wrpQko6d8aBLbm/0aBvyZkG0ZGp/70OhmZHeEfmdzx06DI1AHRwF5Lk5SrffOmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=bHRR6XKo; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="bHRR6XKo"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 4C98D60272
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244012; bh=G72C4jjGerqyahu55rO8vDH/dV2jUr3qX8BQraPooJo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bHRR6XKoaf0jBO3ALPOvVxb3Ig0DnjIIq+ZBVca9SpvwvHeudyeRmL1y8jOmaa/ZZ
	 H9CItXpjJT+HEqcF+LnAiqhP86BLrcBBhvqc9iBDSX+kHlufbjJdRNHFje9rsY8lyj
	 h4Rp8RCT5dWtLnjkOnwmFrOESPMqok1s7ZT7VMS8=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 5/7] fetch: refactor do_fetch handling of followRemoteHEAD
Date: Fri, 12 Jun 2026 01:55:41 -0400
Message-ID: <20260612055947.1499497-6-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update enum follow_remote_head_settings to include the value
FOLLOW_REMOTE_UNCONFIGURED as the new zero-initialized value for
followRemoteHEAD.  This will allow us to distinguish between the option
being unset vs. explicitly set to 'create', which is ultimately the
system default.  The unnecessary indentation is removed.

The do_fetch function is likewise updated to perform its own decision
making to determine the effective followRemoteHEAD mode, falling back to
the system default if necessary.  This will enable the next patch to
introduce a user-configurable fallback default option.

Function set_head now accepts this value as an argument rather than only
considering the value defined by the remote.

The use of the 'warn-if-not-$branch' value is awkward in the context of
a global default option, since the branches will differ between
individual remotes.  For this reason, it's left out of this scheme and
handling of the no_warn_branch variable is untouched.  Since a
remote-specific setting for followRemoteHEAD takes priority, we can
assume that if remote->no_warn_branch is set, then the remote is also
asserting FOLLOW_REMOTE_WARN as the effective operating mode, and it
will be honored by do_fetch.

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 builtin/fetch.c | 14 ++++++++++----
 remote.h        | 14 ++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9a45e1e7a44d..3cc7efdd83a0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1729,12 +1729,12 @@ static void warn_set_head(const char *remote, const char *head_name,
 	strbuf_release(&buf_prefix);
 }
 
-static int set_head(const struct ref *remote_refs, struct remote *remote)
+static int set_head(const struct ref *remote_refs, struct remote *remote,
+			int follow_remote_head)
 {
 	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
-	int follow_remote_head = remote->follow_remote_head;
 	const char *no_warn_branch = remote->no_warn_branch;
 	char *head_name = NULL;
 	struct ref *ref, *matches;
@@ -1901,6 +1901,7 @@ static int do_fetch(struct transport *transport,
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
+	int follow_remote_head;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1916,6 +1917,11 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
+	if (transport->remote->follow_remote_head)
+		follow_remote_head = transport->remote->follow_remote_head;
+	else
+		follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
@@ -1924,7 +1930,7 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (transport->remote->follow_remote_head != FOLLOW_REMOTE_NEVER)
+			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
 		if (branch && branch_has_merge_config(branch) &&
@@ -2131,7 +2137,7 @@ static int do_fetch(struct transport *transport,
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
 		 */
-		set_head(remote_refs, transport->remote);
+		set_head(remote_refs, transport->remote, follow_remote_head);
 	}
 
 cleanup:
diff --git a/remote.h b/remote.h
index 54b17e4b028b..72a54d84ad51 100644
--- a/remote.h
+++ b/remote.h
@@ -62,12 +62,14 @@ struct remote_state {
 void remote_state_clear(struct remote_state *remote_state);
 struct remote_state *remote_state_new(void);
 
-	enum follow_remote_head_settings {
-		FOLLOW_REMOTE_NEVER = -1,
-		FOLLOW_REMOTE_CREATE = 0,
-		FOLLOW_REMOTE_WARN = 1,
-		FOLLOW_REMOTE_ALWAYS = 2,
-	};
+#define BUILTIN_FOLLOW_REMOTE_HEAD_DFLT FOLLOW_REMOTE_CREATE
+enum follow_remote_head_settings {
+	FOLLOW_REMOTE_UNCONFIGURED = 0,
+	FOLLOW_REMOTE_NEVER,
+	FOLLOW_REMOTE_CREATE,
+	FOLLOW_REMOTE_WARN,
+	FOLLOW_REMOTE_ALWAYS,
+};
 
 struct remote {
 	struct hashmap_entry ent;
-- 
2.54.0

