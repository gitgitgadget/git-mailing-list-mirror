Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7A374C2
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001176; cv=none; b=Y06j6VU/NpFJYC4ATbYqdRO1ENDQ5Cq6rud6mljKWmQlsiv6tj06OCUmpNCZ4nUUMTivdrTB5poUhoC2nleuv38nz95iuinDTad7CVJVs7QFEWaVOE7ke+vlUmkCUYssZg2RgzU3hvKQpWAP/CI+0UakjCcPJjKXJ5nSiEnEwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001176; c=relaxed/simple;
	bh=m3bP3NxHpn3E8B4qXWIIpWpoj82k8351tM7ntD4Co9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8UZCN0yor9jiLqbZ6UmHoF3NWTCEU+YadhMEfUE4yzrNjBrFJ+CT2e11WeBcms1Fsu+QeveaikMJlor0bY6yg29ic15X7EPV1/w2xNFWa0tMFQhZKu9zIGSLQLjvquGSIAE+/BSVLhzPD8XqU76gNRVoRedDBtmIfBaaHIfQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z8Din6sw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z8Din6sw"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711001172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqHDX8FvpsHnslgD+qNo1LXSZbs4TlLjOy76Y5P/aKE=;
	b=Z8Din6swTpq0YnoJs3fXwIazDziJNS/GKdOerwo/FN7HOwSkkRNUWOliYBLlG3fqXA1muq
	hyGm5kcM0vzpXBTNwP5/JKPndgHgcdKPJxadAo3dtWWMcQcVcTyM6ktARErbxIN1mkTH/X
	CdRvrQprdVbS+uuHapx+MJfrFKl7ps8PqYUYoFp02fJZ9mU2cyGkmXmw7Z1gHYl/GWNPKA
	W6hfrS2zugw6hmJd/FCkaEqMaXSWLeGzSPba2HZZQ2KGWPJEhoV/kVGxCVYM8fqL4RNGU8
	zi33L4fNqqmRHl113zFwGzjmmvN7eou9t+lc+dTJUOYhNTSkGGLJ4ntkBDx96Q==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	rsbecker@nexbridge.com,
	github@seichter.de,
	sunshine@sunshineco.com
Subject: [PATCH v5 2/4] config: really keep value-internal whitespace verbatim
Date: Thu, 21 Mar 2024 07:06:06 +0100
Message-Id: <36393da367dc6af7e4f045c4804309cb8cb04378.1711001016.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711001016.git.dsimic@manjaro.org>
References: <cover.1711001016.git.dsimic@manjaro.org>
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
    Changes in v5:
        - No changes were introduced
    
    Changes in v4:
        - No changes were introduced
    
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
