Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDF3BF678
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285080; cv=none; b=C8DphmGGCkSbrchBI5GhZdXM0e6lXlLsIa70uoHdpM5ltqKPU9Mv//hInFMwVt2q+Fh3ycYkVLkwTJzj0EhieLPSZb73J8d/+PXaVqkGgOojztmJOImASU3Y3LQjNX9ZkY8vkyqsAj5ViRttKAnGxVfMwSk7SlItQxHuNazO9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285080; c=relaxed/simple;
	bh=b5jq6gjaqP+hsUIVRoSquUL1WhP8ifByhhXYFpmVBoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1jfAtJPXNRRj1n6V1Loci4dOeU6rESV8cVKnHC+FHd0N7BmowJIUw4r95gpuLM3h4vSNuyOrPs77mONyV7OCt5tjW09t8JLr3QGsFa5/iiERJran2n1TvJ9HTHF9XIazGJTNWfM0dXxnPm92ElnjDT6Mn9sfI8C0/PrIppJFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=grdjgEZA; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="grdjgEZA"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIRVKObaHnvNob74xSseLYYtVr43U9tKQXq9cqTMOlc=;
	b=grdjgEZA7KjXqUkn4eeUnt5ayiCOsB2U2v/Ue7JtlTdNQ4KRfauROgRlxzEHJuZjDcT0Xi
	6GmkXU27QRTrVCH+BquR5Yfeg4i6B47LB3OWVeMEqEBmwYMJDsJyBGwZflhqnBvm4x+lRV
	m7YxqyGSZpFJJRl/7pT0SlFZvHyyUaehoQxCbA9sebyi6sMA/3y0Kh+sVdH+33dmG/VnXW
	bBuMynHY8M6Kz9Af32n2VS9Fhcc3+m5fCacdQJrSBdCo/ulnC5Adu5u0Q97rZ/1fa1l5VY
	xv5+rxHwQf9M/PeJ0N5xstxsB2U/gxdlG+Ec55tf6Ffp9uQvYIpAEwouyacKVA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 2/8] format-patch: refactor generate_commit_list_cover
Date: Mon, 23 Mar 2026 17:57:29 +0100
Message-ID: <883dd358b6d69ab8430a4fcd95318150a6fca870.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=mroik@delayed.space; h=from:subject:message-id; bh=b5jq6gjaqP+hsUIVRoSquUL1WhP8ifByhhXYFpmVBoI=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXDz6z9QGNREu6fvssgEWU0BGlsBUSOlCYNwF plPj5jNR/SJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw8wAKCRBIeX6hnBm+ 0UR6D/47W/oczGINv2pWHCp4amTu0ZsWosSqFa26q3rVXUjFJZrUNBbzndrkWXVj2y2192pQ18E fSCNuwnZeHBTBWDOqtjK+NG9j3TRv65CV6yLSj1wIyGqYB1eIEJlZHOodduhujap4YMitMKKHjx /53Sl4JOwDy58fjaahth66pbEJGfSTKDY/RTasOR5d+QHWZo7Y+Xx8iymVya/vLC8JJRK8jdYQc 5hvEMzMqbV1B0mqzxtv4ovVmYfzRfpRH0O3YUR3DTwxvkZD1w/1oKyL6OQ3jep0dXX1t4fokSvQ sGCKZCbseSp9LTigYKM7CWNYHhGiJdg7jG9oUakDuiE4aIlapTDXY1ojoTrPSnAOl0OpjQbxIHz rKm6i+nsWyiEDfJGmh804JwlOlacQGvNJAPOsDthVpqz2EbjJygULQDYqfiKOBqi6ZH7sHZhF0P GBOluoNZF3yViB2+jXVpo4xhmPWirC1drPke3mvWyZqq0ZFw6QF6EDvn3ZGEGS9/on0G0uvjy43 qN2otOXeO6adclL5hbuaQbeKVXX1vDsKk2sCcjFRc08S1j6OzQ1ZnuNJeHeo80AeOStDMyg0VeS gAkQaK8W5R2awbpdc2neXZXb4aaor8cE6D9VI0FjfOapjy1Ybgnx8txpfFmyU1ZAjqBbr30Xd2r wG50vq0uOw
 C5A6A==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

Refactor for readability and remove unnecessary initialization.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 716ebc2701..997bdd608e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1376,12 +1376,11 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
-	strbuf_init(&commit_line, 0);
 	rev.total = n;
 	ctx.rev = &rev;
-	for (int i = n - 1; i >= 0; i--) {
-		rev.nr = n - i;
-		repo_format_commit_message(the_repository, list[i], format,
+	for (int i = 1; i <= n; i++) {
+		rev.nr = i;
+		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
 		fprintf(cover_file, "%s\n", commit_line.buf);
 		strbuf_reset(&commit_line);
-- 
2.53.0.1118.gaef5881109

