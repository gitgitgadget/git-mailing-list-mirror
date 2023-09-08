Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0446EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbjIHXbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbjIHXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:41 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB92121
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34892)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeA-007R4a-Eh; Fri, 08 Sep 2023 17:12:18 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qeke9-009u13-It; Fri, 08 Sep 2023 17:12:18 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:41 -0500
Message-Id: <20230908231049.2035003-24-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qeke9-009u13-It;;;mid=<20230908231049.2035003-24-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+5H1npDdUAtKBB5i7WVOopukoiZ92XGAU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 24/32] builtin/pack-objects:  Communicate the compatibility hash through struct pack_idx_entry
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When pack-objects is run all objects in the repository should already
have a compatibilty hash computed so it is just necessary to read
the existing mappings and store the value in struct pack_idx_entry.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/pack-objects.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d34902002656..ff04660a18fd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -42,6 +42,7 @@
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
 #include "parse-options.h"
+#include "object-file-convert.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
@@ -1547,10 +1548,16 @@ static struct object_entry *create_object_entry(const struct object_id *oid,
 						struct packed_git *found_pack,
 						off_t found_offset)
 {
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
 	struct object_entry *entry;
 
 	entry = packlist_alloc(&to_pack, oid);
 	entry->hash = hash;
+	if (compat &&
+	    repo_oid_to_algop(repo, &entry->idx.oid, compat,
+			      &entry->idx.compat_oid))
+		die(_("can't map object %s while writing pack"), oid_to_hex(oid));
 	oe_set_type(entry, type);
 	if (exclude)
 		entry->preferred_base = 1;
-- 
2.41.0

