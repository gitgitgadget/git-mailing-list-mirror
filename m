Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB902D2390
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991683; cv=none; b=PRyiklv56D/StkLbA0R8bg0ZxZImxxzzBVOOB8cyGXWTYw1spIdZPoKm5AqieFjkFKgiCO6/WviFkDYkKNgWcBcOL83M3LSja5HwfMIMpA7jRBubr30x7nGWlCzRYevemCCtOMH9uZ5+ZJoyC1RVnC4MdyKb3/+xxNlhmM6sEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991683; c=relaxed/simple;
	bh=uQrVGpEJ3Jgry9es/2izwvOmp1tVGvg6yd0zMYvte50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbP3v78vMJTBF9G/a1J92AdD08Hp41vMzFYYCBe2PUUu28BpQekx9uDnlsTEZcEt7+vK6LhZfckq9gEO7vVFkzIY3py8xiYcgd4ivV/Ishv2jTkQIUaRQvoDDk/S4ZzQr31WJ+nFGZoOAclQqDPD0DAlJWW6USCbXo92AxhN/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IY3bC0pc; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IY3bC0pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1762991679;
	bh=uQrVGpEJ3Jgry9es/2izwvOmp1tVGvg6yd0zMYvte50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=IY3bC0pcwforwvt3+urWSqekXOen6hLgfzNuz0RgtbMyWvsgkMVSSRqxXFF+tYEl3
	 YW0RxmwN3CiwOCSNdL+qWYRhMEau4vaRIB7cvoR2XrKEv+WXcIcWfKLwxa//cG3wQZ
	 ublF/YiASTcctOWXn/IPed33USiJLK16kC7Qz04kmLCUqMx9DUG6GdzpKHqIwRIyUt
	 AgUZEYNw9ZNkn7szFoe/FfZIT94w7F9aKiB54ZYWW44PRYEHkkIYHcwWZzeDeBBISZ
	 DO/1rq0uE2B4oqfxK2JDgB11anXrHisrbiBli7icOk5ryfyz1m1jfV/o87D588Od13
	 YhUpwELX3rBIMmMcFoBXfpNUAuvrlWtxUdfenhu4ApR+nq6oC+qFKCc4gMb8Kow4mQ
	 bEWRPDKhC8bc42SXakJafk4tpucSXKvGmCFMOZHV+EpQa+iMwkbWMKjixT8ikdhHp3
	 2d2qoZXyzrLUrSwkkI12g7mrvsLaYJzkCqHW9Qh9es9i8Fhx73q
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b668:e49e:abfe:cbc7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DA48E20065;
	Wed, 12 Nov 2025 23:54:39 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Martin Wilck <mwilck@suse.com>,
	Adrian Schroeter <adrian@suse.com>
Subject: [PATCH] object-file: disallow adding submodules of different hash algo
Date: Wed, 12 Nov 2025 23:54:34 +0000
Message-ID: <20251112235434.1499699-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The design of the hash algorithm transition plan is that objects stored
must be entirely in one algorithm since we lack any way to indicate a
mix of algorithms.  This also includes submodules, but we have
traditionally not enforced this, which leads to various problems when
trying to clone or check out the the submodule from the remote.

Since this cannot work in the general case, restrict adding a submodule
of a different algorithm to the index.  Add tests for git add and git
submodule add that these are rejected.

Note that we cannot check this in git fsck because the malformed
submodule is stored in the tree as an object ID which is either
truncated (when a SHA-256 submodule is added to a SHA-1 repository) or
padded with zeros (when a SHA-1 submodule is added to a SHA-256
repository).  We cannot detect even the latter case because someone
could have an actual submodule that actually ends in 24 zeros, which
would be a false positive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 object-file.c              |  6 +++++-
 t/t3700-add.sh             | 27 +++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 4675c8ed6b..8c43c52ed0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1661,7 +1661,11 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid);
+		if (repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid))
+			return -1;
+		if (&hash_algos[oid->algo] != istate->repo->hash_algo)
+			return error(_("cannot add a submodule of a different hash algorithm"));
+		break;
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index df580a5806..b075eb9b11 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -541,6 +541,33 @@ test_expect_success 'all statuses changed in folder if . is given' '
 	)
 '
 
+test_expect_success 'cannot add a submodule of a different algorithm' '
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit abc &&
+		git init --object-format=sha1 submodule &&
+		(
+			cd submodule &&
+			test_commit def
+		) &&
+		test_must_fail git add submodule &&
+		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
+	) &&
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit abc &&
+		git init --object-format=sha256 submodule &&
+		(
+			cd submodule &&
+			test_commit def
+		) &&
+		test_must_fail git add submodule &&
+		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
+	)
+'
+
 test_expect_success CASE_INSENSITIVE_FS 'path is case-insensitive' '
 	path="$(pwd)/BLUB" &&
 	touch "$path" &&
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fd3e7e355e..b190182d62 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -407,6 +407,33 @@ test_expect_success 'submodule add in subdirectory with relative path should fai
 	test_grep toplevel output.err
 '
 
+test_expect_success 'submodule add of a different algorithm fails' '
+	git init --object-format=sha256 sha256 &&
+	(
+		cd sha256 &&
+		test_commit abc &&
+		git init --object-format=sha1 submodule &&
+		(
+			cd submodule &&
+			test_commit def
+		) &&
+		test_must_fail git submodule add "$submodurl" submodule &&
+		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
+	) &&
+	git init --object-format=sha1 sha1 &&
+	(
+		cd sha1 &&
+		test_commit abc &&
+		git init --object-format=sha256 submodule &&
+		(
+			cd submodule &&
+			test_commit def
+		) &&
+		test_must_fail git submodule add "$submodurl" submodule &&
+		test $(git ls-files --stage | grep ^160000 | wc -l) -eq 0
+	)
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	git config --file=.gitmodules submodule.example.url git://example.com/init.git
 '
