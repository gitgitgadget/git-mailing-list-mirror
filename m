Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A0DC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7F5611EF
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhDQIpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:45:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:54898 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQIpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:45:07 -0400
Received: (qmail 29927 invoked by uid 109); 17 Apr 2021 08:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Apr 2021 08:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2328 invoked by uid 111); 17 Apr 2021 08:44:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Apr 2021 04:44:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Apr 2021 04:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <YHqf9zjSzpYl7IAW@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
 <20210416211451.GP2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416211451.GP2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 11:14:51PM +0200, SZEDER Gábor wrote:

> > @@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const struct config_options *opts,
> >  				  config_fn_t fn, void *data)
> >  {
> >  	int ret = 0;
> > +	char *system_config = git_system_config();
> >  	char *xdg_config = xdg_config_home("config");
> >  	char *user_config = expand_user_path("~/.gitconfig", 0);
> >  	char *repo_config;
> > @@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const struct config_options *opts,
> >  		repo_config = NULL;
> >  
> >  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
> > -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
> 
> Removing git_config_system() from the condition breaks
> GIT_CONFIG_NOSYSTEM:

Good catch. My gut feeling is that the new git_system_config() should
check NOSYSTEM and return NULL if it's set, and then we can get rid of
git_config_system() entirely.

That is slightly different than the old behavior; right now
GIT_CONFIG_NOSYSTEM only prevents reading during the normal sequence,
and not reading (or writing!) via "git config --system". But I think it
would be an improvement to prevent those (the whole point of the feature
was to avoid the test suite accidentally accessing the larger
environment).

-Peff
