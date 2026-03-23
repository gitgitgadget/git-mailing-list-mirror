Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71623C5532
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285083; cv=none; b=gIo2/x5BQzBdrYkdxFQ8Vw4PhNxBXtkiMDqJ564UHj8BybGsBmEutHoBiMX/0TjBrrt8QZ8IhnWfRNtHQmQPMijSgqCl+d00Gi4g83x3y+x8i4o6IrcdkQWcmY12q5JWds8e88JVV8vvi35rC0FyeX23hrYNnCWHwWiLwHZmfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285083; c=relaxed/simple;
	bh=8KnXIpNbe2XSjaQs4foFTFB+EuZzIYAelRxhBDjTE6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD7TZKddS9Mo4JcdWpGxnWFmyoAKDDRvtkJJ7Yqo93aRHEFOgOnmZcdEocO+fJw4ykrGg9LS8v/L6VK+OVsILt6ypFz75bSgo/9cALMiZgxuobiLbendTFRVd7ettXFDEsY8OmLdy+zlMbNgtKw8jLfAECQJwI/YtZ+F9bE5Lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=RcvZoE+x; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="RcvZoE+x"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpN32g6+1hIH2c+GIWL2+TIH+Ggo5xObpDEE6o0hTk8=;
	b=RcvZoE+xewHc7ECTX8rkxhM9hC0gA0YMeEmiST6eAR9svCii4kcVTpUBWmsL2Z7eVZr2O3
	i1BWoZogbKQFgiUTuwKcBWSMGN1ihyC3QafPb4V8EUa03jYBYdoCa3EM1JcrBx9jehkwWH
	WB013Q6ns/0ODUpZd5Zi0l4j6d6JaAi2uv3Blt5qNa2TbZUKYzoDHmkLQ+nNR4/cZ+eSt2
	ERZgNzL/IXEismEAUG52jvNaIGv3wiOFehh2z4v4wRtvhnz30f8sEJcJBp7LinsqluqYuK
	Cejh8fXePY1VbvDRT8xCGMsTKrQYzmj7CCCnLHilLeoVkqZWqms29zlSHZarww==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 6/8] format-patch: wrap generate_commit_list_cover()
Date: Mon, 23 Mar 2026 17:57:33 +0100
Message-ID: <c722fc9d0fd9af25d7c151079a778299f8ea7054.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1774284699.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space> <cover.1774284699.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=mroik@delayed.space; h=from:subject:message-id; bh=8KnXIpNbe2XSjaQs4foFTFB+EuZzIYAelRxhBDjTE6I=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXD0AJIBL7o07PIwBKm9vHBJDNd0qvWvuVb5u i0LqtZ4rayJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw9AAKCRBIeX6hnBm+ 0afYEAC96w21vdUkB39nZfIBM7bwXmrWI+WVAdTkj8ZRvVMS+7ifJ9mtoqSq5IkV7fynVttp21y yP9stgHwYhX5kFkXDfMYqxdlkW/lZBJLvOIVRSjwrvg9hLmfqrnuRzP4J8f8VSW0rXPhL3FuuTk mE+HDIiH6wIW9DpjqHGOa/YkKKhe8f8COGXoM/0ral9UD5snurgGslg6e6Cp2VPklfgfvLYUDjd Z+HwicfEnIBGaYmRaOGqmXYWuy+u0AeIWsav5xu2ggpCNxZ1+XLgH5P+RSaW8WR3djOdqHMRP0X Hy80lBNIpg+XDs+5Tc9ulPQyJG3vJonmXQY8jHCajerqmj6PgwvN5ffSYgep8qAP3eTsl5WsvBN 8Aodg5tA4cSlB8ZNSGEP9akx0GwCzSvb6U5q7ZOaRKSNfOkVY3hVPWvu+ndnqvcSUkvksHjLE+h VG9TZ4vRySJ/JxlsME2XtokD81l6poMt2WO+uXyF2UGytQDWRuvb3fCV2tcanwjEM0G1WNJ5xih y2XbJkmmoa1PcCQa3Yrvxf1tMl0yGzIOKTbYS25Ez4jsSK4nG9cse0xWVwxBbBWRuPwiv6gcWMr wFiv3gKgBvcxEaWMxDgTcrpu6/5Pmz4UZtvhFBUKbD73fUvGV/NaVu/LH0xkswG6SKp+v0fmPXp dg8Wq6eA/
 FNTvMQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

While most conventions should not allow for the text lines in commit
messages to get too long, when they do it could make emails harder to
read.

Teach generate_commit_list_cover() to wrap its commit lines if they are
too long.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 47126f9064..d1765ce4ad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -40,6 +40,7 @@
 #include "progress.h"
 #include "commit-slab.h"
 #include "advice.h"
+#include "utf8.h"
 
 #include "commit-reach.h"
 #include "range-diff.h"
@@ -1364,6 +1365,7 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 				       struct commit **list, int n)
 {
 	struct strbuf commit_line = STRBUF_INIT;
+	struct strbuf wrapped_line = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	struct rev_info rev = REV_INFO_INIT;
 
@@ -1373,12 +1375,16 @@ static void generate_commit_list_cover(FILE *cover_file, const char *format,
 		rev.nr = i;
 		repo_format_commit_message(the_repository, list[n - i], format,
 				&commit_line, &ctx);
-		fprintf(cover_file, "%s\n", commit_line.buf);
+		strbuf_add_wrapped_text(&wrapped_line, commit_line.buf, 0, 0,
+					MAIL_DEFAULT_WRAP);
+		fprintf(cover_file, "%s\n", wrapped_line.buf);
 		strbuf_reset(&commit_line);
+		strbuf_reset(&wrapped_line);
 	}
 	fprintf(cover_file, "\n");
 
 	strbuf_release(&commit_line);
+	strbuf_release(&wrapped_line);
 }
 
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
-- 
2.53.0.1118.gaef5881109

