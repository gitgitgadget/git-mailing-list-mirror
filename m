Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6E34404B
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862507; cv=none; b=Xb3EciSJSz6iDQeXTA+U1oyt5WZGkqq3K+dJnEwItFhV+JxIYjVvB0DOJGyZYbZwHoPo7JfoYcPvCBx0LTZPqgWaHFO4OOZ0aFWktpKguYt0AKteqSHpF2Sy7PZ+CdmI5hcMSTx+IKYj8N1Z0mAsaGRTthX7YuWjVm1ZZkUz5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862507; c=relaxed/simple;
	bh=Gm9Enj5XhOua+4M2RaMw7J3/CuN0Z1O3htTB9g6rlt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7FDuUFqVyLFOS5rPOTm+Xs4rNlwlPeZ2wRQ7B2fpWr0llr+TsRqqNWrcZ8aYbMhVSDBPzusmvU6v+RFc45gSMFIbkl3+8HMNpzs4QZsy7GYT6BGpvA7wVz4sCD+tFSCVaLPPDn6q/PRz7tu470WMHVrO4HwTks+74bnrSvPveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=f2hKiAxo; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="f2hKiAxo"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id E437F6051C;
	Fri, 19 Jun 2026 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862505; bh=Gm9Enj5XhOua+4M2RaMw7J3/CuN0Z1O3htTB9g6rlt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2hKiAxorKbl5RQ8PJrxb2xOZ5khIvjJ1fPYP+7VCzlSHhutlAeWyQvCQIoxb3W9Q
	 11/AzZQQSRGnZK4kM604WOXAolulmzg0rceUjlHKNOkIjYm4ltEJ69WJxnyMYeBQPR
	 4oY0KGCOxrDdbjCh8PfoTEQnjO1fV/yFaZra4dZ0=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/8] t5510: cleanup remote in followRemoteHEAD dangling ref test
Date: Fri, 19 Jun 2026 05:44:22 -0400
Message-ID: <20260619094751.2996804-4-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later patch will introduce a new test which closely mirrors this one.
Update this test to remove the 'custom-head' remote it creates.
Otherwise, the two tests will conflict with each other, as the second
one to execute will fail to create this remote (which already exists,
thanks to the first test).

Signed-off-by: Matt Hunter <m@lfurio.us>
---
 t/t5510-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index eca9a973b5cb..43190630e714 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -251,6 +251,7 @@ test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 '
 
 test_expect_success 'followRemoteHEAD create does not overwrite dangling symref' '
+	test_when_finished "git -C two remote remove custom-head" &&
 	git -C two remote add -m does-not-exist custom-head ../one &&
 	test_config -C two remote.custom-head.followRemoteHEAD create &&
 	git -C two fetch custom-head &&
-- 
2.54.0

