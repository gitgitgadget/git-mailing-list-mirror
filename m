Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D531F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbeAYAzN (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:55:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:56562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYAzN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:55:13 -0500
Received: (qmail 19529 invoked by uid 109); 25 Jan 2018 00:55:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31573 invoked by uid 111); 25 Jan 2018 00:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:55:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:55:11 -0500
Date:   Wed, 24 Jan 2018 19:55:11 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/6] t/lib-git-daemon: record daemon log
Message-ID: <20180125005511.GB26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we start git-daemon for our tests, we send its stderr
log stream to a named pipe. We synchronously read the first
line to make sure that the daemon started, and then dump the
rest to descriptor 4. This is handy for debugging test
output with "--verbose", but the tests themselves can't
access the log data.

Let's dump the log into a file, as well, so that future
tests can check the log. There are two subtleties worth
calling out here:

  - we replace "cat" with a subshell loop around "read" to
    ensure that there's no buffering (so that tests can be
    sure that after a request has been served, the matching
    log entries will have made it to the file)

  - we open the logfile for append, rather than just output.
    That makes it OK for tests to truncate the logfile
    without restarting the daemon (the OS will atomically
    seek to the end of the file when outputting each line).
    That allows tests to look at the log without worrying
    about pollution from earlier tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-git-daemon.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 987d40680b..19f3ffdbb1 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -53,11 +53,19 @@ start_git_daemon() {
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
+	>daemon.log
 	{
 		read line <&7
+		echo "$line"
 		echo >&4 "$line"
-		cat <&7 >&4 &
-	} 7<git_daemon_output &&
+		(
+			while read line <&7
+			do
+				echo "$line"
+				echo >&4 "$line"
+			done
+		) &
+	} 7<git_daemon_output >>"$TRASH_DIRECTORY/daemon.log" &&
 
 	# Check expected output
 	if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
-- 
2.16.1.273.gfdaa03aa74

