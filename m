Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CE3803F9
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772840108; cv=none; b=BDLwMosUw9Qp33km9fFbgc6njyEBVd3Ep3jaGqH9zgoE7Olels+stb8YpJhtmfO17w5UKnyMUKAyPS9CdzBXFUU+GIX/XQrn/p2Ag375yJhlpGi9LVMKDtGgg91P6q4LFSG4NHYyW1lbnYqnKbxl06yX3pQRkhDxMacTcXcuaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772840108; c=relaxed/simple;
	bh=e518wa2Ec+kmRTyyQjb26AmBrYLdpF+RC4x9UbgcB5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEuLWQQS10w+La3EfNGG824jbCpeXRrakTdM0CB3e1NVpgTOfNlddwnQgfBasU4zNrci58L8Rc53iJqn3ZsWQagOe3ftAXU8eu5xDiT1viENtXVW51RNmKQB5elPDMyCFCFaAOlcmymOiTsVF8dWqjWWS+le7rxooUqc8d9juIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=a5+E7FRj; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="a5+E7FRj"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772840103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogXz1UUTtZZCzXSEOJeRpOlc+weSPgv/sAcYuS19vRw=;
	b=a5+E7FRjDq6Ssv/K9A8eEFoOFKgYif0YFGIGPfOU84Xuc98YV2/v9swNHKQvf3S/2tgGw/
	MVyEtcN5qrwW1gDcEE0IxS5DZ+8OZCZyIiLG+abqOhP8gHyXmCKhALN78rh0HxpFGk2Uvl
	Wvyw9gf2xQTza/XQevqrmDMwMpm736B7BRMnZ0o8cDDbCj3ahnxZOAVgCIUWna3mkGMtxr
	A+Qf3jcwhUVBiLC2kiWqqwnPRO9SC09eHdI/+Hcazqk1cv4szgV1uDtrmbVX4nZLEOpeh4
	ugVTDUopQLa/g+Gc05OIERhVWF5oRA6YkjI3U1Py9iYe1CdVou/qtgkiUMNhdw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v7 2/5] format-patch: move cover letter summary generation
Date: Sat,  7 Mar 2026 00:34:41 +0100
Message-ID: <dc131c756520a0982d1d6f733dff48a464900ea5.1772839973.git.mroik@delayed.space>
In-Reply-To: <cover.1772839973.git.mroik@delayed.space>
References: <cover.1772837832.git.mroik@delayed.space> <cover.1772839973.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=mroik@delayed.space; h=from:subject:message-id; bh=e518wa2Ec+kmRTyyQjb26AmBrYLdpF+RC4x9UbgcB5g=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpq2R/8tAGkkcDjy0LLm0jyTDpxZ1I/Irp8FtSi e1x8mzX/8qJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaatkfwAKCRBIeX6hnBm+ 0Vq8D/wMBnHRdF2DeGllLFdwmaaP0OjY3K4LOrxBIoZ1ogwH1GOEolQhr+GtC0A/yyZ3APFW5+v 8xII/cBpCp+NWUhswzFS35OyANQkAZrrmlo6QllmVrJAyb0s2DMG+Ixa1xKaoOa5NtsWmRc3TkX r8KngTCNsww4PEXY0SQqQ5NWW13qWk+j7H7hNdbi6AzH0h4wRsUuBfTP7Nz8QZYiRbP2rcYRxQ+ /ltvs2ASxXNzAAFNnR87X/TYwn2LUW1xcn5rIddV/Hut5ozBmNChIv1jRv/Cxd8o9oY33rO8fkV zB1Ci6MPxHviLqlSZmaRK4YnOnSnm3VF53KxNF9IWU9wf1Z4C/fGRdz81L/WAWQ5Vw64/4viswt /EbwDniZBhpWi5sbjC490dtBf4ZZ3QjU2AwkQBmp5ynLqkUpdPM6YdeYEyXyvYiDgjuAE2XDHQB 9wWiP8CRTfPLT1cv0ubBUtvhWx7agCmCNSoFphY5V5eWxrCbQ+QMNgtNmNDd5pKmyRKk3aqRHAg jzpTbZDe+7Z0k3i/X4Gqcz3pc8Tdd9uVVKbwwjpUO1a4/gToWDEFcozsWCn/KvYnGnHqRuzmTQS GpoX7mCpKzWkFmITIZsovYeNk2th8iTQJ/tNHqhBIfn7hAaoEs4tO3YgJ+u43VbdV/3miLLJneG 2B+BArz19
 BkQhsw==
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
2.53.0.5.gbe7197aef5

