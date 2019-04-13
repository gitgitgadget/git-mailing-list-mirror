Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3318720248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfDMFxh (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:53:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:57192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfDMFxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:53:37 -0400
Received: (qmail 27724 invoked by uid 109); 13 Apr 2019 05:53:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:53:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12602 invoked by uid 111); 13 Apr 2019 05:54:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:54:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:53:34 -0400
Date:   Sat, 13 Apr 2019 01:53:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/7] upload-pack: send ERR packet for non-tip objects
Message-ID: <20190413055334.GC19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit bdb31eada7 (upload-pack: report "not our ref" to client,
2017-02-23) catches the case where a client asks for an object we don't
have, and issues a message that the client can show to the user (in
addition to dying and writing to stderr).

There's a similar case (with the same message) when the client asks for
an object which we _do_ have, but which isn't a ref tip (or isn't
reachable, when uploadpack.allowReachableSHA1InWant is true). Let's give
that one the same treatment, for the same reason (namely that it's more
informative to the client than just hanging up, since they won't see our
stderr over some protocols).

There are two tests here. We cover it most directly in t5530 by invoking
upload-pack, which matches the existing "not our ref" test.

But a more end-to-end check is that "git fetch" actually shows the
message to the client. We're already checking in t5516 that this case
fails, so we can just check stderr there, too. Note that even after we
started ignoring SIGPIPE in 8bf4becf0c, this could in theory still be
racy as described in that commit (because we die() on write failures
before pumping the connection for any ERR packets).

In practice this should be OK for this case. The server will not
actually check reachability until it has received our whole group of
"want" lines. And since we have no objects in the repository, we won't
send any "have" lines, meaning we're always waiting to read the server
response.

Note also that this case cannot happen in the v2 protocol, since it
allows any available object to be requested. However, we don't have to
take any steps to protect against the upcoming GIT_TEST_PROTOCOL_VERSION
in our tests:

  - the tests in t5516 would already need to be skipped under v2, and
    that is covered by ab0c5f5096 (tests: always test fetch of
    unreachable with v0, 2019-02-25)

  - the tests in t5530 invoke upload-pack directly, which will continue
    to default to v0. Eventually we may have a test setting which uses
    v2 even for bare upload-pack calls, but we can't override it here
    until we know what the setting looks like.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5516-fetch-push.sh        |  3 ++-
 t/t5530-upload-pack-error.sh | 13 ++++++++++++-
 upload-pack.c                | 11 ++++++++---
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fc3961ec22..747dc4c31d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1240,7 +1240,8 @@ do
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail git fetch ../testrepo/.git $SHA1_3
+			test_must_fail git fetch ../testrepo/.git $SHA1_3 2>err &&
+			test_i18ngrep "remote error:.*not our ref" err
 		)
 	'
 done
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 295bd0c83c..a1d3031d40 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -57,7 +57,7 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 	grep "bad tree object" output.err
 '
 
-test_expect_success 'upload-pack error message when bad ref requested' '
+test_expect_success 'upload-pack fails due to bad want (no object)' '
 
 	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
 		"deadbeefdeadbeefdeadbeefdeadbeefdeadbeef" >input &&
@@ -67,6 +67,17 @@ test_expect_success 'upload-pack error message when bad ref requested' '
 	! grep multi_ack_detailed output.err
 '
 
+test_expect_success 'upload-pack fails due to bad want (not tip)' '
+
+	oid=$(echo an object we have | git hash-object -w --stdin) &&
+	printf "0045want %s multi_ack_detailed\n00000009done\n0000" \
+		"$oid" >input &&
+	test_must_fail git upload-pack . <input >output 2>output.err &&
+	grep "not our ref" output.err &&
+	grep "ERR" output &&
+	! grep multi_ack_detailed output.err
+'
+
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
 
 	printf "0032want %s\n00000009done\n0000" \
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..cb603a6d8a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -592,7 +592,8 @@ static int has_unreachable(struct object_array *src)
 	return 1;
 }
 
-static void check_non_tip(struct object_array *want_obj)
+static void check_non_tip(struct object_array *want_obj,
+			  struct packet_writer *writer)
 {
 	int i;
 
@@ -611,9 +612,13 @@ static void check_non_tip(struct object_array *want_obj)
 	/* Pick one of them (we know there at least is one) */
 	for (i = 0; i < want_obj->nr; i++) {
 		struct object *o = want_obj->objects[i].item;
-		if (!is_our_ref(o))
+		if (!is_our_ref(o)) {
+			packet_writer_error(writer,
+					    "upload-pack: not our ref %s",
+					    oid_to_hex(&o->oid));
 			die("git upload-pack: not our ref %s",
 			    oid_to_hex(&o->oid));
+		}
 	}
 }
 
@@ -936,7 +941,7 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 	 * by another process that handled the initial request.
 	 */
 	if (has_non_tip)
-		check_non_tip(want_obj);
+		check_non_tip(want_obj, &writer);
 
 	if (!use_sideband && daemon_mode)
 		no_progress = 1;
-- 
2.21.0.931.gd0bc72a411

