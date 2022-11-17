Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C8C433FE
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 22:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbiKQWlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiKQWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 17:41:18 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD21898F0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 14:41:17 -0800 (PST)
Received: (qmail 28711 invoked by uid 109); 17 Nov 2022 22:41:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Nov 2022 22:41:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18874 invoked by uid 111); 17 Nov 2022 22:41:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Nov 2022 17:41:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Nov 2022 17:41:16 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/2] parse_object(): check on-disk type of suspected blob
Message-ID: <Y3a4jKzsHSooYFqj@coredump.intra.peff.net>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In parse_object(), we try to handle blobs by streaming rather than
loading them entirely into memory. The most common case here will be
that we haven't seen the object yet and check oid_object_info(), which
tells us we have a blob.

But we trigger this code on one other case: when we have an in-memory
object struct with type OBJ_BLOB (and without its "parsed" flag set,
since otherwise we'd return early from the function). This indicates
that some other part of the code suspected we have a blob (e.g., it was
mentioned by a tree or tag) but we haven't yet looked at the on-disk
copy.

In this case before hitting the streaming path, we check if we have the
object on-disk at all. This is mostly pointless extra work, as the
streaming path would complain if it couldn't open the object (albeit
with the message "hash mismatch", which is a little misleading).

But it's also insufficient to catch all problems. The streaming code
will only tell us "yes, the on-disk object matches the oid". But it
doesn't actually confirm that what we found was indeed a blob, and
neither does repo_has_object_file().

One way to improve this would be to teach stream_object_signature() to
check the type (either by returning it to us to check, or taking an
"expected" type). But there's an even simpler fix here: if we suspect
the object is a blob, just call oid_object_info() to confirm that we
have it on-disk, and that it really is a blob.

This is slightly less efficient than teaching stream_object_signature()
to do it (since it has to open the object already). But this case very
rarely comes up. In practice, we usually don't have any clue what the
type is, in which case we already call oid_object_info(). This
"suspected" case happens only when some other code created an object
struct but didn't actually parse the blob, which is actually tricky to
trigger at all (see the discussion of the test below).

I reworked the conditional a bit so that instead of:

  if ((suspected_blob && oid_object_info() == OBJ_BLOB)
      (no_clue && oid_object_info() == OBJ_BLOB)

we have the simpler:

  if ((suspected_blob || no_clue) && oid_object_info() == OBJ_BLOB)

This is shorter, but also reflects what we really want say, which is
"have we ruled out this being a blob; if not, check it on-disk".

In either case, if oid_object_info() fails to tell us it's a blob, we'll
skip the streaming code path and call repo_read_object_file(), just as
before. And if we really do have a mismatch with the existing object
struct, we'll eventually call lookup_commit(), etc, via
parse_object_buffer(), which will complain that it doesn't match our
existing obj->type.

So this fixes one of the lingering expect_failure cases from 0616617c7e
(t: introduce tests for unexpected object types, 2019-04-09).  That test
works by peeling a tag that claims to point to a blob (triggering us to
create the struct), but really points to something else, which we later
discover when we call parse_object() as part of the actual traversal).
Prior to this commit, we'd quietly check the sha1 and mark the blob as
"parsed". Now we correctly complain about the mismatch.

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, I found the "this test is marked as success but testing the
wrong thing" pattern here confusing to deal with (since I had to dig in
history to understand what was going on and what the test was _supposed_
to say).

It comes from cf10c5b4cf (rev-list tests: don't hide abort() in
"test_expect_failure", 2022-03-07). I'm skeptical that it was worth
switching those tests for leak detection purposes.

But more importantly, it looks like pw/test-todo would provide us with a
much nicer pattern there. It seems to be stalled on review, so let's see
if we can get that moving again.

 object.c                               | 4 ++--
 t/t6102-rev-list-unexpected-objects.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object.c b/object.c
index 16eb944e98..fad1a5af4a 100644
--- a/object.c
+++ b/object.c
@@ -286,8 +286,8 @@ struct object *parse_object_with_flags(struct repository *r,
 			return &commit->object;
 	}
 
-	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
-	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
+	if ((!obj || (obj && obj->type == OBJ_BLOB)) &&
+	    oid_object_info(r, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 4a9a4436e2..9350b5fd2c 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -121,8 +121,8 @@ test_expect_success 'setup unexpected non-blob tag' '
 	tag=$(git hash-object -w --literally -t tag broken-tag)
 '
 
-test_expect_success 'TODO (should fail!): traverse unexpected non-blob tag (lone)' '
-	git rev-list --objects $tag
+test_expect_success 'traverse unexpected non-blob tag (lone)' '
+	test_must_fail git rev-list --objects $tag
 '
 
 test_expect_success 'traverse unexpected non-blob tag (seen)' '
-- 
2.38.1.890.g50b10763b9
