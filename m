Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3735C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 22:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBKWYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 17:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKWX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 17:23:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBC16AD8
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:23:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r17so5732732pff.9
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=halogix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AJvaZd2Or5Rh0X/D87gR7GQvAmwTr1S5kMNq3i+82VA=;
        b=3c5mHzyyCQgpomEX6ioYQjFu7Ufput+2DreY7JPNm2JGBOvSlzSmxtpXy7MdI23q+t
         AutZF6vFSqkNRkDTf7y+BWGcatTP2TLgFwBVZ5xjp6/glzl/6c84oDVcqvOtvqgnGKSn
         kFMobfUqDVXByyx6BWYbAWa3+m9KWMM7aTvHYy7Vk1RpqhRGzEEpxJ3KKAjVk3grjwnK
         DTUTu3ld8q6bFqGGd8kmfWFc1ZiH1U2GxkMJ0HJYm0zInrbtObsBd5zuD0gk3i4mcp2T
         A+ijXNRG+fElTmL3d3q1p7FH3OuIQAJ5MnaebxykwZbWdYfMn8DxEAno6vqwu0Op/lW1
         9ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJvaZd2Or5Rh0X/D87gR7GQvAmwTr1S5kMNq3i+82VA=;
        b=kQKDuEgneXbWZJgxfVcJVeYZb75boHPwPUG1iXuCQpFXTm0Ba5gm7eXPLMCz6t4dSl
         AlwB8bt55rOzZOnIHmHUgIGpDGyIPEoC2cjLf9BHZEODPop6gDXorD1MuQ1u2LQtfxV2
         3nyCmnJHzU5waWv5aljLQ3UAQGYmk73K+iROi8gn8xdTN6q+iYxZr186t5ksIuqPFz+X
         V1uvGWWetgN7pvstZ4EjYWofNZ4p2EuPGk4p7AFJD4R+1Y5Qy+Ki4h/+aaWZZgLmusd8
         AC8kbvA2+dH1C486+Wi7cKk5+xwIcbeZHD51irBAO4Pz9/n0VxEsEQWZS/H46wEkAy7s
         OBhA==
X-Gm-Message-State: AO0yUKWWpm2pPnL5IF1xJAIxp86zdE46gcPkZai29s+Figmw41HPRy2M
        Yq6axjXCtDuioTHhmqnClXIu7cc70Nm2T7ojxB0=
X-Google-Smtp-Source: AK7set81SgCf/iaVndeKnLk/IOiLvkWk0xq040ANmlqloIiNrGYiIB6/f5/pJBc3EbqF8dP1wbEmFw==
X-Received: by 2002:a62:d458:0:b0:5a8:44d6:f5e5 with SMTP id u24-20020a62d458000000b005a844d6f5e5mr11493714pfl.0.1676154237630;
        Sat, 11 Feb 2023 14:23:57 -0800 (PST)
Received: from wansink.devpod.svc.cluster.local (248.200.82.34.bc.googleusercontent.com. [34.82.200.248])
        by smtp.gmail.com with ESMTPSA id v24-20020aa78518000000b005a8a5be96b2sm735707pfn.104.2023.02.11.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 14:23:57 -0800 (PST)
From:   Andrew Wansink <andy@halogix.com>
To:     git@vger.kernel.org
Cc:     Andrew Wansink <wansink@uber.com>
Subject: [RFC PATCH] upload_pack.c: make deepen-not more tree-ish
Date:   Sat, 11 Feb 2023 14:23:53 -0800
Message-Id: <20230211222353.1984150-1-andy@halogix.com>
X-Mailer: git-send-email 2.39.1.434.ge4127a26028
In-Reply-To: <CA+tAvojz0u7AbcNnY1qyy3VznKhYTiAO1dL+rfOD3O6mOtsa8A@mail.gmail.com>
References: <CA+tAvojz0u7AbcNnY1qyy3VznKhYTiAO1dL+rfOD3O6mOtsa8A@mail.gmail.com>
Reply-To: wansink@uber.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This unlocks `git clone --shallow-exclude=<commit-sha1>`

git-clone only accepts --shallow-excude arguments where
the argument is a branch or tag because upload_pack only
searches deepen-not arguments for branches and tags.

Make process_deepen_not search for commit objects if no
branch or tag is found then add them to the deepen_not
list.

Signed-off-by: Andrew Wansink <wansink@uber.com>
---

At Uber we have a lot of patches in CI simultaneously,
the CI jobs will frequently clone the monorepo multiple
times for each patch.  They do this to calculate diffs
between a patch and its parent commit.

One optimisation in this flow is to clone only to a specific
depth, this may or may not work, depending on how old the 
patch is.  In this case we have to --unshallow or discard
the shallow clone and fully clone the repo.

This patch would allow us to clone to exactly the depth we
need to find a patch's parent commit.

 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 upload-pack.c         | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d18f2823d86..8d5045cc1b9 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -899,6 +899,36 @@ test_expect_success 'shallow clone exclude tag two' '
 	)
 '
 
+test_expect_success 'shallow clone exclude commit' '
+	test_create_repo shallow-exclude-commit &&
+	(
+	cd shallow-exclude-commit &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
+	git clone --shallow-exclude=${commit_two_sha1} "file://$(pwd)/." ../shallow3-by-commit &&
+	git -C ../shallow3-by-commit log --pretty=tformat:%s HEAD >actual &&
+	git log -n 1 --pretty=tformat:%s HEAD >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'shallow clone exclude commit^' '
+	test_create_repo shallow-exclude-commit-carat &&
+	(
+	cd shallow-exclude-commit-carat &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	commit_two_sha1=$(git log -n 1 --pretty=tformat:%h HEAD^) &&
+	git clone --shallow-exclude=${commit_two_sha1}^ "file://$(pwd)/." ../shallow23-by-commit &&
+	git -C ../shallow23-by-commit log --pretty=tformat:%s HEAD >actual &&
+	git log -n 2 --pretty=tformat:%s HEAD >expected &&
+	test_cmp expected actual
+	)
+'
+
 test_expect_success 'fetch exclude tag one' '
 	git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/main >actual &&
diff --git a/upload-pack.c b/upload-pack.c
index 551f22ffa5d..0c8594f4744 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -985,10 +985,37 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
-			die("git upload-pack: ambiguous deepen-not: %s", line);
-		string_list_append(deepen_not, ref);
-		free(ref);
+
+		switch (expand_ref(the_repository, arg, strlen(arg), &oid, &ref)) {
+		case 1:
+			// tag or branch matching arg found
+			string_list_append(deepen_not, ref);
+			free(ref);
+			break;
+		case 0: {
+			// no tags or branches matching arg
+			struct object *obj = NULL;
+			struct commit *commit = NULL;
+
+			if (get_oid(arg, &oid))
+				die("git upload-pack: deepen-not: no ref or object %s", arg);
+
+			obj = parse_object(the_repository, &oid);
+			if (!obj)
+				die("git upload-pack: deepen-not: object could not be parsed: %s", arg);
+
+			commit = (struct commit *)peel_to_type(arg, 0, obj, OBJ_COMMIT);
+			if (!commit)
+				die("git upload-pack: deepen-not: object not a commit: %s", arg);
+
+			string_list_append(deepen_not, oid_to_hex(&commit->object.oid));
+			break;
+		}
+		default:
+			// more than 1 tag or branch matches arg
+			die("git upload-pack: ambiguous deepen-not: %s", arg);
+		}
+
 		*deepen_rev_list = 1;
 		return 1;
 	}
-- 
2.39.1

