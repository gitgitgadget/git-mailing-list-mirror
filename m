Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09DB2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbcJYSRU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:17:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755892AbcJYSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:17:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 739544812A;
        Tue, 25 Oct 2016 14:16:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=/Wq8
        mayldTomTPEKWEXsOQgbE4U=; b=gIrTiiL2GFUtSGduqj+LtSHRe4j/jkxr5sQT
        FyyDNtpz9sB2SVIRsNVpeavB5jjbJ+LEMv5o68zD+lLtwaN9r2Sjx/4LPMvzVNcr
        XOUzFB3jVJwYghygvddc/5/jZ+gSfpoN0NGkanyRoeF8NacSxUaHgPPc+S26KDNN
        rJOn9cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        E1q9q/KefpncHP8mXizdI2yHEJcndZBItKCwFQiAB3T+5Lva3y7S4cQ5meFUS8g/
        xoCE1XAiYPj0ploxs2wWvyXYrdfZLOvHukW5JINY5HxntrDhVmSAOZSWvzGgaM25
        Ypq6fU9lOq/Y7z8isFfHji8Os/rtUbtJ4kdkupjG4UM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 693D448129;
        Tue, 25 Oct 2016 14:16:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA10C48128;
        Tue, 25 Oct 2016 14:16:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 3/3] read-cache: make sure file handles are not inherited by child processes
Date:   Tue, 25 Oct 2016 11:16:21 -0700
Message-Id: <20161025181621.4201-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-777-gd068e6bde7
In-Reply-To: <20161025181621.4201-1-gitster@pobox.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
X-Pobox-Relay-ID: 2CB37084-9ADF-11E6-8BFA-987C12518317-77302942!pb-smtp1.pobox.com
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

Fix this problem by opening files in read-cache with the O_CLOEXEC flag
to ensure that the file descriptor does not remain open in a newly
spawned process similar to 05d1ed6148 ("mingw: ensure temporary file
handles are not inherited by child processes", 2016-08-22).

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With Eric's suggestion to avoid repeated EINVAL and fallback,
   implemented with Dscho's "write open twice explicitly, we are
   retrying after all" coding style.

 read-cache.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 38d67faf70..db5d910642 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,7 +156,14 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
 	int match = -1;
-	int fd = open(ce->name, O_RDONLY);
+	static int cloexec = O_CLOEXEC;
+	int fd = open(ce->name, O_RDONLY | cloexec);
+
+	if ((cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		cloexec &= ~O_CLOEXEC;
+		fd = open(ce->name, O_RDONLY | cloexec);
+	}
 
 	if (fd >= 0) {
 		unsigned char sha1[20];
-- 
2.10.1-777-gd068e6bde7

