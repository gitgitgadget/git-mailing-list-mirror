Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C904120D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdE3FSq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:18:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:59636 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdE3FSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:18:45 -0400
Received: (qmail 13101 invoked by uid 109); 30 May 2017 05:18:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:18:45 +0000
Received: (qmail 20909 invoked by uid 111); 30 May 2017 05:19:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:19:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:18:43 -0400
Date:   Tue, 30 May 2017 01:18:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/8] git: add hidden --list-builtins option
Message-ID: <20170530051843.5ofv2xzebjrvi4ln@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be useful in the test suite to be able to iterate
over the list of builtins. We could do this with some
Makefile magic. But since the authoritative list is in the
commands array inside git.c, and since this could also be
handy for debugging, let's add a hidden command-line option
to dump that list.

Signed-off-by: Jeff King <peff@peff.net>
---
The forward declaration here is necessary because of the function
ordering. We could push handle_options() much lower in the file, but I
didn't think it was worth the churn.

 git.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git.c b/git.c
index 8ff44f081..1b8b7f51a 100644
--- a/git.c
+++ b/git.c
@@ -26,6 +26,8 @@ static const char *env_names[] = {
 static char *orig_env[4];
 static int save_restore_env_balance;
 
+static void list_builtins(void);
+
 static void save_env_before_alias(void)
 {
 	int i;
@@ -232,6 +234,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			}
 			(*argv)++;
 			(*argc)--;
+		} else if (!strcmp(cmd, "--list-builtins")) {
+			list_builtins();
+			exit(0);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
@@ -529,6 +534,13 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
+static void list_builtins(void)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		printf("%s\n", commands[i].cmd);
+}
+
 #ifdef STRIP_EXTENSION
 static void strip_extension(const char **argv)
 {
-- 
2.13.0.613.g11c956365

