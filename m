Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88673FFADB
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538972; cv=none; b=h2bc+VUoXWNNF272BqDRaZV9X+omRsrwHIC6JZ5pmhwR0TUidd9YviBILL0HAjO4ZqTK0JpTW/wwvk/4XIMUlyBESQU4lMY92Wb2YxZEKNIaGWC+OTPKR59vm8WkbajNY9MGVjIxzMuehDR1hy0VJCMINTqY9TAkzqMUXtWcb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538972; c=relaxed/simple;
	bh=0M0FRQRT0DrPmsLvWNWXkBOtiGIfajMsLYjdROfKJOQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+WjZor/vwpl2fr2OIFkBGCuID32jWwVsua+NeQscUoxmZLq4QMxJg22pzSI9OPBzHnngDYTMLKh9Zvb5GlrmKLlbOHZp6xruAmklWiF/YBZDtyFizEZCp53mOgsCMtvahXXL0GEP67vuJItjUArifRwfPO1imeU3c+wykgnjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=qZVANTmn; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="qZVANTmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538577;
	bh=1N9hNBbBXwD5JK3shIPoX0Amv6BzHctke1xEepf/o+M=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=qZVANTmnR40Rfa7ZLmBbTPAtWuny7ymmnKYRypbVq5Lw4JJn14u4g3vkhgiw9H4Dj
	 2hauJKdyjf4RHG4X6gCHYYtoiYjQn6bhX0tAohkafnD1vTOIVXP29jGUaQdv9Jc9JK
	 U0I7WtTIZHPuT86vp5E72Q+rzsDur1Do8M8CMia7wzTix8su4meqS+RMlHg1D0lO8M
	 UahPxPpXt7/QPKbrIGv38BFBjmoCN8mbUH4VhMRRirsQE0GDvBT5YkyEhbOCN4jlFY
	 rdROWS5NmUKs1NOm8KGWX1i9F+zsE1DGT3JOYMtHqsbfbf2jMZj82KNQjIrF8JOrjY
	 lmE3aXjjr/rWg==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 3/6] do not discard const: adjust to non-const data types
Date: Thu, 26 Mar 2026 16:22:49 +0100
Message-ID: <8a65ada967b6b1308ea4cffca82102d4de8e9dd9.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use data types (such as string_list's util member) which are not
necessarily "non-const in practice" (such as the list of environment
variables in run-command.c) but are not declared "const". Rather than
duplicating data types (e.g. with a new constr_string_list), discard the
const explicitly for now to quell ISOC23 warnings.
---
 http-push.c   | 2 +-
 run-command.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 9ae6062198..acc7f1d8fa 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1772,7 +1772,7 @@ int cmd_main(int argc, const char **argv)
 			str_end_url_with_slash(arg, &repo->url);
 			repo->path_len = strlen(repo->url);
 			if (path) {
-				repo->path = strchr(path+2, '/');
+				repo->path = (char *) strchr(path+2, '/');
 				if (repo->path)
 					repo->path_len = strlen(repo->path);
 			}
diff --git a/run-command.c b/run-command.c
index 32c290ee6a..1db02ef030 100644
--- a/run-command.c
+++ b/run-command.c
@@ -604,7 +604,7 @@ static void trace_add_env(struct strbuf *dst, const char *const *deltaenv)
 	/* Last one wins, see run-command.c:prep_childenv() for context */
 	for (e = deltaenv; e && *e; e++) {
 		struct strbuf key = STRBUF_INIT;
-		char *equals = strchr(*e, '=');
+		char *equals = (char *) strchr(*e, '=');
 
 		if (equals) {
 			strbuf_add(&key, *e, equals - *e);
-- 
2.53.0.1195.g771ffcb452

