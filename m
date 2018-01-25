Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136701F404
	for <e@80x24.org>; Thu, 25 Jan 2018 00:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbeAYA65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 19:58:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:56598 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932250AbeAYA64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 19:58:56 -0500
Received: (qmail 19834 invoked by uid 109); 25 Jan 2018 00:58:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 25 Jan 2018 00:58:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31656 invoked by uid 111); 25 Jan 2018 00:59:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 19:59:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 19:58:54 -0500
Date:   Wed, 24 Jan 2018 19:58:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] daemon: fix length computation in newline stripping
Message-ID: <20180125005854.GF26850@sigill.intra.peff.net>
References: <20180125005447.GA26661@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125005447.GA26661@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-daemon gets a pktline request, we strip off any
trailing newline, replacing it with a NUL. Clients prior to
5ad312bede (in git v1.4.0) would send:

  git-upload-pack repo.git\n

and we need to strip it off to understand their request.
After 5ad312bede, we send the host attribute but no newline,
like:

  git-upload-pack repo.git\0host=example.com\0

Both of these are parsed correctly by git-daemon. But if
some client were to combine the two:

  git-upload-pack repo.git\n\0host=example.com\0

we don't parse it correctly. The problem is that we use the
"len" variable to record the position of the NUL separator,
but then decrement it when we strip the newline. So we start
with:

  git-upload-pack repo.git\n\0host=example.com\0
                             ^-- len

and end up with:

  git-upload-pack repo.git\0\0host=example.com\0
                           ^-- len

This is arguably correct, since "len" tells us the length of
the initial string, but we don't actually use it for that.
What we do use it for is finding the offset of the extended
attributes; they used to be at len+1, but are now at len+2.

We can solve that by just leaving "len" where it is. We
don't have to care about the length of the shortened string,
since we just treat it like a C string.

No version of Git ever produced such a string, but it seems
like the daemon code meant to handle this case (and it seems
like a reasonable thing for somebody to do in a 3rd-party
implementation).

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c              |  6 ++----
 t/t5570-git-daemon.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 652f89b6e7..72dfeaf6e2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -760,10 +760,8 @@ static int execute(void)
 	alarm(0);
 
 	len = strlen(line);
-	if (len && line[len-1] == '\n') {
-		line[--len] = 0;
-		pktlen--;
-	}
+	if (len && line[len-1] == '\n')
+		line[len-1] = 0;
 
 	/* parse additional args hidden behind a NUL byte */
 	if (len != pktlen)
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index b556469db6..755b05a8ae 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -196,5 +196,20 @@ test_expect_success 'daemon log records all attributes' '
 	test_cmp expect actual
 '
 
+test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
+	{
+		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
+		printf "0000"
+	} >input &&
+	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
+	depacketize <output >output.raw &&
+
+	# just pick out the value of master, which avoids any protocol
+	# particulars
+	perl -lne "print \$1 if m{^(\\S+) refs/heads/master}" <output.raw >actual &&
+	git -C "$repo" rev-parse master >expect &&
+	test_cmp expect actual
+'
+
 stop_git_daemon
 test_done
-- 
2.16.1.273.gfdaa03aa74
