Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCD8EEB571
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbjIHXbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjIHXbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:31:21 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B9E46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:31:14 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37576)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeK-00FHSi-Ov; Fri, 08 Sep 2023 17:12:28 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeJ-009u13-Os; Fri, 08 Sep 2023 17:12:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:45 -0500
Message-Id: <20230908231049.2035003-28-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeJ-009u13-Os;;;mid=<20230908231049.2035003-28-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/tfzKy/AuVG0IDHhV1dEGvNMzsi2+Edfs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 28/32] builtin/index-pack:  Add a simple oid index
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To support computing the compatibility hash a way to lookup objects by
their oid is needed.  This adds a simple hash table to enable looking
up objects by their oid.  The implementation is inspired by the hash
table for looking up object_entries by their oid in struct packing_data,
and implemented in pack-objects.c

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/index-pack.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 006ffdc9c550..75c2113e455c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -126,6 +126,9 @@ static int ref_deltas_alloc;
 static int nr_resolved_deltas;
 static int nr_threads;
 
+static int32_t *oid_index;
+static uint32_t oid_index_size;
+
 static int from_stdin;
 static int strict;
 static int do_fsck_object;
@@ -183,6 +186,62 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
 		pthread_mutex_unlock(mutex);
 }
 
+static uint32_t locate_oid_index(const struct object_id *oid, int *found)
+{
+	uint32_t i, mask = (oid_index_size - 1);
+
+	i = oidhash(oid) & mask;
+
+	while (oid_index[i] > 0) {
+		uint32_t pos = oid_index[i] - 1;
+
+		if (oideq(oid, &objects[pos].idx.oid)) {
+			*found = 1;
+			return i;
+		}
+
+		i = (i + 1) & mask;
+	}
+
+	*found = 0;
+	return i;
+}
+
+static void place_in_oid_index(struct object_entry *obj)
+{
+	int found;
+	uint32_t pos = locate_oid_index(&obj->idx.oid, &found);
+
+	/* Ignore duplicates */
+	if (found)
+		return;
+
+	oid_index[pos] = (obj - objects) + 1;
+}
+
+static struct object_entry *find_in_oid_index(struct object_id *oid)
+{
+	uint32_t i;
+	int found;
+
+	i = locate_oid_index(oid, &found);
+	if (!found)
+		return NULL;
+
+	return &objects[oid_index[i] - 1];
+}
+
+static inline uint32_t closest_pow2(uint32_t v)
+{
+	v = v - 1;
+	v |= v >> 1;
+	v |= v >> 2;
+	v |= v >> 4;
+	v |= v >> 8;
+	v |= v >> 16;
+	return v + 1;
+}
+
 /*
  * Mutex and conditional variable can't be statically-initialized on Windows.
  */
@@ -987,6 +1046,7 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		bad_object(delta_obj->idx.offset, _("failed to apply delta"));
 	hash_object_file(the_hash_algo, result_data, result_size,
 			 delta_obj->real_type, &delta_obj->idx.oid);
+	place_in_oid_index(delta_obj);
 	sha1_object(result_data, NULL, result_size, delta_obj->real_type,
 		    &delta_obj->idx.oid);
 
@@ -1188,12 +1248,16 @@ static void parse_pack_objects(unsigned char *hash)
 			ref_deltas[nr_ref_deltas].obj_no = i;
 			nr_ref_deltas++;
 		} else if (!data) {
+			place_in_oid_index(obj);
+
 			/* large blobs, check later */
 			obj->real_type = OBJ_BAD;
 			nr_delays++;
-		} else
+		} else {
+			place_in_oid_index(obj);
 			sha1_object(data, NULL, obj->size, obj->type,
 				    &obj->idx.oid);
+		}
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1918,6 +1982,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (show_stat)
 		CALLOC_ARRAY(obj_stat, st_add(nr_objects, 1));
 	CALLOC_ARRAY(ofs_deltas, nr_objects);
+	oid_index_size = closest_pow2(nr_objects * 3);
+	CALLOC_ARRAY(oid_index, oid_index_size);
 	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
-- 
2.41.0

