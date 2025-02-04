Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F521E0BC
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704884; cv=none; b=DnhzAjhFht7H0iiWC43oppc3enqKyOujTOy1FZEka2ZIdCtR5RxZAV4Pd4psE3Nx4BuktSXSeDbu5HgEAy+rPzfj5Ec5oM81yAB5QKWp7BM2gJ75Zp09kHMpRO6GJXxIJZYv1h2TJ29WwYBJKXtDM4IRHExqhBxcYYFbRucE23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704884; c=relaxed/simple;
	bh=yB8sDZVTg4cLN2qfGEdb0+GnVvxJkU85lFGsepoBneA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s7oniFW23yRNsalogXFi7hfdLZ/LeaUB5MlloMISRXm2EXHKGW9GG6/c4JNknBjMmGnRWvFTJpnZTt4/0gxrO7W0cgud67c7ZZQV/OGWjo70KNNDAntWwVKvug3itxR1Yk1i7TmI5nJ8zzIfytOlUv/QR8bygs5KVBXpfgeOqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3pQ8LT5Q; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3pQ8LT5Q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738704871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFWVyqKSEgJlNB0y6bazvhOjYk0Yc3Xn9hd3SyA0EZ4=;
	b=3pQ8LT5QTd2/RuomWyjyFtLWDBhDyrGyKHe9N3BZeK5RzdOYyNAC87i19F+0BCfCKwzkgJ
	FNe1YblA+OuL/Z4gCDMqx13B3L7RBjn+skOxam1T21NRT6rXzJn7jCKEs25wvX560KPDu/
	Rl7iweSxGTopNRz8vE0WUx208ZtHJUo=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 04 Feb 2025 22:34:03 +0100
Subject: [PATCH v5 4/7] clone: add tags refspec earlier to fetch refspec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-toon-clone-refs-v5-4-37e34af283c8@iotcl.com>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
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
index 5efa2bbceb42b230f723660ea963ca1253888235..1419b82a7bdd3d91cc08667a854b84ba33d1e7aa 100644
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
+		 * specified --branch, which argument might be a tag.
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

