Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC8CC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 18:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiF2SqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiF2SqG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 14:46:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9DA3EF29
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:45:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id v6so12765220qkh.2
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=45PPgvs47uQVLRW8vx0jQD35V+xYebNEUK4soB/ZLlg=;
        b=3YwW9cAgLIjY0yw+BEzY/YDrNzMNxA7EdvipqH3WX2axHXTbM43gvp6xwfgNLKacLO
         AeqdZXC867Jg237AwOSLy3J6PZALLEZBXhTC+I6SobjC7b7q37jAmI4WFh5VtAitJQZu
         rsfc5v5isXs/oCUgGTcxm/8glRNXP1p3kaoTL+v2Jt9gmvR5+Maghi/oBDETdBGJLYlu
         C+ZueI6ApkODeFoSZ/1PXAkNwpe2Mk32pMnUqvg6g4dzgsFuSMvv5xQBMmM8E8QKluLi
         i7AMGctqsEyqMFum3UFyTOxJ4P12CNiF0RVu0sXm9kQzc51DFgzb4/mpvSav09HNb395
         XI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45PPgvs47uQVLRW8vx0jQD35V+xYebNEUK4soB/ZLlg=;
        b=J8AdYyIElk6Hn9aZ1MiVsw556JlsZ9dR70SWWvpnLu/PTMuroXg2hgaEsLN2XLnUHr
         YO6XFB+zGC/rHTQxrT3hyqBjbsozluzyedli2cBg7NBHmLvdrn5ifHPT6LVE9W2HBLqC
         8OVBSzFZKl+Tk+rFPn2ZkV3qCrAL1gv5jgynpqHh5oC5PmDY8MOjQd+ULeocfZPtR7i2
         KNox4uIztVLH6X8XJpN6d4JOaA35CRUsgzrqlv1NJKglyeHyuPugD7o1HtKMSEEP40xE
         rBKUgbim9PohUcwLEa3x5KBRZuzeIZuWXDMj54ikL5wFeCq21JYZuNCJIV/qxEKkpCaM
         QIOw==
X-Gm-Message-State: AJIora8UKoidoKHse5sUtQQxBDd6S+dt3ucHQSUix9zPcPqylA4UgHTY
        8vSHGPSo2cGXCVtJ+PuuPAamntyFYwzarg==
X-Google-Smtp-Source: AGRyM1vyihSNJeQOqPHifjbbZqlARKqopLF6KEeAAV1+LMHTw95CF2Rt9zcBpJ0RdVGFegd70jyM6w==
X-Received: by 2002:a05:620a:294a:b0:6ae:fb7f:831 with SMTP id n10-20020a05620a294a00b006aefb7f0831mr3291442qkp.130.1656528356341;
        Wed, 29 Jun 2022 11:45:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s12-20020a05620a29cc00b006a36b0d7f27sm14653953qkp.76.2022.06.29.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:45:56 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:45:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: [RFC PATCH 1/4] builtin/repack.c: pass "out" to
 `prepare_pack_objects`
Message-ID: <eff341cce1f037625c247ac5f168008c8676f5f8.1656528343.git.me@ttaylorr.com>
References: <cover.1656528343.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1656528343.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`builtin/repack.c`'s `prepare_pack_objects()` is used to prepare a set
of arguments to a `pack-objects` process which will generate a desired
pack.

A future patch will add an `--expire-to` option which allows `git
repack` to write a cruft pack containing the pruned objects out to a
separate repository. Prepare for this by teaching that function to write
packs to an arbitrary location specified by the caller.

All existing callers of `prepare_pack_objects()` will pass `packtmp` for
`out`, retaining the existing behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4a7ae4cf48..025882a075 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -188,7 +188,8 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 }
 
 static void prepare_pack_objects(struct child_process *cmd,
-				 const struct pack_objects_args *args)
+				 const struct pack_objects_args *args,
+				 const char *out)
 {
 	strvec_push(&cmd->args, "pack-objects");
 	if (args->window)
@@ -211,7 +212,7 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--quiet");
 	if (delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
-	strvec_push(&cmd->args, packtmp);
+	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
 }
@@ -275,7 +276,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
 
-	prepare_pack_objects(&cmd, args);
+	prepare_pack_objects(&cmd, args, packtmp);
 	cmd.in = -1;
 
 	/*
@@ -673,7 +674,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 	FILE *in, *out;
 	int ret;
 
-	prepare_pack_objects(&cmd, args);
+	prepare_pack_objects(&cmd, args, packtmp);
 
 	strvec_push(&cmd.args, "--cruft");
 	if (cruft_expiration)
@@ -862,7 +863,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	sigchain_push_common(remove_pack_on_signal);
 
-	prepare_pack_objects(&cmd, &po_args);
+	prepare_pack_objects(&cmd, &po_args, packtmp);
 
 	show_progress = !po_args.quiet && isatty(2);
 
-- 
2.37.0.1.g1379af2e9d

