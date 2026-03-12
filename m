Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD3E5580
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332426; cv=none; b=XxBc3K5OCjHr9moXdr96qRdHIVwAkbW+dm3QjlBVkoEiW+WCcFI9LgVqsxJxaobrTVoLS2QRBILSe1I/nOQH42fhDEUntmxAPD4jA7QqBzo3az95hVBCglu6k//P9LERayA8/jNKX1Wbhxctnym9HTaSJCRfuaeZcsCxwMG8uWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332426; c=relaxed/simple;
	bh=Pa4NeY2cpsBvnNLxI7PwBOPjcPiDKz0v9rK4aMKhMY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY2TwdaLgppMeF4fvSPdyIyDTE3eDIhx9Rs+b5+BWEDhL1VzvdB1UnIq4Y0J2RbmBCJlqKSslM2413ydP8h3SOKV1wZWFRIQFtZaee3JbGS5ogL+AUWeHtuVVPBxNnO6aObhuHpKHT/4ih+Ncw8Kv3M69RaOt4ei1MMHnawmDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=fWfeh8r6; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="fWfeh8r6"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773332416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYyC+q0/dfVWVOosyrpqir0mcm6Y324ogAFrYKiRGHM=;
	b=fWfeh8r6Rt0oxvR85yuK9JN73fB7URKZK++UgV0cVuwdb8LjlYRo624I16bMLb5zUzfnsW
	kTKjar2ME5E2QPOgiJcOQBMwc02/5IPCM2MzC477hQ2aC8uuAS1dqiOB7lVp5gHDUNd0Jw
	zQK2hXtDad/nfYFuAs8Ew2h9VqFsxgFwJ5VGQDrUflnP+Nhvx9X7Nx7VkP+iV73I5Vy8Iz
	0JNGhyZebu7PqN6DHYdQyVQOkdMMcz5W9cEWJVj3vWsaAxwaarkKcrkPyEVYaRiZ9J8xAD
	LvPIYJmMqo62+LHLGaq5gyUmfmup8kGLrnJGB5ZaazvxdcTZxKYyNLe0NUFqsQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v8 1/4] format-patch: move cover letter summary generation
Date: Thu, 12 Mar 2026 17:20:08 +0100
Message-ID: <3b008fb94dff3b54f19eb0754938a33968acd1cc.1773331753.git.mroik@delayed.space>
In-Reply-To: <cover.1773331753.git.mroik@delayed.space>
References: <cover.1772839973.git.mroik@delayed.space> <cover.1773331753.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----

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
2.53.0.904.g2727be2e99

