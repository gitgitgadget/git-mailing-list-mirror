Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142F3859DA
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232529; cv=none; b=HnW7MOmIXoArXw+zoQb5ydYzfHple6EL/qgfx7cFO3EJMv+6qPxzunukIfLfMr8rNfn4wMGocOobKpSbHXdHiEkfTM0pa9ocJJAhOwXWRz78Iy4o5Mw8IuXI40mQUHlpRKwWW1ZsOGMiGZVn9wNtbvdbQlIBS6Hu4wT9GBWYOOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232529; c=relaxed/simple;
	bh=xcUOpmBNOeVR12CyDRizk6UY9pnQy7st77JFsp3AFio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mmrv0t86iUqkqvCnO3CrIeTN07Et0K+Uu0V5VCYTQbXyty43FJ8+Y0pUM6PEqray9Rckz6sqpli3lQ36Z8YukprvF7NbJhVOnVz/YjRTwcX7mDfii+/RryjylfUrThzulrTIF9X1fouRlCR7TRpcrbMKP5HgF6NkyyQUUtZpTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=gx+LRK1D; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="gx+LRK1D"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772232526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVKliD3+NUdr0VVsXOq+uJTtJ+1LHsExojq+mYznegY=;
	b=gx+LRK1D/qwu8ibXN9Ve5T5Vj4MSkZhcC6ge1kuDPD+QjfelV+AiIFl+rXKx4QU+VJ4jMv
	eIpsPKJg6OiDkVe5GjW2apnjBJsemzug7cwprHRl3aVnqdOSTGJGZMbNqtgwdcsH5iFMga
	LcD0zK7ypC1bPEJo65aR/XnDoBSy+oWBeQJdqa13+UgkI2UUW2Wyfrak2M6FAz4pb17DH5
	GseyFgpHAlmHjhA6x91YEvUya5tzM+gQKmCbxq533dZjipoBvAgEuEA56SEPd59OhAGUX1
	CNd2DibZMMB2c2i1YM5pR+PPz40s2fLBzIS1xSm5pgXttBkrCHTXy4REYtgpDg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5 1/5] pretty.c: add %(count) and %(total) placeholders
Date: Fri, 27 Feb 2026 23:48:11 +0100
Message-ID: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772232373.git.mroik@delayed.space>
In-Reply-To: <cover.1772232373.git.mroik@delayed.space>
References: <cover.1772196510.git.mroik@delayed.space> <cover.1772232373.git.mroik@delayed.space>
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
2.53.0.5.ga216069370

