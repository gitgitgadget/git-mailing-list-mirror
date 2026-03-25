Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C13E716C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454407; cv=none; b=i0874KBGLb6oDnH102xUBPxOgrQUFSsiURIqWPRopQhAHn7785ovFue9R1eDQsF5GYaWcKsoY5FoPbGje2x2QDS7nGOpaKYSX3JaqKuwHh+4TaS/+/+quwRBLJxyK6vpUX0+0lYuEYiksCrz0t6kxVLd/dpRywNpMiGubHla3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454407; c=relaxed/simple;
	bh=YflwV/RH7R+Gfx/WsmUfXlE95jbRlBuaCHZjjQhCrGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7KbvM8ntUYWzd1xmczzOwgYpT1piuc7moZ/zMBT48OZ3QHN7dmtO+anUryyEWL2KwuuOEVHQzxQD6DpRcpZYXZur5njnN6wwk02FJsA2TouZ9iqZ7v4s13Zqxz60Dv+ZqQBoOOX4WYyOon1+NKz+a7dAwtGfhveEFM8SMej2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QwalAAPn; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QwalAAPn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774454404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SLgyv3cW1LAZzTf+yZ58i/lCbGmNC/Ywhswm+LfB/U=;
	b=QwalAAPnfuryUmjs4VPrGu621C1tHTXUzvyFvFM9/x8VbC4lsxG/RdwpWuxhgHe899jh+r
	hsd8ylE4RbmXRMMJ2ZTODhglhYjo6ZJW6WPyuXVtcby1sGUim7fcbYwawA6q8GeN2ccyvL
	FIQB6UW6OmkPywLi/C5VkMhxhpzI5sM=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 25 Mar 2026 16:59:29 +0100
Subject: [PATCH v2 1/3] builtin/replay: mark options as not negatable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-toon-replay-arbitrary-ref-v2-1-553038702c9c@iotcl.com>
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
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
index fe69f6f8ce..1a04f33390 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -88,20 +88,24 @@ int cmd_replay(int argc,
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

