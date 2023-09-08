Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C8EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbjIHXbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjIHXbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:16 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74EE46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:06 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37636)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeP-00FHT2-Pq; Fri, 08 Sep 2023 17:12:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeO-009u13-KK; Fri, 08 Sep 2023 17:12:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:47 -0500
Message-Id: <20230908231049.2035003-30-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeO-009u13-KK;;;mid=<20230908231049.2035003-30-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19R7ltaLW1xXtFciYsER75FXlQa1q2Njt0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 30/32] builtin/index-pack: Make the stack in compute_compat_oid explicit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Testing index-pack generating the compatibilty hashes on a large
repository (in this case the linux kernel) resulted in a stack
overflow.  I confirmed this by using ulimit -s to force the stack to a
much larger size, and rerunning the test and the code succeeded.
Still it is not a good look to overflow the stack in the default
configuration.

Ideally the objects would be ordered such that no object has any
references to any object that comes after it.  With such an ordering
convert_object_file followed by hash_object_file to could just be on
every object in order to compute the compatibility hashes for every
object.

Unfortunately the work to compute such an order is roughly equaivalent
to the depth first processing compute_compat_oid is doing.  The
objects have to be loaded to get which other objects they reference.
Knowning which objects reference which others is necessary to compute
such an order.

Long story short I can see how to move the depth first traversal into
a topological sort, but that just moves the problem that caused the
deep recursion into another function, and makes everything more
expensive by requiring reading the objects yet another time.

Avoid stack overflow by using an explicitly stack made of heap
allocated objects instead of using the C call stack.

To get a feel for how much this explicit stack consumes I instrumented
up the code.  Testing against a linux kernel 2.16GiB packfile.  This
packfile had 9,033,248 objects, and 7,470,317 deltas.  There were
6,543,758 mappings that cound not be computed opportunistically when
the data was first read.  In the function compute_compat_oid I
measured a maximum cco stack depth of 66,415.  I measured a maximum
memory consumption of 103,783,520 bytes, or about 1563 bytes per level
of the stack. In short call it 100MiB extra to compute the mappings in
a 2GiB packfile.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/index-pack.c | 106 +++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 35 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f5da671ed82d..6827d14b91ce 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2015,54 +2015,90 @@ static void *get_object_data(struct object_entry *obj, size_t *result_size)
 	return NULL; /* The code never reaches here */
 }
 
-static void compute_compat_oid(struct object_entry *obj)
-{
-	struct repository *repo = the_repository;
-	const struct git_hash_algo *algo = repo->hash_algo;
-	const struct git_hash_algo *compat = repo->compat_hash_algo;
+struct cco {
+	struct cco *prev;
+	struct object_entry *obj;
 	struct object_file_convert_state state;
-	struct strbuf out = STRBUF_INIT;
+	struct strbuf out;
 	size_t data_size;
 	void *data;
-	int ret;
+};
 
-	if (obj->idx.compat_oid.algo)
-		return;
+static struct cco *cco_push(struct cco *prev, struct object_entry *obj)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *algo = repo->hash_algo;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct cco *cco;
 
 	if (obj->real_type == OBJ_BLOB)
-		die("Blob object not converted");
+		BUG("Blob object not converted");
 
-	data = get_object_data(obj, &data_size);
+	cco = xmallocz(sizeof(*cco));
+	cco->prev = prev;
+	cco->obj = obj;
+	strbuf_init(&cco->out, 0);
 
-	convert_object_file_begin(&state, &out, algo, compat,
-				  data, data_size, obj->real_type);
+	cco->data = get_object_data(obj, &cco->data_size);
 
-	for (;;) {
-		struct object_entry *pobj;
-		ret = convert_object_file_step(&state);
-		if (ret != 1)
-			break;
-		/* Does it name an object in the pack? */
-		pobj = find_in_oid_index(&state.oid);
-		if (pobj) {
-			compute_compat_oid(pobj);
-			oidcpy(&state.mapped_oid, &pobj->idx.compat_oid);
-		} else if (repo_oid_to_algop(repo, &state.oid, compat,
-					     &state.mapped_oid))
-			die(_("No mapping for oid %s to %s\n"),
-			    oid_to_hex(&state.oid), compat->name);
-	}
-	convert_object_file_end(&state, ret);
-	if (ret != 0)
-		die(_("Bad object %s\n"), oid_to_hex(&obj->idx.oid));
-	hash_object_file(compat, out.buf, out.len, obj->real_type,
-			 &obj->idx.compat_oid);
-	strbuf_release(&out);
+	convert_object_file_begin(&cco->state, &cco->out, algo, compat,
+				  cco->data, cco->data_size, obj->real_type);
+	return cco;
+}
 
-	free(data);
+static struct cco *cco_pop(struct cco *cco, int ret)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct cco *prev = cco->prev;
+
+	convert_object_file_end(&cco->state, ret);
+	if (ret != 0)
+		die(_("Bad object %s\n"), oid_to_hex(&cco->obj->idx.oid));
+	hash_object_file(compat, cco->out.buf, cco->out.len,
+			 cco->obj->real_type, &cco->obj->idx.compat_oid);
+	strbuf_release(&cco->out);
+	if (prev)
+		oidcpy(&prev->state.mapped_oid, &cco->obj->idx.compat_oid);
 
 	nr_resolved_mappings++;
 	display_progress(progress, nr_resolved_mappings);
+
+	free(cco->data);
+	free(cco);
+
+	return prev;
+}
+
+static void compute_compat_oid(struct object_entry *obj)
+{
+	struct repository *repo = the_repository;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	struct cco *cco;
+
+	cco = cco_push(NULL, obj);
+	for (;cco;) {
+		struct object_entry *pobj;
+
+		int ret = convert_object_file_step(&cco->state);
+		if (ret != 1) {
+			cco = cco_pop(cco, ret);
+			continue;
+		}
+
+		/* Does it name an object in the pack? */
+		pobj = find_in_oid_index(&cco->state.oid);
+		if (pobj && pobj->idx.compat_oid.algo)
+			oidcpy(&cco->state.mapped_oid, &pobj->idx.compat_oid);
+		else if (pobj)
+			cco = cco_push(cco, pobj);
+		else if (repo_oid_to_algop(repo, &cco->state.oid, compat,
+					   &cco->state.mapped_oid))
+			die(_("When converting %s no mapping for oid %s to %s\n"),
+			    oid_to_hex(&cco->obj->idx.oid),
+			    oid_to_hex(&cco->state.oid),
+			    compat->name);
+	}
 }
 
 static void compute_compat_oids(void)
-- 
2.41.0

