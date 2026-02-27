Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484E221F1C
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198312; cv=none; b=dKv3S3ifgb5yQxTSeYv6Gy7sOFjiH+dSXWMj+EJOomlXc9kLt8CnxJjvbunkZK77gj6Exop8tcgbj5lKBZWb/VfAfZ3DXIL1uElp01cXtRHHif5sLRUit5gCbXdywxaHk/AwD/Loa9O8SlVopLxMII9iyszmjfPkqyMML47EO0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198312; c=relaxed/simple;
	bh=931C2+ITsmMW/lw+w9DvQVnsH0KFVO+EQx5hQaMoMqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggDKwrORsA5y2JqSRLReGSkURuXOfai4gHmb1Euqf60L47AJbfLWDIEfcpzeFRNxQ6cvm5dDKvmTBjySWiUvTH+cPvQ+NGGtyqkAhngDYfktVApEWSlGbyG/kgUto+uFrNn+j4H19kgO8AQwcg+7HE09yKPfNAbBZuNoElTyRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=nR7Nzqjy; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="nR7Nzqjy"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772198309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpHnyh0P7OgWveP6WTMIOi/u7WxLIHXci4tBXhMTEYk=;
	b=nR7NzqjyHHLJT3DWxM8dx1VoGeT9V8fJlYxHXpKO3em2X8lmn7jcNGg1uMQ0DUZ4GBo2Sm
	GKLdCIPa+E6b+F8sXihSinCXkBFNeh6EBhT++4rYM38DIIS98MAxwEbKmV9WXAvteqUidZ
	GAAeTLc7+Vn1m+VQHKazJLv5KXgISJ58VnNBnY3NxpO4x+6gzwVHa/0bWNdlqYDPeMwwz1
	KJ2mqXS7lkCKmankHVnVM5FxuwbqB8NuVDZXVgWEUcSP9EzlRLQCA/ZyJ8TLA10P8PGgp+
	pUptcoXhIdT4E+yaTYXefBe0ahz9HLy7H21DePz7vIvw8gS3v98BejmyGb0txQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 1/4] pretty.c: add %(count) and %(total) placeholders
Date: Fri, 27 Feb 2026 14:18:09 +0100
Message-ID: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772196510.git.mroik@delayed.space>
In-Reply-To: <cover.1772196510.git.mroik@delayed.space>
References: <cover.1772156996.git.mroik@delayed.space> <cover.1772196510.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
2.53.0.4.gf9ee8e2400

