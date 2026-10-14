Received: from smtp113.iad3a.emailsrvr.com (smtp113.iad3a.emailsrvr.com [173.203.187.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5981368D5E
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948104; cv=none; b=NxrWQC3Spv56im30KqJVrc4Kf4CBONXfVHVZ+9btR/hNJ9AbO7mwP2C6mAyOVMuQuqt49nv080+MbtbCftM1Wy3982gVHcfDspyTar/Sbh6D3m0Q7S7IwjDiX5VJPNgqnt6VBucyLjePtzZJWGypXE0Mma6nRCfx7TRSHGhSdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948104; c=relaxed/simple;
	bh=ZfqFfBHekeaXkZBqMo8KC/f+82rYXgJ+8Q6JGitw1I4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rASUeWDbgkiQ6/FzslxSJk1BPqK9xt3+1SvxMBC4+URcUDR0rox17Hexy5+MMSrN/DGbIqortqDujY9U/DaazV3TaXPG1dSCbN9Qx4VwkCkG8VD+NW1RWwRoao69AsVDPnYQeQMF5OeQB/4mJXPdytTwVhd4NnIDosGZaetA6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org; spf=pass smtp.mailfrom=jonsimons.org; dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b=DGhP2WQ/; arc=none smtp.client-ip=173.203.187.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jonsimons.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jonsimons.org header.i=@jonsimons.org header.b="DGhP2WQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jonsimons.org;
	s=20200911-u7gnnm7o; t=1791947649;
	bh=ZfqFfBHekeaXkZBqMo8KC/f+82rYXgJ+8Q6JGitw1I4=;
	h=From:To:Subject:Date:From;
	b=DGhP2WQ/2Ky6YKAjfiyRSN6J9uTtAsiKtGVvG3eGl0SaPJtC5y8KvWBwUzI7evwE3
	 7ptT+uDGrPfVNMl92fj5GPnxZ+sYNJbOQi/qX4GZI2sjsFgiUITQB1tPJm8MoqpDEU
	 Xv9lyR4BV+ki7Wg038+s1CDoRFhHB2Mf94lciX0c=
X-Auth-ID: jon@jonsimons.org
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 8A2F9252F7;
	Tue, 13 Oct 2026 23:14:09 -0400 (EDT)
From: Jon Simons <jon@jonsimons.org>
To: git@vger.kernel.org
Cc: Jon Simons <jon@jonsimons.org>
Subject: [PATCH v2 05/12] send-pack: plug leak upon match_push_refs failure
Date: Tue, 13 Oct 2026 23:13:40 -0400
Message-ID: <20261014031347.50433-6-jon@jonsimons.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014031347.50433-1-jon@jonsimons.org>
References: <20261009192953.81794-1-jon@jonsimons.org>
 <20261014031347.50433-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 20ae8d58-78b7-4215-81c6-d8119c94fa7d-6-1

Otherwise memory leak tests will flag the missing finish_connect().

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 builtin/send-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d6cdbae472..4e6a45ba30 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -311,6 +311,9 @@ int cmd_send_pack(int argc,
 	/* match them up */
 	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
 		ret = -1;
+		close(fd[1]);
+		close(fd[0]);
+		finish_connect(conn);
 		goto cleanup;
 	}
 	if (!is_empty_cas(&cas))
-- 
2.55.0

