Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEAE020A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdAPVfG (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:35:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:39870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbdAPVfE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:35:04 -0500
Received: (qmail 20797 invoked by uid 109); 16 Jan 2017 21:34:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:34:59 +0000
Received: (qmail 12401 invoked by uid 111); 16 Jan 2017 21:35:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:35:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:34:57 -0500
Date:   Mon, 16 Jan 2017 16:34:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 6/6] fsck: check HAS_OBJ more consistently
Message-ID: <20170116213457.n7twsvr2vozdpgcj@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two spots that call lookup_object() and assume
that a non-NULL result means we have the object:

  1. When we're checking the objects given to us by the user
     on the command line.

  2. When we're checking if a reflog entry is valid.

This generally follows fsck's mental model that we will have
looked at and loaded a "struct object" for each object in
the repository. But it misses one case: if another object
_mentioned_ an object, but we didn't actually parse it or
verify that it exists, it will still have a struct.

It's not clear if this is a triggerable bug or not.
Certainly the later parts of the reachability check need to
be careful of this, and do so by checking the HAS_OBJ flag.
But both of these steps happen before we start traversing,
so probably we won't have followed any links yet. Still,
it's easy enough to be defensive here.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8ae065b2d..28d3cbb14 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -398,7 +398,7 @@ static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
 
 	if (!is_null_sha1(sha1)) {
 		obj = lookup_object(sha1);
-		if (obj) {
+		if (obj && (obj->flags & HAS_OBJ)) {
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
@@ -755,7 +755,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		if (!get_sha1(arg, sha1)) {
 			struct object *obj = lookup_object(sha1);
 
-			if (!obj) {
+			if (!obj || !(obj->flags & HAS_OBJ)) {
 				error("%s: object missing", sha1_to_hex(sha1));
 				errors_found |= ERROR_OBJECT;
 				continue;
-- 
2.11.0.642.gd6f8cda6c
