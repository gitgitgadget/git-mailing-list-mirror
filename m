Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA212CD9A
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674013; cv=none; b=cCuud0sL1EhnYsJVepjujEFSKpfVTP6WeoxJ2QjCMmmi15SdfyGtWYeIl2UU0dFH2CLi8K23vZuvVSdljA+GqWSZD3ov5rJvBKf8M5Nu0AxCIxwgoUAd4exgzD/+uMp6jKSzeCAp2nODWVL4eMnBAUMZl1J4KYbFzti6KYPYwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674013; c=relaxed/simple;
	bh=hVe7QVNkf4DGFvFdB40IbSu04RV35tP0eR3k3Wkx0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSqRcYcdXh+qM8ssIny/CeqnGxT6xVIXyYILeWbYuGNT8Cp42nzfqF2zTdpZykVFVZXOkIViKnt+55hc3dsSfKrvI7NLJWwsMjV8haKqQYyYbUU/fElarO0XesSsBQR2v7f0u9o0V9oOmTK9RFuLwwEXvFnKtuksba4o2a5Bz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJF-000000002Up-20tD
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:50 +0100
Received: from [10.20.10.233] (port=57810 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJE-006Kjg-1B;
	Tue, 05 Mar 2024 22:26:48 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 16351180036;
	Tue,  5 Mar 2024 22:26:47 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:47 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 21/22] contrib/coverage-diff: avoid redundant pipelines
Date: Tue,  5 Mar 2024 22:25:20 +0100
Message-ID: <20240305212533.12947-22-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Merge multiple sed and "grep | awk" invocations, finally use "sort -u"
instead of "sort | uniq".

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/coverage-diff.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
index 4ec419f90048..6ce9603568ef 100755
--- a/contrib/coverage-diff.sh
+++ b/contrib/coverage-diff.sh
@@ -74,8 +74,7 @@ do
 	sort >uncovered_lines.txt
 
 	comm -12 uncovered_lines.txt new_lines.txt |
-	sed -e 's/$/\)/' |
-	sed -e 's/^/ /' >uncovered_new_lines.txt
+	sed -e 's/$/\)/' -e 's/^/ /' >uncovered_new_lines.txt
 
 	grep -q '[^[:space:]]' <uncovered_new_lines.txt &&
 	echo $file >>coverage-data.txt &&
@@ -91,11 +90,7 @@ cat coverage-data.txt
 
 echo "Commits introducing uncovered code:"
 
-commit_list=$(cat coverage-data.txt |
-	grep -E '^[0-9a-f]{7,} ' |
-	awk '{print $1;}' |
-	sort |
-	uniq)
+commit_list=$(awk '/^[0-9a-f]{7,}/ { print $1 }' coverage-data.txt | sort -u)
 
 (
 	for commit in $commit_list
-- 
2.44.0

