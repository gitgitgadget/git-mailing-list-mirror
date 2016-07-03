Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7495420179
	for <e@80x24.org>; Sun,  3 Jul 2016 07:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbcGCH6d (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 03:58:33 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55391 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339AbcGCH6c convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 03:58:32 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id 148B230007B;
	Sun,  3 Jul 2016 00:58:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=1IC1j
	DSl+//jGBILT0OrGgdbAiQ=; b=HQy3y+lIt1E86hoxpG/j05xu+8xlYQeEvYv2o
	C9x1/o72iK9g3dcZVNVbZt+3k8DPdJX6gsdCX3Pz64GUwrlXP2wFVfvXvJ7G5wC9
	DY1YyLtLGF3ADsCsR1sVx3BE+K5/sqS3PnjDx0PMFcZ4ncAxpwtcSmDTEaBCCokZ
	3VbR8E=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 559F1300061;
	Sun,  3 Jul 2016 00:58:31 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 05/21] index-helper: add --strict
Date:	Sun,  3 Jul 2016 03:57:57 -0400
Message-Id: <1467532693-20017-6-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

There are "holes" in the index-helper approach because the shared
memory is not verified again by git. If $USER is compromised, shared
memory could be modified. But anyone who could do this could already
modify $GIT_DIR/index. A more realistic risk is some bugs in
index-helper that produce corrupt shared memory. --strict is added to
avoid that.

Strictly speaking there's still a very small gap where corrupt shared
memory could still be read by git: after we write the trailing SHA-1 in
the shared memory (thus signaling "this shm is ready") and before
verify_shm() detects an error.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt |  9 +++++++
 cache.h                            |  1 +
 index-helper.c                     | 48 ++++++++++++++++++++++++++++++++++++++
 read-cache.c                       |  9 ++++---
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index fa6e347..ca5a9de 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -25,6 +25,15 @@ OPTIONS
 	Exit if the cached index is not accessed for `<n>`
 	seconds. Specify 0 to wait forever. Default is 600.
 
+--strict::
+--no-strict::
+	Strict mode makes index-helper verify the shared memory after
+	it's created. If the result does not match what's read from
+	$GIT_DIR/index, the shared memory is destroyed. This makes
+	index-helper take more than double the amount of time required
+	for reading an index, but because it will happen in the
+	background, it's not noticable. `--strict` is enabled by default.
+
 NOTES
 -----
 
diff --git a/cache.h b/cache.h
index 2d7af6f..6cb0d02 100644
--- a/cache.h
+++ b/cache.h
@@ -345,6 +345,7 @@ struct index_state {
 		  * on it.
 		  */
 		 to_shm : 1,
+		 always_verify_trailing_sha1 : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/index-helper.c b/index-helper.c
index 4672e1a..163586a 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,6 +17,7 @@ struct shm {
 
 static struct shm shm_index;
 static struct shm shm_base_index;
+static int to_verify = 1;
 
 static void release_index_shm(struct shm *is)
 {
@@ -122,11 +123,56 @@ static void share_index(struct index_state *istate, struct shm *is)
 	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1);
 }
 
+static int verify_shm(void)
+{
+	int i;
+	struct index_state istate;
+	memset(&istate, 0, sizeof(istate));
+	istate.always_verify_trailing_sha1 = 1;
+	istate.to_shm = 1;
+	i = read_index(&istate);
+	if (i != the_index.cache_nr)
+		goto done;
+	for (; i < the_index.cache_nr; i++) {
+		struct cache_entry *base, *ce;
+		/* namelen is checked separately */
+		const unsigned int ondisk_flags =
+			CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
+		unsigned int ce_flags, base_flags, ret;
+		base = the_index.cache[i];
+		ce = istate.cache[i];
+		if (ce->ce_namelen != base->ce_namelen ||
+		    strcmp(ce->name, base->name)) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+		ce_flags = ce->ce_flags;
+		base_flags = base->ce_flags;
+		/* only on-disk flags matter */
+		ce->ce_flags   &= ondisk_flags;
+		base->ce_flags &= ondisk_flags;
+		ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
+			     offsetof(struct cache_entry, name) -
+			     offsetof(struct cache_entry, ce_stat_data));
+		ce->ce_flags = ce_flags;
+		base->ce_flags = base_flags;
+		if (ret) {
+			warning("mismatch at entry %d", i);
+			break;
+		}
+	}
+done:
+	discard_index(&istate);
+	return i == the_index.cache_nr;
+}
+
 static void share_the_index(void)
 {
 	if (the_index.split_index && the_index.split_index->base)
 		share_index(the_index.split_index->base, &shm_base_index);
 	share_index(&the_index, &shm_index);
+	if (to_verify && !verify_shm())
+		cleanup_shm();
 	discard_index(&the_index);
 }
 
@@ -224,6 +270,8 @@ int main(int argc, char **argv)
 	struct option options[] = {
 		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
 			    N_("exit if not used after some seconds")),
+		OPT_BOOL(0, "strict", &to_verify,
+			 N_("verify shared memory after creating")),
 		OPT_END()
 	};
 
diff --git a/read-cache.c b/read-cache.c
index 10d5465..befc499 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1672,9 +1672,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 
 	istate->mmap = mmap;
 	istate->mmap_size = mmap_size;
-	if (try_shm(istate) &&
-	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
-		goto unmap;
+	if (try_shm(istate)) {
+		if (verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
+	} else if (istate->always_verify_trailing_sha1 &&
+		   verify_hdr(istate->mmap, istate->mmap_size) < 0)
+			goto unmap;
 	hdr = mmap = istate->mmap;
 	mmap_size = istate->mmap_size;
 	if (!istate->keep_mmap)
-- 
1.9.1

