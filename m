Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DCA2096B
	for <e@80x24.org>; Sat,  1 Apr 2017 08:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750818AbdDAIJj (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55311 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdDAIJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:09:34 -0400
Received: (qmail 29450 invoked by uid 109); 1 Apr 2017 08:09:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:09:33 +0000
Received: (qmail 16225 invoked by uid 111); 1 Apr 2017 08:09:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:09:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:09:32 -0400
Date:   Sat, 1 Apr 2017 04:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH 2/2] index-pack: detect local corruption in collision check
Message-ID: <20170401080931.t67jbtta4w4enui6@sigill.intra.peff.net>
References: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we notice that we have a local copy of an incoming
object, we compare the two objects to make sure we haven't
found a collision. Before we get to the actual object
bytes, though, we compare the type and size from
sha1_object_info().

If our local object is corrupted, then the type will be
OBJ_BAD, which obviously will not match the incoming type,
and we'll report "SHA1 COLLISION FOUND" (with capital
letters and everything). This is confusing, as the problem
is not a collision but rather local corruption. We should
reoprt that instead (just like we do if reading the rest of
the object content fails a few lines later).

Note that we _could_ just ignore the error and mark it as a
non-collision. That would let you "git fetch" to replace a
corrupted object. But it's not a very reliable method for
repairing a repository. The earlier want/have negotiation
tries to get the other side to omit objects we already have,
and it would not realize that we are "missing" this
corrupted object. So we're better off complaining loudly
when we see corruption, and letting the user take more
drastic measures to repair (like making a full clone
elsewhere and copying the pack into place).

Note that the test sets transfer.unpackLimit in the
receiving repository so that we use index-pack (which is
what does the collision check). Normally for such a small
push we'd use unpack-objects, which would simply try to
write the loose object, and discard the new one when we see
that there's already an old one.

Signed-off-by: Jeff King <peff@peff.net>
---
I was surprised to see that unpack-objects doesn't do the same collision
check. I think it relies on the loose-object precedence. But that seems
like it misses a case: if you have a packed version of an object and
receive a small fetch or push, we may unpack a duplicate object to its
loose format without doing any kind of collision check.

We may want to tighten that up. In the long run, I'd love to see
unpack-objects go away in favor of teaching index-pack how to write
loose objects. The two had very similar code once upon a time, but
index-pack has grown a lot of feature and bugfixes over the years.

 builtin/index-pack.c         |  2 ++
 t/t1060-object-corruption.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 88d205f85..9f17adb37 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -809,6 +809,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		unsigned long has_size;
 		read_lock();
 		has_type = sha1_object_info(sha1, &has_size);
+		if (has_type < 0)
+			die(_("cannot read existing object info %s"), sha1_to_hex(sha1));
 		if (has_type != type || has_size != size)
 			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
 		has_data = read_sha1_file(sha1, &has_type, &has_size);
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 3a88d79c5..ac1f189fd 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -21,6 +21,14 @@ test_expect_success 'setup corrupt repo' '
 		cd bit-error &&
 		test_commit content &&
 		corrupt_byte HEAD:content.t 10
+	) &&
+	git init no-bit-error &&
+	(
+		# distinct commit from bit-error, but containing a
+		# non-corrupted version of the same blob
+		cd no-bit-error &&
+		test_tick &&
+		test_commit content
 	)
 '
 
@@ -108,4 +116,13 @@ test_expect_failure 'clone --local detects misnamed objects' '
 	test_must_fail git clone --local misnamed misnamed-checkout
 '
 
+test_expect_success 'fetch into corrupted repo with index-pack' '
+	(
+		cd bit-error &&
+		test_must_fail git -c transfer.unpackLimit=1 \
+			fetch ../no-bit-error 2>stderr &&
+		test_i18ngrep ! -i collision stderr
+	)
+'
+
 test_done
-- 
2.12.2.943.g91cb50fd8
