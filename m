Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC767C77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjEEVT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjEEVTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:19:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A2270C
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:19:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6434e65d808so2528647b3a.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321559; x=1685913559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+fwAjQqhDzVDdDfrV6uYArp6c4TmDLQ6JN6MHucyBU=;
        b=Er+8rR8jNm/yF3yjjNiV1URsrNocH7aSi/p8OnnW0kFFVNagieyoP5w0O5Gm/WSIZN
         A969nlhoa/TumF1VzTz9tzSY4tjunHO7MC+w2QORvnCleUnUGhmLGj8LBwS3WyvcegsS
         Lx1wz2V0/wWLDfJnSY3Res2MstMj8cjrHc1CAaklijoW/B926Ebk2TRDL7QY9WvQOogB
         Gs8nLSY3WMWw2ZL5Ccp3KkiONZBi9oTTBY62SlSTOfnnFFISTf2zFutlV3Giulr4qc4L
         kg5WjFnDPrqjg2XLlkxdaOMKUTPQ0krJjdbL95YMYw9hAjaL4x2+zMdJqfSmJYLW5BYf
         MyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321559; x=1685913559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+fwAjQqhDzVDdDfrV6uYArp6c4TmDLQ6JN6MHucyBU=;
        b=eORBENbe7GON7AcqlktZAiXAo+G30a+WHbMELh4fYecmw9Ff/I0wNpcN1IrVYaUWkO
         zYpM1N4kK/N1yDk8/yQO5WYLZQ3UjgtMBd4rDpaqWRKKH3ivT06UB3wDTFsVTbBvP5Ik
         XhH+C46/4uBm2VqQ5NF7y96yMeV3hsA/belT2gACe58ypHY+h/KiSYS1pJukOeQD80U4
         93JxomKSw65JBMW8HSKA8Ro52ajuY0hdj1fpivBbQOleGxkDQoLBxJ8+Q46cgBXVpYpp
         wZIZYv19eQhJWizLZLDdI1DsJMbs07amiKcBFUkIFkYi53YHSiWST+TkNznw04GhLOMp
         B4gg==
X-Gm-Message-State: AC+VfDzeRsTMA4WuQ65HPto59pIfEuQXN9BhTOxYdh3qHQ3z1JEWMK5N
        M5g0CB2ypqTIPOXG4E5Djbaqvsp18d0=
X-Google-Smtp-Source: ACHHUZ5bFUxOvU9WDNtHR4Tr49evyG9ED+U7ZrZfHs7egLTv2za7pu94zA/vQM7CCr/fVFAC5Geugg==
X-Received: by 2002:a05:6a00:1907:b0:643:b081:3428 with SMTP id y7-20020a056a00190700b00643b0813428mr2147070pfi.27.1683321559207;
        Fri, 05 May 2023 14:19:19 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v6-20020a62a506000000b0064378c52398sm2057787pfm.25.2023.05.05.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:19:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] diff: refactor common tail part of dirstat computation
Date:   Fri,  5 May 2023 14:19:16 -0700
Message-ID: <20230505211917.2746751-2-gitster@pobox.com>
X-Mailer: git-send-email 2.40.1-476-g69c786637d
In-Reply-To: <20230505211917.2746751-1-gitster@pobox.com>
References: <20230505165952.335256-1-gitster@pobox.com>
 <20230505211917.2746751-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will become useful when we plug leaks in these two functions.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 648f6717a5..e13d0f8b67 100644
--- a/diff.c
+++ b/diff.c
@@ -2971,6 +2971,19 @@ static int dirstat_compare(const void *_a, const void *_b)
 	return strcmp(a->name, b->name);
 }
 
+static void conclude_dirstat(struct diff_options *options,
+			     struct dirstat_dir *dir,
+			     unsigned long changed)
+{
+	/* This can happen even with many files, if everything was renames */
+	if (!changed)
+		return;
+
+	/* Show all directories with more than x% of the changes */
+	QSORT(dir->files, dir->nr, dirstat_compare);
+	gather_dirstat(options, dir, changed, "", 0);
+}
+
 static void show_dirstat(struct diff_options *options)
 {
 	int i;
@@ -3060,13 +3073,7 @@ static void show_dirstat(struct diff_options *options)
 		dir.nr++;
 	}
 
-	/* This can happen even with many files, if everything was renames */
-	if (!changed)
-		return;
-
-	/* Show all directories with more than x% of the changes */
-	QSORT(dir.files, dir.nr, dirstat_compare);
-	gather_dirstat(options, &dir, changed, "", 0);
+	conclude_dirstat(options, &dir, changed);
 }
 
 static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *options)
@@ -3104,13 +3111,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 		dir.nr++;
 	}
 
-	/* This can happen even with many files, if everything was renames */
-	if (!changed)
-		return;
-
-	/* Show all directories with more than x% of the changes */
-	QSORT(dir.files, dir.nr, dirstat_compare);
-	gather_dirstat(options, &dir, changed, "", 0);
+	conclude_dirstat(options, &dir, changed);
 }
 
 static void free_diffstat_file(struct diffstat_file *f)
-- 
2.40.1-476-g69c786637d

