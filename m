Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED591F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHS4n (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:56:43 -0500
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:51652 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752159AbeBHS4l (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Feb 2018 13:56:41 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2018 13:56:41 EST
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id DAECF60609;
        Thu,  8 Feb 2018 13:48:08 -0500 (EST)
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id 80BDC6035F;
        Thu,  8 Feb 2018 13:48:08 -0500 (EST)
X-Sender-Id: jon@jonsimons.org
Received: from 73.223.68.52 (c-73-223-68-52.hsd1.ca.comcast.net [73.223.68.52])
        (using TLSv1.2 with cipher AES128-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 08 Feb 2018 13:48:08 -0500
From:   Jon Simons <jon@jonsimons.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/2] correct error messages for NULL packet_read_line()
Date:   Thu,  8 Feb 2018 13:47:49 -0500
Message-Id: <1518115670-2646-2-git-send-email-jon@jonsimons.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
References: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The packet_read_line() function dies if it gets an
unexpected EOF. It only returns NULL if we get a flush
packet (or technically, a zero-length "0004" packet, but
nobody is supposed to send those, and they are
indistinguishable from a flush in this interface).

Let's correct error messages which claim an unexpected EOF;
it's really an unexpected flush packet.

While we're here, let's also check "!line" instead of
"!len" in the second case. The two events should always
coincide, but checking "!line" makes it more obvious that we
are not about to dereference NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/archive.c | 2 +-
 fetch-pack.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index f863465..73971d0 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -55,7 +55,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	buf = packet_read_line(fd[0], NULL);
 	if (!buf)
-		die(_("git archive: expected ACK/NAK, got EOF"));
+		die(_("git archive: expected ACK/NAK, got a flush packet"));
 	if (strcmp(buf, "ACK")) {
 		if (starts_with(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
diff --git a/fetch-pack.c b/fetch-pack.c
index a376b4e..1b7cd6b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -262,8 +262,8 @@ static enum ack_type get_ack(int fd, struct object_id *result_oid)
 	char *line = packet_read_line(fd, &len);
 	const char *arg;
 
-	if (!len)
-		die(_("git fetch-pack: expected ACK/NAK, got EOF"));
+	if (!line)
+		die(_("git fetch-pack: expected ACK/NAK, got a flush packet"));
 	if (!strcmp(line, "NAK"))
 		return NAK;
 	if (skip_prefix(line, "ACK ", &arg)) {
-- 
2.1.4

