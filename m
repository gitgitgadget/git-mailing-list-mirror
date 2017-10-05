Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E7920370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751705AbdJEUcs (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38052 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdJEUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:45 -0400
Received: by mail-wr0-f193.google.com with SMTP id f12so4354454wra.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d88J7RrTei47V8gromvi5+l7RGLC3P3ur8M4tJf0gFQ=;
        b=AYcb8bqCYHTnS7n3xhz6/NAjRPf6wQ7PQC50FxauyfxMW2quxj4/12sLd5pGLVI5QX
         6mppEU2nrFeVpfWMXbDi5WlFZAlM5GhlASb/ZI5TNtHW4JJsL319gjy1ka7bwGgc+8gL
         IRrzGEpjb+ASzYI51KOTtzXQK8ktUPsBJRme6uKNg8nRUscgh8iG/lXT/fCD7JezAM/T
         1ojd2C9MtDMJcyQls2/kE9IhVg2ce9fx/x5cR1A2xaRKezYLLztmVV2C3m/3egLfKDPp
         d9BpHNW5De9P3h5Rl3+Z4RjyBE6vv4rKrqwQWmji58L/tDo5dwDN5GB63u4PbfpurGHC
         3zdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d88J7RrTei47V8gromvi5+l7RGLC3P3ur8M4tJf0gFQ=;
        b=IXf8x3CHNdWfs/6xRBv4Jklqz4pvRD46ccVNJjI4dDZb2QH3GTrSMHYtq+6y9x5vM5
         3DJmYipz9LFhA5KL2w0Em1kglRFhLx1LJvz3K/uyyumhXBK/L8zjp4SCKkcAL5EOmm+S
         bz0TnrqKBQbEMht1RPT3tABQI1xrHBEglAXHG8L2TZ/9lD4OvZEGcrsAPgd109CiD1kO
         Y0+zQvKxvie4z4YpghOv/deRdvTRyuf4bZObnKgHjQtMP3zcC9Pwa5qj6VYMJjB+h1yH
         ck5jouKCdlsvroAG3Sj5Lk1dPmkQlPLYcWk/Aa/LGbccd3OSu5jp16h/B63Ti5kL9hKb
         cHiA==
X-Gm-Message-State: AMCzsaUJPI/nvxfw2kElEmMbZhz4sFjiVD6GFYcLLVNoLn1/+jL81KOV
        iF2+wFVbZ1/HCQXFU37h+tIrdsXh
X-Google-Smtp-Source: AOwi7QCKfxUbLAElbf5iqtXyDdU/kBLwLzpROX2aqE2BFrN04LJ4vFXwdubWoYzSKrlezVIhEodHHg==
X-Received: by 10.223.139.82 with SMTP id v18mr6103563wra.55.1507235564205;
        Thu, 05 Oct 2017 13:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:43 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/12] checkout-index: simplify locking logic
Date:   Thu,  5 Oct 2017 22:32:07 +0200
Message-Id: <fe78be885bb4f5a4e021abdf80097cd5c497746f.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`newfd` starts out negative. If we then take the lock, `newfd` will
become non-negative. We later check for exactly that property before
calling `write_locked_index()`. That is, we are simply using `newfd` as
a boolean to keep track of whether we took the lock or not. (We always
use `newfd` and `lock_file` together, so they really are mirroring each
other.)

Drop `newfd` and check with `is_lock_file_locked()` instead. While at
it, move the `static struct lock_file` into `cmd_checkout_index()` and
make it non-static. It is only used in this function, and after
076aa2cbd (tempfile: auto-allocate tempfiles on heap, 2017-09-05), we
can have lockfiles on the stack.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v2: New patch.

 builtin/checkout-index.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 39c8be05d..b0e78b819 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -129,8 +129,6 @@ static const char * const builtin_checkout_index_usage[] = {
 	NULL
 };
 
-static struct lock_file lock_file;
-
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
@@ -150,7 +148,7 @@ static int option_parse_stage(const struct option *opt,
 int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	int newfd = -1;
+	struct lock_file lock_file = LOCK_INIT;
 	int all = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
@@ -206,7 +204,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (index_opt && !state.base_dir_len && !to_tempfile) {
 		state.refresh_cache = 1;
 		state.istate = &the_index;
-		newfd = hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+		hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	/* Check out named files first */
@@ -251,7 +249,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	if (all)
 		checkout_all(prefix, prefix_length);
 
-	if (0 <= newfd &&
+	if (is_lock_file_locked(&lock_file) &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die("Unable to write new index file");
 	return 0;
-- 
2.14.2.666.gea220ee40

