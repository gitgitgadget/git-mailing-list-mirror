Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF562188735
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773623759; cv=none; b=CO+5Z61ideyc1XKWqO78jQxCxi0lErM0nFxy/VuF6IOZn0ih/h1KiH2jvQ1qXP/5tURU+ew8l6/KzJW/MuxwqFlUpIhSAkyXpBdqblIUHFnpUFJ7+0glYf8EptaJpKYBi0cZVnqynoEE7tno3JhX/IcusDlaUk1ZV/s8jxoJ0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773623759; c=relaxed/simple;
	bh=vwccwxMMGLMnsG2qnOAEiNeFzejxrtsMtXx5otEWrW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR5zz6S0BNd6vTjZqYsm1Iz5cLXq5X4ECBHNZYNScukUf+p0mUSnAqyVeUNBU73TvAXVXpeLEJ7zlvah9Ti+CAz5GqGlO+MeccSZCWKlcmfY9cLKzDFDooDKf55HHa33p0ZDJVpSRoqhJ1UJcfyTs8VhGJIT3m7RM9Vr2o8TtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=SrESgdX5; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="SrESgdX5"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773623755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnvKcApSHCrub1G7Q6DwLbD1X0p8XeO4jDec+EvAwe8=;
	b=SrESgdX5oSWEAdm7R+yS4/ImpgoRsFg78kgQV5MpuKTdEtXp36YaItp9+1RXVfmPYkgG6g
	wZA0kArBR51h5EtwHS/AaBrnMt8XP0gi9YSyV7VPgLn8R5VZ0eNBT4UzHOMithjH55zkDV
	gxbfHIFoePkTzkQGb5jYtmIC/hIX39hScKlyCHpCVfhHKGp9MZMLKF/jTQyVMkxxE+qf58
	7zvLCEkE6bnuldpWn/04gZPnffg37PS9IyHc2wZssBqGW2vhtFTJctYbAxko+Kd+8ax1CH
	pPvZ3kL0oOiyusNvQjRsawQAiD+hlvqjOg+Tt0N0dzxhEEII1ZoMymcR7uOlCw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t0008: improve test cleanup to fix failing test
Date: Mon, 16 Mar 2026 02:15:42 +0100
Message-ID: <20260316011544.13825-1-mroik@delayed.space>
In-Reply-To: <20260315034851.2261530-1-mroik@delayed.space>
References: <20260315034851.2261530-1-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

The "large exclude file ignored in tree" test fails. This is due to an
additional warning message that is generated in the test. "warning:
unable to access 'subdir/.gitignore': Too many levels of symbolic
links", the extra warning that is not supposed to be there, happens
because of some leftover files left by previous tests.

To fix this we improve cleanup on "symlinks not respected in-tree", and
because the tests in t0008 in general have poor cleanup, at the start of
"large exclude file ignored in tree" we search for any leftover
.gitignore and remove them before starting the test.

Improve post-test cleanup and add pre-test cleanup to make sure that we
have a workable environment for the test.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
Sorry again for the poorly written commit message in the previous patch.

 t/t0008-ignores.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index db8bde280e..e716b5cdfa 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -946,7 +946,7 @@ test_expect_success SYMLINKS 'symlinks respected in info/exclude' '
 '
 
 test_expect_success SYMLINKS 'symlinks not respected in-tree' '
-	test_when_finished "rm .gitignore" &&
+	test_when_finished "rm -rf subdir .gitignore err actual" &&
 	ln -s ignore .gitignore &&
 	mkdir subdir &&
 	ln -s ignore subdir/.gitignore &&
@@ -957,6 +957,7 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
 
 test_expect_success EXPENSIVE 'large exclude file ignored in tree' '
 	test_when_finished "rm .gitignore" &&
+	find . -name .gitignore -exec rm "{}" ";" &&
 	dd if=/dev/zero of=.gitignore bs=101M count=1 &&
 	git ls-files -o --exclude-standard 2>err &&
 	echo "warning: ignoring excessively large pattern file: .gitignore" >expect &&
-- 
2.53.0.959.g497ff81fa9

