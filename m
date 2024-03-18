Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735F59B76
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800671; cv=none; b=Elb6yXW+0c2a9baOm9hzU3RiXPGGOMNdUh7dONxo17Sh7jPTfP3hbwCA80N8yy0HAld9O1pJzGRIYVs0g2dS6Lvmy5DxAvkwCh3bQIWq7+KemmW/tCCNN6/2tT6B2t7NqxYYzJKpyH4MmDQ5RcmCO/P2/Khe8y4D/lbuv1zDkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800671; c=relaxed/simple;
	bh=ckjCVy3ISLIaBVawakDXd1wzmNNYm8lGA748VpHB3gQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kn8cGMlIHrWFiQ7KCbcm9N79jbXcDSHQn0SkidunnZeFcl9LV6Nnq3bXr8/QSrTQ+9JtBJmMU7jWBGzepcc/MEXysbaEqCNjOa2NAo/MUmSeXN1P+S7U5/46KQCW35XDgmSQBfvCteY4KqhF6MqCO3MaqR5eGI2CBb4qLFjm4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=vMkFRrdF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="vMkFRrdF"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710800667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ii4zjY85vR7uiNmoNN4GCwMnRz2jh8kLQLlRDVmc+F0=;
	b=vMkFRrdFJ2bD+UzUvq2Lhr3Ii0iEe/YWpDvoV2deYK8DzzCylcB1Sqwar8MTTav84GyZC7
	OX07ZByFY/IBPwtlIi/Tp6SmNDkE4JYmOhyMTxf7qI4qls3GVlIMjLPnW39zl7kLC+8daA
	YnpnV3mJBkMkf3xk1hl1s5Jtc93dysmYTYDzRHRqVjxfZqORqDhw+NjmOcFd12KIOIH4UF
	8ufSoaBl4JKMoFi/TAt6WuADcKo05IBjewBErcla7vinmP77GjKq09PnYjatIePrhfg9m8
	53zTOde+UdN94IjwzsEbIar3omwqm0PUytBRSc3U4suF2S63Vzd1Po0kJDFe6g==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v3 2/4] config: really keep value-internal whitespace verbatim
Date: Mon, 18 Mar 2024 23:24:20 +0100
Message-Id: <4a5fca5c701d59f123d7b1c8dd20f8b3b2e4d982.1710800549.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710800549.git.dsimic@manjaro.org>
References: <cover.1710800549.git.dsimic@manjaro.org>
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
    Changes in v3:
        - No changes were introduced
    
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
