Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C0221D8F
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704896; cv=none; b=CbWzHhiVl2xfJbByPKGAa/8Pk4tVWUs9oD5sgtf22HtijyxSA5nRoaQ8W8dxeTQstBQNrIMz0qtsvVXMMUy0oKuPGtcyEMdZzs1dIFkGo+qLq+2CT2BWXVdUNZSLXaUmHY2471ImxCsHbpU/5gT7kw56p3/ywOQ3pNBwIZGI05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704896; c=relaxed/simple;
	bh=0i1SVIm8xzvgPJITFVZTq84PTHGkxRUImhbMNRjpNBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tf4uBvIQYXU5O+c6+CtjtW4In3il3JdJ/Y9oFXjxXbFpj/BVwcFTn7bzJjoDzN2uEcZ/XvU06wrNNj4e1xUOW58FnQfalsvEDo7UNhdEttDChN8PrgNh0yg8lC1F2x3iSvG25/tnB0LbB1CK/Wx+76cs2CXwOq/nMHUhymzfmfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=i76TD4ZO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="i76TD4ZO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738704888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8FlAbkS/pPb7ivUlrtEIaxWqVuCpNkqAehcBj3i60M=;
	b=i76TD4ZOzo+N7h5AEXI9Ni0i/16WWk0sdHx+vFs1h9qY/0vTZk2N2aWDzo47qaxnoT+eo/
	2cgz210FvlFGSA+bJEGthA3nSCjhY7s2EGe6pQZbXqTnKpUlE2M4zO1vY9j0wccbn7baSp
	sDC3veVnishTNmKFN0g0UQKwb3HG79s=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 04 Feb 2025 22:34:05 +0100
Subject: [PATCH v5 6/7] parse-options: introduce
 die_for_incompatible_opt2()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-toon-clone-refs-v5-6-37e34af283c8@iotcl.com>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
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
 builtin/replay.c | 3 ++-
 parse-options.h  | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 1afc6d1ee0cb738fa7fa3f2b5c8ce0dd7802e7da..03d93afd77290ab556565f05bd424956b66ff01c 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -164,7 +164,8 @@ static void determine_replay_mode(struct rev_cmdline_info *cmd_info,
 	if (!rinfo.positive_refexprs)
 		die(_("need some commits to replay"));
 	if (onto_name && *advance_name)
-		die(_("--onto and --advance are incompatible"));
+		die_for_incompatible_opt2(!!onto_name, "--onto",
+					  !!*advance_name, "--advance");
 	else if (onto_name) {
 		*onto = peel_committish(onto_name);
 		if (rinfo.positive_refexprs <
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

