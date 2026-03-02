Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8F25DB12
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479064; cv=pass; b=U6sdB4FCdx4mM4tJ4eeEoh5KlnDxHj94GTIrllaexB46dkgW8++Kh5zgLE8LFS0hbc6eIL4FajUGyMKSBmsuB/3RZmO1HX0E1SWAD7RXygnADJM8+D+2AHDw5o/i0QtE68Of8mkkdikTGo34aH8DE3QMwwLMxwcuKiOdQ1adP7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479064; c=relaxed/simple;
	bh=upTs16uOvOvkIPI+tlo2RQZAt2rD3Sr0SArU8y1LLmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw7+eMd3bVt4SwAHqrDB8OvmFNOmyG/bY0vcnNdfxUGBbb6tTW9mhw1R1weETsQIOzjLniYF+lHJLfJq9RhVaHVJAd2P/ADvjlFTvNv3xjsOdpDSWSN9m6RjfAmsXQSwO0VaQCKZEL2GA/iEqQoJhLsJ1MoZrN3HXZGZ1E/TmN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kuOR1NFv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kuOR1NFv"
ARC-Seal: i=1; a=rsa-sha256; t=1772479050; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bt8GZENSx9gVzorVq7/SaivAxT44MmMr0SFvQR9r1RcFFJgHRSKDBF0WTll2chGINjj0LjNHJEhbmvca1BM8Azl200CAS1NquJ2PZ4OlH7L2fKiFHGVfWfRiSTI52BFdP+u86asvVxUgGEtfISurFQN5Wy8vUly7ug1XJo7WoVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772479050; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iU7QAlOileT9rgF0t7lSLZs/fT3vSC74Q+68pgo3Hdk=; 
	b=BZaD0MFttBdq7x7uH9DnROiMkUjKmIiYUSe+QwHA1zDmRnqnv590gQMq3DYPCp9SDGzlCrtEfw8N6hmwPLmoUSzOz/M4q+4Av8T61HzcwQS5NnodA2W5FsyD3Pq8rH4/5GjFJmXHjXmeIOcgai3Zk1EqRqBpJmIyn+WhdeXDDFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772479050;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iU7QAlOileT9rgF0t7lSLZs/fT3vSC74Q+68pgo3Hdk=;
	b=kuOR1NFvDNq/JdfWqdBkT9T72DAI0ih3f2XNPyHViuvjqdfpXmi1xgirGHgOYLBx
	Gg4Yf87uUpdRvZ0pXgPX4gg4u0dwM72GXAnUk2wGlg0jifF0AZi1MsHhnA60ZuooIJe
	a+UvnDoJ3sQKbiXWasREdvCiri9MuZSXKogiWzHM=
Received: by mx.zohomail.com with SMTPS id 17724790493441007.5614475619844;
	Mon, 2 Mar 2026 11:17:29 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Jeff King <peff@peff.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/1] builtin/receive-pack: avoid spinning no-op sideband async threads
Date: Mon,  2 Mar 2026 21:17:04 +0200
Message-ID: <20260302191704.1814567-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
References: <20260302191704.1814567-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Exit early if the hooks do not exist, to avoid spinning up/down
sideband async threads which no-op.

It is important to call the hook_exists() API provided by hook.[ch]
because it covers both config-defined hooks and the "traditional"
hooks from the hookdir. find_hook() only covers the hookdir hooks.

The regression happened because the no-op async threads add some
additional overhead which can be measured with the receive-refs test
of the benchmarks suite [1].

Reproduced using:
cd benchmarks/receive-refs && \
./run --revisions /path/to/git \
fc148b146ad41be71a7852c4867f0773cbfe1ff9~,fc148b146ad41be71a7852c4867f0773cbfe1ff9 \
--parameter-list refformat reftable --parameter-list refcount 10000

1: https://gitlab.com/gitlab-org/data-access/git/benchmarks

Fixes: fc148b146ad4 ("receive-pack: convert update hooks to new API")
Reported-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 139a227e71..6376c191c7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -934,6 +934,9 @@ static int run_receive_hook(struct command *commands,
 	int saved_stderr = -1;
 	int ret;
 
+	if (!hook_exists(the_repository, hook_name))
+		return 0;
+
 	/* if there are no valid commands, don't invoke the hook at all. */
 	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
 		iter = iter->next;
@@ -980,6 +983,9 @@ static int run_update_hook(struct command *cmd)
 	int saved_stderr = -1;
 	int code;
 
+	if (!hook_exists(the_repository, "update"))
+		return 0;
+
 	strvec_pushl(&opt.args,
 		     cmd->ref_name,
 		     oid_to_hex(&cmd->old_oid),
@@ -1674,6 +1680,9 @@ static void run_update_post_hook(struct command *commands)
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
 
+	if (!hook_exists(the_repository, "post-update"))
+		return;
+
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-- 
2.52.0.732.gb351b5166d.dirty

