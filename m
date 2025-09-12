Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B4320381
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695632; cv=none; b=MxUlCNeHfqoBPBSXfX06sCCjbSmx4YH8S1PDX6RVIFGguoH73i6x5IdosF9h7XuWSkVYdNRXB7hjcUuxjSmkeD5+dAMpxNK3z3hNcDwu1okXc1EQTfI8wYSnCRxBePkzUaVWn9lL1YfwdCrtojir2GoiYfbOx0nMFEL0GyflDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695632; c=relaxed/simple;
	bh=cLxjJNSHwx/9BgAo/yJhhq5R+16Rx0Nbp9qbOnLznZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=babh+270cSln4qUE3PrjIVfZ9QrOEsEo2mlfW64osM76Z5+5TC5qv+w1Xa26kN1dfSQgYlYPtNTQ15o44Yn6LyM53w17iuxzPaZcBZjJPA/erst2loTbdbLLx+u6sp0efB9G1ddlCqNky4RrITHYEFxfnvdJAIzJUHzSx2PBnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ew/0JxTQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ew/0JxTQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1757695625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoAyDaR/ezDIbx33tpNTeqe5wfTwZwyaH268Q2WI8NI=;
	b=Ew/0JxTQU5r2tXVRVgGKsRxRlA8rUFy1j4k6/VHRZljXLuKTqjvf93LX0m67/okCuCstPP
	pug/EAhkBlYsZmqnsuBBua3qe5xsXF+2TfFp1vXFKbP3ruBZqfAZd58Ks9GgayrfW9g4M5
	CD84T6VilrCD6fXKiG7Yj4Jp7mnJW9U=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 12 Sep 2025 18:46:32 +0200
Subject: [PATCH 1/2] bundle-uri: ignore bundles without uri
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
In-Reply-To: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Bundle-URI can use the heuristic 'creationToken'. With this heuristic
each bundle should specify a 'creationToken' next to the 'uri'
attribute. But this allows misconfiguration where only a 'creationToken'
and no 'uri' is specified for a bundle . Because Git expects each bundle
to have a 'uri', this causes a segmentation fault.

Harden Git against bundles with missing 'uri' and skip bundles which
miss this attribute.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 bundle-uri.c                |  3 +++
 t/t5558-clone-bundle-uri.sh | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 57cccfc6b8..a1120508bf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -745,6 +745,9 @@ static int fetch_bundle_uri_internal(struct repository *r,
 	int result = 0;
 	struct remote_bundle_info *bcopy;
 
+	if (!bundle->uri)
+		return -1;
+
 	if (depth >= max_bundle_uri_depth) {
 		warning(_("exceeded bundle URI recursion limit (%d)"),
 			max_bundle_uri_depth);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 7a0943bd36..3cf498b950 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -468,6 +468,30 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
 	test_grep ! "clone> want " trace-packet.txt
 '
 
+test_expect_success 'negotiation: bundle list with heuristic but uri missing' '
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		creationToken = 1
+	EOF
+
+	git clone --no-local --single-branch --branch=left --no-tags \
+		--bundle-uri="file://$(pwd)/bundle-list" \
+		clone-from nego-bundle-list-uri-missing &&
+
+	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/heads/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	EOF
+	test_cmp expect actual
+'
+
 #########################################################################
 # HTTP tests begin here
 

-- 
2.51.0

