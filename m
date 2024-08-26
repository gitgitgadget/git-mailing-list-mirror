Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8113C9A7
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661140; cv=none; b=jZa31DJmO3yT20wP2kzpYVWU3A8FcZGiDVNaVDQYCo6KvcZma/b4Qvb5GibJVp7dGiaYQjLXfsvRnUhjI7xLUfNzNsX7XKr2aowUcMY1bHwkwjWU33rTgVphvrjTmASFxZFtKxmZHDatr+TB4NPwGQxAIGSUujnMY01F1KPWmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661140; c=relaxed/simple;
	bh=sdbj6Xjqzg65pmPc3ky0WcAAyQ2Y7cz8JaXzB6VYwew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dt2O3N4CUAHmDOdUCuJ7tUBv3HWz6La35CCp1O1kG/V3IVJid9pm0YdjS3tK7lh7GAZEV9mAWNIGtnWrQDrrtkeBjD7Pa/IAELTHpQjN7lLjfAdKNXpMUWaBjTNlD8uTw1tQbsjiJHXPhu9U6VoZ9cF8HDwtRSR/8RuTdHTKxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3aqBI5Qa; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3aqBI5Qa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1724661132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5Px0VYkpToOe04qdH9xaOpi11EXvtYKrKG+1LuCBfk=;
	b=3aqBI5QaS9+a7EhSL+3PVhxK1xi0dFvRkQtnLED1N6+tEmmipc2nxaC/ijIjpISCMerepx
	4iZAOcNiaLz4iHkCCpG8uyRpN3suv4iB1qQwSOqyAmGLzvNV6PBIkoVXZyaSD28LxVjhwV
	dgJBNrqiVcKrZHP5XQIjW2dtWKcloN8=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH] bundle-uri: plug leak in unbundle_from_file()
Date: Mon, 26 Aug 2024 10:30:52 +0200
Message-ID: <20240826083052.1542228-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When the function returns early, the variable bundle_ref is not released
through strbuf_release().

Fix this leak. And while at it, remove assignments in the conditions of
the "if" statements as suggested in the CodingGuidelines.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 1e0ee156ba..eb49cba182 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -367,17 +367,21 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	struct strbuf bundle_ref = STRBUF_INIT;
 	size_t bundle_prefix_len;

-	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
-		return 1;
+	bundle_fd = read_bundle_header(file, &header);
+	if (bundle_fd < 0) {
+		result = 1;
+		goto cleanup;
+	}

 	/*
 	 * Skip the reachability walk here, since we will be adding
 	 * a reachable ref pointing to the new tips, which will reach
 	 * the prerequisite commits.
 	 */
-	if ((result = unbundle(r, &header, bundle_fd, NULL,
-			       VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0))))
-		return 1;
+	result = unbundle(r, &header, bundle_fd, NULL,
+			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
+	if (result)
+		goto cleanup;

 	/*
 	 * Convert all refs/heads/ from the bundle into refs/bundles/
@@ -406,6 +410,8 @@ static int unbundle_from_file(struct repository *r, const char *file)
 				0, UPDATE_REFS_MSG_ON_ERR);
 	}

+cleanup:
+	strbuf_release(&bundle_ref);
 	bundle_header_release(&header);
 	return result;
 }
--
2.46.0
