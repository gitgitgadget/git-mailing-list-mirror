Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964C5258
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710647301; cv=none; b=S+pQs13OYSay7UWu/+9FBgyg/R3k+csjC0ncSa3rRDv9G7OM2/GHae89Fy/yakoUUw6ZJ7AeiDs5UcUybLxvh2rSenxXdHLjbxTv2q4QcRHXnzfdsNuAU/hvfocfnAvGQ4Ed2pCBHNv07KLUyrseyCoArF1JWNspk6I8qQDX8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710647301; c=relaxed/simple;
	bh=W7YS4SpRX9uumS3hTpVH83z6p6xZtQZaTvRjpxnegUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3jvImvT74mzaLQ9cZY1vK6wLCJkU0urYgm0IPkd1fWJNlp1MlGnoDeyR15KqsMdcGJi3FwlEX4G3ciwNfsNy6t93cJY257uczeFrKnTFvdmp63TbnD19hPP2YOz/EPsRzkNIuwVhqNYLuCo2sJAe6dsUEK1Sc8qpUpIO3lYN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=h5bw9CIZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="h5bw9CIZ"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710647291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18Kx7ia0dA1ri52R0KNYdzNRxzen3KWEqy50aLs6CLc=;
	b=h5bw9CIZpeVKB57gYE4Za0+zrFe8eQCWuXDeyEz4rGX3NA37UiPCD/h9yZY5rvaPwrrx2u
	iZ9CnuI/E167yZpl7v310wLeJpNna1X0BzBDPiNBshrq9NnxtsfQYu3T87Hx86faph80zF
	dffEpGESgtG6XnxTGcZOv9qCFXAhgUqo3JW/vU/QBdwrsUqp8kSa5vFPa4QhnW85RiGmb+
	D9IBh1TgdRfXVgdR4ylUDOCcnJyot+CPMt7SZ8LrQuJelADnPoS5wc28Yh26ytRehmjDj6
	ZLbD01/bZVBBzRg8MimhyiFBKSo7YOgiK1+pFqFwgYGw4AcrAYX/tu7NM5znQw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v2 2/5] config: really keep value-internal whitespace verbatim
Date: Sun, 17 Mar 2024 04:48:02 +0100
Message-Id: <f4706cb73cd88139fda8bb09950d98d62f013e61.1710646998.git.dsimic@manjaro.org>
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

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
        - Dropped the "Fixes" tag, as explained and requested by Junio, [1]
          because having such tags actually doesn't help us in the long run
        - No changes to the source code were introduced
    
    [1] https://lore.kernel.org/git/xmqq4jd7qtg6.fsf@gitster.g/

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
