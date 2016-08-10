Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173781FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938961AbcHJTAV (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:00:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35636 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbcHJTAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:00:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so11356460wmg.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:00:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8OC4zGX9puebC84dNMiuF1RUoqYkX9OSeaMulSA/os=;
        b=rT6sL9B9Ov4nBYHW8cxAHCGCxGE8ZhB7VO8LWdKXTdWyJRzNFzHEFI6/xDZvt4s3Fz
         znOffDAYF3p0B5xdnIfrz8TFaWXJPx/OBLkZIo4caLTZ+LU+wGf/qKNKPbAYvcz42KNi
         RyrGrCpJduLchfUdpZINXRd7XcNDVYlbydFKxvB0pFxR4SdgXVZc6t8YNL4QFedjbXC3
         h6ToGnpV59oGTz4qG7qkXc3THY/d+2LO5sWZHeVs7kI/JBUo4a3VbADV32QXe02gSexp
         gncTh2FUWilUR6qV8q1ss/YTqTwdIAcakEiW10DOfDrcfPTll9fxiuPqLbMvPytcUcBs
         tALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R8OC4zGX9puebC84dNMiuF1RUoqYkX9OSeaMulSA/os=;
        b=ThflrhadoZkvur7PHJEqo1jXTdmwGNzZEmd/xiFN38KlxNIe6+YmCJVFUcclh95Y5S
         ejaBPRmFXknGqmSDzY2JvnWlLZNP13ZQD2ZBP9vQNup75nRmM1Ot50RrQ29X9YyZdT7D
         UqyX6tPkkL9zN0267g5nUqymv9xwLs9jcru8Htd5MAoaBHx61oB/JJEMmZ4ppi7TMVE3
         1cAo77vH6+g4oapZ4YRHyDXZ9TzY/2cA6Y5UFWa2KndvIdTk+ymXHDc4I1c+vwH68PJz
         +n7otn2DGyYh26HZvM5U6PWEtqOBujchQZA6/k2u431hC5FU0xdDKYYWMU4PtaMk7jrJ
         kGbw==
X-Gm-Message-State: AEkooutHckHasgZHtWInNh0f0tN7HU32hWm1BgcxLIu1RVQFuu827nZ+yz7aBi18uCY5FQ==
X-Received: by 10.28.197.1 with SMTP id v1mr3027206wmf.8.1470834268674;
        Wed, 10 Aug 2016 06:04:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:28 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 15/15] read-cache: make sure file handles are not inherited by child processes
Date:	Wed, 10 Aug 2016 15:04:11 +0200
Message-Id: <20160810130411.12419-16-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Consider the case of a file that requires filtering and is present in branch A
but not in branch B. If A is the current HEAD and we checkout B then the
following happens:

1. ce_compare_data() opens the file
2.   index_fd() detects that the file requires to run a clean filter and
     calls index_stream_convert_blob()
4.     index_stream_convert_blob() calls convert_to_git_filter_fd()
5.       convert_to_git_filter_fd() calls apply_filter() which creates a new
         long running filter process (in case it is the first file of this kind
         to be filtered)
6.       The new filter process inherits all file handles. This is the default
         on Linux/OSX and is explicitly defined in the `CreateProcessW` call
         in `mingw.c` on Windows.
7. ce_compare_data() closes the file
8. Git unlinks the file as it is not present in B

The unlink operation does not work on Windows because the filter process has
still an open handle to the file. Apparently that is no problem on Linux/OSX.
Probably because "[...] the two file descriptors share open file status flags"
(see fork(2)).

Fix this problem by opening files in read-cache with the `O_CLOEXEC` flag to
ensure that the file descriptor does not remain open in a newly spawned process.
`O_CLOEXEX` is defined as `O_NOINHERIT` on Windows. A similar fix for temporary
file handles was applied on Git for Windows already:
https://github.com/git-for-windows/git/commit/667b8b51ec850c3e1c7d75dee69dc13c29d1f162

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index db27766..f481dee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -159,7 +159,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-- 
2.9.2

