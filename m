Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8645620D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdE3FNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:13:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:59609 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbdE3FNo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:13:44 -0400
Received: (qmail 12716 invoked by uid 109); 30 May 2017 05:13:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:13:45 +0000
Received: (qmail 20822 invoked by uid 111); 30 May 2017 05:14:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:14:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:13:43 -0400
Date:   Tue, 30 May 2017 01:13:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/8] upload-archive: handle "-h" option early
Message-ID: <20170530051342.bvunnqymssnvqlt5@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally upload-archive forks off upload-archive--writer to
do the real work, and relays any errors back over the
sideband channel. This is a good thing when the command is
properly invoked remotely via ssh or git-daemon. But it's
confusing to curious users who try "git upload-archive -h".

Let's catch this invocation early and give a real usage
message, rather than spewing "-h does not appear to be a git
repository" amidst packet-lines. The chance of a false
positive due to a real client asking for the repo "-h" is
quite small.

Likewise, we'll catch "-h" in upload-archive--writer. People
shouldn't be invoking it manually, but it doesn't hurt to
give a sane message if they do.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/upload-archive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index cde06977b..84532ae9a 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -22,7 +22,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	struct argv_array sent_argv = ARGV_ARRAY_INIT;
 	const char *arg_cmd = "argument ";
 
-	if (argc != 2)
+	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage(upload_archive_usage);
 
 	if (!enter_repo(argv[1], 0))
@@ -76,6 +76,9 @@ int cmd_upload_archive(int argc, const char **argv, const char *prefix)
 {
 	struct child_process writer = { argv };
 
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(upload_archive_usage);
+
 	/*
 	 * Set up sideband subprocess.
 	 *
-- 
2.13.0.613.g11c956365

