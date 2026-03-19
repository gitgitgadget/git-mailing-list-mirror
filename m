Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE920407571
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959930; cv=none; b=VB9gYJJKM6UxqG8XLVJGev6sv7n0j7PR5AFs+EqD1MzGJW249MYh8o+dZL7QaXSh6dE8xtz2sZ+hfPlRs2ArpPSoLruqrWj2PxTYp2934pg5H+BcslUwML2HOyFPB0v/jY4YwV1qGHP+6o5MXvVp7mJJgPay2DMoBJOLlaBj5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959930; c=relaxed/simple;
	bh=Q7kpg9KkftThS4E4NAwTRLENcsJGBvdjfLJDwJNGp9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N55ZjvnbK/UnRhGIKfkoJHM29IhE2+0d9UKoUSwRBmX0ebGtgFCfNmDPIyDzhMIq4jDANQCHAqWa61mPcqsYNu/cAadGM9kx5pJjitEQhJctglDuZ0CCJjoHNOMHmARcpCdcIZiiUiL1liaV75v3AME3uyy+KyCEyjrqnlYhdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=CXfIqLFc; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="CXfIqLFc"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773959920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAb/ZnWGf7lOx1pudPVgwbPMajjbYCc67Ca/utf61nQ=;
	b=CXfIqLFcpVjGZBfn7dT6E12djZABgMQB1PjZ6zAMs0IM7KpjTe5I1J1b1HubRBDaC9RYUA
	JghF9zH3wBgyj3QUXiZ/rycygGxnrt4b+xULMbI3ikl9gmgmOfIXCFmreHFooSrc5od1ON
	ISg9QF2DXIneO2V9pJyVe8/WPFkK273K2MmMW6z11u9ogkkZfPBJtcVIvOe8mVQYgHJLX8
	pHg5zABkLYIvdsU0HDWIcbCcE5Ru/kRztN3yatwFJtWFWF+TUB7shEbgZF436B1PqqZv3H
	GipjPgny6X9JVUoCtepbYXESxAsfBbbP/vQrVTVR7pdzocn9qk6OGgcRDQhP3A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 6/8] format-patch: wrap generate_commit_list_cover()
Date: Thu, 19 Mar 2026 23:38:16 +0100
Message-ID: <3f547451a22e12ed04969fc0ed73dc1b72c15259.1773959395.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space> <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
2.53.0.1018.g2bb0e51243

