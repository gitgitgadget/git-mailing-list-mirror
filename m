Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC281382366
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840106; cv=none; b=Xde7LWbsvjXe/mw8CVaCWv4g1q1ARmJ6KPSSRbt8LMlfr/978f4qu4gFEYYr5HBMnS+877pQN3m8UYoVeMzjBvqbmhTXKHlU32GXWESM+T1XEqjb6QBSmQd/hYqiauHzC2pc9BkDbc4MKX3+x0dDcQX2C35FokhTCygH4oxkyBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840106; c=relaxed/simple;
	bh=kkt8COIur+Dmnw95xJKJ0wlhXxKdxg2l9OE7Gvau2kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKtsABgE7V9yOwalZbpYhdn5MHv8wTLeWH+H+abR1wx5XEBdbh6QFYeCzSBbWuwRQbOL/PGe2uRDdcJ2BtikGb7x53nxpXl1Y0nIU53i87vXMk/iB4OL1xLsgVinM9xGluqkUlYot027pKnEqdWTpFg62VTN8OgWT3RkZVNk7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=a3J7ssIk; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="a3J7ssIk"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772840102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnlzTjWfbTi10fzfAg7pl6NUPiGVQPhq0fUMLcZvmXg=;
	b=a3J7ssIkswnqBXzPnC0tdlHgLGNyu3RdI3KldDU5PduJJLAVPMBBIUHJ5z6yxNhF+82VEa
	YlVj46zwuoslKpcfUyfK48jUNYZHMacXn1aLxZdXwIhkk3v/f997B6X4//7e56H5yHqIbk
	VniWQfJ7uyP/sb04rdbCvtWRwRoMUvb5vHju1dBvZ3VX6rPTFJ+FDa9S+trX0/Pji3Nq3i
	Aao/G1UotfAfw6Hm3GVdzi3GJ24Q93nIc1Y5eh07Wf/iG1S7U32S/rnGJXWVwDMEEFZ0H1
	9V5TURKbyYbEALA9CjmE79ii8fO/1iWbbFJtJ6uhy9H63ycbprEoRaq9N+PyjA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v7 1/5] pretty.c: add %(count) and %(total) placeholders
Date: Sat,  7 Mar 2026 00:34:40 +0100
Message-ID: <cfed3bddf66ed2fab1f4da896759de1ba086578f.1772839973.git.mroik@delayed.space>
In-Reply-To: <cover.1772839973.git.mroik@delayed.space>
References: <cover.1772837832.git.mroik@delayed.space> <cover.1772839973.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=mroik@delayed.space; h=from:subject:message-id; bh=kkt8COIur+Dmnw95xJKJ0wlhXxKdxg2l9OE7Gvau2kw=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq2R/ZUMWO0zRb09eZYFzdhswjCa12Co/GLFf9 7lwFYd7Q/WJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatkfwAKCRBIeX6hnBm+ 0RPdD/9T8McCXlPjS+DvTe9nsPLjmRq7DAYDpGp9JKP3p1Xqla4MzcsCUUVv4qY8MgCpctRjiu6 TG80KrRLRuqdRSQpcZoII8B/7beypHOpkh/VqpO7eWsr7kpa91bUpIixcHGpz5PyZ6wg6+ITdSV Cw6BUdadkqaUbGxBofeTmyMAvKwu8diXEhV8NOXky8nDy18PgvEXc3zILYl76nsGjIIVWt+CRtT PVL2L/PbjtjOOg4F2gdtCTp3xBcjwy7ltaXem0npnqe/sQnQkJ4IwqioMVPMIHLAyVY4rca+RIP lA1BDGMnz7vnogNdxwfwiKnVD3/09PBxrz7jO3oD9FozjzpMQONnFhBW1TRqRHYxFfDn7a9sZlU Ppns4ZDDQqaomF34QioEiWaaiS1ItCv05kz/ilxqDW1BrfGoATObhGCpE5Be1CAcg2n1wsonSBJ pyUypYwRnPJmd0afiy3E13FsGvBINnV1bUbETMM3RvRgulpneaZgOhZ8Tr+tu+i09WAFCsL+kYG BdirpttK+MOFocWNVtA3t2MTbWv89pP8xrcm2XY17MkiXHAtn9/K1sqdj8v7oU2VXUY7A8NbDMM 9UVVkNGuIxRu4ITTII4E3piCnP11BcgcJyll4Xtf8eUpvbp5HhL9wWEiVh1XTe4lAdwjSyUxSUE S0yL/7hWk
 nXWkJg==
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
2.53.0.5.gbe7197aef5

