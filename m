Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79251EB64DC
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGAVHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGAVHN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 17:07:13 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 14:07:08 PDT
Received: from haze.kloetzke.net (haze.kloetzke.net [IPv6:2a03:4000:13:91f:34ea:99ff:fed2:e113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE5127
        for <git@vger.kernel.org>; Sat,  1 Jul 2023 14:07:08 -0700 (PDT)
Received: from localhost (p5dd489b2.dip0.t-ipconnect.de [93.212.137.178])
        by haze.kloetzke.net (Postfix) with ESMTPSA id E7BED80006;
        Sat,  1 Jul 2023 22:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kloetzke.net; s=2020;
        t=1688245053; bh=xbG5ZXN1l4jUHRwwwxOUk1YbKac5/QqD35npRtIKi+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Qki2aTX/11/LaEXuJp78XGIJUjtbbPuV0T408onm4QAkeTVRJxgCQ5nJC3quedM3L
         nXtkw3d4QHEUagrYg6mnBwntEjYy6UfMpgPzdbbbEzUQtNOO6hxi2CICZvvjLRYE85
         j4Il1Ejyzvk0a3N8qC5F4p8ZWc192OQ8Boc/RYktjZ3NCchR7rawxK/zGUHiXJ+fUG
         1EXk7B+ALk8vX1r01J9LKGTweYGK6vyrIA7iUqHrgKYbSBT590VTcEJiKEenErCnIW
         coJeMi0h0xrxYUR4jCl5Xw+4L8DTzKLjvoTpfbgq0lH87w0+Jc3qB1lYAEpI7zKGL9
         OHzYTznDTrHdQ==
From:   =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan@kloetzke.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH] ref-filter: handle nested tags in --points-at option
Date:   Sat,  1 Jul 2023 22:57:02 +0200
Message-Id: <20230701205703.1172505-1-jan@kloetzke.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tags are dereferenced until reaching a different object type to handle
nested tags, e.g. on checkout. In contrast, "git tag --points-at=..."
fails to list such nested tags because only one level of indirection is
obtained in filter_refs(). Implement the recursive dereferencing for the
"--points-at" option when filtering refs to unify the behaviour.

Signed-off-by: Jan Klötzke <jan@kloetzke.net>
---
 ref-filter.c                   | 16 +++++++---------
 t/t6302-for-each-ref-filter.sh |  2 ++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e0d03a9f8e..ad7f244414 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2211,10 +2211,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
  * of oids. If the given ref is a tag, check if the given tag points
  * at one of the oids in the given oid array.
  * NEEDSWORK:
- * 1. Only a single level of indirection is obtained, we might want to
- * change this to account for multiple levels (e.g. annotated tags
- * pointing to annotated tags pointing to a commit.)
- * 2. As the refs are cached we might know what refname peels to without
+ * As the refs are cached we might know what refname peels to without
  * the need to parse the object via parse_object(). peel_ref() might be a
  * more efficient alternative to obtain the pointee.
  */
@@ -2222,18 +2219,19 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 					       const struct object_id *oid,
 					       const char *refname)
 {
-	const struct object_id *tagged_oid = NULL;
 	struct object *obj;
 
 	if (oid_array_lookup(points_at, oid) >= 0)
 		return oid;
 	obj = parse_object(the_repository, oid);
+	while (obj && obj->type == OBJ_TAG) {
+		oid = get_tagged_oid((struct tag *)obj);
+		if (oid_array_lookup(points_at, oid) >= 0)
+			return oid;
+		obj = parse_object(the_repository, oid);
+	}
 	if (!obj)
 		die(_("malformed object at '%s'"), refname);
-	if (obj->type == OBJ_TAG)
-		tagged_oid = get_tagged_oid((struct tag *)obj);
-	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >= 0)
-		return tagged_oid;
 	return NULL;
 }
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 1ce5f490e9..af223e44d6 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -45,6 +45,8 @@ test_expect_success 'check signed tags with --points-at' '
 	sed -e "s/Z$//" >expect <<-\EOF &&
 	refs/heads/side Z
 	refs/tags/annotated-tag four
+	refs/tags/doubly-annotated-tag An annotated tag
+	refs/tags/doubly-signed-tag A signed tag
 	refs/tags/four Z
 	refs/tags/signed-tag four
 	EOF
-- 
2.39.2

