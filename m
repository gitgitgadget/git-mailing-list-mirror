Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AD391E7E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244011; cv=none; b=uRpZzdNU0wTEQJGYWOkmLdUrfehtDe7Qoz4E6oSMZjeGqBQVzTythwmTldur/rC/+ttyCiECDhNnmIiuwb9MnixF6isjAL35SgAGQFAH9qKAR6CTRVFB8WwzZeVUB8Y+FQTEGZrMa7DZAlyv0tEG3ezJIQi4iRNZyDtQgKmAHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244011; c=relaxed/simple;
	bh=Gm9Enj5XhOua+4M2RaMw7J3/CuN0Z1O3htTB9g6rlt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORMxsEnc4JiGP6Y8jK6Aiwyb0T5fPpTkqTUZ+e85K5dl0Gk0TR2o7e68EzLcl8oCwmpuVjwBS9yeiIy3MGyJZNf4hs1mYuE/ccQRNqJ70szkPK/0oRw3zrYQ8b1k/sAQO7vnVel56jAjhytmfIvxn2/RlU3YnzA9YdNHYh1Z7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=gJVLz9DZ; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="gJVLz9DZ"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 0C4CD60273
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244009; bh=Gm9Enj5XhOua+4M2RaMw7J3/CuN0Z1O3htTB9g6rlt4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gJVLz9DZBLC6r1xXwd08gZKM3Ac6vyfR/8AUM8csqYRdJ/XecBH52mxzhYGAM/MFA
	 iQW5Zcm4LodFjD7QlnlvMT99hAGGmsRYuCZMhCmYwN2tgwaYtXdjPPpUTV4PU8UCyU
	 8knyChlK3T+m7fruhNkRPojiP26Bzer/yfBwZO7g=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Subject: [PATCH 3/7] t5510: cleanup remote in followRemoteHEAD dangling ref test
Date: Fri, 12 Jun 2026 01:55:39 -0400
Message-ID: <20260612055947.1499497-4-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612055947.1499497-1-m@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260612055947.1499497-1-m@lfurio.us>
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

