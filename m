Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7413CC433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC8160E09
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 05:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDRFkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 01:40:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:55348 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhDRFkA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 01:40:00 -0400
Received: (qmail 2536 invoked by uid 109); 18 Apr 2021 05:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 18 Apr 2021 05:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12584 invoked by uid 111); 18 Apr 2021 05:39:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 18 Apr 2021 01:39:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 18 Apr 2021 01:39:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <YHvGE5/LRPN9obZi@coredump.intra.peff.net>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
 <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
 <20210416211451.GP2947267@szeder.dev>
 <YHqf9zjSzpYl7IAW@coredump.intra.peff.net>
 <xmqq7dl0d23g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dl0d23g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 17, 2021 at 02:37:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Apr 16, 2021 at 11:14:51PM +0200, SZEDER Gábor wrote:
> >
> >> > @@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const struct config_options *opts,
> >> >  				  config_fn_t fn, void *data)
> >> >  {
> >> >  	int ret = 0;
> >> > +	char *system_config = git_system_config();
> >> >  	char *xdg_config = xdg_config_home("config");
> >> >  	char *user_config = expand_user_path("~/.gitconfig", 0);
> >> >  	char *repo_config;
> >> > @@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const struct config_options *opts,
> >> >  		repo_config = NULL;
> >> >  
> >> >  	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
> >> > -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
> >> 
> >> Removing git_config_system() from the condition breaks
> >> GIT_CONFIG_NOSYSTEM:
> >
> > Good catch. My gut feeling is that the new git_system_config() should
> > check NOSYSTEM and return NULL if it's set, and then we can get rid of
> > git_config_system() entirely.
> 
> NULL -> /dev/null I guess?

I was thinking NULL to catch this line from the post-image of Patrick's
series:

          if (system_config && !access_or_die(system_config, R_OK,
                                              opts->system_gently ?
                                              ACCESS_EACCES_OK : 0))
                  ret += git_config_from_file(fn, system_config, data);

which would see that we have no file at all. But that may be unexpected
for other callers (right now git_etc_gitconfig() can never return NULL,
and I'm not sure what would happen with "git config --system"; I suspect
it would do the regular config sequence instead, which is wrong).

So yeah, probably returning /dev/null is more sensible (and makes it a
true alias for GIT_CONFIG_SYSTEM=/dev/null).

-Peff
