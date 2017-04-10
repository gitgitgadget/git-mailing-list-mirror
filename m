Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6640120960
	for <e@80x24.org>; Mon, 10 Apr 2017 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdDJWNZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 18:13:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:59484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752155AbdDJWNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 18:13:24 -0400
Received: (qmail 29710 invoked by uid 109); 10 Apr 2017 22:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 22:13:24 +0000
Received: (qmail 29376 invoked by uid 111); 10 Apr 2017 22:13:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:13:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:13:22 -0400
Date:   Mon, 10 Apr 2017 18:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] receive-pack: drop tmp_objdir_env from run_update_hook
Message-ID: <20170410221322.perffycei6z6ahqc@sigill.intra.peff.net>
References: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 722ff7f87 (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03), we have to feed the
pre-receive hook the tmp_objdir environment, so that git
programs run from the hook know where to find the objects.

That commit modified run_update_hook() to do the same, but
there it is a noop. By the time we get to the update hooks,
we have already migrated the objects from quarantine, and so
tmp_objdir_env() will always return NULL. We can drop this
useless call.

Note that the ordering here and the lack of support for the
update hook is intentional. The update hook calls are
interspersed with actual ref updates, and we must migrate
the objects before any refs are updated (since otherwise
those refs would appear broken to outside processes). So the
only other options are:

  - remain in quarantine for the _first_ ref, but not the
    others. This is sufficiently confusing that it can be
    rejected outright.

  - run all the individual update hooks first, then migrate,
    then update all the refs. But this changes the repository
    state that the update hooks see (i.e., whether or not
    refs from the same push are updated yet or not).

So the functionality is fine and remains unchanged with this
patch; we're just cleaning up a useless and confusing line
of code.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aca9c33d8..b4469b3cc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -772,7 +772,6 @@ static int run_update_hook(struct command *cmd)
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
 	proc.argv = argv;
-	proc.env = tmp_objdir_env(tmp_objdir);
 
 	code = start_command(&proc);
 	if (code)
-- 
2.12.2.952.g759391acc

