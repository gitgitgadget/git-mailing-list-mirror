Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A646120986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbcJDTja (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:39:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:52307 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbcJDTja (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:39:30 -0400
Received: (qmail 13752 invoked by uid 109); 4 Oct 2016 19:39:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 19:39:29 +0000
Received: (qmail 9131 invoked by uid 111); 4 Oct 2016 19:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 15:39:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 15:39:26 -0400
Date:   Tue, 4 Oct 2016 15:39:26 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCHv2 1/2] push: change submodule default to check when
 submodules exist
Message-ID: <20161004193926.32w7yivkakqoadm2@sigill.intra.peff.net>
References: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
 <20161004192910.30649-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004192910.30649-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 12:29:09PM -0700, Stefan Beller wrote:

> Jeff wrote:
> > Consulting .git/config is fine, I think. It's not like we don't read it
> > (sometimes multiple times!) during the normal course of the program
> > anyway. It's just a question of whether it makes more sense for the
> > heuristic to kick in after "init", or only after "update". I don't know
> > enough to have an opinion.
> 
> I think there is no difference in practice, however the "after update"
> is way easier to implement and hence more maintainable (one lstat instead of
> fiddeling with the config; that can go wrong easily). 

Hmm, I would have thought it is the opposite; can't submodules exist in
the working tree in their own ".git" directory? I know that's the "old"
way of doing it, but I didn't know if it was totally deprecated.

Anyway, the config version is probably just:

  int config_check_submodule(const char *var, const char *value, void *data)
  {
	if (starts_with(var, "submodule.") && ends_with(var, ".path"))
		*(int *)data = 1;
	return 0;
  }

  ...
  int have_submodule = 0;
  git_config(config_check_submodule, &have_submodule);

But I don't care too much either way. that's just for reference.

> @@ -31,6 +32,19 @@ static const char **refspec;
>  static int refspec_nr;
>  static int refspec_alloc;
>  
> +static void preset_submodule_default(void)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_addf(&sb, "%s/modules", get_git_dir());
> +
> +	if (file_exists(sb.buf))

Maybe just:

  if (file_exists(git_path("modules"))

?

-Peff
