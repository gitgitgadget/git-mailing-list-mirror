Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DC3C77B7D
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjEEVTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjEEVTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:19:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C85262
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:19:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aaf91ae451so20977275ad.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321560; x=1685913560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=si/D1FtlEEhUQ9o1SxvNC4fWjv0V6oyy2fW/XLfRW0E=;
        b=Z9Fr1mrEQrx2Ao2GIZ3hN7mNmrnzRutwiZMPGgNlp9k/2EqaQWX+g9B2ojtjhwlGyv
         DiKlf46abhNaKqAxMPktrHdaHjXF4oFoCIRRmk88Lt/KjBu8tGBuBey9sttm3sXO7tQb
         FLMdi88cWgOY7UgSIMMeHXRvZiU8YXWPiJESGUx4/F/0Ka2Q6D+7xxjXE8TYv7WPSsyR
         C0yvU0MTFyUcqowct164qU/kvbpLOwGVVOi2aa/Np2lhsi+bZ3zYR/7QvwXqfgxrTU3Z
         iO6zZGyWog1PSvdRR8QFddMbnkIy2I2JuDJz0trPexu+pK7ufan9knVb1QVNa+lECIo9
         2RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321560; x=1685913560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=si/D1FtlEEhUQ9o1SxvNC4fWjv0V6oyy2fW/XLfRW0E=;
        b=TR10uG7grK5D14z/LpqvP1yD62d3VeVuM1aWhb3ATwO55ttxtKS6W+7GEpwo+2QAWJ
         2CVtSql+IgAyZRYRY1hZlR/bNJ3upRxTWm23mAp4u+tRik4Pltr68BtVCFFtjH/bgz7f
         J+1n27aHoB6gWTi5zMM/g2s+MBNBaHZ4+gOGTwjs7+ySgpqak70WJ6OIuPH919my1p6C
         4GA9a5ZudOz1/HokVG0RtY1IQFICSd6vJnV06HfP/qM17R7gZpJVsAjn56Scd2P2Tmy5
         ga8HxUqwKE+u6SnhLiwOBbZduF50ZRGwKCHol4Uu8FoRft0SzZF2fVajZaGJtmEQAOKI
         OCBA==
X-Gm-Message-State: AC+VfDwpabW7kkePy2y5+ZhIAd/FoJn8BiwK2KTIWDF+bg5rmrDO88C2
        9BGK5uCVy1wegNhf7sRt9d6D+fZE5K4=
X-Google-Smtp-Source: ACHHUZ6Z1N0firKDdx9LzKgCkWvUjHpKmS9konV6M1l4E8geNVl3JybUj4kwrQddyaq6zXbOhf8TIQ==
X-Received: by 2002:a17:902:e810:b0:1aa:f6c3:ba24 with SMTP id u16-20020a170902e81000b001aaf6c3ba24mr3468463plg.4.1683321559936;
        Fri, 05 May 2023 14:19:19 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id bg8-20020a1709028e8800b001a96d295f15sm2177585plb.284.2023.05.05.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:19:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] diff: plug leaks in dirstat
Date:   Fri,  5 May 2023 14:19:17 -0700
Message-ID: <20230505211917.2746751-3-gitster@pobox.com>
X-Mailer: git-send-email 2.40.1-476-g69c786637d
In-Reply-To: <20230505211917.2746751-1-gitster@pobox.com>
References: <20230505165952.335256-1-gitster@pobox.com>
 <20230505211917.2746751-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The array of dirstat_file contained in the dirstat_dir structure is
not freed after the processing ends.  Unfortunately, the member that
points at the array, .files, is incremented as the gather_dirstat()
function recursively walks it, and this needs to be plugged by
remembering the beginning of the array before gather_dirstat() mucks
with it and freeing it after we are done.

We can mark t4047 as leak-free.  t4000, which is marked as
leak-free, now can exercise dirstat in it, which will happen next.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  | 17 +++++++++++------
 t/t4047-diff-dirstat.sh |  2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index e13d0f8b67..d52db685f7 100644
--- a/diff.c
+++ b/diff.c
@@ -2975,13 +2975,18 @@ static void conclude_dirstat(struct diff_options *options,
 			     struct dirstat_dir *dir,
 			     unsigned long changed)
 {
-	/* This can happen even with many files, if everything was renames */
-	if (!changed)
-		return;
+	struct dirstat_file *to_free = dir->files;
+
+	if (!changed) {
+		/* This can happen even with many files, if everything was renames */
+		;
+	} else {
+		/* Show all directories with more than x% of the changes */
+		QSORT(dir->files, dir->nr, dirstat_compare);
+		gather_dirstat(options, dir, changed, "", 0);
+	}
 
-	/* Show all directories with more than x% of the changes */
-	QSORT(dir->files, dir->nr, dirstat_compare);
-	gather_dirstat(options, dir, changed, "", 0);
+	free(to_free);
 }
 
 static void show_dirstat(struct diff_options *options)
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 7fec2cb9cd..70224c3da1 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff --dirstat tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # set up two commits where the second commit has these files
-- 
2.40.1-476-g69c786637d

