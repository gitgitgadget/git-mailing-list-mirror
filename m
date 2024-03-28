Received: from mail-108-mta51.mxroute.com (mail-108-mta51.mxroute.com [136.175.108.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3737714
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711599000; cv=none; b=XcH74xUXDsO7RSo8P8NZA0BJn0/eAwUXAID7JE0iwLayXm/YCrbeGodH5PEfDIjzVUZLJWibhXxY2TLIAE/p3s0cLE2fcb+sYXPQ3jZvzIWEGMuX9eQpFnB5HbzHay1qWjWD4ONVuTJvBO34buhNwWaHyOYU0W4x5a5xx2apPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711599000; c=relaxed/simple;
	bh=YfDaXBzjFLMuUxMq7X7Pi75oU75cvnzIrwKn3Ga+Xis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkX8PqkXtxrozdqLKqBWgIeI1U+Jj+QenwaqXmgF79IAqSq3Q6pjeNo9fv+yzcB/n2U0DH0EOObkePxmVpNTSJmETxo+3r3F8xRZM5B8SUtRvb7tHI+EEzhYak6Bs0NS3dRpaS7ni7TS3nEHtmDylNpcFWXU6L4RMaA7/TwufZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me; spf=pass smtp.mailfrom=vkabc.me; dkim=fail (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b=IZUOcpHh reason="signature verification failed"; arc=none smtp.client-ip=136.175.108.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vkabc.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vkabc.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vkabc.me header.i=@vkabc.me header.b="IZUOcpHh"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta51.mxroute.com (ZoneMTA) with ESMTPSA id 18e833b3e060003bea.002
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 04:04:41 +0000
X-Zone-Loop: 9c5c4de066572bdc51c62141e0e4211513d81f35a709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=vkabc.me;
	s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
	From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=GsUyZ5cxtxgnc+KTJhv9BeqxVOxA9l3+deIWmGVt8wU=; b=I
	ZUOcpHhb4RxQXF6+ueE93VAhG/N/OxsLdeDrVqaVaLmbK1+aQdcomXUHGrFjbi+pMhslATN3Xk0VB
	3ZkRI+mSy/YwvLDwAA6LFyrWg5FTxHP0bCcx7Jkgo/yArvT8o7v59xnQcqr5vh5HTMXyDCB+483OG
	1yD49u26q9wNRRRUD8OYKAuPEI5gKdainjNG+KketTUydtsgkQlYhb3uWSkkTViq2o3G1iGGk5PwX
	IGdTAqKu65FR7u3SYb0hv8L4tIqh73922zhDf92mwNRPBItZWa04vqSKqwEWEOXNMkz82zlHl//V4
	2VfeaWUCi4qo8DleF0UeZUJxNEez0VJGg==;
From: vk <g@vkabc.me>
To: git@vger.kernel.org
Cc: ps@pks.im,
	vk <g@vkabc.me>
Subject: [GSoC] [PATCH] builtin/gc: Replace run_command with C function refs_pack_refs
Date: Thu, 28 Mar 2024 12:00:10 +0800
Message-Id: <20240328040010.40230-1-g@vkabc.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: g@vkabc.me

Replace "git pack-refs" with C function refs_pack_refs
for maintenance_task_pack_refs(). C function refs_pack_refs
can be called directly, hence saving an external process.
---
 builtin/gc.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c874b248b..b55c5f5225 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -42,6 +42,8 @@
 #include "setup.h"
 #include "trace2.h"
 
+#include <revision.h>
+
 #define FAILED_RUN "failed to run %s"
 
 static const char * const builtin_gc_usage[] = {
@@ -218,14 +220,29 @@ static int pack_refs_condition(void)
 
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
 {
-	struct child_process cmd = CHILD_PROCESS_INIT;
 
-	cmd.git_cmd = 1;
-	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
-	if (opts->auto_flag)
-		strvec_push(&cmd.args, "--auto");
+	//following coding convention in pack-refs.c
+	int ret;
+
+	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
+	struct string_list included_refs = STRING_LIST_INIT_NODUP;
+
+	//default flag is to prune
+	struct pack_refs_opts pack_refs_opts = {
+		.exclusions = &excludes,
+		.includes = &included_refs,
+		.flags = PACK_REFS_PRUNE,
+	};
+
+
+	//--all flag
+	string_list_append(pack_refs_opts.includes, "*");
+
+	ret = refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
+
+	//same as run_command return since ret is directly returned in cmd_pack_refs
+	return ret;
 
-	return run_command(&cmd);
 }
 
 static int too_many_loose_objects(void)
-- 
2.39.3 (Apple Git-145)

