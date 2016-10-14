Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952DE1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbcJNNUX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755254AbcJNNSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:09 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F07B61E4C;
        Fri, 14 Oct 2016 13:17:35 +0000 (UTC)
Received: from pirat-work.redhat.com (vpn1-4-60.ams2.redhat.com [10.36.4.60])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9EDHAJj008901;
        Fri, 14 Oct 2016 09:17:33 -0400
From:   Petr Stodulka <pstodulk@redhat.com>
To:     git@vger.kernel.org
Cc:     pstodulk@redhat.com, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] resolve_ref_unsafe(): limit the number of "stat_ref" retries
Date:   Fri, 14 Oct 2016 15:16:52 +0200
Message-Id: <1476451012-9925-3-git-send-email-pstodulk@redhat.com>
In-Reply-To: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
References: <1476451012-9925-1-git-send-email-pstodulk@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 14 Oct 2016 13:17:35 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael Haggerty <mhagger@alum.mit.edu>

If there is a broken symlink where a loose reference file is expected,
then the attempt to open() it fails with ENOENT. This error is
misinterpreted to mean that the loose reference file itself has
disappeared due to a race, causing the lookup to be retried. But in
this scenario, the retries all suffer from the same problem, causing
an infinite loop.

So put a limit (of 5) on the number of times that the stat_ref step
can be retried.

Based-on-patch-by: Petr Stodulka <pstodulk@redhat.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d16feb1..245a0b5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,6 +1353,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	int fd;
 	int ret = -1;
 	int save_errno;
+	int retries = 0;
 
 	*type = 0;
 	strbuf_reset(&sb_path);
@@ -1390,7 +1391,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	if (S_ISLNK(st.st_mode)) {
 		strbuf_reset(&sb_contents);
 		if (strbuf_readlink(&sb_contents, path, 0) < 0) {
-			if (errno == ENOENT || errno == EINVAL)
+			if ((errno == ENOENT || errno == EINVAL) &&
+				retries++ < MAXRETRIES) 
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
@@ -1426,7 +1428,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	 */
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT)
+		if (errno == ENOENT && retries++ < MAXRETRIES)
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 708b260..37e6b99 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -255,6 +255,12 @@ int rename_ref_available(const char *old_refname, const char *new_refname);
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define SYMREF_MAXDEPTH 5
 
+/* 
+ * We allow only MAXRETRIES tries to jump on stat_ref, because of possible
+ * infinite loop
+ */
+#define MAXRETRIES 5
+
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
-- 
2.5.5

