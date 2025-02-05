Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391981FCCFE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738774082; cv=none; b=ToKzfwxrTSMXC+pGkN4o5UmAjHUgSBjglgsMRYh+qn+4vbpbM7ZB8Fx7XIzwjzFb5z+ZqCCIX3wbidpOAQpivFL2vflxdvgWcyIovR92p9bQPorQeqL9tQxQSo7XxWOVw+a8q8dxlYT8t4M0bJp43+Oc2EgwJtRHUsjSGP6R+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738774082; c=relaxed/simple;
	bh=WxC5JRLtG3mnKIGr/yhqPYVJD/jif99bS962f2VCCcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfjfYKn/2adF8EtsbpSTwp93WAmbBu8fVI//1eyB4nWTTZHyIQ2JkBJscvpsGhGhyk56RxlVMiYxXuw5QWS7nFOHfptrj3Ug0enlUfuIvNNuEXCiAORA62nyaQ6lYDnqjWyVU/c7bzol58IQhQ1mSjdguRGhx3yOjlugB5BjoS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WvqwTLK1; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WvqwTLK1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738774078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQuMm0VceDjoTQnImSzjoHHrHcGqYqPtkv28jATe10I=;
	b=WvqwTLK1/zF287K+j940wmpq3CQNJ3NAoucV9PRnVZJj7hwpWqk9ZH0KwOvxsQrWkibGAP
	PVtWrnczgE9JDPmEEZgIcD3ejI5XGE8tCB0eWGodX2sTfuPxA+eNDHKOuV+yMojY1GWGSc
	cOL+PwCcEQxxosDQxhPWwsy2tLlUBa0=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 05 Feb 2025 17:47:21 +0100
Subject: [PATCH v6 6/7] parse-options: introduce
 die_for_incompatible_opt2()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-toon-clone-refs-v6-6-0bbc8e6d89fd@iotcl.com>
References: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
In-Reply-To: <20250205-toon-clone-refs-v6-0-0bbc8e6d89fd@iotcl.com>
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

