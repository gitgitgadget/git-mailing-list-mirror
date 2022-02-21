Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE7CC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbiBUJJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:09:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347831AbiBUJI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:08:57 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DAA10AB
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:00:55 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gb39so31450723ejc.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7NBmOfGTSG+gYo7vFA0iQDSNvQFqirTBY4jKNDAYSQ=;
        b=L+5S75kgFXrJ9/k13e5o8+JKO0V4qsLUbMmZ+lyBgrfCubXIO/Z8c6ZyoAT8VTokjv
         4odBft89GseYslRxo+iwjA6cLDbXDOFqUKt+P7D8K1qyp0aPuR5eOm9IA9RrwHkjksKA
         +t0jo4D9ciHEcj/2BVF/2NyYSN75dBW9uT0qMjpDLgYoX5HuqcKSZC8CWsiIhRRiqMHk
         y+S1Uh+yRuZttiGGS61DdJh+LY1L/Sv6nfXrCltvr/fgCAcyB10S6XoLRox4/S4ZLsyI
         LHUX2fndnvAoi6w8t6itxp/Tgh67iYzNFXemboogWN1a9i2bXdKjUSj/pjP80pHotKJo
         wp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7NBmOfGTSG+gYo7vFA0iQDSNvQFqirTBY4jKNDAYSQ=;
        b=iaRrgjZuwsdYu3okqsiz7XNSR4cQNXRv2AhrRDl2OsEW1emF9q1+KzIwiz/nhWLNrA
         TqveuCWITIvEOqEDzDxmIEADNAZ1qZdKWNSVyY9dtQLGDFoypEa3UqoL7M4vU/TET2X4
         JdSvpjINuwxbrbEUHkGGsL9GjOTzb0jzSBS0InT2t3GTKiSzp93kG4RWpozKDiCiZeLk
         iTdbwqZVjfLarhFvktB3tQHMDhR6rQeaYqXJeZHcHQ/B4YrRJ/4XkCw6PUkS/H7mb1oM
         BR12gRhUi7S1MbiiXzByxGpRzmMO/S5qF/L+nSV6GGvg1sVhgzPCNhzhYGtA3yLNW/MB
         z21Q==
X-Gm-Message-State: AOAM5336a6be0VRnoFh2HgyLgYHX/S/1QGjUUyFEr52TColZNcAVCK3y
        +Jxtfr0i6DquDlkwmFcVbL/ZiNxbjAs7yQ==
X-Google-Smtp-Source: ABdhPJyZ1GtWCha6E8AYF4jFxSS5fPcFzmwG5VDjFO2q7UivgGcTGWh1uYCS/ranBdI0OQqhpzUY5Q==
X-Received: by 2002:a17:906:b2c6:b0:6cf:e599:6b81 with SMTP id cf6-20020a170906b2c600b006cfe5996b81mr14599815ejb.578.1645434053802;
        Mon, 21 Feb 2022 01:00:53 -0800 (PST)
Received: from matebook-pat.. ([2a04:ee41:84:d422:21c:c2ff:fe46:a5ad])
        by smtp.gmail.com with ESMTPSA id j8sm8793958edw.40.2022.02.21.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 01:00:53 -0800 (PST)
From:   Patrick Marlier <patrick.marlier@gmail.com>
To:     git@vger.kernel.org, newren@gmail.com
Cc:     Patrick Marlier <patrick.marlier@gmail.com>
Subject: [PATCH v2 2/2] clean: avoid traversing into untracked dirs when unnecessary
Date:   Mon, 21 Feb 2022 10:00:34 +0100
Message-Id: <20220221090034.4615-2-patrick.marlier@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221090034.4615-1-patrick.marlier@gmail.com>
References: <20220221090034.4615-1-patrick.marlier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When deleting all untracked and ignored files and any nested
repositories (such as with `git clean -ffdx`), we do not need to recurse
into an untracked directory to see if any of the entries under it are
ignored or a nested repository.  Special case this condition to avoid
unnecessary recursion.
---
 builtin/clean.c  |  4 +++-
 t/t7300-clean.sh | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 18b37e3fd9..1b1454d052 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -978,7 +978,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		remove_directories = 1;
 	}
 
-	if (remove_directories && !ignored_only) {
+	if (remove_directories && ignored && !exclude_list.nr && force > 1)
+		; /* No need to recurse to look for ignored files */
+	else if (remove_directories && !ignored_only) {
 		/*
 		 * We need to know about ignored files too:
 		 *
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0399701e62..ceab7c4883 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -788,4 +788,28 @@ test_expect_success 'traverse into directories that may have ignored entries' '
 	)
 '
 
+test_expect_success 'avoid traversing into untracked directories' '
+	test_when_finished rm -f output error trace.* &&
+	git init avoid-traversing-untracked-hierarchy &&
+	(
+		cd avoid-traversing-untracked-hierarchy &&
+
+		mkdir -p untracked/subdir/with/b &&
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdx
+	) &&
+
+	# Make sure we only visited into the top-level directory, and did
+	# not traverse into the "untracked" subdirectory since it was excluded
+	grep data.*read_directo.*directories-visited trace.output |
+		cut -d "|" -f 9 >trace.relevant &&
+	cat >trace.expect <<-EOF &&
+	 ..directories-visited:1
+	EOF
+	test_cmp trace.expect trace.relevant
+'
+
 test_done
-- 
2.35.1

