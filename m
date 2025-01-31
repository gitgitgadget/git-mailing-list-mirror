Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB56514B092
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337480; cv=none; b=PEZOXW1rsCuEp3vQTCTnqgQH3Qz8zBpFG1mE4cXFNPTc2xMbScncwGWoFMiFuvZSxv8gfrOzI6dBMFC1GwI7e7ibYIn5j60aLxvZh4Ibbjq7gcsddy6j/7RWpAWCqAOkQK9g1YeGTTbREhU3HvQndhoRtcVyIKq255vrm4j6wNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337480; c=relaxed/simple;
	bh=4E+yVO6kiLTJQXsrWmGusmhazti+UkHRboFEK7THSCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoIwpHlTw/NMzb8GbxGjr6tK3QVkFnrJWZrv3HUWV/J5zReENT8iENtROtbPobt+QXbCWryK/UkynSM7GL3sMsDpy7sHWEw4ge+n4gqj4wWy3JuXpsP0v88OTJMIHJl0Wyz6ZXDgtcs7rKeMaheKEQRodL8KyJpdCtBWi25F6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j1fjUHSt; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j1fjUHSt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738337470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvp/0ZM5EOJ1pULZ+0f1zq2NxwcuedpbAZdog7ucLDo=;
	b=j1fjUHStnIGfzz0wP00pnSh8DUnZMq3mSuCpmTEmxRcYY3FBK54IyabGpv2dsB/n9+D8Tq
	s9GP2ZrMDc6FGah24KCZj/kHVU+J4jknHxob/ZN78ukMk5Xe1K8LFXtNALv1WUdJREskrj
	c68svjx/5q1vM0ObPw9aLfHEhFcpTh4=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 31 Jan 2025 16:30:31 +0100
Subject: [PATCH v4 3/6] clone: refactor wanted_peer_refs()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-toon-clone-refs-v4-3-2a4ff851498f@iotcl.com>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
In-Reply-To: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function wanted_peer_refs() is used to map the refs returned by the
server to refs we will save in our clone.

Over time this function grown to be very complex. Refactor it.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 69d1ad029dfa84a2f7136fa4a3c4c8a594b179c4..d652682494d0d27dd73cd0585e28b23f2883786d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -434,46 +434,37 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
-	struct ref **tail = head ? &head->next : &local_refs;
+	struct ref **tail = local_refs ? &local_refs->next : &local_refs;
 	struct refspec_item tag_refspec;
+	struct ref *to_free = NULL;
 
 	refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
 
 	if (option_single_branch) {
-		struct ref *remote_head = NULL;
-
 		if (!option_branch)
-			remote_head = guess_remote_head(head, refs, 0);
+			refs = to_free = guess_remote_head(head, refs, 0);
 		else {
 			free_one_ref(head);
 			local_refs = head = NULL;
 			tail = &local_refs;
-			remote_head = copy_ref(find_remote_branch(refs, option_branch));
-		}
-
-		if (!remote_head && option_branch)
-			warning(_("Could not find remote branch %s to clone."),
-				option_branch);
-		else {
-			int i;
-			for (i = 0; i < refspec->nr; i++)
-				get_fetch_map(remote_head, &refspec->items[i],
-					      &tail, 0);
-
-			/* if --branch=tag, pull the requested tag explicitly */
-			get_fetch_map(remote_head, &tag_refspec, &tail, 0);
+			refs = to_free = copy_ref(find_remote_branch(refs, option_branch));
 		}
-		free_refs(remote_head);
-	} else {
-		int i;
-		for (i = 0; i < refspec->nr; i++)
-			get_fetch_map(refs, &refspec->items[i], &tail, 0);
 	}
 
-	if (!option_mirror && !option_single_branch && option_tags)
+	for (int i = 0; i < refspec->nr; i++)
+		get_fetch_map(refs, &refspec->items[i], &tail, 0);
+
+	/*
+	 * Grab all refs that match the TAG_REFSPEC. Any tags we don't care
+	 * about won't be present in `refs` anyway.
+	 * Except with option --mirror, where we grab all refs already.
+	 */
+	if (!option_mirror)
 		get_fetch_map(refs, &tag_refspec, &tail, 0);
 
+	free_one_ref(to_free);
 	refspec_item_clear(&tag_refspec);
+
 	return local_refs;
 }
 

-- 
2.48.1.164.g9a5474a648.dirty

