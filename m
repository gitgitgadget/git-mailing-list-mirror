Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253B5207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbcJCUfs (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:35:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:51451 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbcJCUfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:35:46 -0400
Received: (qmail 17401 invoked by uid 109); 3 Oct 2016 20:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:35:46 +0000
Received: (qmail 29808 invoked by uid 111); 3 Oct 2016 20:36:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:35:43 -0400
Date:   Mon, 3 Oct 2016 16:35:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 11/18] alternates: encapsulate alt->base munging
Message-ID: <20161003203543.qkylezpwuruwpjsa@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alternate_object_database struct holds a path to the
alternate objects, but we also use that buffer as scratch
space for forming loose object filenames. Let's pull that
logic into a helper function so that we can more easily
modify it.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 549cf1e..ccf59ba 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -204,6 +204,13 @@ const char *sha1_file_name(const unsigned char *sha1)
 	return buf;
 }
 
+static const char *alt_sha1_path(struct alternate_object_database *alt,
+				 const unsigned char *sha1)
+{
+	fill_sha1_path(alt->name, sha1);
+	return alt->base;
+}
+
 /*
  * Return the name of the pack or index file with the specified sha1
  * in its filename.  *base and *name are scratch space that must be
@@ -601,8 +608,8 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		fill_sha1_path(alt->name, sha1);
-		if (check_and_freshen_file(alt->base, freshen))
+		const char *path = alt_sha1_path(alt, sha1);
+		if (check_and_freshen_file(path, freshen))
 			return 1;
 	}
 	return 0;
@@ -1600,8 +1607,8 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st)
 	prepare_alt_odb();
 	errno = ENOENT;
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		fill_sha1_path(alt->name, sha1);
-		if (!lstat(alt->base, st))
+		const char *path = alt_sha1_path(alt, sha1);
+		if (!lstat(path, st))
 			return 0;
 	}
 
@@ -1621,8 +1628,8 @@ static int open_sha1_file(const unsigned char *sha1)
 
 	prepare_alt_odb();
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		fill_sha1_path(alt->name, sha1);
-		fd = git_open_noatime(alt->base);
+		const char *path = alt_sha1_path(alt, sha1);
+		fd = git_open_noatime(path);
 		if (fd >= 0)
 			return fd;
 		if (most_interesting_errno == ENOENT)
-- 
2.10.0.618.g82cc264

