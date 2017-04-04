Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EE420964
	for <e@80x24.org>; Tue,  4 Apr 2017 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbdDDVJE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 17:09:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:21458 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754092AbdDDVJC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 17:09:02 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E607484616;
        Tue,  4 Apr 2017 17:09:00 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 2/4] read-cache: add strcmp_offset function
Date:   Tue,  4 Apr 2017 21:08:45 +0000
Message-Id: <20170404210847.50860-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170404210847.50860-1-git@jeffhostetler.com>
References: <20170404210847.50860-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add strcmp_offset() function to also return the offset of the
first change.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 cache.h      |  1 +
 read-cache.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/cache.h b/cache.h
index 80b6372..4d82490 100644
--- a/cache.h
+++ b/cache.h
@@ -574,6 +574,7 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
 extern int verify_path(const char *path);
+extern int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change);
 extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
 extern void adjust_dirname_case(struct index_state *istate, char *name);
 extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
diff --git a/read-cache.c b/read-cache.c
index 9054369..b3fc77d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -887,6 +887,35 @@ static int has_file_name(struct index_state *istate,
 	return retval;
 }
 
+
+/*
+ * Like strcmp(), but also return the offset of the first change.
+ */
+int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change)
+{
+	const unsigned char *s1 = (const unsigned char *)s1_in;
+	const unsigned char *s2 = (const unsigned char *)s2_in;
+	int diff = 0;
+	int k;
+
+	*first_change = 0;
+	for (k=0; s1[k]; k++)
+		if ((diff = (s1[k] - s2[k])))
+			goto found_it;
+	if (!s2[k])
+		return 0;
+	diff = -1;
+
+found_it:
+	*first_change = k;
+	if (diff > 0)
+		return 1;
+	else if (diff < 0)
+		return -1;
+	else
+		return 0;
+}
+
 /*
  * Do we have another file with a pathname that is a proper
  * subset of the name we're trying to add?
-- 
2.9.3

