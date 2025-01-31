Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77D1E5700
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337487; cv=none; b=V92wdDN+fdR176jNTB5qfDXTdnf/CBkn/5wbL0Ew6IK1x7j3yK2rCMz+SB8cP/u0PnZ3oEz9jofE4naefL54pMqzKyYyExhfRWt9Nf8nwxtiab1seYEbxaRsTmg68XOq9PW3hL0DoiOyKuIz9Q2wTGH65OexLxI31gG+XGoxtaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337487; c=relaxed/simple;
	bh=I8NWqcmdZfG0k4GUrYDxpz/mgzujtVH38y6bp0eb5p8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUJXTkp0K4DrntUZpFuCvGhUqXr4+JB8zOZZWj9vO06Jd93t6K4hHetZvVGHYaTCkJkjXIAOwRN2ifpB6WJDduM34sV48FcGDkJAWRgiA/4u8mM9qv+CWmihLw2o2OuFbtIaOpsZF6OiICc/Fo6r07hQWmYjR/J9PmybFv5lgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Oosh67pw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Oosh67pw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738337478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsgVQxnmpA+yJ2jdOFx4R8ZsZ2HlrJY7j3HbeQD6tlE=;
	b=Oosh67pwukGP4LXtu8CnWWIVBH+N7Y76vbYHQu+14Hf3WmnM7PGyrKwVa5wINrSs+fxpPz
	uHBVTbMPyH0oapBbMzW9uYTgBTve9fjDlLxR3S6WgL6X9I9c3d/c4o94l0J7mEMrpqCAIA
	wkR/Ksu9svxBJmrUCn7kqY+e9WgK0PA=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 31 Jan 2025 16:30:32 +0100
Subject: [PATCH v4 4/6] clone: add tags refspec earlier to fetch refspec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-toon-clone-refs-v4-4-2a4ff851498f@iotcl.com>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
In-Reply-To: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In clone.c we call refspec_ref_prefixes() to copy the fetch refspecs
from the `remote->fetch` refspec into `ref_prefixes` of
`transport_ls_refs_options`. Afterward we add the tags prefix
`refs/tags/` prefix as well. At a later point, in wanted_peer_refs() we
process refs using both `remote->fetch` and `TAG_REFSPEC`.

Simplify the code by appending `TAG_REFSPEC` to `remote->fetch` before
calling refspec_ref_prefixes().

To be able to do this, we set `option_tags` to 0 when --mirror is given.
This is because --mirror mirrors (hence the name) all the refs,
including tags and they do not need to be treated separately.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d652682494d0d27dd73cd0585e28b23f2883786d..7ab156ac00240de89baca6533ed2541839286fc4 100644
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
 	for (int i = 0; i < refspec->nr; i++)
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
@@ -1375,14 +1365,15 @@ int cmd_clone(int argc,
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
+	if (option_tags || option_branch)
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
2.48.1.164.g9a5474a648.dirty

