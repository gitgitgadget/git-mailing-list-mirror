Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19822C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53F9206E4
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t6yH24O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLCQEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:04:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65126 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfLCQEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 11:04:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85E58B370C;
        Tue,  3 Dec 2019 11:04:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eRnUwCMLArvq5iOsEtOOvUeaKdw=; b=t6yH24
        O8zYh7pBZS9aKyOeFt3NJ5eIECivBCyIV8q9fVCsQGVK4UdwyodUovos0EkiyKVU
        6OgCeFHB67is9MoUcOSMGrwQ3xalPaErIzdpVv2drql4IMEERtdndRO8klaRa/Fd
        oCj2rYNEfYPBJxB0/ZBa8DfeXZ4/tRfM+v9kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OdjVSB3BhOA2qR6HpSC/jT02d1/Hd3Hh
        QpfSZ9ZT6g6ttTPmQquJto0sOJUyqvIRh7XzBFlGIiEEemY2VNMx/miVOqgjcz/Q
        qz7U1arPL4J84+cM07zdwNb/HQ0JI6M8/4oH+XThrWOjwduQh2MI9qCuwVj0wovY
        qa9vnlLD1Es=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E218B370A;
        Tue,  3 Dec 2019 11:04:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F552B3707;
        Tue,  3 Dec 2019 11:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
References: <20191127222453.GA3765@owl.colinstolley.com>
        <20191202174035.GJ23183@szeder.dev>
        <20191202194231.GA10707@sigill.intra.peff.net>
Date:   Tue, 03 Dec 2019 08:04:15 -0800
In-Reply-To: <20191202194231.GA10707@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 2 Dec 2019 14:42:31 -0500")
Message-ID: <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FC0A1B2-15E6-11EA-8DB0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good catch. The issue is that we only add entries to the hashmap in
> prepare_packed_git(), but they may be added to the pack list by other
> callers of install_packed_git(). It probably makes sense to just push
> the hashmap maintenance down into that function, like below.

Makes sense to me.

Let me locally squash your fix in and credit you with helped-by
footer in the amended log message.  Strictly speaking, this may
invalidate the perf numbers, but I do not think the scenario p5303
sets up alone is all that interesting anyway---if you have 10,000
packs, not just registering them (which is improved with this patch)
but using objects from them would be slower than necessary X-<.

Thanks.

 -- >8 --

From: Colin Stolley <cstolley@runbox.com>
Date: Wed, 27 Nov 2019 16:24:53 -0600
Subject: [PATCH] packfile.c: speed up loading lots of packfiles

When loading packfiles on start-up, we traverse the internal packfile
list once per file to avoid reloading packfiles that have already
been loaded. This check runs in quadratic time, so for poorly
maintained repos with a large number of packfiles, it can be pretty
slow.

Add a hashmap containing the packfile names as we load them so that
the average runtime cost of checking for already-loaded packs becomes
constant.

Add a perf test to p5303 to show speed-up.

The existing p5303 test runtimes are dominated by other factors and do
not show an appreciable speed-up. The new test in p5303 clearly exposes
a speed-up in bad cases. In this test we create 10,000 packfiles and
measure the start-up time of git rev-parse, which does little else
besides load in the packs.

Here are the numbers for the new p5303 test:

Test                         HEAD^             HEAD
---------------------------------------------------------------------
5303.12: load 10,000 packs   1.03(0.92+0.10)   0.12(0.02+0.09) -88.3%

Signed-off-by: Colin Stolley <cstolley@runbox.com>
Helped-by: Jeff King <peff@peff.net>
[jc: squashed the change to call hashmap in install_packed_git() by peff]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-store.h             | 21 +++++++++++++++++++++
 object.c                   |  3 +++
 packfile.c                 | 19 ++++++++++---------
 t/perf/p5303-many-packs.sh | 18 ++++++++++++++++++
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/object-store.h b/object-store.h
index 7f7b3cdd80..55ee639350 100644
--- a/object-store.h
+++ b/object-store.h
@@ -60,6 +60,7 @@ struct oid_array *odb_loose_cache(struct object_directory *odb,
 void odb_clear_loose_cache(struct object_directory *odb);
 
 struct packed_git {
+	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
 	struct list_head mru;
 	struct pack_window *windows;
@@ -88,6 +89,20 @@ struct packed_git {
 
 struct multi_pack_index;
 
+static inline int pack_map_entry_cmp(const void *unused_cmp_data,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry2,
+				     const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -131,6 +146,12 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	/*
+	 * A map of packfiles to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct hashmap pack_map;
+
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/object.c b/object.c
index 3b8b8c55c9..142ef69399 100644
--- a/object.c
+++ b/object.c
@@ -479,6 +479,7 @@ struct raw_object_store *raw_object_store_new(void)
 
 	memset(o, 0, sizeof(*o));
 	INIT_LIST_HEAD(&o->packed_git_mru);
+	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	return o;
 }
 
@@ -518,6 +519,8 @@ void raw_object_store_clear(struct raw_object_store *o)
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 	o->packed_git = NULL;
+
+	hashmap_free(&o->pack_map);
 }
 
 void parsed_object_pool_clear(struct parsed_object_pool *o)
diff --git a/packfile.c b/packfile.c
index 355066de17..f0dc63e92f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -757,6 +757,9 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
 
 	pack->next = r->objects->packed_git;
 	r->objects->packed_git = pack;
+
+	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
+	hashmap_add(&r->objects->pack_map, &pack->packmap_ent);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -856,20 +859,18 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
 	    !(data->m && midx_contains_pack(data->m, file_name))) {
-		/* Don't reopen a pack we already have. */
-		for (p = data->r->objects->packed_git; p; p = p->next) {
-			size_t len;
-			if (strip_suffix(p->pack_name, ".pack", &len) &&
-			    len == base_len &&
-			    !memcmp(p->pack_name, full_name, len))
-				break;
-		}
+		struct hashmap_entry hent;
+		char *pack_name = xstrfmt("%.*s.pack", (int)base_len, full_name);
+		unsigned int hash = strhash(pack_name);
+		hashmap_entry_init(&hent, hash);
 
-		if (!p) {
+		/* Don't reopen a pack we already have. */
+		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
 			p = add_packed_git(full_name, full_name_len, data->local);
 			if (p)
 				install_packed_git(data->r, p);
 		}
+		free(pack_name);
 	}
 
 	if (!report_garbage)
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 3779851941..ede78e19e2 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -84,4 +84,22 @@ do
 	'
 done
 
+# Measure pack loading with 10,000 packs.
+test_expect_success 'generate lots of packs' '
+	for i in $(test_seq 10000); do
+		echo "blob"
+		echo "data <<EOF"
+		echo "blob $i"
+		echo "EOF"
+		echo "checkpoint"
+	done |
+	git -c fastimport.unpackLimit=0 fast-import
+'
+
+# The purpose of this test is to evaluate load time for a large number
+# of packs while doing as little other work as possible.
+test_perf "load 10,000 packs" '
+	git rev-parse --verify "HEAD^{commit}"
+'
+
 test_done
-- 
2.24.0-578-g4820254054

