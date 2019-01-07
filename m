Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFD71F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAGIkg (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:40:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:56426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726404AbfAGIkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:40:36 -0500
Received: (qmail 1904 invoked by uid 109); 7 Jan 2019 08:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:40:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 877 invoked by uid 111); 7 Jan 2019 08:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:40:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:40:34 -0500
Date:   Mon, 7 Jan 2019 03:40:34 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 11/11] prefer "hash mismatch" to "sha1 mismatch"
Message-ID: <20190107084033.GK29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To future-proof ourselves against a change in the hash, let's use the
more generic "hash mismatch" to refer to integrity problems. Note that
we do advertise this exact string in git-fsck(1). However, the message
itself is marked for translation, meaning we do not expect it to be
machine-readable.

While we're touching that documentation, let's also update it for
grammar and clarity.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm actually a little nervous that we _shouldn't_ have marked the
messages that fsck produces for translation (and nor should we change
them here, but then we're stuck with the word "sha1" forever).

I actually think fsck ought to have a machine-readable output format,
but of course that does not help any existing scripts.

 Documentation/git-fsck.txt | 6 +++---
 object.c                   | 4 ++--
 sha1-file.c                | 4 ++--
 t/t1450-fsck.sh            | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index ab9a93fb9b..55950d9eea 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -140,9 +140,9 @@ dangling <type> <object>::
 	The <type> object <object>, is present in the database but never
 	'directly' used. A dangling commit could be a root node.
 
-sha1 mismatch <object>::
-	The database has an object who's sha1 doesn't match the
-	database value.
+hash mismatch <object>::
+	The database has an object whose hash doesn't match the
+	object database value.
 	This indicates a serious data integrity problem.
 
 Environment Variables
diff --git a/object.c b/object.c
index a5c5cf830f..df72914bdc 100644
--- a/object.c
+++ b/object.c
@@ -263,7 +263,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	    (!obj && has_object_file(oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
 		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
-			error(_("sha1 mismatch %s"), oid_to_hex(oid));
+			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
 		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
@@ -274,7 +274,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if (buffer) {
 		if (check_object_signature(repl, buffer, size, type_name(type)) < 0) {
 			free(buffer);
-			error(_("sha1 mismatch %s"), oid_to_hex(repl));
+			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
 		}
 
diff --git a/sha1-file.c b/sha1-file.c
index 55a4782844..a5726c3e73 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2223,7 +2223,7 @@ static int check_stream_oid(git_zstream *stream,
 
 	the_hash_algo->final_fn(real_oid.hash, &c);
 	if (!oideq(expected_oid, &real_oid)) {
-		error(_("sha1 mismatch for %s (expected %s)"), path,
+		error(_("hash mismatch for %s (expected %s)"), path,
 		      oid_to_hex(expected_oid));
 		return -1;
 	}
@@ -2275,7 +2275,7 @@ int read_loose_object(const char *path,
 		}
 		if (check_object_signature(expected_oid, *contents,
 					 *size, type_name(*type))) {
-			error(_("sha1 mismatch for %s (expected %s)"), path,
+			error(_("hash mismatch for %s (expected %s)"), path,
 			      oid_to_hex(expected_oid));
 			free(*contents);
 			goto out;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 2e5e979336..c61f972141 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -406,7 +406,7 @@ test_expect_success 'rev-list --verify-objects with bad sha1' '
 
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/null 2>out &&
 	cat out &&
-	test_i18ngrep -q "error: sha1 mismatch 63ffffffffffffffffffffffffffffffffffffff" out
+	test_i18ngrep -q "error: hash mismatch 63ffffffffffffffffffffffffffffffffffffff" out
 '
 
 test_expect_success 'force fsck to ignore double author' '
-- 
2.20.1.470.g640a3e2614
