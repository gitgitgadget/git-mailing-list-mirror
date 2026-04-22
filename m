Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA319C546
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817760; cv=none; b=dD6VgIfeGTJ7fZjPpxUhc7pnzACTPX+xCp98UQ860YOXJqLCU2D1atZApN2Mza2I+TRBTYY/U/ZJF1zY9Ta8YWpZ/R1rahwlp9wFWnqKj3M/mvbgHoKggMFS+ZWYKZm7BkAW6k6nKg6FrXHTRgPSkmqCfkPafI5EBaxKXur6M4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817760; c=relaxed/simple;
	bh=+TOhKezFJMNNoU/D/dJYebsqeP5JA11fJlMueYFbdH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLRfvr9tq76hEY/Jy6lwK+0QlcEwImDYqmOmIg7jwhMgtQJDGPMDUJ0gx8tYomvZBKh2HuSTEAuqd85Dr4KlIwUnmYcn8l8fwstRh+hdz9xPSqhYmbVuNHMCszvcT3Yx5OPIXKDY1yVwlJkSVLU1llBrso8vv422cEXV5BD51J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=KEyY3Vf5; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="KEyY3Vf5"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776817752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9Ae+JKMGffI+QDfejuyoiMd9XKh1zaxtANdp5HjIfY=;
	b=KEyY3Vf5YXJZS+g84WCzxpZKscZZg66AzyPSudz5N3AimWuFHI2lkrF4kk0wao94Sw+0Hd
	UJShuEA36+jTwtyhsK2eArafNuv8tmS0V82tj+G81KZiyP6xMMDA+dfwk5q0sTtft3L+tl
	zJaZ+dFMgZ4sI5F0DNucODfecYoUsgC/cLrNJ+jyniUpqpnGRGM66Tw623AajDZgM9LijL
	P6HkGyaLYGJ/+LC3S5Azv4KmrgoxGb/hwDuZ8NMrYdqX/vpmDyU3odyzLKdsWIpyyYjpQC
	vUxMW+Pr5LOn3H+DYK1l9PejcUra0OLio5mYNxbNNEYc+lrEdvfcgp67lDwESg==
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
Subject: [PATCH v2 2/2] revision.c: reduce memory usage on reverse before
Date: Wed, 22 Apr 2026 02:28:41 +0200
Message-ID: <20260422002840.303477-6-mroik@delayed.space>
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>
References: <20260418164736.2367523-2-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=mroik@delayed.space; h=from:subject; bh=+TOhKezFJMNNoU/D/dJYebsqeP5JA11fJlMueYFbdH8=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6BY5UWVGUm2zQhQBDstjdGYd2YJTIhsINpkBC xSjXVZoaOaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaegWOQAKCRBIeX6hnBm+ 0TVsD/wODHPYzHW1TjxAQRxmUYPwGjliMw2SwsRcbJWmYbTUPz4B/tizlem9+o5WYqqHQeDQ9+z ID90pBrg7THIwFumrp/WCGVx/QQvo/64TcMt+mDtQhsgfbIoUocFs9UlUTAP/6DGJF5ptbbG4Ze 73xsDMBpYwMdEattcXpbIAdgmOSfSdglntgLR7gBGoT03YBR3Mr2LzescDFEm6dVii1STGEBnZF r7cPbT/EAg1bPJJWKNqc2L9jL4yawYtsQuE6c2tyjwG+UgX+yYmlWAgB2Hit6F6triZg/jAR5DC asbMwvj1wvYHgfMm/K9uaSsRMCmCBJOSTuBHoNvREUkTHW2SHFS45+2aRLv8vruGnaSNtv6bVKz +lxLspsaP4qZBlRYk0h674UxS2sCcHsYt+5Hsg7IMGDi+iQIBgz04VWvU92ITTj5TJssof9JJZu F3nmjfo/uTizNQvfL+6ELvTnOg9/CMpBB1amSHicMF43QmEL4tkpRtVmQE+9BkGIsZtWolUVsUI Un1B3FcZLLq09W3Hwuz+e0u3mX0S8L34PkUNdhZrkDX5hF9G2yTbi4O49sQHbh+6XgHeFaTn7yW /rRdbO/ShKydWB9rHi6fbTq4jtRtefG5uFC9hNuuiSjzJxW2JsYmMMp9MhpYyMKYnONh1tShx2P L13Uwt6aFCv2Mmg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

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
 revision.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index d581f5e38e..4730f21ea6 100644
--- a/revision.c
+++ b/revision.c
@@ -4530,6 +4530,52 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	return c;
 }
 
+static void retrieve_with_window(struct rev_info *revs, int max_count,
+			  struct commit_list **reversed)
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
+	while (outo_count) {
+		c = pop_commit(&outo_queue);
+		outo_count--;
+		commit_list_insert(c, reversed);
+	}
+
+	while (into_count) {
+		c = pop_commit(&into_queue);
+		into_count--;
+		commit_list_insert(c, &outo_queue);
+		outo_count++;
+	}
+
+	while (outo_count) {
+		c = pop_commit(&outo_queue);
+		outo_count--;
+		commit_list_insert(c, reversed);
+	}
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
@@ -4546,8 +4592,12 @@ struct commit *get_revision(struct rev_info *revs)
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

