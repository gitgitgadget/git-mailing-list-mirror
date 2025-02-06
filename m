Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DF19BBA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823649; cv=none; b=hUNBeQYf73Ll/Y3cCBI7B1DUrjoihQFmYkgTP41n0HU2YA2ephCsZ8BHCMw+4xhVVdzONj8wO5FxpYrTm+pbD42Oz62s4QcpvhRhves16IYzYZzoY/n3mjRteGV0oRXF30GyvFpjMGULQHWLK3MgiMgV+aY3U1pdtP0K9CaEdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823649; c=relaxed/simple;
	bh=lgBLB697+FvzKO4KojqRjDrIjd1KI0R1zccyQDFF91s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCOivXaLsxMZLVgxmLxp/ZItS0I/TB4rqo+xCbOXIqhX647tInIGSJ18tK8wrunB1MPT9GTXdtN+uA5aiuBTa9FWD6LgkMTZgetGyNUSGgWh7k1ONZ7jHVFcqAv7l0fb1W2eotKURzjUp5HfimafMgDLDl91XUWz0krLldgJIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=2E0ROOGw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="2E0ROOGw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psL1avMTJ1yHFAPZmmDLfT8J+X1MaflHkvHAuR1+WVY=;
	b=2E0ROOGw6bxeOcevwSkxFGLWXsMC+mEz3Pl2t7SUlr+fusGzjBvRvXKe6YyCi1mRVCx2Y6
	PiIIc9Riggtx4HBrPCoTw5fc0/wHY66Sr/uX8MyZa8wS/+Cx8tCUWGsE9QIxSfdjgDMtqU
	lazrk0FivTLJVIg245Son5SoMK6I+kA=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:32 +0100
Subject: [PATCH v7 4/7] clone: add tags refspec earlier to fetch refspec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-4-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In clone.c we call refspec_ref_prefixes() to copy the fetch refspecs
from the `remote->fetch` refspec into `ref_prefixes` of
`transport_ls_refs_options`. Afterwards we add the tags prefix
`refs/tags/` prefix as well. At a later point, in wanted_peer_refs() we
process refs using both `remote->fetch` and `TAG_REFSPEC`.

Simplify the code by appending `TAG_REFSPEC` to `remote->fetch` before
calling refspec_ref_prefixes().

To be able to do this, we set `option_tags` to 0 when --mirror is given.
This is because --mirror mirrors (hence the name) all the refs,
including tags and they do not need to be treated separately.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5efa2bbceb42b230f723660ea963ca1253888235..ef4af1f3e6bf0a33c13ed874587b35aba14fe43c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -435,11 +435,8 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
 	struct ref **tail = local_refs ? &local_refs->next : &local_refs;
-	struct refspec_item tag_refspec;
 	struct ref *to_free = NULL;
 
-	refspec_item_init(&tag_refspec, TAG_REFSPEC, 0);
-
 	if (option_single_branch) {
 		if (!option_branch)
 			refs = to_free = guess_remote_head(head, refs, 0);
@@ -454,16 +451,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	for (size_t i = 0; i < refspec->nr; i++)
 		get_fetch_map(refs, &refspec->items[i], &tail, 0);
 
-	/*
-	 * Grab all refs that match the TAG_REFSPEC. Any tags we don't care
-	 * about won't be present in `refs` anyway.
-	 * Except with option --mirror, where we grab all refs already.
-	 */
-	if (!option_mirror)
-		get_fetch_map(refs, &tag_refspec, &tail, 0);
-
 	free_one_ref(to_free);
-	refspec_item_clear(&tag_refspec);
 
 	return local_refs;
 }
@@ -1011,8 +999,10 @@ int cmd_clone(int argc,
 			die(_("unknown ref storage format '%s'"), ref_format);
 	}
 
-	if (option_mirror)
+	if (option_mirror) {
 		option_bare = 1;
+		option_tags = 0;
+	}
 
 	if (option_bare) {
 		if (real_git_dir)
@@ -1375,14 +1365,19 @@ int cmd_clone(int argc,
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
+	if (option_tags || option_branch)
+		/*
+		 * Add tags refspec when user asked for tags (implicitly) or
+		 * specified --branch, whose argument might be a tag.
+		 */
+		refspec_append(&remote->fetch, TAG_REFSPEC);
+
 	refspec_ref_prefixes(&remote->fetch,
 			     &transport_ls_refs_options.ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&transport_ls_refs_options.ref_prefixes,
 				  option_branch);
-	if (option_tags)
-		strvec_push(&transport_ls_refs_options.ref_prefixes,
-			    "refs/tags/");
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 

-- 
2.48.1.447.gc0086e9015

