Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1870420970
	for <e@80x24.org>; Fri, 14 Apr 2017 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdDNRnp (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 13:43:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:33572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdDNRnn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 13:43:43 -0400
Received: (qmail 28691 invoked by uid 109); 14 Apr 2017 17:43:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 17:43:40 +0000
Received: (qmail 2094 invoked by uid 111); 14 Apr 2017 17:44:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 13:44:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Apr 2017 13:43:37 -0400
Date:   Fri, 14 Apr 2017 13:43:37 -0400
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: includeIf breaks calling dashed externals
Message-ID: <20170414174337.n6qksfvugkrexnsi@sigill.intra.peff.net>
References: <CAKPyHN1W175wm1doQHF71vB3PHpU2o=xtEAcZMqZtR=U_Kv0_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPyHN1W175wm1doQHF71vB3PHpU2o=xtEAcZMqZtR=U_Kv0_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 07:04:23PM +0200, Bert Wesarg wrote:

> Dear Duy,
> 
> heaving an includeIf in a git config file breaks calling external git
> commands, most prominently git-gui.
> 
> $ git --version
> git version 2.12.2.599.gcf11a6797
> $ git rev-parse --is-inside-work-tree
> true
> $ git echo
> git: 'echo' is not a git command. See 'git --help'.
> 
> Did you mean this?
>     fetch
> $ echo '[includeIf "gitdir:does-not-exists"]path = does-not-exists'
> >>.git/config
> $ git rev-parse --is-inside-work-tree
> true
> $ git echo
> fatal: BUG: setup_git_env called without repository

Probably this fixes it:

diff --git a/config.c b/config.c
index b6e4a57b9..8d66bdf56 100644
--- a/config.c
+++ b/config.c
@@ -213,6 +213,9 @@ static int include_by_gitdir(const char *cond, size_t cond_len, int icase)
 	struct strbuf pattern = STRBUF_INIT;
 	int ret = 0, prefix;
 
+	if (!have_git_dir())
+		return 0;
+
 	strbuf_add_absolute_path(&text, get_git_dir());
 	strbuf_add(&pattern, cond, cond_len);
 	prefix = prepare_include_condition_pattern(&pattern);

But it does raise a question of reading config before/after repository
setup, since those will give different answers. I guess they do anyway
because of $GIT_DIR/config.

-Peff
