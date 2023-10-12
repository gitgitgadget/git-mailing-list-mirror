Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3258C41513
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbjJLQKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbjJLQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:09:58 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE51094
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:09:56 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 04DD25B07D;
        Thu, 12 Oct 2023 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1697126996;
        bh=Er1KCoat2TS2G+4DgbrWpD+++iArBPkNwn3eEjnAF7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=a8Spry84hsXrqVpQiEDuzU/Z/vckdV7q/mJiQi0KUJZDgSf+neIRCb0DU1CC+j/ZY
         W7sJpyu8+ZeY5qOtSI9sJC/DvnwaCeHEvOtwR44cCPDz2StGNdPCmN5TCVB/bEojgh
         J6LwETlUTSUPIJHf1CJ4ThnX3gt8n3nCAiZeFF8AwjTEy5L1+GEzZ7Uh63XiI5QyKl
         wLF64uWHbpWoBOK3KlgXQr/iokP+nGLYmatW3Jz9vF43Rqn2UB1r4NnSIX4BQnJ6+7
         fPDiRvloaEXH7q5fh+gwkQ17z0nxoScmX1JwHl+TU61CRavK/d5HWM8H9P58JEy3ER
         JrEinvVIobTzeOIW284wzUU3OIaK8UBQ4uMSeitbJS2FWetwYaFe2VeMTvhut3/nDh
         CpNVtDoXk3RA0RA+A1Y2UXJRajsaJbkJ7yzcpvO4cxMHl4IHwlhA2+A+7ZxIkc8ibS
         k5CMUxDkQun32hatvInxO+SwjxDqQS8nzhcmsvr8F3Jdz3m696J
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jason Hatton <jhatton@globalfinishing.com>
Subject: [PATCH v2 2/2] Prevent git from rehashing 4GiB files
Date:   Thu, 12 Oct 2023 16:09:30 +0000
Message-ID: <20231012160930.330618-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012160930.330618-1-sandals@crustytoothpaste.net>
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jason Hatton <jhatton@globalfinishing.com>

The index stores file sizes using a uint32_t. This causes any file
that is a multiple of 2^32 to have a cached file size of zero.
Zero is a special value used by racily clean. This causes git to
rehash every file that is a multiple of 2^32 every time git status
or git commit is run.

This patch mitigates the problem by making all files that are a
multiple of 2^32 appear to have a size of 1<<31 instead of zero.

The value of 1<<31 is chosen to keep it as far away from zero
as possible to help prevent things getting mixed up with unpatched
versions of git.

An example would be to have a 2^32 sized file in the index of
patched git. Patched git would save the file as 2^31 in the cache.
An unpatched git would very much see the file has changed in size
and force it to rehash the file, which is safe. The file would
have to grow or shrink by exactly 2^31 and retain all of its
ctime, mtime, and other attributes for old git to not notice
the change.

This patch does not change the behavior of any file that is not
an exact multiple of 2^32.

Signed-off-by: Jason D. Hatton <jhatton@globalfinishing.com>
Signed-off-by: brian m. carlson <bk2204@github.com>
---
 statinfo.c        | 20 ++++++++++++++++++--
 t/t7508-status.sh | 16 ++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/statinfo.c b/statinfo.c
index 17bb8966c3..9367ca099c 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -2,6 +2,22 @@
 #include "environment.h"
 #include "statinfo.h"
 
+/*
+ * Munge st_size into an unsigned int.
+ */
+static unsigned int munge_st_size(off_t st_size) {
+	unsigned int sd_size = st_size;
+
+	/*
+	 * If the file is an exact multiple of 4 GiB, modify the value so it
+	 * doesn't get marked as racily clean (zero).
+	 */
+	if (!sd_size && st_size)
+		return 0x80000000;
+	else
+		return sd_size;
+}
+
 void fill_stat_data(struct stat_data *sd, struct stat *st)
 {
 	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
@@ -12,7 +28,7 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
 	sd->sd_ino = st->st_ino;
 	sd->sd_uid = st->st_uid;
 	sd->sd_gid = st->st_gid;
-	sd->sd_size = st->st_size;
+	sd->sd_size = munge_st_size(st->st_size);
 }
 
 int match_stat_data(const struct stat_data *sd, struct stat *st)
@@ -51,7 +67,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 			changed |= INODE_CHANGED;
 #endif
 
-	if (sd->sd_size != (unsigned int) st->st_size)
+	if (sd->sd_size != munge_st_size(st->st_size))
 		changed |= DATA_CHANGED;
 
 	return changed;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 6928fd89f5..6c46648e11 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1745,4 +1745,20 @@ test_expect_success 'slow status advice when core.untrackedCache true, and fsmon
 	)
 '
 
+test_expect_success EXPENSIVE 'status does not re-read unchanged 4 or 8 GiB file' '
+	(
+		mkdir large-file &&
+		cd large-file &&
+		# Files are 2 GiB, 4 GiB, and 8 GiB sparse files.
+		test-tool truncate file-a 0x080000000 &&
+		test-tool truncate file-b 0x100000000 &&
+		test-tool truncate file-c 0x200000000 &&
+		# This will be slow.
+		git add file-a file-b file-c &&
+		git commit -m "add large files" &&
+		git diff-index HEAD file-a file-b file-c >actual &&
+		test_must_be_empty actual
+	)
+'
+
 test_done
