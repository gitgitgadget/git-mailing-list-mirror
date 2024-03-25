Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136313B7A4
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372796; cv=none; b=OnkujeNg1/OosLxbUxVSl7ccVjgj5TVx1i1zJs9pA0WQuOTpVEk8jzcHsW/FERqcp+tn+1csqjQUP+xFZCXXehXSLvFbAN9vGO65SGc73Sxas8U6s8VMcvDqTqrrb4zkKO6KonwpBscf4QRu/NPb+zfT/OduBC9W3uGv1/7xI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372796; c=relaxed/simple;
	bh=+pdy4sDOhlD1rE+/o3W26ADVjvr5568xx7dI+Bkjbu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTHTnDwE4i/Tywx9xQevJFRcKUlGnS2nWuoFDA0zwdEpG2RujCJRQ6dkHbSPN2xiySSRcNhjuMttmWPiQP+g6p7NdJW8dngPjcvebNMKKBPFe/0TBORdX6SDUO4LmN366klQxqvNj9u1i36PM1ABEvzAIyMli2fHtbd5UnDYiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=SqWzg2ap; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="SqWzg2ap"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42PDJgLX003638
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 25 Mar 2024 14:19:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711372783; bh=+pdy4sDOhlD1rE+/o3W26ADVjvr5568xx7dI+Bkjbu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SqWzg2apubpKgHHJJFk6igQbBzrRmAczqvq2NVbGUT5JtWoB7mdw/NZ8/blUxbJXT
	 Q+eIebx6bmhH8xHNVC3qXaYM7+hVm2097kyLQ9SAooBXNtNEPlexK+53BA08nLBIOB
	 n/c702f8CFNetmDgM74LespZ2kLUgEuO6MDY5Tng=
From: Dirk Gouders <dirk@gouders.net>
To: git@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Kyle Lippincott <spectral@google.com>
Subject: [PATCH v3 4/5] MyFirstObjectWalk: fix description for counting omitted objects
Date: Mon, 25 Mar 2024 13:33:35 +0100
Message-ID: <cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711368498.git.dirk@gouders.net>
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the changes to count omitted objects, the function
traverse_commit_list() was used and its call cannot be changed to pass
a pointer to an oidset to record omitted objects.

Fix the text to clarify that we now use another traversal function to
be able to pass the pointer to the introduced oidset.

Helped-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index a06c712e46..811175837c 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
 === Counting Omitted Objects
 
 We also have the capability to enumerate all objects which were omitted by a
-filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
-`traverse_commit_list_filtered()` to populate the `omitted` list means that our
-object walk does not perform any better than an unfiltered object walk; all
-reachable objects are walked in order to populate the list.
+filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
+change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
+able to populate an `omitted` list. Note that this means that our object walk
+will not perform any better than an unfiltered object walk; all reachable
+objects are walked in order to populate the list.
 
 First, add the `struct oidset` and related items we will use to iterate it:
 
@@ -778,8 +779,9 @@ static void walken_object_walk(
 	...
 ----
 
-Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
-object:
+Replace the call to `traverse_commit_list()` with
+`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
+defined and initialized above:
 
 ----
 	...
-- 
2.43.0

