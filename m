Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8521F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcHOMuK (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:55402 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752748AbcHOMuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:50:10 -0400
Received: (qmail 15155 invoked by uid 109); 15 Aug 2016 12:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:50:09 +0000
Received: (qmail 14483 invoked by uid 111); 15 Aug 2016 12:50:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:50:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:50:07 -0400
Date:	Mon, 15 Aug 2016 08:50:07 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	ryenus <ryenus@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-parse: respect core.hooksPath in --git-path
Message-ID: <20160815125006.qdssqgd4rzjw4vi5@sigill.intra.peff.net>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 02:43:18PM +0200, Johannes Schindelin wrote:

> The idea of the --git-path option is not only to avoid having to
> prefix paths with the output of --git-dir all the time, but also to
> respect overrides for specific common paths inside the .git directory
> (e.g. `git rev-parse --git-path objects` will report the value of
> the environment variable GIT_OBJECT_DIRECTORY, if set).
> 
> When introducing the core.hooksPath setting, we forgot to adjust
> git_path() accordingly. This patch fixes that.

Makes sense.

I think you can squash in:

diff --git a/run-command.c b/run-command.c
index 33bc63a..5a4dbb6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -824,10 +824,7 @@ const char *find_hook(const char *name)
 	static struct strbuf path = STRBUF_INIT;
 
 	strbuf_reset(&path);
-	if (git_hooks_path)
-		strbuf_addf(&path, "%s/%s", git_hooks_path, name);
-	else
-		strbuf_git_path(&path, "hooks/%s", name);
+	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0)
 		return NULL;
 	return path.buf;

as strbuf_git_path() handles this now.

-Peff
