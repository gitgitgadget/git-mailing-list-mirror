Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62D220756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdAMSA3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:00:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:38951 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdAMSA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:00:29 -0500
Received: (qmail 6326 invoked by uid 109); 13 Jan 2017 18:00:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 18:00:29 +0000
Received: (qmail 7473 invoked by uid 111); 13 Jan 2017 18:01:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 13:01:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 13:00:25 -0500
Date:   Fri, 13 Jan 2017 13:00:25 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 6/6] fsck: detect trailing garbage in all object types
Message-ID: <20170113180025.xkwyc6mzxl572jn7@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a loose tree or commit is read by fsck (or any git
program), unpack_sha1_rest() checks whether there is extra
cruft at the end of the object file, after the zlib data.
Blobs that are streamed, however, do not have this check.

For normal git operations, it's not a big deal. We know the
sha1 and size checked out, so we have the object bytes we
wanted.  The trailing garbage doesn't affect what we're
trying to do.

But since the point of fsck is to find corruption or other
problems, it should be more thorough. This patch teaches its
loose-sha1 reader to detect extra bytes after the zlib
stream and complain.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c     |  5 +++++
 t/t1450-fsck.sh | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index c0fccb73c..b77ab6d5c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3864,6 +3864,11 @@ static int check_stream_sha1(git_zstream *stream,
 		error("corrupt loose object '%s'", sha1_to_hex(expected_sha1));
 		return -1;
 	}
+	if (stream->avail_in) {
+		error("garbage at end of loose object '%s'",
+		      sha1_to_hex(expected_sha1));
+		return -1;
+	}
 
 	git_SHA1_Final(real_sha1, &c);
 	if (hashcmp(expected_sha1, real_sha1)) {
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 455c186fe..8975b4d1b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -597,4 +597,26 @@ test_expect_success 'fsck finds problems in duplicate loose objects' '
 	)
 '
 
+test_expect_success 'fsck detects trailing loose garbage (commit)' '
+	git cat-file commit HEAD >basis &&
+	echo bump-commit-sha1 >>basis &&
+	commit=$(git hash-object -w -t commit basis) &&
+	file=$(sha1_file $commit) &&
+	test_when_finished "remove_object $commit" &&
+	chmod +w "$file" &&
+	echo garbage >>"$file" &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "garbage.*$commit" out
+'
+
+test_expect_success 'fsck detects trailing loose garbage (blob)' '
+	blob=$(echo trailing | git hash-object -w --stdin) &&
+	file=$(sha1_file $blob) &&
+	test_when_finished "remove_object $blob" &&
+	chmod +w "$file" &&
+	echo garbage >>"$file" &&
+	test_must_fail git fsck 2>out &&
+	test_i18ngrep "garbage.*$blob" out
+'
+
 test_done
-- 
2.11.0.629.g10075098c
