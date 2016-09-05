Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451C920705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbcIEVLV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:11:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34761 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933286AbcIEVLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:11:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id w12so5852027wmf.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 14:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGkSdsaOzZF9U5leIzVe0khaKA2LLunJfzxKYp6Vpnw=;
        b=vM9c9Ux8xXADD1oP44nouzVmW4P8vf2EWwLkrWQwTWmNyr3v/G3JiyYjkTKCOc3EaW
         2cJmD8BOl0WP9hCn9R/Is/Vz3Nxol9H927VxQBCWcAWiWfnvDOaY9I46Ohqiudy7dktr
         531D/W3dItI7Fug4Sm5/3jRfgXCYIYuoUyFFJxCRxQBx30+zWt5+cu4uiZkSGD76mNZc
         JkeQ/Q4+G4y2Yy7BkpMjYOuEX+cnFwL/hKrC1wGvL33s7ovKWtSTj1dS6G8FODX6PYqJ
         Dc5Sf62RNRwVolNx6beNR+VatSTeHiSk8mSI0XWBSku9OZ2E3PJ5SomquOj62bCWzk6n
         A9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGkSdsaOzZF9U5leIzVe0khaKA2LLunJfzxKYp6Vpnw=;
        b=gf41M3eMI1oHOqo+EhsPXgMAdwmdiDVhRaJS4BpRibgxwbF72sL8ft+SyiAlucosND
         6x127Ft2mVm0I0p78BfX/HvMJiinaZc+ISc+XeNbTKKl6kmX1/uA0tyAgFzdIhXmOU1t
         mgQZxnMoPjU0aYXOPQLWFCTXcBLlVzZtRu0XzKG0ckcpeJrWYUYmJL3u3LM3eHWzLbjU
         7CUrFbT+T4XvdRLRwsP/G9eKCy9S/YH21pf8X7/e6810pXRzw7fMwrQKHyk+OFRvaraY
         HKYHk4ZWLmXEAugg/ZuB/auTQ1FIxTnb1yDBr6VEbAO37HOsa4tcGdbWim+qoOO6VpTB
         j4Cw==
X-Gm-Message-State: AE9vXwOcdkQfiv7r8kAyMPAKzUNa147iK9SDnjU69HPGNasHrWXuyKYAzoi63PPPrPDcoQ==
X-Received: by 10.28.52.2 with SMTP id b2mr17896816wma.109.1473109877669;
        Mon, 05 Sep 2016 14:11:17 -0700 (PDT)
Received: from far1pr3662.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id r4sm29555818wjs.13.2016.09.05.14.11.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 14:11:16 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, Johannes.Schindelin@gmx.de,
        e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 2/2] read-cache: make sure file handles are not inherited by child processes
Date:   Mon,  5 Sep 2016 23:11:11 +0200
Message-Id: <20160905211111.72956-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160905211111.72956-1-larsxschneider@gmail.com>
References: <20160905211111.72956-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

This fix prepares a series with the goal to avoid launching a new
clean/smudge filter process for each file that is filtered. A new
long running filter process is introduced that is used to filter all
files in a single Git invocation.

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
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 491e52d..02f74d3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,7 +156,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-- 
2.10.0

