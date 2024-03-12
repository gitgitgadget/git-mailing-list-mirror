Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934E7CF22
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258966; cv=none; b=WmZX6w4mxPDCAuJ1WmifxYWzjfJmDBgOIJqSzyZBG5PNzy7ilis1UAFZbOhF/oXkLQPiLt0mrccP6/pVTItpPEZ3sS8Qvb1A59YuS9cU/nm9R04tNE1f2+i8MDYwcCaSsT8m62jiR+sonQayJxkQ9u+NGtNNM68d2ZO/7S1nDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258966; c=relaxed/simple;
	bh=BvqiMujoQ8kyI3l/ioZkTKxS2Yukkd1T2aY5NqSZfgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sE7Zkl4hg3YPWCT7Y0y2QJgak5P6ipg1c/a/Hk1I1JSsws5cKm1dXuM0OEeMQxei2l+JA+jNU2mxs9DRd1f4SOj6RIABNeA791c8SB7qHk02GNoX5ZEdaITojturbnslWc/2KuBBcuIqJubY+5UNAqOPp6KUTsyK3y7fiyncpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yCP7sig9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yCP7sig9"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710258955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSBYn12Ga7Dmc0uXGe7sYSko6S++U+DD2LwLST2vic0=;
	b=yCP7sig92GEwVIsyRPW4x2fyZv6K/NrchloXWigofAvGrwirEdUFP8Mz+lndtI+WEfLOre
	1H9HkQ/5Y+Vau+ydiXt3OP8h+PBq9s+cfY/TlN8Srya/0LkSaKQrmXQjBbFzNRPUsGwKDs
	kurSCi9TMXJmXuziIF57TIvlEgVUXhN345jv95CpGGHEF1R9G2Slf9mRZJuY3OtaA5mYyT
	AkqT0F2tYANnolBcbPnHTKr3Y9OLCxbGGlG+dXv93+BrA2q4i2qsN7BoKxmmMUZbo37v/H
	Gy/ZGkB9MukJH8qxM7udbKpssmaVveYHZ+OgT6fL0qHSKRbcUQ9LpdXByuviUw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 3/3] t1300: add tests for internal whitespace and inline comments
Date: Tue, 12 Mar 2024 16:55:46 +0100
Message-Id: <292ab942c38de44476c6c5bf045c375bf4f6a70d.1710258538.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710258538.git.dsimic@manjaro.org>
References: <cover.1710258538.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a couple of additional automated tests, to improve the coverage of
configuration file entries whose values contain internal whitespace, or have
an additional inline comment.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 t/t1300-config.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 31c387868708..589af5e81d61 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,26 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+cat > .git/config << EOF
+[section]
+	sparse = big 		 blue
+	annotated = big blue	# to be discarded
+EOF
+
+echo 'big    blue' > expect
+
+test_expect_success 'internal whitespace' '
+	git config --get section.sparse > output &&
+	test_cmp expect output
+'
+
+echo 'big blue' > expect
+
+test_expect_success 'inline comment' '
+	git config --get section.annotated > output &&
+	test_cmp expect output
+'
+
 test_expect_success 'clear default config' '
 	rm -f .git/config
 '
