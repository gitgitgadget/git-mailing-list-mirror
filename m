Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730911F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932774AbeAYA4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:56:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:56572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYA4J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:56:09 -0500
Received: (qmail 19603 invoked by uid 109); 25 Jan 2018 00:56:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:56:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31605 invoked by uid 111); 25 Jan 2018 00:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:56:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:56:07 -0500
Date:   Wed, 24 Jan 2018 19:56:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/6] daemon: fix off-by-one in logging extended attributes
Message-ID: <20180125005606.GC26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If receive a request like:

  git-upload-pack /foo.git\0host=localhost

we mark the offset of the NUL byte as "len", and then log
the bytes after the NUL with a "%.*s" placeholder, using
"pktlen - len" as the length, and "line + len + 1" as the
start of the string.

This is off-by-one, since the start of the string skips past
the separating NUL byte, but the adjusted length includes
it. Fortunately this doesn't actually read past the end of
the buffer, since "%.*s" will stop when it hits a NUL. And
regardless of what is in the buffer, packet_read() will
always add an extra NUL terminator for safety.

As an aside, the git.git client sends an extra NUL after a
"host" field, too, so we'd generally hit that one first, not
the one added by packet_read(). You can see this in the test
output which reports 15 bytes, even though the string has
only 14 bytes of visible data. But the point is that even a
client sending unusual data could not get us to read past
the end of the buffer, so this is purely a cosmetic fix.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
This code actually goes away in the next patch, but I thought it was
worth dealing with individually, since it is a memory error (albeit a
harmless one).

 daemon.c              |  4 ++--
 t/t5570-git-daemon.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index e37e343d0a..d78afc8e96 100644
--- a/daemon.c
+++ b/daemon.c
@@ -759,8 +759,8 @@ static int execute(void)
 	len = strlen(line);
 	if (pktlen != len)
 		loginfo("Extended attributes (%d bytes) exist <%.*s>",
-			(int) pktlen - len,
-			(int) pktlen - len, line + len + 1);
+			(int) pktlen - len - 1,
+			(int) pktlen - len - 1, line + len + 1);
 	if (len && line[len-1] == '\n') {
 		line[--len] = 0;
 		pktlen--;
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index f92ebc5cd5..359af3994a 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -183,5 +183,16 @@ test_expect_success 'hostname cannot break out of directory' '
 		git ls-remote "$GIT_DAEMON_URL/escape.git"
 '
 
+test_expect_success 'daemon log records hostnames' '
+	cat >expect <<-\EOF &&
+	Extended attributes (15 bytes) exist <host=localhost>
+	EOF
+	>daemon.log &&
+	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
+		git ls-remote "$GIT_DAEMON_URL/interp.git" &&
+	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
+	test_cmp expect actual
+'
+
 stop_git_daemon
 test_done
-- 
2.16.1.273.gfdaa03aa74

