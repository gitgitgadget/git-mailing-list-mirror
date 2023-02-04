Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6835C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 23:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjBDXTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 18:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 18:19:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFA21B558
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 15:19:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ba1so3425053wrb.5
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNJJiwU9M+h9eSbS5AaDSn52RciE9m7YEJY1wB3QsjU=;
        b=lwsZ7Cts7nz5I+pSLudeb/SNERoluhavrM6uF0DhZx6Uj29j0e2C3xEukCws98RTYa
         wSxcTKfhYOtY096296D/nv84XsuSMB+j4f5me6KoxpzE8UlbSyWUspzWPkJfjA2O+T2A
         tf4hbBivXLXCc4RsTWGmpf0pdNIXAGRJU10xjtkXKguOCc2uSOAWGAW6DcESwPaXNwPc
         k9W1/z2X2q2hUYCxYfsVQVRX2qOy1SpaKuVKmJqX7vL8KK8YMTeN1S26UqbKc72LOeL2
         NpxoXJmbfK+V5yeSWyWXK9adK3udUwIVds//HwL3rqlhAP/NaiciYAMWJt+FiVeZciPB
         dyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNJJiwU9M+h9eSbS5AaDSn52RciE9m7YEJY1wB3QsjU=;
        b=soj/bFsXcpw2uCiGLLNiVdsEqAQ1H22A+V4OQhUfaw47R1ueW6aMrMfkvzm4B4PDwK
         WGTVDZGXleZ5G9bb+i+hRdyh+Aers/Lfw2vWNcK56hrncyRLYpAR6gxFsyMWfa/RaDya
         BjHx1IaeonBnJzzNtWaJlaTJxSZNQoCenV8VEv1ktVVmyDQGXUIu77t+bmvVSdUaThkx
         OlXvkKkDj1Z9M0PZWDeWXBJPgxBrP4MeB/b+R3ixe5e9sEBL8/R8E7tL+l2rw4tbiY2j
         f6pWTba10FpPa6qNE6/YE7D70GwQucMhKywV9KlhL28D86uCdiT30np9NoTTGV0Sibt0
         4j/A==
X-Gm-Message-State: AO0yUKUj1v1Q6kgDMvK3IUJgLp0jnwzjqxDDk3WnSwQ/Yn5oy+tYGIbo
        qqvT5H7hzT6DrQmga9q1WvU=
X-Google-Smtp-Source: AK7set/JeK1RSJ/DBtVFyZvbc1mc2QvGJJ6vBjD+TDdzq5kOcx02rEi/PIEThc0z1nLdrAMyvNjMxQ==
X-Received: by 2002:a5d:55ca:0:b0:2c3:e0a0:94f with SMTP id i10-20020a5d55ca000000b002c3e0a0094fmr2190790wrw.37.1675552743678;
        Sat, 04 Feb 2023 15:19:03 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id k6-20020adfb346000000b0027cb20605e3sm5386762wrd.105.2023.02.04.15.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 15:19:03 -0800 (PST)
Subject: [PATCH v3 0/4] fix die_if_checked_out() when ignore_current_worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Message-ID: <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
Date:   Sun, 5 Feb 2023 00:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2:

 - is_shared_symref() is introduced in its own commit
 - code style fixes

Rubén Justo (4):
  worktree: introduce is_shared_symref()
  branch: fix die_if_checked_out() when ignore_current_worktree
  rebase: refuse to switch to a branch already checked out elsewhere (test)
  switch: reject if the branch is already checked out elsewhere (test)

 branch.c          | 14 +++++++----
 t/t2060-switch.sh | 29 ++++++++++++++++++++++
 t/t3400-rebase.sh | 14 +++++++++++
 worktree.c        | 63 +++++++++++++++++++++++------------------------
 worktree.h        |  6 +++++
 5 files changed, 89 insertions(+), 37 deletions(-)

Range-diff against v2:
1:  cacdc022f8 < -:  ---------- branch: fix die_if_checked_out() when ignore_current_worktree
-:  ---------- > 1:  6bbe05f452 worktree: introduce is_shared_symref()
-:  ---------- > 2:  d787afe77f branch: fix die_if_checked_out() when ignore_current_worktree
2:  6e9ed45f4e = 3:  4c418d37f8 rebase: refuse to switch to a branch already checked out elsewhere (test)
3:  a66e58e7b2 = 4:  00b075af6a switch: reject if the branch is already checked out elsewhere (test)

Diff against v2:
diff --git a/branch.c b/branch.c
index aa854fa65f..64b7dbfd17 100644
--- a/branch.c
+++ b/branch.c
@@ -820,10 +820,8 @@ void remove_branch_state(struct repository *r, int verbose)
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
 	struct worktree **worktrees = get_worktrees();
-	int i;
 
-	for (i = 0; worktrees[i]; i++)
-	{
+	for (int i = 0; worktrees[i]; i++) {
 		if (worktrees[i]->is_current && ignore_current_worktree)
 			continue;
 
diff --git a/worktree.c b/worktree.c
index d500d69e4c..34043d8fe0 100644
--- a/worktree.c
+++ b/worktree.c
@@ -434,17 +434,12 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
 					  const char *symref,
 					  const char *target)
 {
-	const struct worktree *existing = NULL;
-	int i = 0;
 
-	for (i = 0; worktrees[i]; i++) {
-		if (is_shared_symref(worktrees[i], symref, target)) {
-			existing = worktrees[i];
-			break;
-		}
-	}
+	for (int i = 0; worktrees[i]; i++)
+		if (is_shared_symref(worktrees[i], symref, target))
+			return worktrees[i];
 
-	return existing;
+	return NULL;
 }
 
 int submodule_uses_worktrees(const char *path)
-- 
2.39.0
