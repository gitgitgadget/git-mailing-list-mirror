Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF82144A8
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823648; cv=none; b=fQeJkiHEFnL4aMyTsYnmKn3jIN5lPOv0hVFr34uiQwsGXNuEp/HuQHlREFa3uk4hAd6JZ+ieFUo+NSP3P8/ToQHPAQ5XgJd5Bo1yre9E4MfQBYWtvB/2xxgTiqWdRyGuUX5m+WrJW621o6olgA4U1lZMqRabfAJdhKSbePNDZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823648; c=relaxed/simple;
	bh=WPIfQUijgkgLnVirjLfDKr8BCdS5wGqpyEK65MIiQTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuMeSH+0+Lh34L8wQcqc3jRdA8vp4HDsLj62rSekj7If3yT4QVp+NrIcSHXoFW6L8dlAfymzmm6gav8AAxgyIXrX/MxaGzeGux5MUocEo8YJbB1Pt779+62kdq/y4mq6KQH5FtjWFdk8rBQJVpG8seftfxviqA+HtHQx+Dq/n28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hdfItJDd; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hdfItJDd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhiBbp0As8MrORVTe77mTMEMF+yFM7KnVjyaDRbeK40=;
	b=hdfItJDdhvswm8BpkjEJeJrWoYTIvhvm7Xpf0EvCilAa8vjyAKzqbKw1TUTDWf2LmTyIhu
	GK9Baom+t6EdbzTVW2EhisE+9lS5DIPfy2hPdjuuESpgMcQUSJiIA5X6EkaQVjr+fP33V1
	fxpGBq5z4Xbxyr3a1wy3Iyl0wZPhOTw=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:31 +0100
Subject: [PATCH v7 3/7] clone: refactor wanted_peer_refs()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-3-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The function wanted_peer_refs() is used to map the refs returned by the
server to refs we will save in our clone.

Over time this function grown to be very complex. Refactor it.

Previously, there was a separate code path for when
`option_single_branch` was set. It resulted in duplicated code and
deeper nested conditions. After this refactor the code path for when
`option_single_branch` is truthy modifies `refs` and then falls through
to the common code path. This approach relies on the `refspec` being set
correctly and thus only mapping refs that are relevant.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 69d1ad029dfa84a2f7136fa4a3c4c8a594b179c4..5efa2bbceb42b230f723660ea963ca1253888235 100644
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
+	for (size_t i = 0; i < refspec->nr; i++)
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
2.48.1.447.gc0086e9015

