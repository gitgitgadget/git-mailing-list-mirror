Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6A1F63D9
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249548; cv=none; b=NOWMkHEJ4vSBDS2rLPH5BPopUcNj4Io/XYZDNxwUDg1vQ8d092AOBqyAlBwyIgAFh+xINOulhSxqtLXSXEkPDo6vxBpO5elpjMS80ohiejb4Zyh/TAbD3WffT5SDwLHCs6Ml+3P5dXxOF/69lk3TP63QmeiH7xyosaTyaSF7ZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249548; c=relaxed/simple;
	bh=m1TaiyZnPXguQhMFgnpwoFWg4SP1oBPKjU29IKvVRZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtTWaxT1eo8MkMW7/V9nNGkPXIM+1hnevnc2xqupYe0eTuebY0MzY4OZ/RsihPf2CZXW+okLc5qM7ZRBOCM+k1Y1pEQTJ/ahruGj0cIvdgGpxoaOB6mm5kfqeLBIeY1sRhf6fNF1ZECToE6rPUbKueuIRqlDs95Wfrto2FaJSnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=FlNxO0xF; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="FlNxO0xF"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1777249540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+97etdnTFa7ZqvmRTCPpdCH5MC2sfzWVzvUoEMZIjI=;
	b=FlNxO0xFq3CoWkGlo3THagtf2pq4bsmC5SDNItO3H59l5cCGuoFdwnq14ox4ff5tPLQQQn
	gpN5WHMDJWHQf3MvHM6shFMgtQ9JmNxSP2/B/ZFmrYFzLF2sSoOVnLVsEEl0qL8JzeEsRT
	a8UHny2RJGOCsiUZnv8+W1jjPWgCPcOgyAFn9id0YBsdsOG8CGtjghneyq0mowoz7IXqY5
	B0krK3dOor5NQzom3BJLpxk30z2cUczXkAlkhgWc9rYQxCsnjiCNSPYHCa7KSUxfIKQAyc
	zsGlGNsZZVQ9XhRZrOKB7ELMYkMvhYlzlq8hEOQBegELRen+nxYQVkPNiw7Ftw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v4 2/2] revision.c: reduce memory usage on reverse before
Date: Mon, 27 Apr 2026 02:24:58 +0200
Message-ID: <7c0bab5d14bb2ce2a10d35d93e3d911ed4c386eb.1777249165.git.mroik@delayed.space>
In-Reply-To: <cover.1777249165.git.mroik@delayed.space>
References: <cover.1776984666.git.mroik@delayed.space> <cover.1777249165.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2804; i=mroik@delayed.space; h=from:subject:message-id; bh=m1TaiyZnPXguQhMFgnpwoFWg4SP1oBPKjU29IKvVRZc=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp7qzZgtGnsj8aA5E8Zg945MuPlE5c3WxJZAOHP PH3F4Pt5amJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCae6s2QAKCRBIeX6hnBm+ 0QUrD/99ieVXPyNzV9s5Iqqc0FTncIvK7u4LdFsc7CjnBwERgdpG1Ie7LLavWpG4DGHNBjurTn8 rjNhmsEyom7glA4zvesNWpwDRvouJgkdHqkVeuliWJsPTJwMY366j5rLcehRgqAe5w0mkY6bvBo kgu3hgCt19HMOdXm5bSpPQAne5gUS4ZT21pVGjcRJKiTJPsmv4d7ZgGoW9rT1eEfWLsPau8bYsW BzJKSG+D3wGDU+MUqw6GMan9q7uOfbIps6vls79dgpERIccVxZgzFLW9oXbFH1HOJmVrYzDcP/G 9e1423SOwNgCubUD7Lk5ePGi3wHeeO/QceE/nS5KBX8HWUY5CqDuC/yeg5/TyisLY8zyQ252ZVv OZulig0o4Gepvf/a/FmVg1aQcaKB0eCM4eWTfK/W4uKQ+9Cc7j12LRbHNY7w08zLLzPoFVYHkHj BvgdEv8BAWI3nbQx2eZHiadufBlPD+ICuKR6Z/ldlQvn0hckqa9duJR9UXq3fhEkSrkKZVB3oA3 IG6znmcEjslvvSTcW0FtYKWkUmeWSaU0IkP1sJx7GRzhFv3pGQkBLPuJQ8zXrkiLxLsWFrTQkw5 PGCMX2PWkeKdjjZLDSfjfW8JIrvQI27zkNFJI4Kxl6paWTl/ZRb1JliPHUwWg23QLyLUI1ZNsIg ZWGkMYTGP
 sD3I5Q==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

Due to the nature of --reverse=before we have to walk all of the history
and store each non-filtered processed commit, this can be expensive on
memory for projects with a long history. When --max-count is being used
we don't really have to keep every processed commit, we can discard
older commits (as in have been processed before than the ones we're now
considering, from a chronological commit order they are the newer
commits) as we surpass the --max-count limit.

Teach get_revision() to keep only the newer commits as we walk a
revision with --reverse=before and --max-count=<k>. We do this through a
simple queue. With N nodes and K as the --max-count argument, assuming K
< N, we go from a space complexity of O(N) to O(K). When it comes down
to time complexity, the queue has an amortized time of O(1) for pops, so
the complexity remains O(N).

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 revision.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index d581f5e38e..41c3d185c5 100644
--- a/revision.c
+++ b/revision.c
@@ -4530,6 +4530,40 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	return c;
 }
 
+static void retrieve_with_window(struct rev_info *revs, int max_count,
+			  	 struct commit_list **reversed)
+{
+	struct commit *c;
+	struct commit_list *into_queue = NULL;
+	struct commit_list *outo_queue = NULL;
+	int into_count = 0;
+	int outo_count = 0;
+
+	while ((c = get_revision_internal(revs))) {
+		commit_list_insert(c, &into_queue);
+		into_count++;
+		if (into_count + outo_count > max_count) {
+			if (!outo_count) {
+				while (into_count) {
+					c = pop_commit(&into_queue);
+					into_count--;
+					commit_list_insert(c, &outo_queue);
+					outo_count++;
+				}
+			}
+			pop_commit(&outo_queue);
+			outo_count--;
+		}
+	}
+
+	while ((c = pop_commit(&outo_queue)))
+		commit_list_insert(c, reversed);
+	while ((c = pop_commit(&into_queue)))
+		commit_list_insert(c, &outo_queue);
+	while ((c = pop_commit(&outo_queue)))
+		commit_list_insert(c, reversed);
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
@@ -4546,8 +4580,12 @@ struct commit *get_revision(struct rev_info *revs)
 			revs->max_count = -1;
 
 		reversed = NULL;
-		while ((c = get_revision_internal(revs)))
-			commit_list_insert(c, &reversed);
+		if (revs->reverse == REVERSE_BEFORE && max_count >= 0) {
+			retrieve_with_window(revs, max_count, &reversed);
+		} else {
+			while ((c = get_revision_internal(revs)))
+				commit_list_insert(c, &reversed);
+		}
 		commit_list_free(revs->commits);
 		revs->commits = reversed;
 		revs->reverse_output_stage = 1;
-- 
2.54.0

