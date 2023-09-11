Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A1EE7FF4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjIKGhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIKGhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:37:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EFFB5
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:37:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E18F61BD9EB;
        Mon, 11 Sep 2023 02:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=R2UfUJ6MUwd4JWCCq0hk2qpNSmS3+46yo/QuvY
        M9ICs=; b=cNuKSfsgX0KwkVdWGWiWl/Jq/lsEj1PxA/JYrckKVQTcbYfVOcFGbt
        MebTxSBNIgNCsClw5gcPmZUi68vfLKYUAuWXDQcuvUZdFT0QbPsJmygGUcHpNVaS
        vsoLtbuHEQpOK+ieR6VigHYr1M5SmNE4kQQ/Zs3pvoqkUtjvblcUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7C7F1BD9EA;
        Mon, 11 Sep 2023 02:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 205AB1BD9E9;
        Mon, 11 Sep 2023 02:37:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC][PATCH 0/32] SHA256 and SHA1 interoperability
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Fri, 08 Sep 2023 18:05:52 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
Date:   Sun, 10 Sep 2023 23:37:13 -0700
Message-ID: <xmqq8r9di5ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4CAED72-506D-11EE-897A-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> I would like to see the SHA256 transition happen so I started playing
> with the k2204-transition-interop branch of brian m. carlson's tree.

I needed these tweaks to build the series standalone on 'master' (or
2.42).  There are semantic merge conflicts with some topics in flight
when this is merged to 'seen', so it may take me a bit more time to
push the integration result.

Thanks.

 builtin/fast-import.c | 2 +-
 bulk-checkin.c        | 2 +-
 commit.c              | 2 +-
 object-file-convert.c | 4 ++--
 pack-write.c          | 1 +
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 66c471bc73..93cc4a491c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -784,7 +784,7 @@ struct pack_index_names {
 
 static struct pack_index_names create_index(void)
 {
-	struct pack_index_names tmp = {};
+	struct pack_index_names tmp = { 0 };
 	struct pack_idx_entry **idx, **c, **last;
 	struct object_entry *e;
 	struct object_entry_pool *o;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 3206412a19..d63b3ffa01 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -264,7 +264,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 	struct hashfile_checkpoint checkpoint = {0};
 	struct pack_idx_entry *idx = NULL;
 	const struct git_hash_algo *compat = the_repository->compat_hash_algo;
-	struct object_id compat_oid = {};
+	struct object_id compat_oid = { 0 };
 
 	seekback = lseek(fd, 0, SEEK_CUR);
 	if (seekback == (off_t) -1)
diff --git a/commit.c b/commit.c
index 54f19ed032..2e2b805d5e 100644
--- a/commit.c
+++ b/commit.c
@@ -1654,7 +1654,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	struct strbuf buffer, compat_buffer;
 	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
 	struct object_id *parent_buf = NULL;
-	struct object_id compat_oid = {};
+	struct object_id compat_oid = { 0 };
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
diff --git a/object-file-convert.c b/object-file-convert.c
index 2306e17dd5..148e61d24f 100644
--- a/object-file-convert.c
+++ b/object-file-convert.c
@@ -26,7 +26,7 @@ int repo_submodule_oid_to_algop(struct repository *repo,
 
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
-		struct repository subrepo = {};
+		struct repository subrepo = { 0 };
 		int ret;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -205,7 +205,7 @@ static int convert_tag_object_step(struct object_file_convert_state *state)
 	const struct git_hash_algo *to = state->to;
 	struct strbuf *out = state->outbuf;
 	const char *buffer = state->buf;
-	size_t payload_size, size = state->buf_len;;
+	size_t payload_size, size = state->buf_len;
 	struct object_id oid;
 	const char *p;
 	int ret = 0;
diff --git a/pack-write.c b/pack-write.c
index f22eea964f..b2ec09737e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -7,6 +7,7 @@
 #include "remote.h"
 #include "chunk-format.h"
 #include "pack-mtimes.h"
+#include "pack-compat-map.h"
 #include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
-- 
2.42.0-158-g94e83dcf5b

