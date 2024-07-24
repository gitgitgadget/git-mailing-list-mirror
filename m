Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053B15B98E
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832644; cv=none; b=qpX41GR6IfeHv1PsX2NITym3AVBM3g0coPmW57Gl195ES2xT1teyyVfffLGkri9OxTNhDlLqYa7+OAN4oSDzRBSfrSwQFk4dPOA7slyY594xdNSoE5cgxBmXl5/Gh2L17QRQrzPFF+vQ9oZ8Rnve+My5yVQH9S1yhWt+b+ZaeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832644; c=relaxed/simple;
	bh=EIJ4VJ/DET5fUrXx9pArfLB/ubqxqHlZM/EKHzizfKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VARj5rHA7FE98T4tMd3mbDQSex0PXYLO8kmHjnhwtMIG6v1qvdtGOroht75VvwVsg3R42VOECM7Hl2XHVncG0WrYiFlfFeBOY96xjY3YqBH5r/3lMy0H/xrvgFW7hWSo2x2CPW4qO+STFIF0MiGvXg9rMgs4gJ77D3FRNdA9qQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wfq5ZLLJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wfq5ZLLJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1721832639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8a7/4lFL09MDGArufZsv3GfVpnMXCl8SjrOVi5tGmE=;
	b=wfq5ZLLJGwKVoIUPRl+Mp1SZap+G2Zrwnz2kZYF44EpiYHpsssQTjh67JOujz6Q8ztmlG4
	EcExwcwxCsCkao4F8i5QvY/qK36TGpi5WM871nRrq0AYonnuTkh/+nyDYgQJ5cRbHdDUIy
	lLPU2/hxzIcqR9prDIFcys27ZxwTMpg=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 1/3] clone: remove double bundle list clear code
Date: Wed, 24 Jul 2024 16:49:55 +0200
Message-ID: <20240724144957.3033840-2-toon@iotcl.com>
In-Reply-To: <20240724144957.3033840-1-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The bundle list transport->bundles is filled by
transport_get_remote_bundle_uri(). Only when the list is not used, it is
cleared right away by calling clear_bundle_list().

This looks like we leak memory allocated for the list when
transport->bundles *is* used. But in fact, transport->bundles is cleaned
up in transport_disconnect() near the end of cmd_clone().

Remove the double clean up of transport->bundles, and depend solely on
transport_disconnect() to take care of it.

Also add a test case that hits this code, but due to other leaks we
cannot mark it as leak-free.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/clone.c             |  3 ---
 t/t5558-clone-bundle-uri.sh | 28 +++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index af6017d41a..aa507395a0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1419,9 +1419,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			else if (fetch_bundle_list(the_repository,
 						   transport->bundles))
 				warning(_("failed to fetch advertised bundles"));
-		} else {
-			clear_bundle_list(transport->bundles);
-			FREE_AND_NULL(transport->bundles);
 		}
 	}

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index cd05321e17..2d6e690fbe 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1,6 +1,6 @@
 #!/bin/sh

-test_description='test fetching bundles with --bundle-uri'
+test_description='test clone with use of bundle-uri'

 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
@@ -438,6 +438,32 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
 	test_grep ! "clone> want " trace-packet.txt
 '

+test_expect_success 'bundles advertised by the server' '
+	test_when_finished rm -f trace*.txt &&
+	git clone clone-from clone-advertiser &&
+	git -C clone-advertiser config uploadpack.advertiseBundleURIs true &&
+	git -C clone-advertiser config bundle.version 1 &&
+	git -C clone-advertiser config bundle.mode all &&
+	git -C clone-advertiser config bundle.bundle-1.uri "file://$(pwd)/clone-from/bundle-1.bundle" &&
+	git -C clone-advertiser config bundle.bundle-2.uri "file://$(pwd)/clone-from/bundle-2.bundle" &&
+	git -C clone-advertiser config bundle.bundle-3.uri "file://$(pwd)/clone-from/bundle-3.bundle" &&
+	git -C clone-advertiser config bundle.bundle-4.uri "file://$(pwd)/clone-from/bundle-4.bundle" &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
+	git -c transfer.bundleURI=true clone clone-advertiser clone-advertised &&
+	git -C clone-advertised for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/base
+	refs/bundles/left
+	refs/bundles/merge
+	refs/bundles/right
+	EOF
+	test_cmp expect actual &&
+	# We already have all needed commits so no "want" needed.
+	test_grep ! "clone> want " trace-packet.txt
+'
+
 #########################################################################
 # HTTP tests begin here

--
2.45.2
