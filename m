Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AF36680F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862515; cv=none; b=kYt0StExE4bGnaXPAx3J+XbOsjog55u3mu+79/XJd0tIk3dfgTaulGpd9IATEGnnO+DnxkEmpHDVpSpCSS9TgyF7X5wb0QT+PFt+liUtjVVn8Bv5Go3MFn8R8lEC2djTSb0Ekc18gAnSMQHHac4Zl1KkMqoWMnq4sChY3oq05k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862515; c=relaxed/simple;
	bh=WAH/UC+pRGGDrX+AgZSLXyamOw/tpGaT3jp8SnFbI+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H131STyXago2x6RrLe5Kav7x1lumaWrWgOrZrCdfb4AThazRfz3vVoXgotbu3dWVa+MelW/Sy0Qy3AlDPPa/7KgCZu/VBfdYqcvEVr8HVYBKxDc77BqrKGo4XtpMEDlN56CaL4H5zNjhpYW9oRO94I7wa3Wp6L4RKracsWyr2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=OP87T1uU; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="OP87T1uU"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id B6932600E8;
	Fri, 19 Jun 2026 09:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862510; bh=WAH/UC+pRGGDrX+AgZSLXyamOw/tpGaT3jp8SnFbI+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OP87T1uU8Fv/uNA7pCAHTkJVVlW9lF3sfnon9q8MtZxeFe6B2KeMmkcVKbwNwUiSc
	 bAhFkQWmhr4R2YyGP4Uv84ndBIbJN083GZU69/6S4jQwP2FTiz2rrp6sbdm9enmzoW
	 W5SQc3UOuhgKECWm0dThZCBZfhr344iFx7yoqX2M=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/8] fetch: refactor do_fetch handling of followRemoteHEAD
Date: Fri, 19 Jun 2026 05:44:25 -0400
Message-ID: <20260619094751.2996804-7-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
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
index 1036e8edbc59..ad63ca943c33 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1730,12 +1730,12 @@ static void warn_set_head(const char *remote, const char *head_name,
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
@@ -1902,6 +1902,7 @@ static int do_fetch(struct transport *transport,
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
+	int follow_remote_head;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1917,6 +1918,11 @@ static int do_fetch(struct transport *transport,
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
@@ -1925,7 +1931,7 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (transport->remote->follow_remote_head != FOLLOW_REMOTE_NEVER)
+			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
 		if (branch && branch_has_merge_config(branch) &&
@@ -2132,7 +2138,7 @@ static int do_fetch(struct transport *transport,
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

