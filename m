Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF15F84F
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647842; cv=none; b=VOMsbdAda+QTdbqxxpAAl61B2dZkCD7axBO/WHzfy8sisd5pSJ+m9qJkKa7Zc+Gzf08RDoCP/dC6dYGo+FT6VBy6XsFrTf8YrSmry6i9l0LWs4fbfMlJx6y7wuA9bZy11Je1cTxhwIk8AG/VbkjpUIUPLJLSsJjdWHSZPItYeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647842; c=relaxed/simple;
	bh=rQ38/Sm7AATcS5WXKu8oNgyvRa21PhPOmgk69Ccxl80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryqUMWA/OzfoXYgj24XkU5sz5uxDY7XSqbQagcCqGK6U3kQiDwxMa12FzymVxG0ENhAraMxZWp9qio7vQ9VW2Bm+bH+XsfeUKnjMcgzmMBepxiRZXB+ppW9ltkO2sCzjdGJqHen2zNPmVtPbR3YfY1rJLIrFiwnSo2kckHPoOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1s2UEB-0000000025j-2Ird
	for git@vger.kernel.org;
	Thu, 02 May 2024 13:03:52 +0200
Received: from [10.20.10.232] (port=36798 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1s2UEA-00EbDo-1M;
	Thu, 02 May 2024 13:03:50 +0200
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 20E62180088;
	Thu,  2 May 2024 13:03:49 +0200 (CEST)
Received: by minibeat.bolli (sSMTP sendmail emulation); Thu, 02 May 2024 13:03:49 +0200
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 2/3] t/t4026-color: add test coverage for invalid RGB colors
Date: Thu,  2 May 2024 13:03:30 +0200
Message-ID: <20240502110331.6347-3-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502110331.6347-1-dev+git@drbeat.li>
References: <20240502110331.6347-1-dev+git@drbeat.li>
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

Make sure that the RGB color parser rejects invalid characters and
invalid lengths.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t4026-color.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 37622451fc23..c41138031989 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -140,6 +140,24 @@ test_expect_success 'extra character after attribute' '
 	invalid_color "dimX"
 '
 
+test_expect_success 'non-hex character in RGB color' '
+	invalid_color "#x23456" &&
+	invalid_color "#1x3456" &&
+	invalid_color "#12x456" &&
+	invalid_color "#123x56" &&
+	invalid_color "#1234x6" &&
+	invalid_color "#12345x"
+'
+
+test_expect_success 'wrong number of letters in RGB color' '
+	invalid_color "#1" &&
+	invalid_color "#23" &&
+	invalid_color "#456" &&
+	invalid_color "#789a" &&
+	invalid_color "#bcdef" &&
+	invalid_color "#1234567"
+'
+
 test_expect_success 'unknown color slots are ignored (diff)' '
 	git config color.diff.nosuchslotwilleverbedefined white &&
 	git diff --color
-- 
2.44.0

