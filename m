Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE851D8E01
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157185; cv=none; b=HoUJO6T7iwdDPzRMcbp+7JXOb8O/hB4jMIqORsD4FUmTW+4jQL5ce+wA8Do0AKN+Rh4MFyfXzXx9aUlzVBvLapG3TG9eiuUlJRbwnk5DrM9cWEnaj05doZYBwbCAZr4wzFQZ9LFO+uV6cGqyE0Uj9RJRgR1kfH5IxdMbcwVBo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157185; c=relaxed/simple;
	bh=NoG4XtJDxLmbHnZU4B7GeFcbXBspBeSVy3dF4/9npVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bc2e9PZ8Yvkz2LDDcWAs+/T5Z5NOkQCzOS+Q6dnOVklZf+QKqvkGHMvfex88bFYvQ3eoOShHjO9uB3E6QQKkAgnGnoscROdrMk8sMlM5HSAQVkm52jz86q8/A4sRnhgrg0LcWdc4ihQdR68BYv3DQkuAKKKIwIwCdxJcamaL3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Lei5mAzU; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Lei5mAzU"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772157175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dvXQxC6KAS8eV2h87hmCbiC799H9dKy720yAIuVD3M=;
	b=Lei5mAzU26bvWW8YgGncedTM/jPPePaGcRhWIJd+UyaG+hXaqneagLrBGeqGauAInOPwdo
	B3o5ZzrcwKWmC8/Ngt9qhakcuSpo2LPf9bTu6E49D6lkn5JeStJjL5y4T8WhTTHbcKbMuA
	N/PQJA1wROWz0pvKDVfOsMkMnB70KlJ6k3X9FlPUMfysgYwHGzsEOk0xEybj0Y4491agXl
	QCICnDWGW9lDNvr9sQzFRG9keUohp39Iz+/DtvDzj5wi6cNDbnS1F1tIhLa3HY5wC20lsN
	PX4HoQ1lo+jsKJsU5UbSzAwBXkWYi0RY061+ebWA6khistIYmRevq51Znl8NfQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] format-patch: move cover letter summary generation
Date: Fri, 27 Feb 2026 02:52:37 +0100
Message-ID: <dc131c756520a0982d1d6f733dff48a464900ea5.1772156996.git.mroik@delayed.space>
In-Reply-To: <cover.1772156996.git.mroik@delayed.space>
References: <cover.1771925291.git.mroik@delayed.space> <cover.1772156996.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=mroik@delayed.space; h=from:subject:message-id; bh=NoG4XtJDxLmbHnZU4B7GeFcbXBspBeSVy3dF4/9npVs=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpoPiZm4Ab3Ya25Oq4Upkxoctxr1KYpNu/e7UVy aerQ0fW0LOJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaaD4mQAKCRBIeX6hnBm+ 0Yl7EACc5EFqtVvlYLoJHNRZEiEp5YZUN9HrzCViqZ1swXNynmkABf+mgcEX6cLcYS18LQCibr0 OryGcMb4RV0Xm8Kwxts6OMrD7AAoGRBPCaZ7+I9NfimOpmmKrPuV4jy9tvfbCTCOhjrc2y1kQp3 sUW+7JLMxllfRNmlOXlxbOdXTaWBXbnAptKoUKM28cKlTYhFYFp/299jzjwuSRvurYlQeYM1jVI Th0KVWZF7eFmQEKZ3AZWY17RpL9liR1NM1g5U53oUXyKYL0UBw38YPgbiejZw6apWIbbvFe68xl yK0eLwXj1belusqQGAHmXmSc+m6k9J+N445QKsZWS1fGpFaLJhL1turqd7bOXpkHTJ85uKmrvVn 03juSUxd91pLAPVo+BsmzWakfdr/yeSKW2Y/yonYL1hC8DSU1ZLUQkx1W9zUyfOEXfyDx0BcUTK yCj1LvaMAkLthMmy5UdvTKNMnXkV92wJYinzUp4Otf6QeEcIdxOeFPrsr2BBUJ1RFF6TDryZFB6 gaL6wenB9alCPn7fjfZDP3sWJbrQBbUskxxca5eKsvL/Ef/6+TY/1ljtLekraHcquPXcBH9++95 xvwGAD0Y7ysOoNDMtPM7Nd0O9rYf/3ZhcZgw+HO58tjbELB5FC1d7Xxus5eSsHLHpLMG/NWyW5k fSE2Ef5S1
 ozxCmg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
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
2.53.0.4.g55f3102ead

