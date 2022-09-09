Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF3ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 22:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIIWhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIIWhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 18:37:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC8F3BCD
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 15:37:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r6so2402502qtx.6
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 15:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zKgghAoH2WJXipP65RtKo/fe43gBMyKeUEoUUR7WYJs=;
        b=dY1UFt0SYdMQyDoo0Qu1Wl20J4G0MGFhhS/yB0MLhasEV7UhDTrKDNYIk6rpm5I6LT
         BO3/9x5BBt2q+VJJalwPOCMLbV/6FM5khidQ4PFdya/EwLGAhZWcei/fnmKciL16b724
         AM9ElInzI9n4Cf29trkn47CkTW3FKyFBa1UntcJadmizzvDh23KM1uC8EGkuGqUia8qg
         2bCwbRdBR8NcYIqsnDO8jRUjdb4GYxN90H+dFBcwMNQTjzIcc+3K3SrUV2tYh/bebTki
         qnOcandNGEeFBOKgZHv4IhwoXM+yn5Iz6RpWhS9LKQ5ds/aXkPW5a6JmB2wZRjJ5qO4o
         mYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zKgghAoH2WJXipP65RtKo/fe43gBMyKeUEoUUR7WYJs=;
        b=epnfbNvAqmKCLtfUl1SHaODcRulHlLcje9SLlKKT/YysSbC8EYyVRXT3+j4YLyACzx
         BWMRH09slsI+p2AVhub/7bOivn0M25RIJf/eOnl4iyv0rIQfSAeXPRoaRyuZCXVpTGcR
         we0pc8bvekV8r7crR1jrRjr7nJsPVMLhLO1JYwSDpbdsMwN+usn0d405s3N5IMfazeIo
         h4+9IUsxHebZFKyENYca+C9l0pfedAy9RlvUo9icRMqjzUi0OVvVvvjWu4HNLPd/c/9s
         jKlG6iQ4hsn3UbsIIQ7Ziq4ELQVVcw+iCT0N0bBBg/Vx/brfr3AKNONf7FFG6VEtij1+
         VAqQ==
X-Gm-Message-State: ACgBeo3wmbuCU9WiQpYsI4Pzoujfb5cHG/BpeyW4+Y4MB3JyqD/OtTKL
        /qb57qGOP4OXXZJGUNyvkVc=
X-Google-Smtp-Source: AA6agR6crYB2WPQNeyAAFILfUN4AVGgxqrqP6n7SCzbgsJipn0u9lVO1fT+sKUN61gVKc4LB4mQqUg==
X-Received: by 2002:ac8:58cf:0:b0:35b:a373:c506 with SMTP id u15-20020ac858cf000000b0035ba373c506mr3408615qta.371.1662763040818;
        Fri, 09 Sep 2022 15:37:20 -0700 (PDT)
Received: from ffyuanda.localdomain (99-110-131-145.lightspeed.irvnca.sbcglobal.net. [99.110.131.145])
        by smtp.gmail.com with ESMTPSA id f17-20020a05622a105100b0031ee918e9f9sm1378373qte.39.2022.09.09.15.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 15:37:20 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, vdye@github.com
Subject: [PATCH v3] builtin/mv.c: fix possible segfault in add_slash()
Date:   Fri,  9 Sep 2022 15:27:36 -0700
Message-Id: <20220909222736.279362-1-shaoxuan.yuan02@gmail.com>
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

The add_slash() call could segfault when path argument to it is an empty
string, because it makes an out-of-bounds read to decide if an extra
slash '/' needs to be appended to it.

As add_slash() is used to make sure that a valid pathname to a file in
the given directory can be made by appending a filename after the value
returned from it, if path is an empty string, we want to return it
as-is.  The path to a file "F" in the top-level of the working tree
(i.e. path=="") is formed by appending "F" after "" (i.e. path) without
any slash in between.

So, just like the case where a non-empty path already ends with a slash,
return an empty path as-is.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
Range-diff against v2:
1:  1120dc7e6b ! 1:  569e618013 builtin/mv.c: fix possible segfault in add_slash()
    @@ Commit message
         or
                 any <destination> that makes dest_path[0] an empty string.
     
    -    The add_slash() call could segfault when dest_path[0] is an empty string,
    -    because it was accessing a null value in such case.
    -
    -    Change add_slash() to check the path argument is a non-empty string
    -    before accessing its value. If the path is empty, return it as-is.
    -
    -    Explanation:
    -
    -    It's OK for add_slash() to return an empty string as-is. add_slash()
    -    converts its path argument to the prefix (for "folder1/file1",
    -    "folder1/" is the prefix we mean here) for the result path. The path
    -    argument is an empty string _iff_ the result path is analyzed to be at
    -    the top level (this normalization process is done earlier by
    -    internal_prefix_pathspec()).
    -
    -    Because the prefix for a top-level path is an empty string, thus
    -    add_slash() should return an empty path argument as-is, both for
    -    correctness and avoiding inappropriate memory access.
    +    The add_slash() call could segfault when path argument to it is an empty
    +    string, because it makes an out-of-bounds read to decide if an extra
    +    slash '/' needs to be appended to it.
    +
    +    As add_slash() is used to make sure that a valid pathname to a file in
    +    the given directory can be made by appending a filename after the value
    +    returned from it, if path is an empty string, we want to return it
    +    as-is.  The path to a file "F" in the top-level of the working tree
    +    (i.e. path=="") is formed by appending "F" after "" (i.e. path) without
    +    any slash in between.
    +
    +    So, just like the case where a non-empty path already ends with a slash,
    +    return an empty path as-is.
     
         Reported-by: Jeff King <peff@peff.net>
         Helped-by: Jeff King <peff@peff.net>

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

base-commit: a6b4b080e4ef65ebbab73e47c0100b5dc12e104c
-- 
2.37.0

