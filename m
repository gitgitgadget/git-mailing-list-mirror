Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F8D2018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbcFXTpQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:45:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:59966 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcFXTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:45:16 -0400
Received: (qmail 31440 invoked by uid 102); 24 Jun 2016 19:45:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:45:15 -0400
Received: (qmail 22184 invoked by uid 107); 24 Jun 2016 19:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:45:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:45:12 -0400
Date:	Fri, 24 Jun 2016 15:45:12 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 4/4] t/lib-git-daemon: use test_match_signal
Message-ID: <20160624194512.GD6441@sigill.intra.peff.net>
References: <20160624193924.GA6282@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624193924.GA6282@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When git-daemon exits, we expect it to be with the SIGTERM
we just sent it. If we see anything else, we'll complain.
But our check against exit code "143" is not portable. For
example:

  $ ksh93 t5570-git-daemon.sh
  [...]
  error: git daemon exited with status: 271

We can fix this by using test_match_signal.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-git-daemon.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 340534c..f9cbd47 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -82,8 +82,7 @@ stop_git_daemon() {
 	kill "$GIT_DAEMON_PID"
 	wait "$GIT_DAEMON_PID" >&3 2>&4
 	ret=$?
-	# expect exit with status 143 = 128+15 for signal TERM=15
-	if test $ret -ne 143
+	if test_match_signal 15 $?
 	then
 		error "git daemon exited with status: $ret"
 	fi
-- 
2.9.0.215.gc5c4261
