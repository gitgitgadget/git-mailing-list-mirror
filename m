Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF493ACEE1
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648808; cv=none; b=RlvsBUlKzOOJwksU+JbVMrBHP565fvO4DlZkqwjzpb+CcYWj+LFH0313CGhidGSNZ2048rV16xVRytKOMIDy/l8UFAsjvOBf7DBtgRRlkQRsubg7vvoogrYDH5NpyfetImXoH2S+9LYWmYhJa8z8H0snYvAZYI5GVKcEEJvi2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648808; c=relaxed/simple;
	bh=Ifd4SBxuG0L4URe64PrmSFguKY6nOakeecGuo0J0cbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/fa+UpxAczOO2FU1/c/wqVic9IwdlAVWEcFlQ1QjoZkU0fDVeb+PZO9EaEYNtaoKQHGHHzjP58wKipQM9wv4FMFHd2gXY8oXiFhDFSzMVVSS9AEAC5mii1boVVsq/z4lQ5tVAd7//UM7xc8nXAhmPBGs4aseOou2/pJSw2yECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=jmmrD+5f; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="jmmrD+5f"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 86378600E8;
	Tue, 16 Jun 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781648802; bh=Ifd4SBxuG0L4URe64PrmSFguKY6nOakeecGuo0J0cbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmmrD+5fW42vcXhlZkj2aC5uAA3j5g1xPe+VzBxj2OR+UgItPSJHlRWSzkzbh1Kk9
	 IPuUm6jJJxLfDqQ4uCQbKaWfRENwsljOqA1QtHSRVtxFQAON3t0rnXsj28XIcBFCJV
	 dohal8i3e7XzMR5+ZknGDnku3czBTCsHduOnlS0U=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] fetch: refactor do_fetch handling of followRemoteHEAD
Date: Tue, 16 Jun 2026 18:25:19 -0400
Message-ID: <20260616222606.1003521-6-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616222606.1003521-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260616222606.1003521-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update enum follow_remote_head_settings to include the value
FOLLOW_REMOTE_UNCONFIGURED as the new zero-initialized value for
followRemoteHEAD.  This will allow us to distinguish between the
variable being unset vs. explicitly set to 'create', which is ultimately
the system default.  The unnecessary indentation is removed.

The do_fetch function is likewise updated to perform its own decision
making to determine the effective followRemoteHEAD mode, falling back to
the system default if necessary.  This will enable the next patch to
introduce a user-configurable default.

Function set_head now accepts the mode as an argument rather than only
considering the value defined by the remote.

The use of the 'warn-if-not-$branch' value is awkward in the context of
a global default, since the branches will differ between individual
remotes.  For this reason, it's left out of this scheme and handling of
the no_warn_branch variable is untouched.  Since a remote-specific
value for followRemoteHEAD takes priority, we can assume that if
remote->no_warn_branch is set, then the remote is also asserting
FOLLOW_REMOTE_WARN as the effective operating mode, and it will be
honored by do_fetch.

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

