Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87F1E98FF
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076926; cv=none; b=KVAb9dvBd57HoTIOgYucg+A29CGN8TIu2JacSJ3StUEJyiwTZ5EUu45YIaXr//s8/gN4mt0ypDmjN3nX0iQVaTvp9OhcIMFD1JB3wW9UuWrFWkxORyOTonCq4WCEKpTYupLkF8Wr/9czIp/0l2JWHRlHD77DPli0a82do/1tEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076926; c=relaxed/simple;
	bh=zNaNBVHUwsSwfEopeko9DW0ZwjKq6q+ha2wOBhPXul4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rv+2kag3v1HD5f/ZNYKkyFgs33US+urBa2Qk5x+DVfS9Hkq7OJ0NDe4u5ASowwS+PIh4bJAUpO16cq9KWjxh0neo6v0IlXUiSLcAeijX2f1SCOfNLDZadYi4OnpopdfrrHf5fUbpQUzF6Sj7aNoT9mL+kkjUikOXcjgHC4lC2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ZU1XRbNG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ZU1XRbNG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775076923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XY/HploIMnPyqbd1bl71c3V1cbX1z+XQfv5pkNaBXfw=;
	b=ZU1XRbNGRIKe4OmcNVq9uRf8RfplDivLtIjKHoOsVOG0eD/g8DzTgbV69AgvNA3gVIuwp3
	pARDxxVbYLA3QDmKrdklLdd00s4U+E6ciG2ODjnn7L4PXBiJI49QGrTQZnTTDW7WFZ2pZT
	hTI37F+QM0BB4rxZ1T9b/KfVFQM+qd4=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 01 Apr 2026 22:55:10 +0200
Subject: [PATCH v3 1/3] builtin/replay: mark options as not negatable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-toon-replay-arbitrary-ref-v3-1-a0b4fabb34b3@iotcl.com>
References: <20260401-toon-replay-arbitrary-ref-v3-0-a0b4fabb34b3@iotcl.com>
In-Reply-To: <20260401-toon-replay-arbitrary-ref-v3-0-a0b4fabb34b3@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The options '--onto', '--advance', '--revert', and '--ref-action' of
git-replay(1) are not negatable. Mark them as such using
PARSE_OPT_NONEG.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/replay.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index a0879b020f..85aa9fa0a4 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -89,20 +89,24 @@ int cmd_replay(int argc,
 		NULL
 	};
 	struct option replay_options[] = {
-		OPT_STRING(0, "advance", &opts.advance,
-			   N_("branch"),
-			   N_("make replay advance given branch")),
-		OPT_STRING(0, "onto", &opts.onto,
-			   N_("revision"),
-			   N_("replay onto given commit")),
 		OPT_BOOL(0, "contained", &opts.contained,
 			 N_("update all branches that point at commits in <revision-range>")),
-		OPT_STRING(0, "revert", &opts.revert,
-			   N_("branch"),
-			   N_("revert commits onto given branch")),
-		OPT_STRING(0, "ref-action", &ref_action,
-			   N_("mode"),
-			   N_("control ref update behavior (update|print)")),
+		OPT_STRING_F(0, "onto", &opts.onto,
+			     N_("revision"),
+			     N_("replay onto given commit"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "advance", &opts.advance,
+			     N_("branch"),
+			     N_("make replay advance given branch"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "revert", &opts.revert,
+			     N_("branch"),
+			     N_("revert commits onto given branch"),
+			     PARSE_OPT_NONEG),
+		OPT_STRING_F(0, "ref-action", &ref_action,
+			     N_("mode"),
+			     N_("control ref update behavior (update|print)"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 

-- 
2.53.0.310.g728cabbaf7

