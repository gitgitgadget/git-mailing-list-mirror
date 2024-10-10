Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CF1A0BD1
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551589; cv=none; b=fVROG6V60Mn+vs8za5yXQTGIiWUg92m8Hp4Za21bZ4aL6+3zYEjKAPLxGswtE2oWiHI1eDYDN0KjTHlU9WR/0gELVLbDmy+YNlOUSeOKcuW0hlGQW3BGhf6zSe6YAoRwdiaEBBu20Or8IfJwvUlVoZlfcmu3bJibCcSm1vD68O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551589; c=relaxed/simple;
	bh=k7MgnSVzsHMtCmD/2n95TXnfIu5ZfGofNhEaKfXKlHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9dY64QTJFca7/0ALpvmPRyZlMwfhxckuYKYFiyZ6HcEfpNPIFwNrNcmQuDE9s7sjlGkAoC3zdMpifRvX7ZfVmflW8oySUyPCnWVcZdAnOP+lCYntss2a9x2O2itGdhgQTb7v1/yGxkcpF72fIpKDVJBeOtswS8wcHcmy0IQzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=6ethoA5c; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="6ethoA5c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1728551582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiZ767CMiIjRyMEk93O8wzDu+yZet+YG1zC3pQ4P83w=;
	b=6ethoA5c4Ph/rU65g0Z4khtmRhSnQD8yHkXYk/36alQ29+eLeKSIhd5nhJAMv/GsS7uxDC
	vlb/bX0lL3TIGgnlwfPddbi2A1/1ttKb7/uugzK7oLOFRerSp96oPeUakIV89Rc6+07LFo
	rgZdV3dQA4t/1e8uoXiz9pFsdBE1QBo=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2] bundle-uri: plug leak in unbundle_from_file()
Date: Thu, 10 Oct 2024 11:12:49 +0200
Message-ID: <20241010091249.1895960-1-toon@iotcl.com>
In-Reply-To: <20240826083052.1542228-1-toon@iotcl.com>
References: <20240826083052.1542228-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function `unbundle_from_file()` has two memory leaks:

  - We do not release the `struct bundle_header header` when hitting
    errors because we return early without any cleanup.

  - We do not release the `struct strbuf bundle_ref` at all.

Plug these leaks by creating a common exit path where both of these
variables are released.

While at it, refactor the code such that the variable assignments do not
happen inside the conditional statement itself according to our coding
style.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 4b1a2e2937..0df66e2872 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -368,17 +368,23 @@ static int unbundle_from_file(struct repository *r, const char *file)
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
+	if (result) {
+		result = 1;
+		goto cleanup;
+	}
 
 	/*
 	 * Convert all refs/heads/ from the bundle into refs/bundles/
@@ -407,6 +413,8 @@ static int unbundle_from_file(struct repository *r, const char *file)
 				0, UPDATE_REFS_MSG_ON_ERR);
 	}
 
+cleanup:
+	strbuf_release(&bundle_ref);
 	bundle_header_release(&header);
 	return result;
 }

Range-diff against v1:
1:  f30f393e05 ! 1:  19714d860c bundle-uri: plug leak in unbundle_from_file()
    @@ Metadata
      ## Commit message ##
         bundle-uri: plug leak in unbundle_from_file()
     
    -    When the function returns early, the variable bundle_ref is not released
    -    through strbuf_release().
    +    The function `unbundle_from_file()` has two memory leaks:
     
    -    Fix this leak. And while at it, remove assignments in the conditions of
    -    the "if" statements as suggested in the CodingGuidelines.
    +      - We do not release the `struct bundle_header header` when hitting
    +        errors because we return early without any cleanup.
    +
    +      - We do not release the `struct strbuf bundle_ref` at all.
    +
    +    Plug these leaks by creating a common exit path where both of these
    +    variables are released.
    +
    +    While at it, refactor the code such that the variable assignments do not
    +    happen inside the conditional statement itself according to our coding
    +    style.
     
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    @@ bundle-uri.c: static int unbundle_from_file(struct repository *r, const char *fi
     -		return 1;
     +	result = unbundle(r, &header, bundle_fd, NULL,
     +			  VERIFY_BUNDLE_QUIET | (fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0));
    -+	if (result)
    ++	if (result) {
    ++		result = 1;
     +		goto cleanup;
    ++	}
      
      	/*
      	 * Convert all refs/heads/ from the bundle into refs/bundles/
-- 
2.46.0.46.g406f326d27

