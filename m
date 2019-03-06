Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2FC20248
	for <e@80x24.org>; Wed,  6 Mar 2019 20:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfCFUAv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 15:00:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:41366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726233AbfCFUAv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 15:00:51 -0500
Received: (qmail 30342 invoked by uid 109); 6 Mar 2019 20:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 20:00:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16787 invoked by uid 111); 6 Mar 2019 20:01:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 15:01:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 15:00:49 -0500
Date:   Wed, 6 Mar 2019 15:00:49 -0500
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        t.gummerer@gmail.com, gitster@pobox.com
Subject: Re: [BUG] GIT_AUTHOR_NAME was checked before prepare_fallback got
 called (ps/stash-in-c)
Message-ID: <20190306200049.GA23315@sigill.intra.peff.net>
References: <20190306195236.GA22872@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306195236.GA22872@dev-l>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 11:52:36AM -0800, Denton Liu wrote:

> Hello all,
> 
> I've been on "jch" for my daily use and I noticed today that git stash
> isn't working. I managed to debug it down to "ps/stash-in-c".
> 
> To reproduce on git.git, it's simply the following:
> 
> 	echo // >>dir.c
> 	git stash
> 
> This gives me the following error:
> 
> 	$ git stash
> 	BUG: ident.c:511: GIT_AUTHOR_NAME was checked before prepare_fallback got called
> 	Aborted (core dumped)
> 
> I haven't read through the branch's code so I'm not too familiar with
> the changes but please let me know if you need any other information or
> if there's anything I can help with.

Yeah, it seems like the code from fd5a58477c (ident: add the ability to
provide a "fallback identity", 2019-02-25) is over-eager:

  static void set_env_if(const char *key, const char *value, int *given, int bit)
  {
        if (*given & bit)
                BUG("%s was checked before prepare_fallback got called", key);
	...
  }

  void prepare_fallback_ident(const char *name, const char *email)
  {
        set_env_if("GIT_AUTHOR_NAME", name,
                   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
	...
  }

If the ident comes from config, then those bits will be set already,
even if nobody ever looked at $GIT_AUTHOR_NAME. I think that BUG()
should actually just be a silent return.

-Peff
