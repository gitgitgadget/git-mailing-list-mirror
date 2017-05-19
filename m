Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D87B2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbdESMzO (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:55:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:54844 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753994AbdESMzN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:55:13 -0400
Received: (qmail 2753 invoked by uid 109); 19 May 2017 12:55:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:55:13 +0000
Received: (qmail 27860 invoked by uid 111); 19 May 2017 12:55:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:55:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:55:11 -0400
Date:   Fri, 19 May 2017 08:55:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 10/15] handle_revision_arg: record modes for "a..b" endpoints
Message-ID: <20170519125511.uz7hsdalem57n77d@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "a..b" revision syntax was designed to handle commits,
so it doesn't bother to record any mode we find while
traversing a "tree:path" endpoint. These days "git diff" can
diff blobs using either "a:path..b:path" (with dots) or
"a:path b:path" (without), but the two behave
inconsistently, as the with-dots version fails to notice the
mode.

Let's teach the dot-dot range parser to record modes; it
doesn't cost us anything, and it makes this case work.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c            | 10 ++++++----
 t/t4063-diff-blobs.sh |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index eb45501fd..96427e3c2 100644
--- a/revision.c
+++ b/revision.c
@@ -1448,9 +1448,11 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	const char *a_name, *b_name;
 	struct object_id a_oid, b_oid;
 	struct object *a_obj, *b_obj;
+	struct object_context a_oc, b_oc;
 	unsigned int a_flags, b_flags;
 	int symmetric = 0;
 	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
+	unsigned int oc_flags = GET_SHA1_COMMITTISH;
 
 	a_name = arg;
 	if (!*a_name)
@@ -1464,8 +1466,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_sha1_committish(a_name, a_oid.hash) ||
-	    get_sha1_committish(b_name, b_oid.hash))
+	if (get_sha1_with_context(a_name, oc_flags, a_oid.hash, &a_oc) ||
+	    get_sha1_with_context(b_name, oc_flags, b_oid.hash, &b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1507,8 +1509,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	b_obj->flags |= b_flags;
 	add_rev_cmdline(revs, a_obj, a_name, REV_CMD_LEFT, a_flags);
 	add_rev_cmdline(revs, b_obj, b_name, REV_CMD_RIGHT, b_flags);
-	add_pending_object(revs, a_obj, a_name);
-	add_pending_object(revs, b_obj, b_name);
+	add_pending_object_with_mode(revs, a_obj, a_name, a_oc.mode);
+	add_pending_object_with_mode(revs, b_obj, b_name, b_oc.mode);
 	return 0;
 }
 
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 90c6f6b85..df9c35b2d 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -71,7 +71,7 @@ test_expect_success 'index of ranged tree:path diff' '
 test_expect_failure 'ranged tree:path diff uses filenames as paths' '
 	check_paths one two
 '
-test_expect_failure 'ranged tree:path diff shows mode change' '
+test_expect_success 'ranged tree:path diff shows mode change' '
 	check_mode 100644 100755
 '
 
-- 
2.13.0.219.g63f6bc368

