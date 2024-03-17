Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961A524A
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647302; cv=none; b=jpubGagtJ5ZZvn5hsOPK2mFXa9wzKgg9wLKV4JFBQJhbWKy+GrekfsH959CLMv8Kph7iVptivGmKjR2I0K4fAR2p+q+vEj0HHxpUuJpfjyINm6TbTZc7tK7P8zaibhqqNHGjTNJPCcYpOb29VhF6NZvBgVZ6QfMTWWaey0Hx5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647302; c=relaxed/simple;
	bh=akpAulV3PCDGqkBRqbxqCpnOrddwv0AxTcd97t4/tQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M20SHS0MPXrtCVWqag9+wa36mzX015PdCgA4PS4KwtmEhO0hzXgg8SOJBkCBrKS7FzqreixzgVek9mQMw00Fbi4YM87qi56PGVslQN3E/o5o7SSimygI8viFwB1wGqajjEMdcGrBjvNwSUXqyVjDMxoawC5K6AmLnI3SFa3lnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=haDdhHDS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="haDdhHDS"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RWjqsACRHdbiKwEMfRlL+XmBJOHm7l7pfVJruBv3Uk=;
	b=haDdhHDSSwBM7syQ7K+4n2fahM2Q2Pqz4vF3oaLCNwu5Ok19thWrOET9Ss7ou54+x3YRPR
	uSDI/izTq6N2ZuuKTxfiT/S95afbiwDuQWzE9HaKO96FXlWevZceo0tCdPfSPJZLjGpKSU
	VXgZRRtMqar/68/MggfyYlyaa4mSu6PF4TccewA7zB82aSi3WjnwZchlUxshDggvoTwTsO
	7XVvJ8ep/77e5FvWkI6mwtZS9e+ZG4Jr8v1IkUS64W4LRV/B6fnyl08rJAU39pfWse7gz6
	5jJlnhf1mfvE5DwY/+aqeLP8LXYG7tYaeXfEsXYBriN66fFdkidy6OCtIW6udw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 3/5] test: introduce new x_to_tab() helper function
Date: Sun, 17 Mar 2024 04:48:03 +0100
Message-Id: <480b46f2db82ea9c6cd9bbc2423923f81f2d36f5.1710646998.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710646998.git.dsimic@manjaro.org>
References: <cover.1710646998.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

There's nothing wrong with the already existing q_to_tab() function, except
when it's used on strings that contain uppercase letter "Q" in its literal
meaning, which, for example, can happen with git configurations that contain
"*.*Quoted" as the names of their configuration variables.

Thus, let's introduce new x_to_tab() helper function that does pretty much
the same job as the already existing q_to_tab() helper function, except for
replacing "X" with a horizontal tab (HT), instead of replacing "Q".

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    This patch didn't exist in the v1 of this patch series.

 t/test-lib-functions.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6eaf116346be..362d3205b7b0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -107,6 +107,10 @@ q_to_tab () {
 	tr Q '\011'
 }
 
+x_to_tab () {
+	tr X '\011'
+}
+
 qz_to_tab_space () {
 	tr QZ '\011\040'
 }
