Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9340C4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BBF6044F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhHNUBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 16:01:43 -0400
Received: from mout.web.de ([212.227.15.3]:51955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhHNUBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 16:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628971240;
        bh=tqQ1HdUA2wsjNt0xLFihGNDZOsiL5DKv3xGRph2jMQ4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sCAnjLwiL6uFC9HwfYjG3AC71zNKM8jBsrf3MCI/m8elXt/7IW1pIce76o7Q4gRA4
         UyrGHx94Wds5PK0SUQWiwuJ0MP6+F1pQr13XU2T1yIq4XzpL2sK1ox+BwY29pGzOqP
         TKX9K24O8b8NkEp8BtZW+6LVMUe2VNrvDcFwOpfg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LtFVL-1nDOs706ih-012lLQ; Sat, 14 Aug 2021 22:00:40 +0200
Subject: [PATCH] oidtree: avoid unaligned access to crit-bit tree
To:     Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9583052d-9181-7532-304a-4bacfb9e1147@web.de>
Date:   Sat, 14 Aug 2021 22:00:38 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zhGSI0BBxtmXM8RB/ipa/eRJVdRO4dk4MQZ+CiqKuvo/Kw7ldNk
 NRdU7mPp1uvUIZ2m5ffOC25iLHlq5S+3bClYts4jfClEUkOUCLBKKUs/Ial+6dfAjInaNmL
 p2AsY16GZIagEC7kav6ouPoVbrqNQj66S+FzgVnUIBhE7Mr4zOT+cYS2L2sufzqf7yomdg7
 y9lMmMqIC688hMd3gPOMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TmDmqVxGBAU=:O4Q69b3221KbyiUVpXrbnB
 zw69Tjt2J0AU4ACCVOStHiW95lElBvQzdfSLbOwnoOh9VH6utcYudVKoJSU8SYHdwEe3mGTBK
 pbUxy8CkdaFpl4STLtaaDnhkIYGVI6JtlwyH9cnnCf2No6QClPKu3n4nVujnxNR7tzuwDjEBw
 jBSAgonzGoH2j/xf44VAzf2BQnHDFKrsOharGAimKu47ZTEjd+lpkQM5eAotp/+MqJnIje4sR
 7URst/9sOdbM7uKrH+VsRu7/hW86XB39nGvcv5onmHifu0gF/o1dxF7RFBe/ET8r7IXMNGiNg
 iQhbHdyuUuh5bJ3wP827GtgW4xuxd6RPMTGa/ExvDDeoBdNo/dLsPGXydPBrj83Wc4QEZH35G
 MS4q/dsTTM1uHwxzPMwyk3E6wEPD4RS/48HH1vRAucoO7KDsB4cmx10bhOXar6EtYMY4VJ0T7
 x0OwAe+DSnm9zWlsDz1xt6n0BBD9bRBi3FK3VHc3qjLO9BGdIyXXNhxxv72Ux1csKfyAWxjGm
 nDWkQMHKjreycjdGbv+OBgaG/J7XGzzFnVkpLZtuXMnRmyRI6iwo51RXLlHMemo4qMgToxjEt
 q7ruD2GwGMqrw+bgsf8m9JL0oDDtN+g/+k0se8FqNLJ8zgofLMjpTzXn0oj6pRfzM2WSfdOhR
 aUGyn+lapIWq5k9bDg2TJPDggaklWtmX5MEjtDxRE32/8Jro560BxOh0HwgEmqnVxxR4sudeV
 0vFGGQ/dnpWFELLVbITkUMVKI2+MkujmRVQHiUWeNr1+h/lQImjCxCLszvh9OYkmHbzBEWvFT
 p5y4qcdSuA7NEZYsPKEJqy3cpzJXiJSHQeCfGOIhD2Zk4eQjojQ+FQkh39UaAT0Gn+8Jf6xRo
 BLcmidKm6NgQDp+G0AUnh1jzN0fDSfWxfxXNQ7DDsRXNNvJViUwWFHT7sUfYNxrpDSTpNga+t
 nYXnwG4UaSb9x21dzgZRxoBaqdAVeTWNaNT3ERfZ3hKAp4mXdriaWMq2v8GSBbNXQZ1KVj6kL
 yKZ0mgRHls7oG6OgV4hd9n/wvJEoXRATUPerI1ieDvL4HrKBDzLWHK8k5fsPJT7PLvfb32FOR
 cuLeXGif+f6m161ie165osyht3inBAHiQ8z
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flexible array member "k" of struct cb_node is used to store the key
of the crit-bit tree node.  It offers no alignment guarantees -- in fact
the current struct layout puts it one byte after a 4-byte aligned
address, i.e. guaranteed to be misaligned.

oidtree uses a struct object_id as cb_node key.  Since cf0983213c (hash:
add an algo member to struct object_id, 2021-04-26) it requires 4-byte
alignment.  The mismatch is reported by UndefinedBehaviorSanitizer at
runtime like this:

hash.h:277:2: runtime error: member access within misaligned address 0x000=
15000802d for type 'struct object_id', which requires 4 byte alignment
0x00015000802d: note: pointer points here
 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  0=
0 00 00 00 00 00 00 00  00
             ^
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hash.h:277:2 in

We can fix that by:

1. eliminating the alignment requirement of struct object_id,
2. providing the alignment in struct cb_node, or
3. avoiding the issue by only using memcpy to access "k".

Currently we only store one of two values in "algo" in struct object_id.
We could use a uint8_t for that instead and widen it only once we add
support for our twohundredth algorithm or so.  That would not only avoid
alignment issues, but also reduce the memory requirements for each
instance of struct object_id by ca. 9%.

Supporting keys with alignment requirements might be useful to spread
the use of crit-bit trees.  It can be achieved by using a wider type for
"k" (e.g. uintmax_t), using different types for the members "byte" and
"otherbits" (e.g. uint16_t or uint32_t for each), or by avoiding the use
of flexible arrays like khash.h does.

This patch implements the third option, though, because it has the least
potential for causing side-effects and we're close to the next release.
If one of the other options is implemented later as well to get their
additional benefits we can get rid of the extra copies introduced here.

Reported-by: Andrzej Hunt <andrzej@ahunt.org>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 cbtree.h  |  2 +-
 hash.h    |  2 +-
 oidtree.c | 20 +++++++++++++++-----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/cbtree.h b/cbtree.h
index fe4587087e..a04a312c3f 100644
=2D-- a/cbtree.h
+++ b/cbtree.h
@@ -25,7 +25,7 @@ struct cb_node {
 	 */
 	uint32_t byte;
 	uint8_t otherbits;
-	uint8_t k[FLEX_ARRAY]; /* arbitrary data */
+	uint8_t k[FLEX_ARRAY]; /* arbitrary data, unaligned */
 };

 struct cb_tree {
diff --git a/hash.h b/hash.h
index 27a180248f..9e25c40e9a 100644
=2D-- a/hash.h
+++ b/hash.h
@@ -115,7 +115,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *ds=
t, const git_SHA256_CTX *s

 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;
+	int algo;	/* XXX requires 4-byte alignment */
 };

 /* A suitably aligned type for stack allocations of hash contexts. */
diff --git a/oidtree.c b/oidtree.c
index 580cab8ae2..0d39389bee 100644
=2D-- a/oidtree.c
+++ b/oidtree.c
@@ -31,12 +31,19 @@ void oidtree_clear(struct oidtree *ot)
 void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 {
 	struct cb_node *on;
+	struct object_id k;

 	if (!oid->algo)
 		BUG("oidtree_insert requires oid->algo");

 	on =3D mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
-	oidcpy_with_padding((struct object_id *)on->k, oid);
+
+	/*
+	 * Clear the padding and copy the result in separate steps to
+	 * respect the 4-byte alignment needed by struct object_id.
+	 */
+	oidcpy_with_padding(&k, oid);
+	memcpy(on->k, &k, sizeof(k));

 	/*
 	 * n.b. Current callers won't get us duplicates, here.  If a
@@ -68,17 +75,20 @@ int oidtree_contains(struct oidtree *ot, const struct =
object_id *oid)
 static enum cb_next iter(struct cb_node *n, void *arg)
 {
 	struct oidtree_iter_data *x =3D arg;
-	const struct object_id *oid =3D (const struct object_id *)n->k;
+	struct object_id k;
+
+	/* Copy to provide 4-byte alignment needed by struct object_id. */
+	memcpy(&k, n->k, sizeof(k));

-	if (x->algo !=3D GIT_HASH_UNKNOWN && x->algo !=3D oid->algo)
+	if (x->algo !=3D GIT_HASH_UNKNOWN && x->algo !=3D k.algo)
 		return CB_CONTINUE;

 	if (x->last_nibble_at) {
-		if ((oid->hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
+		if ((k.hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
 			return CB_CONTINUE;
 	}

-	return x->fn(oid, x->arg);
+	return x->fn(&k, x->arg);
 }

 void oidtree_each(struct oidtree *ot, const struct object_id *oid,
=2D-
2.32.0

