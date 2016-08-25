Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0601E2042F
	for <e@80x24.org>; Thu, 25 Aug 2016 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758157AbcHYL1C (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 07:27:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33747 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758114AbcHYL1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 07:27:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so6980647wme.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yfJrs5EEz88VZZAGgQfByjAmMWurMZ+SV5tNhU7O754=;
        b=h6hdF2MZJsV6sBqGR2VVGwbbXPied9KczSnIvSSqTZnHG9r09P+E23Qu+LRYoS2ZRH
         w9irdw+96YFxaMJ1SrTTgXixcEIQvXQ3UFlQuFjOgUOCsbqJPk6XM9Tz5gf4J4wFgTXS
         dlARieg4EZaDOa11iaNB/4s6hZMbhsetq2RVUWVfHFfxiYfTorbME/ossOjQsU9+YrtO
         AjbANtZjy06PQTuxJZAHYNc8VEqjPmto80bA5etTo2pPKd59exy5unlqiSO5GTbTO84j
         CCntA8q/vqoSdb7HkM2PZqQqsKBb6ZAE/P1Lmm7kSJM4QgooezId3ta5OkcBkZCq91ms
         eRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yfJrs5EEz88VZZAGgQfByjAmMWurMZ+SV5tNhU7O754=;
        b=jrKjr61QgtyECJ+QKpydDICJnVApB1jbMhb7NmcnRZVQHoKCgw5EWfNRvdqstx4LE1
         l0T/HXcK9t8KxSj96FuZ/iLNZI1Mtrb5OhSYZxlhOG1u8aejNkGag2zZ0JvkAfEawhKE
         6WA1U6oUk11ysB74ViTBlqU8nCYqp33IcEAb6OdhD+MiwIESWzafLVruZ6MuSAf6Th1C
         cUpRtvYPT7JU2t4Zuqbid8LYvW00BvsN4ogFPf1P38qe4D5sqj+8aiIs/QJbKdumW7lP
         5rb96ZE2rWAmsFIV75bcPNXzibpG6JUithdMqOjMfw86dba4koJFpJNat/hXHc+CMFXO
         /ghg==
X-Gm-Message-State: AE9vXwPG/hZWjcFm8HbeEKADUARS81aNmOf+mRiiycpAQpNuY84j4UDuMgFL9CKUUHWC2A==
X-Received: by 10.28.142.2 with SMTP id q2mr6457697wmd.119.1472123295658;
        Thu, 25 Aug 2016 04:08:15 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:14 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
Date:   Thu, 25 Aug 2016 13:07:52 +0200
Message-Id: <20160825110752.31581-14-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

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
has still an open handle to the file. Apparently that is no problem on
Linux/OSX. Probably because "[...] the two file descriptors share open
file status flags" (see fork(2)).

Fix this problem by opening files in read-cache with the `O_CLOEXEC`
flag to ensure that the file descriptor does not remain open in a newly
spawned process. `O_CLOEXEC` is defined as `O_NOINHERIT` on Windows. A
similar fix for temporary file handles was applied on Git for Windows
already:
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

