Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E165620A26
	for <e@80x24.org>; Wed, 27 Sep 2017 06:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdI0GCO (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:02:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:51576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752400AbdI0GCN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:02:13 -0400
Received: (qmail 25401 invoked by uid 109); 27 Sep 2017 06:01:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 06:01:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11466 invoked by uid 111); 27 Sep 2017 06:02:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 02:02:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 02:02:11 -0400
Date:   Wed, 27 Sep 2017 02:02:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] distinguish error versus short read from
 read_in_full()
Message-ID: <20170927060210.euuaefuakciusudl@sigill.intra.peff.net>
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers of read_in_full() expect to see the exact
number of bytes requested, but their error handling lumps
together true read errors and short reads due to unexpected
EOF.

We can give more specific error messages by separating these
cases (showing errno when appropriate, and otherwise
describing the short read).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/get-tar-commit-id.c |  4 +++-
 bulk-checkin.c              |  5 ++++-
 packfile.c                  | 11 +++++++++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index cd3e656828..2706fcfaf2 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -26,8 +26,10 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 		usage(builtin_get_tar_commit_id_usage);
 
 	n = read_in_full(0, buffer, HEADERSIZE);
+	if (n < 0)
+		die_errno("git get-tar-commit-id: read error");
 	if (n != HEADERSIZE)
-		die("git get-tar-commit-id: read error");
+		die_errno("git get-tar-commit-id: EOF before reading tar header");
 	if (header->typeflag[0] != 'g')
 		return 1;
 	if (!skip_prefix(content, "52 comment=", &comment))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9a1f6c49ab..3310fd210a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -115,7 +115,10 @@ static int stream_to_pack(struct bulk_checkin_state *state,
 
 		if (size && !s.avail_in) {
 			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
-			if (read_in_full(fd, ibuf, rsize) != rsize)
+			ssize_t read_result = read_in_full(fd, ibuf, rsize);
+			if (read_result < 0)
+				die_errno("failed to read from '%s'", path);
+			if (read_result != rsize)
 				die("failed to read %d bytes from '%s'",
 				    (int)rsize, path);
 			offset += rsize;
diff --git a/packfile.c b/packfile.c
index f69a5c8d60..eab7542487 100644
--- a/packfile.c
+++ b/packfile.c
@@ -442,6 +442,7 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char sha1[20];
 	unsigned char *idx_sha1;
 	long fd_flag;
+	ssize_t read_result;
 
 	if (!p->index_data && open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -483,7 +484,10 @@ static int open_packed_git_1(struct packed_git *p)
 		return error("cannot set FD_CLOEXEC");
 
 	/* Verify we recognize this pack file format. */
-	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+	read_result = read_in_full(p->pack_fd, &hdr, sizeof(hdr));
+	if (read_result < 0)
+		return error_errno("error reading from %s", p->pack_name);
+	if (read_result != sizeof(hdr))
 		return error("file %s is far too short to be a packfile", p->pack_name);
 	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
 		return error("file %s is not a GIT packfile", p->pack_name);
@@ -500,7 +504,10 @@ static int open_packed_git_1(struct packed_git *p)
 			     p->num_objects);
 	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
 		return error("end of packfile %s is unavailable", p->pack_name);
-	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
+	read_result = read_in_full(p->pack_fd, sha1, sizeof(sha1));
+	if (read_result < 0)
+		return error_errno("error reading from %s", p->pack_name);
+	if (read_result != sizeof(sha1))
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
 	if (hashcmp(sha1, idx_sha1))
-- 
2.14.2.988.g01c8b37dde

