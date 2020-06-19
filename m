Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC9C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C8C20776
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="d5AyOW8o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394473AbgFSR5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39524 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404431AbgFSR4c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 62DF960A64;
        Fri, 19 Jun 2020 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589385;
        bh=+4Z4pf0T9fzuVPGr+GKKdEY7iEgxxGa0MzEFtugw7Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=d5AyOW8oLGefHdH8b2cEZhvr3R2VFT+5FrWD3RMCt7g+zzoMYV9R6t3akCpYKAPjI
         YktWW98Y0SdpzElaSBrm2wuXSLze9ZsfLnPR8dgN7AaaRFCQ/HewZ7vj1xzuRP4hsS
         GY+g7Ov2NikfWuRfPo+gSCHFIbsM1LRu6+TqeN5PKev6QQxviHEmD4CgzxHsZ4YV0R
         vkFdMpOzQLl5j5TEfP6ygdCjQJeXETFMsnvR1qm57xZNk7dg/ig/wCF9GQ9O04JZQP
         K2vfJp106SO2uKsiqWV6S3mN0lIp4ao7drmfrzIx6+ymlIZNOxnfOWfqb61YMWXWlZ
         lDhTGWMUG1aPa6d2k9FifEw4sLdEmkaSIXp32Uk2IhhtJuXAc8S6nN3RiIOsdONs4/
         a4i5cFHSF5FvdTIy7YG6ywZS3uLZY+s0AWHEqUzvF58i/MSzGL09IP6oEQpNAc+gfm
         tCJw2ijsLdW9Lg0Rv3RvL8gstuVITrMsWL5VBd4HwhbjgD76POk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 24/44] packfile: compute and use the index CRC offset
Date:   Fri, 19 Jun 2020 17:55:41 +0000
Message-Id: <20200619175601.569856-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both v2 pack index files and the v3 format specified as part of the
NewHash work have similar data starting at the CRC table.  Much of the
existing code wants to read either this table or the offset entries
following it, and in doing so computes the offset each time.

In order to share as much code between v2 and v3, compute the offset of
the CRC table and store it when the pack is opened.  Use this value to
compute offsets to not only the CRC table, but to the offset entries
beyond it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 6 +-----
 object-store.h       | 1 +
 packfile.c           | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f176dd28c8..7bea1fba52 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1555,13 +1555,9 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 {
 	const uint32_t *idx1, *idx2;
 	uint32_t i;
-	const uint32_t hashwords = the_hash_algo->rawsz / sizeof(uint32_t);
 
 	/* The address of the 4-byte offset table */
-	idx1 = (((const uint32_t *)p->index_data)
-		+ 2 /* 8-byte header */
-		+ 256 /* fan out */
-		+ hashwords * p->num_objects /* object ID table */
+	idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
 		+ p->num_objects /* CRC32 table */
 		);
 
diff --git a/object-store.h b/object-store.h
index d1e490f203..f439d47af8 100644
--- a/object-store.h
+++ b/object-store.h
@@ -70,6 +70,7 @@ struct packed_git {
 	size_t index_size;
 	uint32_t num_objects;
 	uint32_t num_bad_objects;
+	uint32_t crc_offset;
 	unsigned char *bad_object_sha1;
 	int index_version;
 	time_t mtime;
diff --git a/packfile.c b/packfile.c
index f4e752996d..6ab5233613 100644
--- a/packfile.c
+++ b/packfile.c
@@ -178,6 +178,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		     */
 		    (sizeof(off_t) <= 4))
 			return error("pack too large for current definition of off_t in %s", path);
+		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
 	}
 
 	p->index_version = version;
