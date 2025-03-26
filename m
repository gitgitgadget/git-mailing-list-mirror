Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB83214A8F
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020379; cv=none; b=eBBUuIHKZgoN19aFKajkVRJLyOQZqJWAOzWZT5aaXDIYIZM6ZgOgCgvrG3A0JYhHy0psAOTIM+IMmCOgOMMSOiQ8eE3Q6jc0xWOyXr44/cl1tVso70oxGDtM3/fDXQEqkjMgwthEEmXL4N5w3uezReD7CpFC3Rs3VgrIGs0V8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020379; c=relaxed/simple;
	bh=co6sp4XhrW8QICdllWV/8LKV704rKIry+jXVEJOQCVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KywvwLhRVp/g0Z5pfqvbkXPnunc9ocM6sg0hgp3axNnbn88g2lk8tE+HdQnh1ey9sTh7sMYihAUAvcYmvPX5V89WeNufGuyPqBJcd/ZugtLMoN47oyLP0P3iQmXy+btMJBWFiKKY6VjW5dotCajLrOFSwhG1covI15fKwXiXpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kN+0j2Wn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kN+0j2Wn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743020375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agIwgCHQn9n3n6cUiz7PIJoQZis536XvaW6vG413CBc=;
	b=kN+0j2Wn5BeAGZP/Jo8jrsStefKmoiJ1Kxzhmih0lN8FRSOU2k0G3hqC+fS+ZliB8xydiX
	4KNq0zYyp5I10dtrrTdQKxnTqS2hfnM/qd82KImCGhrcC/ZTXWrz5PFd498MjbWoV3b6T9
	ze3fcGKSLdYf2pdJhl7q7rUvQr0YFh4=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 26 Mar 2025 21:18:26 +0100
Subject: [PATCH 2/8] within_depth: fix return for empty path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-toon-blame-tree-v1-2-4173133f3786@iotcl.com>
References: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
In-Reply-To: <20250326-toon-blame-tree-v1-0-4173133f3786@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
X-Migadu-Flow: FLOW_OUT

From: Jeff King <peff@peff.net>

The within_depth function is used to check whether pathspecs
limited by a max-depth parameter are acceptable. It takes a
path to check, a maximum depth, and a "base" depth. It
counts the components in the path (by counting slashes),
adds them to the base, and compare them to the maximum.

However, if the base does not have any slashes at all, we
always return "true". If the base depth is 0, then this is
correct; no matter what the maximum is, we are always within
it. However, if the base depth is greater than 0, then we
might return an erroneous result.

This ends up not causing any user-visible bugs in the
current code. The call sites in dir.c always pass a base
depth of 0, so are unaffected. But tree_entry_interesting
uses this function differently: it will pass the prefix of
the current entry, along with a "1" if the entry is a
directory, in essence checking whether items inside the
entry would be of interest. It turns out not to make a
difference in behavior, but the reasoning is complex.

Given a tree like:

  file
  a/file
  a/b/file

walking the tree and calling tree_entry_interesting will
yield the following results:

  (with max_depth=0):
      file: yes
         a: yes
    a/file: no
       a/b: no

  (with max_depth=1):
      file: yes
         a: yes
    a/file: yes
       a/b: no

So we have inconsistent behavior in considering directories
interesting. If they are at the edge of our depth but at the
root, we will recurse into them, but then find all of their
entries uninteresting (e.g., in the first case, we will look
at "a" but find "a/*" uninteresting). But if they are at the
edge of our depth and not at the root, then we will not
recurse (in the second example, we do not even bother
entering "a/b").

This turns out not to matter because the only caller which
uses max-depth pathspecs is cmd_grep, which only cares about
blob entries. From its perspective, it is exactly the same
to not recurse into a subtree, or to recurse and find that
it contains no matching entries. Not recursing is merely an
optimization.

It is debatable whether tree_entry_interesting should
consider such an entry interesting. The only caller does not
care if it sees the tree itself, and can benefit from the
optimization. But if we add a "max-depth" limiter to regular
diffs, then a diff with DIFF_OPT_TREE_IN_RECURSIVE would
probably want to show the tree itself, but not what it
contains.

This patch just fixes within_depth, which means we consider
such entries uninteresting (and makes the current caller
happy).  If we want to change that in the future, then this
fix is still the correct first step, as the current behavior is
simply inconsistent.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index cbd82be6c9..3aead2a599 100644
--- a/dir.c
+++ b/dir.c
@@ -278,7 +278,7 @@ int within_depth(const char *name, int namelen,
 		if (depth > max_depth)
 			return 0;
 	}
-	return 1;
+	return depth <= max_depth;
 }
 
 /*

-- 
2.49.0.rc2

