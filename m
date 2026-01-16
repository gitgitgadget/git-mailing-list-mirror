Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC226C384
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569797; cv=none; b=GG1r1uX94aluo7Tr3fGwfXz8dArdQCWtupLKfxkf7gEY2ELYVu8ZdXKWD+gi9y1B2tlfZRJj+p961s4eL+4MD/uoxlmrRJLoc3wCIKchHP6jUfPvuxuFNoCAxSEMWdTH3HW3T80rHTyxOpB/ClnYmHtrXF3IUQSGpDZ6E4Df+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569797; c=relaxed/simple;
	bh=zkbJzaA4P1jXfQO3OtmbO3C+GiPqRwNOPLRPPHRzcs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWwkfi2f5uMOXv175A0Rr1V3CiojsFOnlpwC8G2GAwJ6ro9I233BdClIr/Ic2waUw7pi9Q00vOdO8kPRxSUWzz+o75EG7NK9TkGzOWYkcAVTvk3uUkHCsARTwttcECxgj8+O0yfcdkGSuGyWM59rZ+JMpdoxqj4Ferl6NNn8UI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nIV1CQgH; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nIV1CQgH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrFE0dZuYi4DH4mAksiaPWh5027JGJGthJSSNQkhrSo=;
	b=nIV1CQgHms6hQagbcg2CgV3ErFMYNdUfR1czSTa5YB3XND4bmZLJ+at+h60eoJWTJDtK0/
	t/kbXo2/EnrH1NCtWaqbIJY7T/3iAJUrSu+A4Y4yCr1L+pB3a9KoucsUnJVPsobM3nQZHL
	tCoqEsUgoF+aT9UXr334x1728yWzQm8=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:22:50 +0100
Subject: [PATCH v2 2/5] last-modified: add option '-z' to help output
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-zzzz-v2-2-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The parsing of option '-z' is done by diff_opt_parse(), which is called
by setup_revisions(), and ends up filling in
`struct diff_options::line_termination`. But that field isn't used by
the diff machinery itself, only by builtin/last-modified.c to format
the output.

To have '-z' also appear in the help output of `git last-modified -h`,
move the handling of '-z' to parse_options() in builtin/last-modified.c
itself.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/last-modified.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index cac66d03fd..0d73384e45 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -55,6 +55,7 @@ struct last_modified {
 	struct rev_info rev;
 	bool recursive;
 	bool show_trees;
+	bool null_termination;
 
 	const char **all_paths;
 	size_t all_paths_nr;
@@ -165,10 +166,10 @@ static void last_modified_emit(struct last_modified *lm,
 		putchar('^');
 	printf("%s\t", oid_to_hex(&commit->object.oid));
 
-	if (lm->rev.diffopt.line_termination)
-		write_name_quoted(path, stdout, '\n');
-	else
+	if (lm->null_termination)
 		printf("%s%c", path, '\0');
+	else
+		write_name_quoted(path, stdout, '\n');
 }
 
 static void mark_path(const char *path, const struct object_id *oid,
@@ -520,6 +521,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 			 N_("recurse into subtrees")),
 		OPT_BOOL('t', "show-trees", &lm.show_trees,
 			 N_("show tree entries when recursing into subtrees")),
+		OPT_BOOL('z', NULL, &lm.null_termination,
+			N_("lines are separated with NUL character")),
 		OPT_END()
 	};
 

-- 
2.52.0

