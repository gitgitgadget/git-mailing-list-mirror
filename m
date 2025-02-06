Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E119BBA
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823660; cv=none; b=BAxkUTwrTrQQdrA8VT/ZkGCQCPAiRDIAwibqcDrU9pWuJatHEj+pn9Vu/heWCu5SE88a3t6gJ5ZxHJPpzza2c/REyX1na7MsPynfRf1hA/3UBBLqLq6ipSy3RK8efvMd/oDtgn19mzZ3If1+JmUAVmItWp+OPw5Kdx4p/JSuXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823660; c=relaxed/simple;
	bh=WxC5JRLtG3mnKIGr/yhqPYVJD/jif99bS962f2VCCcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryxkNhlyh2CHL9+oxM5VmIwiJyGbBA/EwXNrQ3ZSNe1J/c/1u4tQCoTnu9xKZwTFP2VyhVu0LQ0+08qheSOvnU18wKtYXiWQUC/anK35yu9U2M6QwRTezVmq//zp+mqK+8Xo1rdTp97ZcvrfbGmu3WH+ddOuu42IFIvk5rX2bdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Oa7zBlfP; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Oa7zBlfP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738823653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQuMm0VceDjoTQnImSzjoHHrHcGqYqPtkv28jATe10I=;
	b=Oa7zBlfP3cmRoiGrf0tqpew//PSV2yocOMLuClSgUz7o6K7lSqsSbeYwGI2KuWiDLNscl7
	8B7YIYZyiU0CTclK+SDyOmpGCu/sqJghFCpNcE2V0vbwRMuf7o8I36cGdpdnpW90MIDf8T
	qhGf0EtgMXAy8wyDC2VNAuYI6BWR1gw=
From: Toon Claes <toon@iotcl.com>
Date: Thu, 06 Feb 2025 07:33:34 +0100
Subject: [PATCH v7 6/7] parse-options: introduce
 die_for_incompatible_opt2()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-toon-clone-refs-v7-6-4622b7392202@iotcl.com>
References: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
In-Reply-To: <20250206-toon-clone-refs-v7-0-4622b7392202@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The functions die_for_incompatible_opt3() and
die_for_incompatible_opt4() already exist to die whenever a user
specifies three or four options respectively that are not compatible.

Introduce die_for_incompatible_opt2() which dies when two options that
are incompatible are set.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/replay.c | 7 ++++---
 parse-options.h  | 9 +++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1afc6d1ee0cb738fa7fa3f2b5c8ce0dd7802e7da..032c172b65ece4e2c3b275ffdde22a54c55a3933 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -163,9 +163,10 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 	get_ref_information(cmd_info, &rinfo);
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
-	if (onto_name && *advance_name)
-		die(_("--onto and --advance are incompatible"));
-	else if (onto_name) {
+
+	die_for_incompatible_opt2(!!onto_name, "--onto",
+				  !!*advance_name, "--advance");
+	if (onto_name) {
 		*onto = peel_committish(onto_name);
 		if (rinfo.positive_refexprs <
 		    strset_get_size(&rinfo.positive_refs))
diff --git a/parse-options.h b/parse-options.h
index 39f088625494f20dea96b9a9cbe986916773bf60..fca944d9a93d643d984c58de2ead9154c8b16c94 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -436,6 +436,15 @@ static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
 				  0, "");
 }
 
+static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
+					     int opt2, const char *opt2_name)
+{
+	die_for_incompatible_opt4(opt1, opt1_name,
+				  opt2, opt2_name,
+				  0, "",
+				  0, "");
+}
+
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"

-- 
2.48.1.447.gc0086e9015

