Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F8534D93D
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417793; cv=none; b=lYgc9NIke2Qjqq6q+/oMOyOhZWO1Vd34ClSITAgJ6ebN//fD2KaRjm8sgy4UAsnLt/4KmBHU+5eW4KOM50PF3eYwCmVreIR6q35RnRs7JD4dcHiAYeXkImBd+m/ifOFZ5B/e91WVK9DkTxYA11fe9uvUyp8Zl6w6S4yqo2KV/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417793; c=relaxed/simple;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/OiR/V1yCF5crM9GRro3zjY84zS7awfQ09ycjzP35key7mEP1YrOi7IfpqkihTsZlNi/5v2zfEjTEAxiGlMwl7KyR+UOubdRu5bJ8wvw8jL2FlTHjWligmcRKqp4MD9KLsgRUGAE3VeRQmDGMqiN8VH7lT7xQH5/BP3GPsVIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FTxIsyZn; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FTxIsyZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=kg41+dqjOzuXFZWYaLWiR0bhM8dISTlb+UAzLYeybg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FTxIsyZn1J9o75CUwYNNk358niHw2nzeOrGsisc0IS0gRI9k2GxEQZthieG7SwEBu
	 LHVzh/r/o8/A91204DFf8JDs9wZJMxSkS5DlvJGLnpKst5q63T7b9vrNWp1UwWp+QM
	 t7fjHYywRJfgbZ6U4/GqHqDRVVnYqskoDZEr77udqEbWx8GuNg/6pDv9tkWqaGe/L1
	 OMjDB2Ts1wBbYaQ0A2XOfN3cR6IhgfOveTzpfsym3mEFe6Rgbqxn2TqH0uMmhu+a6t
	 ZhZ+awbptOj1iFoeYeO3Vwm6za1o/fzd5jEZVnQ4CGdfGcyg/1iAXx8TqDOW/LIfvJ
	 7H/JaHJKp5bxACwWU8SfOXEKO9FeucpLcdyTbh6dSTXxas/0zUgDg5E+WpcKQ/hmQs
	 2/f2dqeCb6u3lthpjlQ1HeEryl204kjfTYU8JyiiS5iKVXmKlY3AIrsKiigQDylh/B
	 MX8iF+dVlso6QXU7nV2vNJ/uAuk1H7efRRWHohn9ig17phShK56
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 641BB25551;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 15/15] object-file-convert: always make sure object ID algo is valid
Date: Mon, 17 Nov 2025 22:16:21 +0000
Message-ID: <20251117221621.2863243-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, we zero-initialize our object IDs, which sets the algo
member to zero as well, which is not a valid algorithm number.  This is
a bad practice, but we typically paper over it in many cases by simply
substituting the repository's hash algorithm.

However, our new Rust loose object map code doesn't handle this
gracefully and can't find object IDs when the algorithm is zero because
they don't compare equal to those with the correct algo field.  In
addition, the comparison code doesn't have any knowledge of what the
main algorithm is because that's global state, so we can't adjust the
comparison.

To make our code function properly and to avoid propagating these bad
entries, if we get a source object ID with a zero algo, just make a copy
of it with the fixed algorithm.  This has the benefit of also fixing the
object IDs if we're in a single algorithm mode as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file-convert.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/object-file-convert.c b/object-file-convert.c
index e44c821084..f8dce94811 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -13,7 +13,7 @@
 #include "gpg-interface.h"
 #include "object-file-convert.h"
 
-int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
+int repo_oid_to_algop(struct repository *repo, const struct object_id *srcoid,
 		      const struct git_hash_algo *to, struct object_id *dest)
 {
 	/*
@@ -21,7 +21,15 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 	 * default hash algorithm for that object.
 	 */
 	const struct git_hash_algo *from =
-		src->algo ? &hash_algos[src->algo] : repo->hash_algo;
+		srcoid->algo ? &hash_algos[srcoid->algo] : repo->hash_algo;
+	struct object_id temp;
+	const struct object_id *src = srcoid;
+
+	if (!srcoid->algo) {
+		oidcpy(&temp, srcoid);
+		temp.algo = hash_algo_by_ptr(repo->hash_algo);
+		src = &temp;
+	}
 
 	if (from == to || !to) {
 		if (src != dest)
