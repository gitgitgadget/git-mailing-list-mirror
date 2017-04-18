Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A274F1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbdDRDqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:46:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:35057 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbdDRDqM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:46:12 -0400
Received: (qmail 8945 invoked by uid 109); 18 Apr 2017 03:46:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:46:13 +0000
Received: (qmail 8406 invoked by uid 111); 18 Apr 2017 03:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:46:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:46:10 -0400
Date:   Mon, 17 Apr 2017 23:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 2/3] config: handle conditional include when $GIT_DIR
 is not set up
Message-ID: <20170418034610.oiex6x3d4pcyzbzy@sigill.intra.peff.net>
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
 <20170417101002.18272-1-pclouds@gmail.com>
 <20170417101002.18272-2-pclouds@gmail.com>
 <xmqq7f2ih1l1.fsf@gitster.mtv.corp.google.com>
 <xmqqzifefmog.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzifefmog.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 07:56:47PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +	if (!have_git_dir() && opts.git_dir) {
> >>  		struct git_config_source repo_config;
> >>  
> >>  		memset(&repo_config, 0, sizeof(repo_config));
> >
> > But this one I do not quite understand.  When have_git_dir() was
> > false and asked discover_git_directory() to set opts.git_dir, we
> > enter the body of this block and then end up doing
> >
> > 	git_config_with_options(cb, data &repo_config, &opts);
> >
> > with repo_config set to the discovered git directory plus "/config";
> > we'd read the repository configuration twice, in other words.
> 
> Ahh, nevermind.  The fix to make the "usual sequence" pay attention
> to the opts->git_dir comes in 3/3 and in that step this redundant
> reading is also removed, so all is well at the end.

I think 2/3 is actually OK as-is. We know we didn't read repo config in
the first call to git_config_with_options() because have_git_dir() is
unset.

So 2/3 doesn't make anything worse; the bug already existed before Duy's
series (it goes back to my original read_early_config() hack).

-Peff
