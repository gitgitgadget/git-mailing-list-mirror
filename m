Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEADEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjIHXMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344775AbjIHXMn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:12:43 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB78E46
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:12:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39970)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeR-006Mz5-Rm; Fri, 08 Sep 2023 17:12:35 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekeQ-009u13-SE; Fri, 08 Sep 2023 17:12:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:48 -0500
Message-Id: <20230908231049.2035003-31-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekeQ-009u13-SE;;;mid=<20230908231049.2035003-31-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/8pbldQrsM7Fw6wO8gSYSrsAIUxrJLnEM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 31/32] unpack-objects: Update to compute and write the compatibility hashes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To properly generate the compatibility hash objects that are referred
to must be written before the objects that refer to them.  When
--strict is set the unpack-objects already writes objects in that
order.

When a compatibilty hash is desired force use of the same code
path that --strict uses.   If --strict is not wanted don't
actually fsck the object buffers, just use fsck_walk to
walk to the parents of the objects recursively.

Unlike in index-pack nothing special needs to be done when an object
is written.  The guarantee that referred to objects are written to the
loose object store before their refers ensures that the object
mappings are in the loose object map.  The object mapings being in the
loose object map guarantees that the call to convert_object_file can
find all of the mappings of the referred to objects.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 builtin/unpack-objects.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 32505255a009..834551142cd8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -241,7 +241,8 @@ static int check_object(struct object *obj, enum object_type type,
 	obj_buf = lookup_object_buffer(obj);
 	if (!obj_buf)
 		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
-	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
+	if (strict &&
+	    fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("fsck error in packed object");
 	fsck_options.walk = check_object;
 	if (fsck_walk(obj, NULL, &fsck_options))
@@ -270,7 +271,7 @@ static void added_object(unsigned nr, enum object_type type,
 static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
-	if (!strict) {
+	if (!strict && !the_repository->compat_hash_algo) {
 		if (write_object_file(buf, size, type,
 				      &obj_list[nr].oid) < 0)
 			die("failed to write object");
@@ -409,7 +410,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 		die(_("inflate returned (%d)"), data.status);
 	git_inflate_end(&zstream);
 
-	if (strict) {
+	if (strict || the_repository->compat_hash_algo) {
 		struct blob *blob = lookup_blob(the_repository, &info->oid);
 
 		if (!blob)
@@ -670,11 +671,10 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	unpack_all();
 	the_hash_algo->update_fn(&ctx, buffer, offset);
 	the_hash_algo->final_oid_fn(&oid, &ctx);
-	if (strict) {
+	if (strict || the_repository->compat_hash_algo)
 		write_rest();
-		if (fsck_finish(&fsck_options))
-			die(_("fsck error in pack objects"));
-	}
+	if (strict && fsck_finish(&fsck_options))
+		die(_("fsck error in pack objects"));
 	if (!hasheq(fill(the_hash_algo->rawsz), oid.hash))
 		die("final sha1 did not match");
 	use(the_hash_algo->rawsz);
-- 
2.41.0

