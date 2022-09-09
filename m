Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93953ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 19:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiIITrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIITrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 15:47:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634B883DA
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 12:45:05 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v2-20020a056830090200b006397457afecso1705579ott.13
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4YL8imvrk/C+EZ/lfCpR2K/c/MZwHJ8jvgUSjLb21Dk=;
        b=c3qA/fypL4MEjp1AzHxz160V/k0DiiVCFRoJ7r+9L3D3L95VvDhM5K5bhvfQwyGjGV
         1NGGo8EhKOCwBGTdxNFRYHX5JqxnqNsO6FLk1nTAlolyvuFjVsM4uZuxbp9PMx9sU/k0
         fZ5ZgVLMXsgUWTKDlGJhPkvGSUx55bqOpHWwN0zWn6VCQqmkUbHaBFTBr1AKy/ELL3id
         BwWzpaHCSxJ0+WiiV16cFMm228GFVPeFvvA1grPxBZ/G4KnmiDGLE9CtXLHeLimhryiA
         Edw/yte4VgV8jhCE5RWfccXIziBDrtVXR9JAADiHmrn6vQMGXmkk2YcUYql2C5lHWAeh
         HLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4YL8imvrk/C+EZ/lfCpR2K/c/MZwHJ8jvgUSjLb21Dk=;
        b=W5hu94/XJhFTCokcd2rTXbs3rHbiioQHrGC3JpLtMW3m0Jvt4hhosbEPbexOnRWx9B
         P0oMNyzjvVbSzKthdmIrzT5M9LHvPi3AP5izZuSq+bblAerefmFoZHGcEgiI1sli0K5h
         a3xWehJO8jk6+K2/5S1kiCuxFIxpDFxzRZZO4jPR1w6Xo+QwryzHMIpC0h1HIegxlm29
         TAxj4qjthEdGtd81d0vD2JmkDtuxw8DCLdDGk7xps+2CBwVF9wlfZxGslmDc/QYNzvmU
         N/veTaN0/WxUxe9eTI9UZLzNPuP1WLcXNpk8fgOPDXA4qdC6kufh0ILVf6FGyHQ9vxqy
         1isg==
X-Gm-Message-State: ACgBeo3Ox96U9Xlf/o9F2Dj0rKspCv7hxUA1kkHrEZyAlZ8eJNpmC9MZ
        +0L+z16TsNUuxZFFjWHe6yQ=
X-Google-Smtp-Source: AA6agR7toOZBhr64kvMt340Kgy3tLMHRBxpSbTt5d0NCddMVSyZJEcRrqJNMWJQbtYxL1CLtKll+ZQ==
X-Received: by 2002:a05:6830:3910:b0:63b:2195:31a9 with SMTP id br16-20020a056830391000b0063b219531a9mr6075344otb.91.1662752704508;
        Fri, 09 Sep 2022 12:45:04 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id d96-20020a9d2969000000b0065126423321sm107100otb.76.2022.09.09.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:45:03 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, vdye@github.com
Subject: [PATCH v2] builtin/mv.c: fix possible segfault in add_slash()
Date:   Fri,  9 Sep 2022 12:44:58 -0700
Message-Id: <20220909194458.264735-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
References: <20220908230223.239970-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A possible segfault was introduced in c08830de41 (mv: check if
<destination> is a SKIP_WORKTREE_DIR, 2022-08-09).

When running t7001 with SANITIZE=address, problem appears when running:

	git mv path1/path2/ .
or
	git mv directory ../
or
	any <destination> that makes dest_path[0] an empty string.

The add_slash() call could segfault when dest_path[0] is an empty string,
because it was accessing a null value in such case.

Change add_slash() to check the path argument is a non-empty string
before accessing its value. If the path is empty, return it as-is.

Explanation:

It's OK for add_slash() to return an empty string as-is. add_slash()
converts its path argument to the prefix (for "folder1/file1",
"folder1/" is the prefix we mean here) for the result path. The path
argument is an empty string _iff_ the result path is analyzed to be at
the top level (this normalization process is done earlier by
internal_prefix_pathspec()).

Because the prefix for a top-level path is an empty string, thus
add_slash() should return an empty path argument as-is, both for
correctness and avoiding inappropriate memory access.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
Range-diff against v1:
1:  a5dccc030c ! 1:  82353f457d builtin/mv.c: fix possible segfault in add_slash()
    @@ Commit message
         or
                 any <destination> that makes dest_path[0] an empty string.
     
    -    The add_slash() call segfaults when dest_path[0] is an empty string,
    +    The add_slash() call could segfault when dest_path[0] is an empty string,
         because it was accessing a null value in such case.
     
         Change add_slash() to check the path argument is a non-empty string
    -    before accessing its value.
    +    before accessing its value. If the path is empty, return it as-is.
     
    -    The purpose of add_slash() is adding a slash to the end of a string to
    -    construct a directory path. And, because adding a slash to an empty
    -    string is of no use here, and checking the string value without checking
    -    it is non-empty leads to segfault, we should make sure the length of the
    -    string is positive to solve both problems.
    +    Explanation:
    +
    +    It's OK for add_slash() to return an empty string as-is. add_slash()
    +    converts its path argument to the prefix (for "folder1/file1",
    +    "folder1/" is the prefix we mean here) for the result path. The path
    +    argument is an empty string _iff_ the result path is analyzed to be at
    +    the top level (this normalization process is done earlier by
    +    internal_prefix_pathspec()).
    +
    +    Because the prefix for a top-level path is an empty string, thus
    +    add_slash() should return an empty path argument as-is, both for
    +    correctness and avoiding inappropriate memory access.
     
         Reported-by: Jeff King <peff@peff.net>
         Helped-by: Jeff King <peff@peff.net>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Derrick Stolee <derrickstolee@github.com>
         Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
     
      ## builtin/mv.c ##

 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2d64c1e80f..3413ad1c9b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -71,7 +71,7 @@ static const char **internal_prefix_pathspec(const char *prefix,
 static const char *add_slash(const char *path)
 {
 	size_t len = strlen(path);
-	if (path[len - 1] != '/') {
+	if (len && path[len - 1] != '/') {
 		char *with_slash = xmalloc(st_add(len, 2));
 		memcpy(with_slash, path, len);
 		with_slash[len++] = '/';

base-commit: e71f9b1de6941c8b449d0c0e17e457f999664bc9
-- 
2.37.0

