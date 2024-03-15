Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F85537FF
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532020; cv=none; b=Cih8ItceMWzRNSIXbkJOAKN2nUxBmsWJmK+0ITKy1KeOZOEzReRy4Q0HZvRCBIW04Y+oeX3yZjpQC3RKJJ6JkGeKcDjxj97x3CS9xs7giXPdkki72DnqN3reNFcbLOw+jwPADaO16h5t9loZF3BVBU1vI8OppkF/gSzxqc52XSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532020; c=relaxed/simple;
	bh=hVe7QVNkf4DGFvFdB40IbSu04RV35tP0eR3k3Wkx0aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIZZDsDNKxw1JNIc//fCd6Lpv572TIN+GBJGvlWGdbMsqeJeyStDSstWkp5e37GpAUl4dUo1c5dUHfhc7F8GGnu/ZYKQw3tSaZb/xoqs1HmpGMNuqFxuXrcMF1l3jiNhs478SVuUnzEspS5jL3v646MzV/LkiYRrl7pvV+/FrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW3-000000002H0-1Aqz
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:55 +0100
Received: from [10.20.10.233] (port=36122 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDW2-006atA-0W;
	Fri, 15 Mar 2024 20:46:54 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id D0EE9180130;
	Fri, 15 Mar 2024 20:46:52 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:52 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 21/22] contrib/coverage-diff: avoid redundant pipelines
Date: Fri, 15 Mar 2024 20:46:18 +0100
Message-ID: <20240315194620.10713-22-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
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

