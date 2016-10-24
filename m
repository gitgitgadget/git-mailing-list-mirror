Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99591FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757298AbcJXSDH (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 14:03:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36599 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757202AbcJXSDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 14:03:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id c78so16914wme.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zsBJlIUJC0tPNhozLiu06PXlFIB0t1PPWebMciJeZiA=;
        b=vB9wWDhAnGNWqpdAmMdvdnUSTUyYzPEV0ScP3C5GtxpVk6/55si6qtccEuHfy+VQei
         lvl9aAwFnqW52x+NqaB7wwNR9HUpLBSAn4WEqwuxmtQf8SiKIcifmlBpwr+ff+elFFSh
         YZJ3mPP0lWoFjMN5KbVCx18EK8UwVdqCKt47yW962zSRLavx76HhV+U5N6gA+MvGJiQY
         vsWQSmlRBjvRd1j6LXle4pCuChdkzFdSQJfqQ88pG1RtWQCDSIlU/j1g3ZR7IykdV0Zd
         UwSZmYX12q6v/ZFD2oXlXm6Vl7hzUKsaQqgrTJU/UVNRQcVEagM+3Qgd+4iguz8HLpWa
         Umow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zsBJlIUJC0tPNhozLiu06PXlFIB0t1PPWebMciJeZiA=;
        b=S6uQOJGJmUCK0Yi6JXjCNuDmYvYkCnG16pdiA2dyfTelvbz/0U22gxS/slIrJuABYN
         2UOZxRSEO4DTb9ubr6ipQtQ25LWYCCm2wjpEBN/CTESabU2FSaCNMJLqlSaPlRY+O5+t
         cu0hn9QhmMvwCBEkUWzFq3esNyHncSynPNaeVTQSSQL5YuS9/GeueRw3ovS2r+H9maYO
         u3vNM1QTBlBowSS28p9cIEQA5+xDmVt5YmzyylcjQxMyMFgvjzqjSWP9HzVRBoOFapnV
         Z1w/hV4GzFxhXikGFi3h2gQAYaYc5hwL+9PKuRQDESkCeTWAcJIpmNs4WKZkTzlotWYp
         OR5Q==
X-Gm-Message-State: ABUngveKezBi8VbRMUiCkiTuwEzhoayLDdQ/LjkdxhsDxUNo82F0n0ms8uX84GeTk2S77Q==
X-Received: by 10.194.79.97 with SMTP id i1mr12532549wjx.222.1477332184149;
        Mon, 24 Oct 2016 11:03:04 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r72sm16020323wmd.21.2016.10.24.11.03.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 11:03:03 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, e@80x24.org, jnareb@gmail.com,
        gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v2 2/2] read-cache: make sure file handles are not inherited by child processes
Date:   Mon, 24 Oct 2016 20:03:00 +0200
Message-Id: <20161024180300.52359-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161024180300.52359-1-larsxschneider@gmail.com>
References: <20161024180300.52359-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

This fixes "convert: add filter.<driver>.process option" (edcc8581) on
Windows.

Consider the case of a file that requires filtering and is present in
branch A but not in branch B. If A is the current HEAD and we checkout B
then the following happens:

1. ce_compare_data() opens the file
2.   index_fd() detects that the file requires to run a clean filter and
     calls index_stream_convert_blob()
4.     index_stream_convert_blob() calls convert_to_git_filter_fd()
5.       convert_to_git_filter_fd() calls apply_filter() which creates a
         new long running filter process (in case it is the first file
         of this kind to be filtered)
6.       The new filter process inherits all file handles. This is the
         default on Linux/OSX and is explicitly defined in the
         `CreateProcessW` call in `mingw.c` on Windows.
7. ce_compare_data() closes the file
8. Git unlinks the file as it is not present in B

The unlink operation does not work on Windows because the filter process
has still an open handle to the file. On Linux/OSX the unlink operation
succeeds but the file descriptors still leak into the child process.

Fix this problem by opening files in read-cache with the CLOEXEC flag to
ensure that the file descriptor does not remain open in a newly spawned
process similar to 05d1ed61.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 read-cache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 38d67fa..b594865 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,7 +156,11 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
+
+	if (O_CLOEXEC && fd < 0 && errno == EINVAL)
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		fd = open(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-- 
2.10.0

