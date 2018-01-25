Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4CA1FADF
	for <e@80x24.org>; Thu, 25 Jan 2018 00:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932937AbeAYA4W (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:56:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:56580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYA4W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:56:22 -0500
Received: (qmail 19620 invoked by uid 109); 25 Jan 2018 00:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31622 invoked by uid 111); 25 Jan 2018 00:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:56:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:56:20 -0500
Date:   Wed, 24 Jan 2018 19:56:20 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/6] daemon: handle NULs in extended attribute string
Message-ID: <20180125005619.GD26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we receive a request with extended attributes after the
NUL, we try to write those attributes to the log. We do so
with a "%s" format specifier, which will only show
characters up to the first NUL.

That's enough for printing a "host=" specifier. But since
dfe422d04d (daemon: recognize hidden request arguments,
2017-10-16) we may have another NUL, followed by protocol
parameters, and those are not logged at all.

Let's cut out the attempt to show the whole string, and
instead log when we parse individual attributes. We could
leave the "extended attributes (%d bytes) exist" part of the
log, which in theory could alert us to attributes that fail
to parse. But anything we don't parse as a "host=" parameter
gets blindly added to the "protocol" attribute, so we'd see
it in that part of the log.

Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c              | 9 ++++-----
 t/t5570-git-daemon.sh | 8 +++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/daemon.c b/daemon.c
index d78afc8e96..652f89b6e7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -597,6 +597,7 @@ static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 		if (strncasecmp("host=", extra_args, 5) == 0) {
 			val = extra_args + 5;
 			vallen = strlen(val) + 1;
+			loginfo("Extended attribute \"host\": %s", val);
 			if (*val) {
 				/* Split <host>:<port> at colon. */
 				char *host;
@@ -647,9 +648,11 @@ static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
 		}
 	}
 
-	if (git_protocol.len > 0)
+	if (git_protocol.len > 0) {
+		loginfo("Extended attribute \"protocol\": %s", git_protocol.buf);
 		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
 				 git_protocol.buf);
+	}
 	strbuf_release(&git_protocol);
 }
 
@@ -757,10 +760,6 @@ static int execute(void)
 	alarm(0);
 
 	len = strlen(line);
-	if (pktlen != len)
-		loginfo("Extended attributes (%d bytes) exist <%.*s>",
-			(int) pktlen - len - 1,
-			(int) pktlen - len - 1, line + len + 1);
 	if (len && line[len-1] == '\n') {
 		line[--len] = 0;
 		pktlen--;
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 359af3994a..b556469db6 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -183,13 +183,15 @@ test_expect_success 'hostname cannot break out of directory' '
 		git ls-remote "$GIT_DAEMON_URL/escape.git"
 '
 
-test_expect_success 'daemon log records hostnames' '
+test_expect_success 'daemon log records all attributes' '
 	cat >expect <<-\EOF &&
-	Extended attributes (15 bytes) exist <host=localhost>
+	Extended attribute "host": localhost
+	Extended attribute "protocol": version=1
 	EOF
 	>daemon.log &&
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
-		git ls-remote "$GIT_DAEMON_URL/interp.git" &&
+		git -c protocol.version=1 \
+			ls-remote "$GIT_DAEMON_URL/interp.git" &&
 	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
 	test_cmp expect actual
 '
-- 
2.16.1.273.gfdaa03aa74

