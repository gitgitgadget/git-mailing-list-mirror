Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E143D51E
	for <git@vger.kernel.org>; Mon, 11 May 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527282; cv=none; b=mMDwrx3GEjfvSRt03OUV81aGErJeYk4IvuzuEP00LZdGOt+WBeRWRCPii/HL1TICkMyxCwGZDO2sRZw6G/aIfivFsmkdnmieORq0dGfGHARP4Zua9YX9OHlGyo4UFyg3v36MKIRof/R7e3hebNSEkKocFT131hz3HZ68bM7+q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527282; c=relaxed/simple;
	bh=1GbvotasxMHoe77lsx9liYHlBpxMQJf705Wnkm1n+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bByFUjwVsJukb/8rBOd3qTM3aMucw4YAw+oApFb+Yzgs8rlQsfxtw54wXHbDBJRqzC/R0AR3lddpGdNLo397zygBlfkdUhULvRNSXrGPP3rCfFK/YNggJBSkkWvm3jDw8rHvuaJj/q8qak78fTAGpyriINDLaw+0ImkOfOOzZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=nrjjkZzh; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="nrjjkZzh"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4gDqMV3FgHz9vDSr;
	Mon, 11 May 2026 21:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1778527270;
	bh=1GbvotasxMHoe77lsx9liYHlBpxMQJf705Wnkm1n+Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nrjjkZzheF3hhc+1MnPdsfiMKfGeWfrMsEV4Dds4elGAsyMRFbOcIyu7IaC1cV57e
	 WYeYaEgPgKTe5evGeStQYktewQ1QxnIN8b9bgzh9bF6RPItgUFasrZRh6EVR9RjKC9
	 33dNHI3c5RAGz6RII/ckHlqsY/VDEcPoDbBD97gA=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from hpfur15.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4gDqMB4XJRzMrW1Y;
	Mon, 11 May 2026 21:20:54 +0200 (CEST)
From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	owen@owenstephens.co.uk,
	=?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] shallow: fix relative deepen on non-shallow repositories
Date: Mon, 11 May 2026 21:20:42 +0200
Message-ID: <20260511192044.169557-1-samo_pogacnik@t-2.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqy0hqqreq.fsf@gitster.g>
References: <xmqqy0hqqreq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit "3ef68ff40e (shallow: handling fetch relative-deepen,
2026-02-15)" introduced a bug where using --deepen=<n> on a non-
shallow repository incorrectly treated the value as an absolute
depth, resulting in a shallow fetch and truncated history.

This patch prevents any modification when a relative deepen is
requested on a non-shallow repository.

A test is added to ensure that history is not changed when
--deepen is used on a non-shallow repository.

Reported-by: Owen Stephens <owen@owenstephens.co.uk>
Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
Changes since v1:
- Fixed commit reference in the commit message.

 shallow.c                |  6 +++++-
 t/t5537-fetch-shallow.sh | 10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index a8ad92e303..610ff3d13b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -245,7 +245,11 @@ struct commit_list *get_shallow_commits(struct object_array *heads,
 					int depth, int shallow_flag, int not_shallow_flag)
 {
 	if (shallows && deepen_relative) {
-		depth += get_shallows_depth(heads, shallows);
+		int cur_shallow_depth = get_shallows_depth(heads, shallows);
+		if (cur_shallow_depth)
+			depth += cur_shallow_depth;
+		else
+			return NULL;
 	}
 	return get_shallows_or_depth(heads, NULL, NULL,
 				     depth, shallow_flag, not_shallow_flag);
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6588ce6226..9982dd2aa6 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -251,6 +251,16 @@ test_expect_success '.git/shallow is edited by repack' '
 		origin "+refs/heads/*:refs/remotes/origin/*"
 '
 
+test_expect_success 'fetch --deepen does not truncate' '
+	git clone --no-local .git full-clone &&
+	git -C full-clone rev-parse --is-shallow-repository >expect &&
+	git -C full-clone log --oneline >>expect &&
+	git -C full-clone fetch --deepen=1 &&
+	git -C full-clone rev-parse --is-shallow-repository >actual &&
+	git -C full-clone log --oneline >>actual &&
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.43.0

