Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD5C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F5060F6F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhIKUop (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:44:45 -0400
Received: from mout.web.de ([212.227.15.3]:51813 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKUop (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631393007;
        bh=uCjBRV+uxPeb9a8ciZ5vB8vyzzvgzks4y9F7yoY5PLk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=L01pj9IOBUacfbUcmIzvz2oRO2O4oDT7k73QjD5LzJ2JazIwczpPzj/xKwJ2Ch3qJ
         wL2dByHdTBSpvMwySTOddFrr4K3lwOKLzv8kB37OkpcHcZIu7pKGrqh5NhQtND5xpp
         z7jVretSi0maw/O97tZx3vDACRSFRSW3/ULCfkjg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LvS9z-1n7fmG1RhL-010e2d; Sat, 11 Sep 2021 22:43:27 +0200
Subject: [PATCH v2 5/5] packfile: use oidset for bad objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <fb64d00f-b44a-6a23-3ddd-027f1df83a22@web.de>
Date:   Sat, 11 Sep 2021 22:43:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dkVQnLQ33Ee0aPkIGYwUlyuApKeuiB2LBbITuS5nN4Ntr0PuI+3
 x716ExphXNzNaask0vbDBzAlcdGWfYfdYDG5mYTJeDF+QBmIfFBqy4ZjFQMjlKLAlMAbMOi
 wycRF7EWqAX7507Wnt+esE1oZ1pm4nbmLsu/mhl86YcdsUofOyxp6M8V+kNDGoJTp7KKSDX
 AoQTzZ/u9gNuhArvzoKfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfEtr2xQHGE=:olKJ2mPZS619cZJzCHzPZ2
 0UmBK1tbr06PRpXUdTv5702QpUYY5cHivBCJAoINSzL42twaGQdS/DwJnCCCxrrpzcUjT4yAF
 44/YbB2Po4jUhJ5UgV7ny0oQqYPf/FXz4hkb4iPCuVJwJWNCzLURuSjEEwxn5xHKrbu7l3Xnn
 OQRtUhC4YgGtlurO20lBmz+xcBvJEFh9YYgtgcFraLjD2B68jYMfX2HOKy6gtSqW8KbgOrKfo
 HSmNDgDNV5r0efvnYYk83/WbNDOP/O4zA2jMkjucVAJZ4+TtFfx1CSl8uZ0wuyFg1CTVw27tT
 IbwScS6kW3Sfn3yKMbjqA6njgCxczkybPGj4E1TzF2mTWbtGSDfWd5gGf/ukPRMux8ndg0paZ
 TV3JUNWFvqfg+E8VENuEAWNif7jTXcrw6PmWuneqlnPXe/tRur9yLdalfqveBDJxkqANLJtQa
 YxEXOgpxZwRG1C453oVXZ4NLTpmp84LKsBE6u7AnZn/2/5dFySTVKQj77UTKc7MQc1q4Ep2PB
 L8s3hYgP+z9fmAVpdu7y5ZHcGZU08UEWgmEAeFCH5DYSqej/H1DEKtzv47UL6bsplFZve+8ha
 6743hAnQhWJ62qfpLAZxv7dSVwATr008KxvAVgIE/4MpZ/OXXfhBgHOPlouQuKcMR+eU4qzT/
 wiiH27CqFIioCNlpGqUCp0mRBgPntCxMl2bAUEW5AqFpRIKzaoemFVS1khWqM1hf8KtpWT7Dt
 abH6forIVdMQTKIZg6hd53Cf+CtOLjmMWzREe/1grNhsqOd66qd+kliym5+9XT12RprrywtPb
 letTGRRH4u+h0nYzrBk4CKSbziAG4goK2tkdBaPqIc8n/1JnQQ+9dWcKqaNffxTFq4/U0Jat/
 6D5C77ivmwXUVocluFljNFLKPFkDEIVIXJBkdnSNw8GVG3XJIUP6z5GpPusV93037yiHTCOOj
 3GtXQB/40trAc4a5oMFT3rLmvmn1txAKENFXq4bql7plh0m6XZFCOCCXfbDGozUGppRR+np10
 thMb0+c3ETg3rz/xGsMmsE9HKa4aLL+iviYijnT3XagYnlmHCyp1cCXN3d+95Mkr1nVdbpqkF
 OJKAYL+EApjEqQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the object ID of broken pack entries in an oidset instead of
keeping only their hashes in an unsorted array.  The resulting code is
shorter and easier to read.  It also handles the (hopefully) very rare
case of having a high number of bad objects better.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c         | 10 +++-------
 object-store.h |  4 ++--
 packfile.c     | 28 ++++++----------------------
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/midx.c b/midx.c
index 8cb063023c..76322b713c 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -307,13 +307,9 @@ int fill_midx_entry(struct repository * r,
 	if (!is_pack_valid(p))
 		return 0;

-	if (p->num_bad_objects) {
-		uint32_t i;
-		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(oid->hash,
-				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
-				return 0;
-	}
+	if (oidset_size(&p->bad_objects) &&
+	    oidset_contains(&p->bad_objects, oid))
+		return 0;

 	e->offset =3D nth_midxed_offset(m, pos);
 	e->p =3D p;
diff --git a/object-store.h b/object-store.h
index b4dc6668aa..c7bead66f6 100644
=2D-- a/object-store.h
+++ b/object-store.h
@@ -10,6 +10,7 @@
 #include "khash.h"
 #include "dir.h"
 #include "oidtree.h"
+#include "oidset.h"

 struct object_directory {
 	struct object_directory *next;
@@ -75,9 +76,8 @@ struct packed_git {
 	const void *index_data;
 	size_t index_size;
 	uint32_t num_objects;
-	uint32_t num_bad_objects;
 	uint32_t crc_offset;
-	unsigned char *bad_object_sha1;
+	struct oidset bad_objects;
 	int index_version;
 	time_t mtime;
 	int pack_fd;
diff --git a/packfile.c b/packfile.c
index 04080a558b..caba29c624 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -1163,29 +1163,17 @@ int unpack_object_header(struct packed_git *p,

 void mark_bad_packed_object(struct packed_git *p, const struct object_id =
*oid)
 {
-	unsigned i;
-	const unsigned hashsz =3D the_hash_algo->rawsz;
-	for (i =3D 0; i < p->num_bad_objects; i++)
-		if (hasheq(oid->hash, p->bad_object_sha1 + hashsz * i))
-			return;
-	p->bad_object_sha1 =3D xrealloc(p->bad_object_sha1,
-				      st_mult(GIT_MAX_RAWSZ,
-					      st_add(p->num_bad_objects, 1)));
-	hashcpy(p->bad_object_sha1 + hashsz * p->num_bad_objects, oid->hash);
-	p->num_bad_objects++;
+	oidset_insert(&p->bad_objects, oid);
 }

 const struct packed_git *has_packed_and_bad(struct repository *r,
 					    const struct object_id *oid)
 {
 	struct packed_git *p;
-	unsigned i;

 	for (p =3D r->objects->packed_git; p; p =3D p->next)
-		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(oid->hash,
-				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
-				return p;
+		if (oidset_contains(&p->bad_objects, oid))
+			return p;
 	return NULL;
 }

@@ -2016,13 +2004,9 @@ static int fill_pack_entry(const struct object_id *=
oid,
 {
 	off_t offset;

-	if (p->num_bad_objects) {
-		unsigned i;
-		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(oid->hash,
-				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
-				return 0;
-	}
+	if (oidset_size(&p->bad_objects) &&
+	    oidset_contains(&p->bad_objects, oid))
+		return 0;

 	offset =3D find_pack_entry_one(oid->hash, p);
 	if (!offset)
=2D-
2.33.0
