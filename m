Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D92B1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeBHS45 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:56:57 -0500
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:36800 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752281AbeBHS4z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Feb 2018 13:56:55 -0500
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 2330060616;
        Thu,  8 Feb 2018 13:48:12 -0500 (EST)
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id BF5446060A;
        Thu,  8 Feb 2018 13:48:11 -0500 (EST)
X-Sender-Id: jon@jonsimons.org
Received: from 73.223.68.52 (c-73-223-68-52.hsd1.ca.comcast.net [73.223.68.52])
        (using TLSv1.2 with cipher AES128-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 08 Feb 2018 13:48:12 -0500
From:   Jon Simons <jon@jonsimons.org>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>
Subject: [PATCH 2/2] always check for NULL return from packet_read_line()
Date:   Thu,  8 Feb 2018 13:47:50 -0500
Message-Id: <1518115670-2646-3-git-send-email-jon@jonsimons.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
References: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The packet_read_line() function will die if it sees any
protocol or socket errors. But it will return NULL for a
flush packet; some callers which are not expecting this may
dereference NULL if they get an unexpected flush. This would
involve the other side breaking protocol, but we should
flag the error rather than segfault.

Signed-off-by: Jon Simons <jon@jonsimons.org>
---
 remote-curl.c | 2 ++
 send-pack.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 0053b09..9903077 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -339,6 +339,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		 * pkt-line matches our request.
 		 */
 		line = packet_read_line_buf(&last->buf, &last->len, NULL);
+		if (!line)
+			die("invalid server response; expected service, got flush packet");
 
 		strbuf_reset(&exp);
 		strbuf_addf(&exp, "# service=%s", service);
diff --git a/send-pack.c b/send-pack.c
index 11d6f3d..d37b265 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -147,6 +147,8 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 static int receive_unpack_status(int in)
 {
 	const char *line = packet_read_line(in, NULL);
+	if (!line)
+		return error(_("unexpected flush packet while reading remote unpack status"));
 	if (!skip_prefix(line, "unpack ", &line))
 		return error(_("unable to parse remote unpack status: %s"), line);
 	if (strcmp(line, "ok"))
-- 
2.1.4

