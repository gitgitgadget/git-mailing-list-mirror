Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF09212D7C
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157184; cv=none; b=Glt1cAlpBcJ652yMrbs/CmyqnbWKIojoeK2Hmm6+yM8bijWPnRuYXKx8J5eMSrY0MM1vLjpFmUEFHJjqEJa/igUfegt38IzD/XYisR6diBK2ZjeQL/1cvA7zE2wwfZZ6oeat5+ptCQRjLBvzoClZaWy/8+tEAIpSunnSU7qMdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157184; c=relaxed/simple;
	bh=bLZgvnafKz/vxPN2JuOU5UauFNma+fldLgi2cTV538s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov51AXkBhZM38kMX0KJvQBMvcWwyFIrJDC4FHEpMrpUwv/qZnJzzHT6sfNgx+yQG5Y1W89eEGh6Y1Ex0wDAqsDxQ/L14FFwdK0GET2dS+piLnyrItxGAwS0ctSrxQgNLG9yxNN1Ed+iC9adrI+qppdsEqdU3yLX9f/UmEQsZjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=G3VSO7UW; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="G3VSO7UW"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772157174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vi5vMcTuslWFzzpIbm/NWZWlGoqWKKI81Ah8ughkmSo=;
	b=G3VSO7UWktfy0X7D57OLnMO3NoN+rGFPY8py5wsTGnoJCWHuO5ekyb2hkgHOSQ8yfzG3Zn
	TKv/b9rD+9R+K/XyEMK5xI1ntKLmeNQyetAKaNNcqrK/HhFY+6L7l52R2Pc4CvHTP86Dxu
	P61iTTNghLPZtUyq89Ph30UhJwo6UfdRFT4pI5R4VDjhuULZTjIJm4Qe/JOiGVyq7DzyrT
	DpAX3CP4cmsEW4VD8rzrsc2l8lvC7m1CTfFkguScV3LQsELNT7aHNbGdgSg8gQP/bTGbJv
	rd1ga6YtmeMDPXWjQ3jW8eMFvTyKVRKcnv/LcgKCbxkG3U5d48/6BRps05l2zg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] pretty.c: add %(count) and %(total) placeholders
Date: Fri, 27 Feb 2026 02:52:36 +0100
Message-ID: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772156996.git.mroik@delayed.space>
In-Reply-To: <cover.1772156996.git.mroik@delayed.space>
References: <cover.1771925291.git.mroik@delayed.space> <cover.1772156996.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=mroik@delayed.space; h=from:subject:message-id; bh=bLZgvnafKz/vxPN2JuOU5UauFNma+fldLgi2cTV538s=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoPiZwZyQvhuKbsT4/f6KluobxygKWp+RRX+KW LAaBTW21dOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaD4mQAKCRBIeX6hnBm+ 0aXaEACD3okN/jCTHIpjAhANfghEJRBNjsXKMYvUAow4gdQPzZTBxRPZ4JYl+t/LUobv2+E8Fx1 kOWKldWEEw2dxMc4svvoIc5qCQVc1+hj5eXA6rQ0d8qFjQzBi/tn+MGTplFz2Oaw0R5yFvOAW0Y 2kKap0xXq0orkUz62hEJFTUh2NI4to+rEKNRifHEwihPJIfwcuDOoqc3/NUm+kxvAPhWF85ES6D DApLDWOthR/JOCGNeu9oA+skbWGlUhyWW3gIOVW7eydExQGxO0+8M5ukXu0PzLMwfBb+PWNlqCK 05tN5vG8A4QWC2C5roPrgiRFlUP98dIXGBcDEYssUfUS5b/V+ViXBmyjYytF6Aic5RmUEgdRWYi vY7B/r8Il+r3b8FccKAhzQRgGo3PjK7GDiW54IiPWGf34PTa25muyqzSn7zjb7mSXJNaorH9ePq 4AgO9oPIHbAKaqRWD1QbdX9+aVBSn9kOoMKvOmNy20yrYNJKjpssXdUYNaVmmgiSjM4+K1T9iZT 17aRSeGMzJezYsmoFGp9mbb0QqGUFTjm4PAlYyM64Z+MZ/FTomf4zpbnMdE0XGjrchmbUzcD4/l NW0jlu6WnF7zNOaC7VMEn4ktnM/EHFA+eQPnzMt6xYF9NUo8j5n50gQY7MU/yc2A0doLxNvLhR9 6/+DxugsI
 sVr4xw==
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
2.53.0.4.g55f3102ead

