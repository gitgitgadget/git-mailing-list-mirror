Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B17C1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJJByW (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 21:54:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:44023 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJByW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 21:54:22 -0400
Received: by mail-qt1-f201.google.com with SMTP id j24-v6so2515162qtn.10
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+NXNfaiWGWlTRJSDSJS8Iwb4I5qbfrnXz8U4JFwkOBA=;
        b=XoZ5quba2axkbVppEUUbsM+FIKtKpt8napf8qTo3ixoNXHu/JMSc2PiUlB6NdMEjkv
         olAQ+mnxt4AFf6rp0pmHgy//v4YRjgCU1h3dBhQdrToMEO/DmqdhO5pbPY57MUZwoZhY
         xtCqT86yj+W2Iimc5TLU1Cuqjo24VqLZLEYUbDa9MA7KFo3B3xn6MKQXzPubWukurNWt
         DYP+epJTwHJCtvyAbgDB4MqzrwX5+Um+niZP3aM9nLRc2DnuJzydgoldU00AjVQOAQFB
         U7DTpd7mWJEyJlUGgPbeFMaFqAx5vyLJJ7S+5iTi1xIWw4lfItdElU6WTiisY70q7L50
         oLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+NXNfaiWGWlTRJSDSJS8Iwb4I5qbfrnXz8U4JFwkOBA=;
        b=Bj5B2IKfwC2sameW+O7rXvla6jSb6FpK8b9WuYawiJgSMEqZ3SHbqIrKK+EZTnRy54
         kBkvNewZEy/gB/1NtAA4sB6Px9YuotsqEZ+QOH9Lo4Rscj99J5piFrNITFNMUHSvBFDs
         6nR/HmYZWMolV4zp9JbMBCxXip/fsqpilgrg0sxttgLq/HxUxdsS8wnelHqzz8z3937q
         jH/S1Y7bqujLwaHRXadEn1ZFkyiXA1WZQmkOXvCpfJwfGN6mbzs6zITcm5GCWu6NniW2
         iRwukNAy3zwpuhn36X0DoDZOSYf9/nWHWoV915bONXFU1/GfmV3e9C7oLDq7TF5Y9GH8
         S59w==
X-Gm-Message-State: ABuFfoiHhInVJMN40bEBuSKVv4fnt6thxy9HF9JyTdbayMgvSF0yjrmF
        hfTaA3QQYMdL22d5jkQB10tXCWINL1cs
X-Google-Smtp-Source: ACcGV60GFTuufnEL88++TNKPC+UYlXfx85OvN7IdmJIWhM5DhRSsm/9Kb0Obzc2iyutInYxOnSKuvNbcU/tC
X-Received: by 2002:aed:23ac:: with SMTP id j41-v6mr22225728qtc.5.1539110164055;
 Tue, 09 Oct 2018 11:36:04 -0700 (PDT)
Date:   Tue,  9 Oct 2018 11:35:49 -0700
Message-Id: <20181009183549.195316-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] builtin/grep.c: remote superflous submodule code
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, ao2@ao2.it
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f9ee2fcdfa (grep: recurse in-process using 'struct repository',
2017-08-02), we introduced a call to repo_read_gitmodules in builtin/grep
to simplify the submodule handling.

After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
file, 2017-08-03) this is no longer necessary, but that commit did not
cleanup the whole tree, but just show cased the new way how to deal with
submodules in ls-files.

It claimed that grep would still need some explicit handling, but that is
not the call to repo_read_gitmodules (applying this patch on top of
ff6f1f564c4 still keep the test suite happy, specifically
t7814-grep-recurse-submodules, which contains a test
"grep history with moved submoules")

The special handling is the call to gitmodules_config_oid which was added
already in 74ed43711f (grep: enable recurse-submodules to work on
<tree> objects, 2016-12-16), but then was still named
gitmodules_config_sha1.

Signed-off-by: Stefan Beller <sbeller@google.com>
Acked-by: Antonio Ospite <ao2@ao2.it>
---

This is a resend of origin/sb/grep-submodule-cleanup,
and I think picking ff6f1f564c4 as the base for the series would
also be appropriate.

Stefan


 builtin/grep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..a6272b9c2f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -427,8 +427,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	if (repo_submodule_init(&submodule, superproject, path))
 		return 0;
 
-	repo_read_gitmodules(&submodule);
-
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
 	 * alternates for the single in-memory object store.  This has some bad
-- 
2.19.0

