Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E952C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 08:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB3E60F35
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 08:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhIKIDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 04:03:06 -0400
Received: from mout.web.de ([212.227.15.14]:41631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235334AbhIKIDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 04:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631347301;
        bh=w7snnXce2LM+ZPD4VOQ+Mof2r/y6sxTsKSwJhVS4Grs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=LdJPhv1kT4I+JgEyQC+x9FGw0G3bw3hgwD+3yWaSfyUlLcdTrUNXUrj8Ry+hI7a58
         K+VwGRCgtd2K82k66c+TNg11/QqQ943rkskeixMYUcq6jcqf8RVmp8y67R40qVmKtI
         ZToyEVn21Sa/ti5C8a5hIn9TYKywYWhlhxEqcPeI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LxNyU-1n0yJb18eo-016xZI; Sat, 11 Sep 2021 10:01:41 +0200
Subject: [PATCH 3/3] packfile: use oidset for bad objects
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Message-ID: <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
Date:   Sat, 11 Sep 2021 10:01:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eeh0VQEvLSR8qJq3uGQB6DgfdT40Iha9+V+3hhogfSbXz/j9PYO
 6koxjub2pn9Db9u8tiH7y1FpFmHvhLcY6mTSLiUem1ehnbryf8etSNX4PP+YYsdIwRetQ/+
 K5j499Xx3SqaQHumBRsHGSLOaa4CIlzvEs4IsLJedQD7WtArXx3zELkYW+NM3axEcJhGuUO
 25CTpB/xtoy5UoxK2RHtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/YyZCnvPZUI=:HrfR0PJx4MxzT5eO2nVpBV
 CZRe0eylZnR9rPIbSnIv6mzlg3cT66hXh7ygsPj+55NoY648eor/65S+Y8Eek+L/pKnewefCC
 s3rCiRzvAts/Sovgl4N/drPTlYkaNYvmjTLx7kESMHBrdWZ67t4hZmKy391hWKx12n5sJbTXX
 dKLODblU1921sGNJuf4QkwJTNFmsMrO1jCu7Zg3SzOqHawyYXZgmLXLIpf7ltAJtcjVLYW7pw
 rsRppYtQDlR4D0A4KuWyY+o9OBBgp7uA1U3hJaqW+w8rZXrtrGaxcP2k9s4mw27iYqhpmFEgi
 tt1vi+Oqx1GbMmFH4oCVgoSkIrVvWRlxEy/kCA7wdhAOyTDUJqjx4ycxZWr8ah+zvTY6bgAXJ
 wcZ6qJqFcAFbVMY7KYJYHiY+ZPVgf7xk9b3L4RpDmIpucpQ14NRQJE64faU0ispt1jn/SLBzH
 Vg0dPT23Hm9i/32hgcNeL4rR7x2X9arCc7qGn9a9YoEfVpGvD4RiLrfUI1IK5j81P7fo4UYB6
 FoJPZ8WlyffWhIr2PIs1zxNhiPy0qZuyp/Fzf3uSxbXo70oIsE/3Iphaja1wefd20tRzfPpp8
 FrEyGJoAqSmQp46kPlDafQ+VHuyKHd8GzUmDW0clQmm4dxe4x5TkfP5wRQ7wfyQrJgJlgecw1
 +t51qI+pJOGZ19nmdYC5cOfXvZyqgr3KGBrMoGtwE56MrTHZGPbC6bLKJWN+C01RODTOlTpi8
 bTlsggTppT5pffHObKoXCj8GRGly3Cg9o0JeyiqjBYJDZUw5yFyZuGvledc7sKVOSDLWNgZYM
 nYfRlQdguXvtjwHBSTLaWq8aESW3v9hsybNkZyxKf37GsZIucLhPeChxMacgfzxcDEOJh2YMn
 JTy2pscTGOEbVk/Q5BJ8GRDVyhEHgV8T0vKzAe6ZcLcmbd5PUdQh+74ZLYjt6OfNXbZMCCAU2
 hgbx5lPbEpcUtGVfziZz0od4/wY8+HM9gAXx7N1dZI6PWdeQY+yCzhikT30yLcbOsmzHO9JjV
 pq3p2wqgpept1e6tvsZCTRhNcmZNLT5zJTYot5LVEU7ytvFjSox7s07oFkB51iNGEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the object ID of broken pack entries in an oidset instead of
keeping only their hashes in an unsorted array.  The resulting code is
shorter and easier to read.  It also handles the (hopefully) very rare
case of having a high number of bad objects better.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c         | 13 ++++---------
 object-store.h |  4 ++--
 packfile.c     | 27 +++++----------------------
 3 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f..01623fb339 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -283,6 +283,7 @@ static int nth_midxed_pack_entry(struct repository *r,
 {
 	uint32_t pack_int_id;
 	struct packed_git *p;
+	struct object_id oid;

 	if (pos >=3D m->num_objects)
 		return 0;
@@ -303,15 +304,9 @@ static int nth_midxed_pack_entry(struct repository *r=
,
 	if (!is_pack_valid(p))
 		return 0;

-	if (p->num_bad_objects) {
-		uint32_t i;
-		struct object_id oid;
-		nth_midxed_object_oid(&oid, m, pos);
-		for (i =3D 0; i < p->num_bad_objects; i++)
-			if (hasheq(oid.hash,
-				   p->bad_object_sha1 + the_hash_algo->rawsz * i))
-				return 0;
-	}
+	nth_midxed_object_oid(&oid, m, pos);
+	if (oidset_contains(&p->bad_objects, &oid))
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
index 04080a558b..8f6d1d6328 100644
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

@@ -2016,13 +2004,8 @@ static int fill_pack_entry(const struct object_id *=
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
+	if (oidset_contains(&p->bad_objects, oid))
+		return 0;

 	offset =3D find_pack_entry_one(oid->hash, p);
 	if (!offset)
=2D-
2.33.0
