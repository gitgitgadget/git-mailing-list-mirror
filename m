Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AEE221F39
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198313; cv=none; b=D3tRNcCral+4x4omtcYQkemDuMRtt9XMezTyHmAS2/QEtyPt4/3jgKO1gKzjcF7KZs50KO4zKmDJM1cCylfOS/yJ5Qlsoaen113ZUNu2v5gMKipqdBWBfSNRXMIANhRMFP8Zlvg28nJOovUpX9AcmmLEyPOfZqmK3b0JkxZLxZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198313; c=relaxed/simple;
	bh=mt/Rru7bltgrkX93+4jhZWwSGdTheVs2nCIIrW34kcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzzlczM9zr3J98Wm2GpzQtrDBCj8PDrYVPJiUtSeIalK33huel7PBXsajROgph3VB5eoHFfkHdHMnMY0WWWNsVxYtLB7PW+U6sDVR4/7o+s+UWzL54I7ppykUTHOJadfm5dh0A0kZ3hbtA8c4/E3hzbD/Gui+IG/waNWrZE0a0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=NofCwhQk; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="NofCwhQk"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772198309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+KnQVT4VCuy/8rogqxpkxg1Kb7TSClhLHuidSBvOgQ=;
	b=NofCwhQkjgsQvmxAd+LMa2B4Z1IxSw/E38XHcpgubhaeRWbMpSLtlgHKDXo4tSCzT02ZON
	5jU5qfDxHI+wugN88HGYMrwo73XX6CXeAUvoPdf8lZRlo9pBhdmw0AN+RO6k2u5h1nOd+K
	tGw57xTtYbm3NFTOrWzNXA/JLqLKD4FRb5i0jUHOgDHqRUf38iBBj78MJhoVk8AjJEqd4W
	Jl9hqKRMss4vBdZpDEolnov55uY0aK0ev2lL1XL+AMmnDq434hLqmBLy0imxUi95X+PdT9
	ual2Qy2X/vhHUcWEPHVnd2GRVbiZR2XV0TBZETHrYPdkZNK26OlDgNwlVJItiQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 2/4] format-patch: move cover letter summary generation
Date: Fri, 27 Feb 2026 14:18:10 +0100
Message-ID: <dc131c756520a0982d1d6f733dff48a464900ea5.1772196510.git.mroik@delayed.space>
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

As of now format-patch allows generation of a template cover letter for
patch series through "--cover-letter".

Move shortlog summary code generation to its own function. This is done
in preparation to other patches where we enable the user to format the
commit list using thier own format string.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 builtin/log.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef363..0d12272031 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1324,6 +1324,25 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 	}
 }
 
+static void generate_shortlog_cover_letter(struct shortlog *log,
+					   struct rev_info *rev,
+					   struct commit **list,
+					   int nr)
+{
+	shortlog_init(log);
+	log->wrap_lines = 1;
+	log->wrap = MAIL_DEFAULT_WRAP;
+	log->in1 = 2;
+	log->in2 = 4;
+	log->file = rev->diffopt.file;
+	log->groups = SHORTLOG_GROUP_AUTHOR;
+	shortlog_finish_setup(log);
+	for (int i = 0; i < nr; i++)
+		shortlog_add_commit(log, list[i]);
+
+	shortlog_output(log);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
@@ -1377,18 +1396,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	free(pp.after_subject);
 	strbuf_release(&sb);
 
-	shortlog_init(&log);
-	log.wrap_lines = 1;
-	log.wrap = MAIL_DEFAULT_WRAP;
-	log.in1 = 2;
-	log.in2 = 4;
-	log.file = rev->diffopt.file;
-	log.groups = SHORTLOG_GROUP_AUTHOR;
-	shortlog_finish_setup(&log);
-	for (i = 0; i < nr; i++)
-		shortlog_add_commit(&log, list[i]);
-
-	shortlog_output(&log);
+	generate_shortlog_cover_letter(&log, rev, list, nr);
 
 	/* We can only do diffstat with a unique reference point */
 	if (origin)
-- 
2.53.0.4.gf9ee8e2400

