Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5C2E2657
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434993; cv=none; b=A/pqVqPmUbLnZfCmfEoywgrwy9EowWdwwA2YMfecaGpYwlNd1xKDeG4o6dg86tU+Gzq/BOw0hZ+ajWBe0RVpWHR1s05Xys1fjYd2FJSozQU/OLjKtC3MR/eixczjVc/NwGaNQ2GTQiRlcl3EdlL2J61mVWlirHTSxRVo0nBPg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434993; c=relaxed/simple;
	bh=H3lxZKx3qJrHl9EgR+A1VCbyODy+zPZU7sG6Tn7UP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/CqGUd2rFSGlmde+epcJlUSFUSLBezbOumVkyaN0nZBv6vWHJ5RDb/NqTFTYesev8LnNGXztyLlnuMJ7ZcwZWHJ6vQ6YUzvt5CEDOTvFXfLrEoSCw88gyNLQuiOw+gUZ2N2cFcntZbC8fdCPXw/FPlkTgb2o2RS/dLlzLjb2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=FTwNtiR2; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="FTwNtiR2"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id 8501C89C1B7;
	Fri, 20 Jun 2025 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750434983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ag3m5hINXka+4jkbS18viZMH6c/he/ktBICiXtWfkgE=;
	b=FTwNtiR2DTMxEzc68334Hn9a+7/ZfnsCntl8B9p1UPopDT4WwKzVm3SXdDltCi5soZH5Hh
	yWmIKBMvnmrjhPC3kB7/n1ZH8Q/UCtDRumKdRrgcB1Au+zfOv0r9IrYvgZkKPEcKUjStLL
	cyOSMJ5hPG4Vj47dIPoAshHFL3bRWZ8=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v3 2/2] imap-send: improve error messages with configuration hints
Date: Fri, 20 Jun 2025 17:56:14 +0200
Message-ID: <20250620155614.901816-3-joerg@thalheim.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620155614.901816-1-joerg@thalheim.io>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
 <20250620155614.901816-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

Replace basic error messages with more helpful ones that guide users
on how to resolve configuration issues. When imap.host or imap.folder
are missing, provide the exact git config commands needed to fix the
problem, along with examples of typical values.

Use the advise() API to display hints in a multi-line format with
proper "hint:" prefixes for each line.

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 imap-send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 33690cd66a..b6fa90960f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "advice.h"
 #include "config.h"
 #include "credential.h"
 #include "gettext.h"
@@ -1811,7 +1812,9 @@ int cmd_main(int argc, const char **argv)
 
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no IMAP host specified\n");
+			error(_("no IMAP host specified"));
+			advise(_("set the IMAP host with 'git config imap.host <host>'.\n"
+				 "(e.g., 'git config imap.host imaps://imap.example.com')"));
 			ret = 1;
 			goto out;
 		}
@@ -1831,7 +1834,9 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no IMAP folder specified\n");
+		error(_("no IMAP folder specified"));
+		advise(_("set the target folder with 'git config imap.folder <folder>'.\n"
+			 "(e.g., 'git config imap.folder Drafts')"));
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

