Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB923612D9
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837945; cv=none; b=OSEZGH9WSS7AAMEUu1JczmynNvqiaxvZecdZQhbSsWxr+9oe+qiMQvndFvu87cgbgM3c3RAgfdCxSjANruXyhgBR246sXWFF++YGm7+WOPxvVYJR12/L8/GvgJ0xUUSNHx63C9Du6xnyt7Zb3EkQDZjNqw3VLw8t6qJfcI0yIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837945; c=relaxed/simple;
	bh=pJakgC/CgZnpBPHQoMMWw9UH9P5e/ByjG8YfgmHs6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1xtWtAxs8wxftgG70n8kaK1FR140r4Eu45vu+h2e8N3GhNbIUby9dxpp2WAG+ee4hh9M54hhVIkiXIqB94RIqDaybM5SDuRRm4AMRjGCc3RVOKlSIqFBgYHLCUdlZ/jLp0tA/zsjcihTvDhM2Pcx5GiQMBFAtpbed9r0xIpGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=m8o5GDXk; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="m8o5GDXk"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772837942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4y1W9mhLo+9QhA4qAsxS+Ui4hF542HjhVZF0SwhCL3A=;
	b=m8o5GDXkqllBdv3qVznF5+DbByzuXyvtJMdzDYUV269xYOOGlUnWBjzeq2/XNm+Cvjjg4g
	6LOZHxCoqQRzB53kUuiHMCmO7URG028nRdNy3qftpIO7RlFzSLLVzmYoSHV/Lee4Wttarn
	zJHzh3SlvDSED8Y+bQpYhG6lxzturEdiu7rbViZfmCuvP1anR9JKTvha6hJKTH2ImMQSPT
	LgOpg+V0DunstBIEQ+C2INIQvUmwfdX2XXGJhLTSSlmwQAET0Xwd4Cniqxmt1A53ccVzAA
	CBwdvfqgF41+NMMiaCLrPYipPl/44Vg17QyjBxpHaq9JOPsoE7EmUiAyX2DIYA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v6 1/5] pretty.c: add %(count) and %(total) placeholders
Date: Fri,  6 Mar 2026 23:58:44 +0100
Message-ID: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772837832.git.mroik@delayed.space>
In-Reply-To: <cover.1772837832.git.mroik@delayed.space>
References: <cover.1772232373.git.mroik@delayed.space> <cover.1772837832.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=mroik@delayed.space; h=from:subject:message-id; bh=pJakgC/CgZnpBPHQoMMWw9UH9P5e/ByjG8YfgmHs6sg=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq1v9BG8k55V1wMWmPVSeKDf/G2xD/MYjn2fQU Z01U4TvMO2JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatb/QAKCRBIeX6hnBm+ 0WNLEAC49G+TKsB9uOM21Ta19AFo1vXpId9oBL0bPd0l4FxxWajcNMoximDBKQShQJCWYIvhnJs hDOpefhNeQwDuBCye265U1iB6gbNEEsawLMcULKFa3CTUEPOG25gmt2+Ckns9Tga5Lcu5R9NRBl X9uCom/FaC2OgVBGMqwdpkty6hKa6oGqiSvi1fybYczJ1TBdStXD4dBJLIhGh0p7tmniDIFlMMW d7L8R1qcFG7rAc78S1neXhdm/VDbm5Nc1aS5Kkls86QwHPZ7rl4tlcE3CQjMNWhIXfPQxGv/o89 WGBYV7ZxZngK/XBFOVtCZEE6VSLM5fVIIfLuzwNmobmZrA3y7fdvSoPfxGehx6sAqdS2JUk3xMD 2YSsm/VDYKp5fsrqeEctWPV9E7AJgFBFRS1T5CvlTlY8oT9IIszyX7xcnwLBh/SIzkxwwMK8jNw twPwqopCgqd9xm8ciy1NxIDRuRc/kTljm4DoAFjUKQZbm7+743eztVfLciq9xl2BceUMvPmeUgC AGNMO1HJozLt91ie4J6TiWMS6bcmy5FBEUlUuMI5mreUn0MJgFdNah6izO3RYSf0jvgyWWZN7Bc j4Digqd9kYEHZfgqBGBTFL1jGx8Ek02ALes8hzaSJakVp1JvmfZ2SFucBn027KvFaVIE6doSBi4 YjTUEd4bt
 sSRmfQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

In many commands we can customize the output through the "--format" or
the "--pretty" options. This patch adds two new placeholders used mainly
when there's a range of commits that we want to show.

Currently these two placeholders are not usable as they're coupled with
the rev_info->nr and rev_info->total fields, fields that are used only
by the format-patch numbered email subjects.

Teach repo_format_commit_message() the %(count) and %(total)
placeholders.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 pretty.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/pretty.c b/pretty.c
index e0646bbc5d..e29bb8b877 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1549,6 +1549,21 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	if (!commit->object.parsed)
 		parse_object(the_repository, &commit->object.oid);
 
+	if (starts_with(placeholder, "(count)")) {
+		if (!c->pretty_ctx->rev)
+			die(_("this format specifier can't be used with this command"));
+		strbuf_addf(sb, "%0*d", decimal_width(c->pretty_ctx->rev->total),
+			    c->pretty_ctx->rev->nr);
+		return 7;
+	}
+
+	if (starts_with(placeholder, "(total)")) {
+		if (!c->pretty_ctx->rev)
+			die(_("this format specifier can't be used with this command"));
+		strbuf_addf(sb, "%d", c->pretty_ctx->rev->total);
+		return 7;
+	}
+
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-- 
2.53.0.5.g1a4ba6dc33

