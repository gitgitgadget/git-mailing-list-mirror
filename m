Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CD376F3
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508942; cv=none; b=hJOv9ORdoHzZ+tEDSMwIjWjazprNdGk8+lhAE8t1DchpBBjf026V5h4YNgZZ2bdAgFMm5G2Nqro2uWLNc4SakuTVL8Ych3ueVre6iPy25xF7yzlkD+0q46CsvK65YPGZpU5D/4qV7pJNRM6Ubnu9BALWggSaUB529daFAtctg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508942; c=relaxed/simple;
	bh=s+N0oZmfAnr/6eQYR0NNBDqkFzG+o9KMb2wCWBXKez8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QOADIS2+keCKBc4Qa0rnalNmsR8PV+j3NGNUG1r+h0zPMTqq9vy3F8IGThkgHbp3ti2X5kSdA87ZNdjvd2ehLcs5fdjlV2o3t6v979RK7RViLd/e7pWVgvVgadvhI4R/95ZXKJPAMVLNF5pzfpFVaCjnhLIHqzjhumRjnyXMPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=tO8aFSxP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="tO8aFSxP"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710508935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2kpVHoh0v7GRLWEM82TSUPDpWHyuzQgrT22rNTeQKI=;
	b=tO8aFSxPVKjLFnMTr/LvhEo0Ix7x1iOFM/p82UUjSHvCHonJ/V5iLoJL6n4ZtEqyEHC2s3
	wTr+LBNaDVrQEk8pXQC5qGJ1XWpXAZXlLN/WAu3xJZ6IRiDm56zqs1mQZlibqeZ2IQy9oL
	/UuZCft7YHJIivfCHHArR7gKHBqNKvp4TbMcYThXnvJP3OPLUGp6St7LGAYHQKAgaaqv8s
	WJw9OvRPQDZXmrctFq9B3bZnpTHMlHXiHrke55KTdw5qMKtYMGNPU5BiLjaxqyvlPwH9nv
	7kpRmwMgCKs7OPaJVkQNxCD12AeCUnrjoKRsugn/poy/xqUVJf60Lzft9Uz3Mg==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de
Subject: [PATCH 2/4] config: really keep value-internal whitespace verbatim
Date: Fri, 15 Mar 2024 14:22:08 +0100
Message-Id: <cd890a7015733e311e0e0a4939c539d2894e31cf.1710508691.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710508691.git.dsimic@manjaro.org>
References: <cover.1710508691.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Fix a bug in function parse_value() that prevented whitespace characters
(i.e. spaces and horizontal tabs) found inside configuration option values
from being parsed and returned in their original form.  The bug caused any
number of consecutive whitespace characters to be wrongly "squashed" into
the same number of space characters.

This bug was introduced back in July 2009, in commit ebdaae372b46 ("config:
Keep inner whitespace verbatim").

Further investigation showed that setting a configuration value, by invoking
git-config(1), converts value-internal horizontal tabs into "\t" escape
sequences, which the buggy value-parsing logic in function parse_value()
didn't "squash" into spaces.  That's why the test included in the ebdaae37
commit passed, which presumably made the bug remain undetected for this long.
On the other hand, value-internal literal horizontal tab characters, found in
a configuration file edited by hand, do get "squashed" by the value-parsing
logic, so the right choice was to fix this bug by making the value-internal
whitespace characters preserved verbatim.

Fixes: ebdaae372b46 ("config: Keep inner whitespace verbatim")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 config.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index a86a20cdf5cb..5072f12e62e4 100644
--- a/config.c
+++ b/config.c
@@ -817,33 +817,38 @@ static int get_next_char(struct config_source *cs)
 
 static char *parse_value(struct config_source *cs)
 {
-	int quote = 0, comment = 0, space = 0;
+	int quote = 0, comment = 0;
+	size_t trim_len = 0;
 
 	strbuf_reset(&cs->value);
 	for (;;) {
 		int c = get_next_char(cs);
 		if (c == '\n') {
 			if (quote) {
 				cs->linenr--;
 				return NULL;
 			}
+			if (trim_len)
+				strbuf_setlen(&cs->value, trim_len);
 			return cs->value.buf;
 		}
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
+			if (!trim_len)
+				trim_len = cs->value.len;
 			if (cs->value.len)
-				space++;
+				strbuf_addch(&cs->value, c);
 			continue;
 		}
 		if (!quote) {
 			if (c == ';' || c == '#') {
 				comment = 1;
 				continue;
 			}
 		}
-		for (; space; space--)
-			strbuf_addch(&cs->value, ' ');
+		if (trim_len)
+			trim_len = 0;
 		if (c == '\\') {
 			c = get_next_char(cs);
 			switch (c) {
