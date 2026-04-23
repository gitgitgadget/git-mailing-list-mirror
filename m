Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99E387361
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984758; cv=none; b=WXjscINjlJm5krEgsvauiifQqkhwqJrxp4KfFDS8nP3vEWjQyzx5A+I/pk/YI/54NheVKH9Nvu/hNlIbJE6aPSRmg/s0S7RIdufBaI+YuXCdJHjgPb/IKPdrlNidrzQQNPTf9N0HhlODISLSglLat+FYlNGKcN/1hSTHw6wF5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984758; c=relaxed/simple;
	bh=5gXy4MWbqbYPcPSjfHyG9HJYFU6tkhnj9Dr+23UFWhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvqAtik0qviNK4i681Gp3ceDsTs7I8+jCI+czZwDlI//2QXtoYIc69G5Q43ga3bmBFZciz5wJh3K/K+0VMhQYPP4S7Es5kLxM/GzQfRTi/UzkcHHJxU4S1pFWQVf6qnA2RqpWCsSTIP3SsSEe1bp7eiBBaXIuwBKdzAwjaaALs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Y1Ws/1XO; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Y1Ws/1XO"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776984744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKUfZkN5fcH/HtjvvxANtR2A57SZLebaxQBWXSWZdl4=;
	b=Y1Ws/1XON7WKH1A8IcLX0pocSUH263shxAux80SsbRzw6xUtvpt75T3yCPlyNbR894mR5H
	GavXIxoBkZ+8ftcJ5AOGgPgug2mEmSrkbmSKef5liLuryXT/bH1VNlU04bn3OWUqDDbEjL
	oXRPXzaIvurZ6y5qs13H4EfuNAiknypv/4lsnUMDJYnxXMBt8LohBkxpd1dm640mF7bqfq
	coGxRtOrw1eiGHs+VLWB1Yl7quYoHzBzh69sAOm2/oLWbvXxnzBsM590y9aROdIH0fxCWM
	OM08o+X3F35PJmshy0T0ahvFqQRPWETer2ereBYdm6BdXBAX+70TARwP48SiGQ==
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
Subject: [PATCH v3 2/2] revision.c: reduce memory usage on reverse before
Date: Fri, 24 Apr 2026 00:52:00 +0200
Message-ID: <00489b0e5282028292a6a2f582b9bef3f8a50041.1776984666.git.mroik@delayed.space>
In-Reply-To: <cover.1776984666.git.mroik@delayed.space>
References: <20260422002840.303477-4-mroik@delayed.space> <cover.1776984666.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=mroik@delayed.space; h=from:subject:message-id; bh=5gXy4MWbqbYPcPSjfHyG9HJYFU6tkhnj9Dr+23UFWhE=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6qKS6y6GpEPgAsB8J+i4usXLlg/wlVA5Q3LJ5 nGXbMVo1POJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeqikgAKCRBIeX6hnBm+ 0Q4uEACEnRaQehwXaU6Hbi+1SJJHYdQ+I8dz1UU+nDcVE/s/mLkICQ7yX0yRU05IVELOIQ0klNV 2iUD3nPMFya3Wr1aoj6/o6YzTv1hHM4VayeqgpcMRqm0rAdoT0CnFfe0Ij8xh7IxCI6qfVIBAGs Pu8IjxfcifTOPXSJYmHiakjmaFCNw8lWoDqU2pSp09Z72T4JyDTM99dOPzJ0B3RbQcxNI5sxKfG YjsIJhl+TG3AmDU6fG7MmiEf8vvFPLUDqNwEHuocJ2UeT/ht6aViJ8Sh67XQsHoY+Jj88CHTawV fXP858/8OT7TVLSymUekIGNf6GXFcPSu88f7NxncWbWR2r8NAjX0I8GK5VoxYH//uIi5tzvjTvW XGa5pqpWegB4gQAWnfw4SZHc/auunFou/1U8DkbxIkATAVDJtv9s9dUhti05UiUgTqJIa0BVYwU HYF9lPbxJWo83VkcBL/rzR38eoqA1b/rKcQPoONagwZ+DThYNt5tBMgZXugIE8Ru/EVY/eHZu3I /KAxWgFeTrMXpj802kV+GMIYbJc8ueu40XndDHQHQ/f9g6zYFC1giuvaT9qnCeD5sHiwfs8+PvY 2ufoLnaVyyfxsqgmvJ+YDpdQVcLB2QpdOPU2yABCGonvlx6/nqLX+bKOStawE2AIg/qcyIUs04K d//OgncdC
 mxeD6Q==
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
to time complexity, the queue has an ammortized time of O(1) for pops,
so the complexity remains O(N).

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 revision.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index d581f5e38e..03acff9bac 100644
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
+		if (revs->reverse == REVERSE_BEFORE && max_count != -1) {
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

