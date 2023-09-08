Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EBEEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjIHXbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjIHXbI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:08 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDE8212A
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:54 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37694)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeU-00FHTK-3m; Fri, 08 Sep 2023 17:12:38 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeS-009u13-UB; Fri, 08 Sep 2023 17:12:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:49 -0500
Message-Id: <20230908231049.2035003-32-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeS-009u13-UB;;;mid=<20230908231049.2035003-32-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19I/XbGBI/Kx8ojoZqRVwW7X0RIbQiXenc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 32/32] object-file-convert: Implement repo_submodule_oid_to_algop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From time to time git tree objects contain gitlinks.  These gitlinks
contain the oid of an object in another git repository.  To
succesfully translate these oids it is necessary to look at the
mapping tables in the submodules where the mapping tables live.

Limiting myself to submodule interfaces I can see in the code
repo_submodule_oid_to_algop is the best I can figure out how to do,
for a gitlink agnostic implementation.

The big downsides are that the code as implemented is not thread
safe, it depends upon a worktree, and it always walks through
all of the submodules.

There are interfaces in the code to lookup the submodule for an
individual gitlink.  As such iterating all of the submodules could be
avoided if care was taken to compute the path to the gitlink and to
recognizes the code is translating a gitlink.

The dependency on a worktree, and the thread safety issues
I do not see a solution to short of reworking how git
deals with submodules.

For now repo_oid_to_algop does not call repo_submodule_oid_to_algop to
allow avoiding the thread safety issues.

Update callers of repo_oid_to_algop that can benefit from a submodule
translation to also call repo_sumodule_oid_to_algop.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/fast-import.c |  5 ++++-
 builtin/index-pack.c  |  4 +++-
 object-file-convert.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 object-file-convert.h |  5 +++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f1c250dd3c8f..66c471bc730e 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1070,7 +1070,10 @@ static int store_object(
 			else if (pobj)
 				break;
 			else if (repo_oid_to_algop(repo, &state.oid, compat,
-						   &state.mapped_oid))
+						   &state.mapped_oid) &&
+				 repo_submodule_oid_to_algop(repo, &state.oid,
+							     compat,
+							     &state.mapped_oid))
 				break;
 		}
 		convert_object_file_end(&state, ret);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6827d14b91ce..4100fd56a845 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2093,7 +2093,9 @@ static void compute_compat_oid(struct object_entry *obj)
 		else if (pobj)
 			cco = cco_push(cco, pobj);
 		else if (repo_oid_to_algop(repo, &cco->state.oid, compat,
-					   &cco->state.mapped_oid))
+					   &cco->state.mapped_oid) &&
+			 repo_submodule_oid_to_algop(repo, &cco->state.oid, compat,
+						     &cco->state.mapped_oid))
 			die(_("When converting %s no mapping for oid %s to %s\n"),
 			    oid_to_hex(&cco->obj->idx.oid),
 			    oid_to_hex(&cco->state.oid),
diff --git a/object-file-convert.c b/object-file-convert.c
index 3fd080ebc112..2306e17dd57e 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -11,6 +11,45 @@
 #include "gpg-interface.h"
 #include "pack-compat-map.h"
 #include "object-file-convert.h"
+#include "read-cache.h"
+#include "submodule-config.h"
+
+int repo_submodule_oid_to_algop(struct repository *repo,
+				const struct object_id *src,
+				const struct git_hash_algo *to,
+				struct object_id *dest)
+{
+	int i;
+
+	if (repo_read_index(repo) < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < repo->index->cache_nr; i++) {
+		const struct cache_entry *ce = repo->index->cache[i];
+		struct repository subrepo = {};
+		int ret;
+
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+
+		while (i + 1 < repo->index->cache_nr &&
+		       !strcmp(ce->name, repo->index->cache[i + 1]->name))
+			/*
+			 * Skip entries with the same name in different stages
+			 * to make sure an entry is returned only once.
+			 */
+			i++;
+
+		if (repo_submodule_init(&subrepo, repo, ce->name, null_oid()))
+			continue;
+
+		ret = repo_oid_to_algop(&subrepo, src, to, dest);
+		repo_clear(&subrepo);
+		if (ret == 0)
+			return 0;
+	}
+	return -1;
+}
 
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		      const struct git_hash_algo *to, struct object_id *dest)
@@ -34,6 +73,7 @@ int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		 */
 		if (!repo_packed_oid_to_algop(repo, src, to, dest))
 			return 0;
+
 		/*
 		 * We may have loaded the object map at repo initialization but
 		 * another process (perhaps upstream of a pipe from us) may have
@@ -306,6 +346,11 @@ int convert_object_file(struct strbuf *outbuf,
 			break;
 		ret = repo_oid_to_algop(the_repository, &state.oid, state.to,
 					&state.mapped_oid);
+		if (ret)
+			ret = repo_submodule_oid_to_algop(the_repository,
+							  &state.oid,
+							  state.to,
+							  &state.mapped_oid);
 		if (ret) {
 			error(_("failed to map %s entry for %s"),
 			      type_name(type), oid_to_hex(&state.oid));
diff --git a/object-file-convert.h b/object-file-convert.h
index da032d7a91ef..7a19feda5f0c 100644
--- a/object-file-convert.h
+++ b/object-file-convert.h
@@ -10,6 +10,11 @@ struct strbuf;
 int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
 		      const struct git_hash_algo *to, struct object_id *dest);
 
+int repo_submodule_oid_to_algop(struct repository *repo,
+				const struct object_id *src,
+				const struct git_hash_algo *to,
+				struct object_id *dest);
+
 struct object_file_convert_state {
 	struct strbuf *outbuf;
 	const struct git_hash_algo *from;
-- 
2.41.0

