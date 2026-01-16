Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C790262FF8
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569811; cv=none; b=M4xSPTKsBvQ087Bzp+3BH43z2001UdF4tPWS1pN05zfdPGUpgbvyfHNzd9MF6+qW9Irr+CJhyv5hmAiWs0FmBCR+2KwHFP+sK7E0zTrpYnCFzeDjOcrIYX0G5gcCcPQqFf8X58T1MQ5XGXgt9cDWic7uDowif/N1YplCoF9RQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569811; c=relaxed/simple;
	bh=glcodk0aesQIvdWGF9+8Lf8vrnGuTTJgJisK7a4OytU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aU1Up/aF6s1+Qw7O3MQJMTia1FYeaBCKEzNkMO7gtJqIPoOVa8ELv2BQ2zvCMACbW8inwuWQCyGTdqniBlvuN25IWu8eWTgB7G/BO5djsg3LEFqDhjWJDB6p/9RwYPwuYw1JRzHuBTtrAf4v5DC+MVDJO1jWHaPCvSJm8xAzUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=OoZ2VB4o; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="OoZ2VB4o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hmBlIK9RBA8J6HlpeqVauAPwJ3n6mjQy+oXiaZoY//w=;
	b=OoZ2VB4olS82BA8FdH/4O3IS5Qfwp/iLuO5dEFo7vUydk4dFJ2ZnyrHWGrSCubjbwsk6om
	mxO12WEh0V4N+34zrQn5YByUdIt0775rqQINiPzvDWr+IGEO3MdIfj8aX13BJ1G1aRHPxT
	i6MQmjGqELZxnfchc0BbQu0xMUwjZvI=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:22:52 +0100
Subject: [PATCH v2 4/5] last-modified: add option '--max-depth' to help
 output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-zzzz-v2-4-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

In previous commit option '--max-depth' was added to the documentation.
To have it also appear in the help output of `git last-modified -h`,
move the handling of '--max-depth' to parse_options() in
builtin/last-modified.c itself.

It enables us to change default behavior in a subsequent commit.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 324363b5ca..842700bc6a 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -56,6 +56,7 @@ struct last_modified {
 	bool recursive;
 	bool show_trees;
 	bool null_termination;
+	int max_depth;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -483,6 +484,12 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 	lm->rev.diffopt.flags.recursive = lm->recursive;
 	lm->rev.diffopt.flags.tree_in_recursive = lm->show_trees;
 
+	if (lm->max_depth >= 0) {
+		lm->rev.diffopt.flags.recursive = 1;
+		lm->rev.diffopt.max_depth = lm->max_depth;
+		lm->rev.diffopt.max_depth_valid = 1;
+	}
+
 	argc = setup_revisions(argc, argv, &lm->rev, NULL);
 	if (argc > 1) {
 		error(_("unknown last-modified argument: %s"), argv[1]);
@@ -521,11 +528,19 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_INTEGER_F(0, "max-depth", &lm.max_depth,
+			N_("maximum tree depth to recurse"), PARSE_OPT_NONEG),
 		OPT_BOOL('z', NULL, &lm.null_termination,
 			N_("lines are separated with NUL character")),
 		OPT_END()
 	};
 
+	/*
+	 * Set the default of a max-depth to "unset". This will change in a
+	 * subsequent commit.
+	 */
+	lm.max_depth = -1;
+
 	argc = parse_options(argc, argv, prefix, last_modified_options,
 			     last_modified_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |

-- 
2.52.0

